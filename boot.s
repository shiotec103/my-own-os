/* Multibootヘッダの定数定義 */
.set ALIGN,    1<<0             /* モジュールをページ境界に配置 */
.set MEMINFO,  1<<1             /* メモリマップ情報を提供 */
.set FLAGS,    ALIGN | MEMINFO  /* フラグセット */
.set MAGIC,    0x1BADB002       /* マジックナンバー (ブートローダが探す値) */
.set CHECKSUM, -(MAGIC + FLAGS) /* チェックサム */

/* Multibootセクション */
.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

/* スタック領域の確保 (16KiB) */
.section .bss
.align 16
stack_bottom:
.skip 16384
stack_top:

/* エントリポイント */
.section .text
.global _start
.type _start, @function
_start:
    /* スタックポインタの設定 (C言語の実行に必須) */
    mov $stack_top, %esp

    /* カーネルのメイン関数を呼び出し */
    call kernel_main

    /* 処理が戻ってきた場合の無限ループ (CPU停止) */
    cli
1:  hlt
    jmp 1b
