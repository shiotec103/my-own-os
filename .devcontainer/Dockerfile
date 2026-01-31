# OS開発に適した軽量なLinuxをベースにする
FROM ubuntu:22.04

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y \
    build-essential \
    nasm \
    binutils-i686-linux-gnu \
    gcc-i686-linux-gnu \
    gdb \
    qemu-system-x86 \
    make \
    git \
    && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリの設定
WORKDIR /workspace
