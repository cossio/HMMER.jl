# Compilation of hmmer

**UPDATE 2023-08-31.** Since v1.4.0, we are using `HMMER_jll`. This note is no longer needed.

We download the source from http://hmmer.org. At the time of writing the latest version is 3.4.

```bash
wget http://eddylab.org/software/hmmer/hmmer.tar.gz
tar xfv hmmer.tar.gz
cd hmmer-3.4
```

## Compilation instructions for each platform

#### Linux or MacOS (Intel or Apple Silicon)

The following commands work on Linux and macOS. HMMER does not support Windows (though WSL should be fine). We use the commands listed on the HMMER website to compile:

```bash
./configure --prefix=$(pwd)
make
make install
cd easel
make install
```

`hmmer` supports Apple Silicon natively, since v3.4 (ref. [#262](https://github.com/EddyRivasLab/hmmer/issues/262)). I compiled it on a MacBook with M2 chip. 


##### Compilation for macOS Intel on Apple Silicon using Rosetta

I used the same machine to compile it for Intel. To do this, first run

```bash
env /usr/bin/arch  -x86_64 /bin/zsh --login
```

which means the shell will now be running on Rosetta. Then, run the commands above to compile HMMER on this terminal session. This will produce x86 binaries that can be used on Intel Macs.


## Cleanup

To reduce the size of the tarball we upload to GitHub Gists, we remove some things that are not useful:

```bash
rm -rf src documentation easel testsuite
```

If we don't do this the gist is too big and we get an error when trying to upload it.

## Artifact creation

From within the `hmmer-3.4` directory, start a Julia session and run:

```julia
using ArtifactUtils
artifact_id = ArtifactUtils.artifact_from_directory(".")
gist = ArtifactUtils.upload_to_gist(artifact_id)
```

# Script

I created a script in `compilation/compile.jl` that will carry out all of the above steps automatically.