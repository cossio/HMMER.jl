module HMMERTestFixtures

using FASTX

const TEST_ALIGNMENT = """
# STOCKHOLM 1.0
seq1 ACDEFGHIK
seq2 ACDEYGHIK
seq3 ACDEWGHIK
//
"""

const TEST_FASTA = """
>hit1
ACDEFGHIK
>hit2
ACDEWGHIK
>miss
TTTTTTTTT
"""

function write_test_alignment()
    path = tempname() * ".sto"
    write(path, TEST_ALIGNMENT)
    return path
end

function write_test_fasta()
    path = tempname() * ".fa"
    write(path, TEST_FASTA)
    return path
end

function fasta_sequences(path)
    sequences = Dict{String,String}()
    FASTX.FASTA.Reader(open(path)) do reader
        for record in reader
            sequences[String(FASTX.identifier(record))] = String(FASTX.sequence(record))
        end
    end
    return sequences
end

is_alignment_position(c) = !islowercase(c) && c != '.' && c != '-'

function normalized_alignment_sequences(path)
    sequences = Dict{String,String}()
    FASTX.FASTA.Reader(open(path)) do reader
        for record in reader
            cleaned = filter(is_alignment_position, FASTX.sequence(record))
            sequences[String(FASTX.identifier(record))] = String(cleaned)
        end
    end
    return sequences
end

end # module
