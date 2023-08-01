function esl_reformat(format, seqfile; informat=nothing, wait=true)
    cmd = hmmer_cmd("esl-reformat")

    isnothing(informat) || (cmd = `$cmd --informat $informat`)
    stdout = tempname()
    stderr = tempname()
    o = tempname()

    process = run(pipeline(`$cmd -o $o $format $seqfile`; stdout, stderr, append=false), wait=false)
    wait && Base.wait(process)

    return (; process, stdout, stderr, o)
end
