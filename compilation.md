# Compilation of hmmer

We download the source from http://hmmer.org. At the time of writing the latest version is 3.3.2.

```bash
wget http://eddylab.org/software/hmmer/hmmer.tar.gz
tar xfv hmmer.tar.gz
cd hmmer-3.3.2
```

## Compilation instructions for each platform

#### Linux / MacOS (Intel)

```bash
./configure --prefix=$(pwd)
make
make install
cd easel
make install
```

#### MacOS (Apple Silicon)

`hmmer` does not support Apple Silicon natively yet (see https://github.com/EddyRivasLab/hmmer/issues/262). However, it can be compiled/run with Rosetta. To do so, run the following command before compiling in the terminal:

```bash
env /usr/bin/arch  -x86_64 /bin/zsh --login
```

After running this, the shell is now running under Rosetta, emulating Intel architecture. Then, run the compilation instructions below (same as above).

```bash
./configure --prefix=$(pwd)
make
make install
cd easel
make install
```

After compilation, be sure to revert to the native architecture by exiting the shell spawned above (Ctrl + D).

## Cleanup

To reduce the size of the tarball we upload to GitHub Gists, we remove some things that are not useful:

```bash
rm -rf src documentation easel testsuite
```

If we don't do this the gist is too big and we get an error when trying to upload it.

## Artifact creation

From within the `hmmer-3.3.2` directory, start a Julia session and run:

```julia
using ArtifactUtils
artifact_id = ArtifactUtils.artifact_from_directory(".")
gist = ArtifactUtils.upload_to_gist(artifact_id)
```