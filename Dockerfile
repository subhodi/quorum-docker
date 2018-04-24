FROM ubuntu:16.04 as builder

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y software-properties-common python-software-properties && \
    apt-get update

RUN add-apt-repository -y ppa:ethereum/ethereum && \
    apt-get update -y && \
    apt-get install -y build-essential unzip libdb-dev libleveldb-dev libsodium-dev zlib1g-dev libtinfo-dev solc sysvbanner wrk

ENV CREL constellation-0.2.0-ubuntu1604 
RUN apt-get install -y wget \
     tar \
     git 

RUN wget -q https://github.com/jpmorganchase/constellation/releases/download/v0.2.0/$CREL.tar.xz && \
    tar xfJ $CREL.tar.xz && \
    cp $CREL/constellation-node /usr/local/bin && chmod 0755 /usr/local/bin/constellation-node && \
    rm -rf $CREL 

ENV GOREL go1.7.3.linux-amd64.tar.gz
ENV PATH $PATH:/usr/local/go/bin
RUN wget -q https://storage.googleapis.com/golang/$GOREL && \
    tar xfz $GOREL && \
    mv go /usr/local/go && \
    rm -f $GOREL && \
    echo 'PATH=$PATH:/usr/local/go/bin' >> /root/.bashrc

RUN git clone https://github.com/jpmorganchase/quorum.git 
RUN cd quorum && \
    git checkout tags/v2.0.0 && \
    make all  && \
    cp build/bin/geth /usr/local/bin  && \
    cp build/bin/bootnode /usr/local/bin 

RUN wget -q https://github.com/jpmorganchase/quorum/releases/download/v1.2.0/porosity && \
    mv porosity /usr/local/bin && chmod 0755 /usr/local/bin/porosity
