FROM ubuntu:16.04 as builder

RUN export DEBIAN_FRONTEND=noninteractive 
RUN apt-get update
RUN apt-get install -y software-properties-common python-software-properties
RUN apt-get update

RUN add-apt-repository -y ppa:ethereum/ethereum 
RUN apt-get update -y 
RUN apt-get install -y build-essential unzip libdb-dev libleveldb-dev libsodium-dev zlib1g-dev libtinfo-dev solc sysvbanner wrk

ENV CREL constellation-0.2.0-ubuntu1604 
RUN apt-get install -y wget \
     tar \
     git 

RUN wget -q https://github.com/jpmorganchase/constellation/releases/download/v0.2.0/$CREL.tar.xz 
RUN tar xfJ $CREL.tar.xz 
RUN cp $CREL/constellation-node /usr/local/bin && chmod 0755 /usr/local/bin/constellation-node 
RUN rm -rf $CREL 

ENV GOREL go1.7.3.linux-amd64.tar.gz 
RUN wget -q https://storage.googleapis.com/golang/$GOREL 
RUN tar xfz $GOREL 
RUN mv go /usr/local/go 
RUN rm -f $GOREL 
ENV PATH $PATH:/usr/local/go/bin 
RUN echo 'PATH=$PATH:/usr/local/go/bin' >> /root/.bashrc

RUN git clone https://github.com/jpmorganchase/quorum.git 
RUN cd quorum && \
    git checkout tags/v2.0.0 && \
    make all  && \
    cp build/bin/geth /usr/local/bin  && \
    cp build/bin/bootnode /usr/local/bin 

RUN wget -q https://github.com/jpmorganchase/quorum/releases/download/v1.2.0/porosity 
RUN mv porosity /usr/local/bin && chmod 0755 /usr/local/bin/porosity






