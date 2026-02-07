# ツールチェーンの定義
CC = i686-linux-gnu-gcc
AS = i686-linux-gnu-as

# コンパイルオプション
# -ffreestanding: 標準ライブラリを使わない環境であることを指定
# -O2: 最適化
# -Wall -Wextra: 警告を有効化
CFLAGS = -std=gnu99 -ffreestanding -O2 -Wall -Wextra

# リンクオプション
# -nostdlib: 標準ライブラリをリンクしない
# -lgcc: コンパイラ依存の基本的な算術関数などをリンク
LDFLAGS = -ffreestanding -O2 -nostdlib -lgcc

# ソースファイルとオブジェクトファイル
OBJS = boot.o kernel.o

# デフォルトターゲット
all: myos.bin

# カーネルバイナリのリンク
myos.bin: linker.ld $(OBJS)
	$(CC) -T linker.ld -o $@ $(LDFLAGS) $(OBJS)

# Cソースのコンパイル
kernel.o: kernel.c
	$(CC) -c $< -o $@ $(CFLAGS)

# アセンブリソースのコンパイル
boot.o: boot.s
	$(AS) $< -o $@

# クリーンアップ
clean:
	rm -f *.o myos.bin

# QEMUでの実行確認用 (QEMUがインストールされている場合)
run: myos.bin
	qemu-system-i386 -kernel myos.bin
