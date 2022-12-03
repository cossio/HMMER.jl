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
