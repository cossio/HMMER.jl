"""
    hmmbuild(msafile; wait=true, n=nothing, amino=false, dna=false, rna=false)

Build an HMM profile from a multiple-sequence alignment file with `hmmbuild`.

`msafile` is passed directly to the HMMER executable. The returned named tuple
contains the spawned `process`, captured `stdout` and `stderr`, and the output
paths `hmmout`, `o`, and `O`. These output files are guaranteed to exist and be
complete once the process finishes (or immediately on return when `wait=true`).

Keyword arguments mirror the corresponding command-line options:
- `n`: set the model name
- `amino`, `dna`, `rna`: force the alphabet
- `wait`: when `true`, wait for the process to finish before returning
"""
function hmmbuild(msafile; wait=true, n=nothing, amino=false, dna=false, rna=false)
    cmd = `$(HMMER_jll.hmmbuild())`

    stdout = tempname()
    stderr = tempname()
    hmmout = tempname()
    o = tempname()
    O = tempname()

    isnothing(n) || (cmd = `$cmd -n $n`)

    amino && (cmd = `$cmd --amino`)
    dna && (cmd = `$cmd --dna`)
    rna && (cmd = `$cmd --rna`)

    pipe = pipeline(`$cmd -o $o -O $O $hmmout $msafile`; stdout, stderr, append=false)
    process = run(pipe, wait=false)
    wait && Base.wait(process)

    return (; process, stdout, stderr, hmmout, o, O)
end

"""
    hmmsearch(hmmfile, seqdb; wait=true, Z=nothing, E=nothing, cpu=nothing)

Search a sequence database with an HMM profile using `hmmsearch`.

The returned named tuple contains the spawned `process`, captured `stdout` and
`stderr`, and the output paths `o`, `A`, `tblout`, and `domtblout`. These
outputs are guaranteed to exist and be complete once the process finishes (or
immediately on return when `wait=true`).

Keyword arguments mirror the corresponding command-line options:
- `Z`: set the database size for E-value calculations
- `E`: set the reporting threshold
- `cpu`: choose the number of worker threads used by HMMER
- `wait`: when `true`, wait for the process to finish before returning
"""
function hmmsearch(hmmfile, seqdb; wait=true, Z=nothing, E=nothing, cpu=nothing)
    cmd = `$(HMMER_jll.hmmsearch())`

    stdout = tempname()
    stderr = tempname()
    o = tempname()
    A = tempname()
    tblout = tempname()
    domtblout = tempname()

    isnothing(Z) || (cmd = `$cmd -Z $Z`)
    isnothing(E) || (cmd = `$cmd -E $E`)
    isnothing(cpu) || (cmd = `$cmd --cpu $cpu`)

    pipe = pipeline(`$cmd -o $o -A $A --tblout $tblout --domtblout $domtblout $hmmfile $seqdb`; stdout, stderr, append=false)
    process = run(pipe, wait=false)
    wait && Base.wait(process)

    return (; process, stdout, stderr, o, A, tblout, domtblout)
end

"""
    hmmfetch(hmmfile, key; wait=true)

Fetch a single profile named `key` from an HMM database with `hmmfetch`.

The returned named tuple contains the spawned `process`, captured `stdout` and
`stderr`, and the fetched-profile output path `o`. The output file is
guaranteed to exist and be complete once the process finishes (or immediately
on return when `wait=true`).
"""
function hmmfetch(hmmfile, key; wait=true)
    cmd = `$(HMMER_jll.hmmfetch())`
    stdout = tempname()
    stderr = tempname()
    o = tempname()
    pipe = pipeline(`$cmd -o $o $hmmfile $key`; stdout, stderr, append=false)
    process = run(pipe, wait=false)
    wait && Base.wait(process)
    return (; process, stdout, stderr, o)
end

"""
    hmmalign(hmmfile, seqfile; wait=true, informat=nothing, outformat=nothing)

Align sequences in `seqfile` against the profile HMM in `hmmfile` with
`hmmalign`.

The returned named tuple contains the spawned `process`, captured `stdout` and
`stderr`, and the alignment output path `o`. The output file is guaranteed to
exist and be complete once the process finishes (or immediately on return when
`wait=true`).

Keyword arguments mirror the corresponding command-line options:
- `informat`: specify the input sequence format
- `outformat`: specify the alignment output format
- `wait`: when `true`, wait for the process to finish before returning
"""
function hmmalign(
    hmmfile, seqfile;
    wait=true,
    informat=nothing,
    outformat=nothing
)
    cmd = `$(HMMER_jll.hmmalign())`
    isnothing(informat) || (cmd = `$cmd --informat $informat`)
    isnothing(outformat) || (cmd = `$cmd --outformat $outformat`)

    stdout = tempname()
    stderr = tempname()
    o = tempname()
    pipe = pipeline(`$cmd -o $o $hmmfile $seqfile`; stdout, stderr, append=false)
    process = run(pipe, wait=false)
    wait && Base.wait(process)
    return (; process, stdout, stderr, o)
end
