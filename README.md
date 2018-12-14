# Speech/NLP docker image

## Introduction

This is a docker image with several speech/NLP/DL packages:

- Ubuntu 16.04
- CUDA 8.0 + CUDNN 5.0
- Kaldi-ctc
- and other dependency packages

This docker image can be used to do some speech and NLP tasks with GPU support.

## Installation

### prerequisites

Linux, CUDA supported GPU, docker, nvidia-docker

### Steps

1. docker pull zwcih/morfessor_srilm_kaldi-ctc_cuda_dockerimage
2. docker run --runtime=nvidia -v /home/your_data_folder:/lmdata -it zwcih/morfessor_srilm_kaldi-ctc_cuda_dockerimage /bin/bash
3. Have fun!

## Build

1. git clone https://github.com/zwcih/morfessor_srilm_kaldi-ctc_cuda_dockerimage.git
2. docker build . -t zwcih/morfessor_srilm_kaldi-ctc_cuda_dockerimage:latest

## Contact

zwcih@qq.com for any comments/feedbacks