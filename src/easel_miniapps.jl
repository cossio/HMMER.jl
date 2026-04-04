"""
    esl_reformat(format, seqfile; informat=nothing, wait=true)

Convert a sequence or alignment file to another format with `esl-reformat`.

`format` is the Easel output format name and `seqfile` is the input file. The
returned named tuple contains the spawned `process`, captured `stdout` and
`stderr`, and the reformatted output path `o`. The output file is guaranteed to
exist and be complete once the process finishes (or immediately on return when
`wait=true`).

Keyword arguments mirror the corresponding command-line options:
- `informat`: specify the input format explicitly
- `wait`: when `true`, wait for the process to finish before returning
"""
function esl_reformat(format, seqfile; informat=nothing, wait=true)
    cmd = `$(HMMER_jll.esl_reformat())`

    isnothing(informat) || (cmd = `$cmd --informat $informat`)
    stdout = tempname()
    stderr = tempname()
    o = tempname()

    process = run(pipeline(`$cmd -o $o $format $seqfile`; stdout, stderr, append=false), wait=false)
    wait && Base.wait(process)

    return (; process, stdout, stderr, o)
end
