FROM --platform=i386 i386/debian:buster
ARG DEBIAN_FRONTEND=noninteractive

# Add architecture for RISC-V packages
RUN dpkg --add-architecture riscv64

RUN apt-get clean && apt-get update && apt-get -y upgrade
RUN apt-get -y install apt-utils gcc vim unzip ruby nodejs \
    fakeroot dbus whiptail hexedit \
    patch wamerican ucf manpages \
    file luajit make lua50 dialog curl \
    less cowsay netcat-openbsd \
    qemu-system-misc \
    git build-essential gdb-multiarch \
    gcc-riscv64-linux-gnu binutils-riscv64-linux-gnu \
    libc6-dev-riscv64-cross

RUN useradd -m user && echo "user:password" | chpasswd
WORKDIR /home/user/
RUN git clone https://github.com/mit-pdos/xv6-riscv.git xv6
RUN echo 'root:password' | chpasswd

ENV HOME="/home/user" TERM="xterm" USER="user" SHELL="/bin/bash" EDITOR="vim" LANG="en_US.UTF-8" LC_ALL="C"
ENV PATH="/usr/riscv64-linux-gnu/bin:${PATH}"

USER user
CMD [ "/bin/bash" ]