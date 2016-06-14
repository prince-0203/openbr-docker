FROM ubuntu:latest

WORKDIR /home

# Install dependencies
RUN apt-get update -y && \
    apt-get install -y build-essential cmake cmake-curses-gui wget unzip git qt5-default libqt5svg5-dev qtcreator

# Download OpenCV
RUN wget -O opencv-2.4.13.zip https://github.com/Itseez/opencv/archive/2.4.13.zip && \
    unzip opencv-2.4.13.zip

# Install OpenCV
RUN cd opencv-2.4.13 && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make -j4 && \
    make install && \
    cd ../.. && \
    rm -rf opencv-2.4.13*

# Download OpenBR
RUN git clone https://github.com/biometrics/openbr.git && \
    cd openbr && \
    git checkout v1.1.0 && \
    git submodule init && \
    git submodule update

# Build OpenBR
RUN cd openbr && \
    mkdir build &&  cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make -j4 && \
    make install

# Clean up
RUN apt-get remove --purge -y wget unzip && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*
