# Changelog

All notable changes to this project will be documented in this file. The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 1.5.1

- Fix GSL dependency issue. See https://github.com/JuliaPackaging/Yggdrasil/issues/5283#issuecomment-2887756631.

## 1.4.0

- Now using HMMER v3.4 (released on 2023-08-15), through `HMMER_jll`. HMMER v3.4 now supports Apple Silicon natively, so we are no longer using Rosetta.

## 1.3.1

- Remove unused `HMMER_jll` dependency.

## 1.3.0

- We are now using pre-compiled artifacts (see `compilation.md`) to provide the `hmmer` and `easel` binaries.
- Now using HMMER 3.3.2.
- Support macOS with Apple Silicon, through Rosetta.

## 1.2.0

- informat, outformat options of hmmalign.

## 1.1.0

- Remove type annotations.

## 1.0.0

- hmmfetch

## 0.1.0

- Register package.