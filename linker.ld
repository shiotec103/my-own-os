ENTRY(_start)

SECTIONS
{
	/* カーネルを1MBの位置から開始 */
	. = 1M;

	/* Multibootヘッダを最初に配置 */
	.text BLOCK(4K) : ALIGN(4K)
	{
		*(.multiboot)
		*(.text)
	}

	/* 読み取り専用データ */
	.rodata BLOCK(4K) : ALIGN(4K)
	{
		*(.rodata)
	}

	/* 初期化済みデータ */
	.data BLOCK(4K) : ALIGN(4K)
	{
		*(.data)
	}

	/* 未初期化データとスタック */
	.bss BLOCK(4K) : ALIGN(4K)
	{
		*(COMMON)
		*(.bss)
	}
}
