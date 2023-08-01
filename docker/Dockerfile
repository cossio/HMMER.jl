# FROM --platform=linux/amd64 ubuntu:latest
FROM ubuntu:latest
WORKDIR /Users/cossio/Developer/Julia/HMMER.jl
COPY . .
RUN apt-get update
RUN apt-get install -y curl git
EXPOSE 3000