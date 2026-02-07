#include <stdint.h>

/* VGAテキストモードのバッファアドレス (物理アドレス) */
volatile uint16_t* vga_buffer = (uint16_t*)0xB8000;

/* VGAテキストモードの標準サイズ */
const int VGA_WIDTH = 80;
const int VGA_HEIGHT = 25;

/* 色属性の定義 */
/* 背景: 青(1), 文字: 白(F) -> 0x1F */
/* 文字自体はスペース(' ')を使うことで塗りつぶしに見せます */
const uint16_t BLUE_SCREEN_ENTRY = (0x1F << 8) | ' ';

void kernel_main(void) {
    /* 画面全体を走査して青色のスペースで埋める */
    for (int y = 0; y < VGA_HEIGHT; y++) {
        for (int x = 0; x < VGA_WIDTH; x++) {
            const int index = y * VGA_WIDTH + x;
            vga_buffer[index] = BLUE_SCREEN_ENTRY;
        }
    }
}
