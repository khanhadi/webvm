FROM --platform=i386 i386/debian:buster
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get clean && apt-get update && apt-get -y upgrade

# Install the necessary packages for building xv6 and running QEMU (for x86)
RUN apt-get -y install \
    apt-utils \
    gcc \
    make \
    vim \
    qemu-system-i386 \
    git \
    gdb-multiarch \
    build-essential

RUN useradd -m user && echo "user:password" | chpasswd
WORKDIR /home/user/

# Clone the original xv6 (32-bit x86 version)
RUN git clone https://github.com/mit-pdos/xv6-public.git xv6

# Change ownership of the xv6 directory to the user
RUN chown -R user:user /home/user/xv6

ENV HOME="/home/user" \
    TERM="xterm" \
    USER="user" \
    SHELL="/bin/bash" \
    EDITOR="vim" \
    LANG="en_US.UTF-8" \
    LC_ALL="C"

USER user

# Set xv6 as the working directory
WORKDIR /home/user/xv6

# Build xv6 using the provided Makefile
RUN make clean && make

# Run xv6 in QEMU
CMD ["qemu-system-i386", "-hda", "fs.img", "-m", "512", "-nographic", "-kernel", "kernel"]
