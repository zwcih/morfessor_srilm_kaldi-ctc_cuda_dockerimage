FROM nvidia/cuda:8.0-cudnn5-devel-ubuntu16.04
LABEL maintainer "Wayne Zhang <zwcih@qq.com>"

RUN apt-get -y update
RUN apt-get -y install python python-pip gcc-4.9 g++-4.9 automake autoconf wget subversion libatlas3-base git cmake gfortran-4.9 zlib1g-dev libtool vim

# make gcc/g++ 4.9 as default
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.9
RUN update-alternatives --install /usr/bin/gfortran gfortran /usr/bin/gfortran-4.9 50

RUN mkdir /lm
COPY ./dependencies/ /lm/dependencies/
# install morefessor
RUN cd /lm/dependencies/ && pip install ./morfessor-2.0.1.tar.gz

# make srilm
RUN mkdir -p /lm/dependencies/srilm && tar zxvf /lm/dependencies/srilm.tgz -C /lm/dependencies/srilm 
RUN cd /lm/dependencies/srilm && make SRILM=/lm/dependencies/srilm World
# add srlm binaries to PATH
ENV PATH $PATH:/lm/dependencies/srilm/bin/i686-m64:/lm/dependencies/srilm/bin

RUN cd /lm/ && git clone https://github.com/lingochamp/kaldi-ctc.git
RUN cd /lm/kaldi-ctc/tools && ln -s -f bash /bin/sh && make -j && make openblas
RUN cd /lm/kaldi-ctc/src && ./configure --cudnn-root=/usr/ && make depend && make
RUN chmod 755 /lm/kaldi-ctc/tools/openfst-*
ENV KALDI_ROOT /lm/kaldi-ctc
ENV PATH $PATH:$KALDI_ROOT/egs/wsj/s5/utils:$KALDI_ROOT/tools/openfst/bin