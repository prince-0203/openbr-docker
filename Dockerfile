FROM ubuntu:latest

RUN apt-get update -y && \
    apt-get install -y build-essential cmake cmake-curses-gui wget unzip

WORKDIR /tmp/downloads

RUN wget -O opencv-2.4.13.zip https://github.com/Itseez/opencv/archive/2.4.13.zip

RUN unzip opencv-2.4.13.zip && \
    cd opencv-2.4.13 && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make -j4 && \
    make install && \
    cd ../.. && \
    rm -rf opencv-2.4.13*

RUN apt-get install -y git qt5-default libqt5svg5-dev qtcreator

RUN git clone https://github.com/biometrics/openbr.git && \
    cd openbr && \
    git checkout v1.1.0 && \
    git submodule init && \
    git submodule update

RUN cd openbr && \
    mkdir build &&  cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make -j4 && \
    make install
