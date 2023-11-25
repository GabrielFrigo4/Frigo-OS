#include "default.h"

enum
{
	PRINT_COLOR_BLACK = 0,
	PRINT_COLOR_BLUE = 1,
	PRINT_COLOR_GREEN = 2,
	PRINT_COLOR_CYAN = 3,
	PRINT_COLOR_RED = 4,
	PRINT_COLOR_MAGENTA = 5,
	PRINT_COLOR_BROWN = 6,
	PRINT_COLOR_LIGHT_GRAY = 7,
	PRINT_COLOR_DARK_GRAY = 8,
	PRINT_COLOR_LIGHT_BLUE = 9,
	PRINT_COLOR_LIGHT_GREEN = 10,
	PRINT_COLOR_LIGHT_CYAN = 11,
	PRINT_COLOR_LIGHT_RED = 12,
	PRINT_COLOR_PINK = 13,
	PRINT_COLOR_YELLOW = 14,
	PRINT_COLOR_WHITE = 15,
};

void Console_Clear();
void Console_NewLine();
void Console_Write_Byte(uint8_t byte);
void Console_Write_Word(uint16_t word);
void Console_Write_DWord(uint32_t dword);
void Console_Write_QWord(uint64_t qword);
void Console_Write_Char(char character);
void Console_Write_String(char *string);
void Console_Write_Buffer(void *buffer, uint64_t offset, uint64_t lenght);
void Console_Write_Uint8(uint8_t uint8);
void Console_Write_Uint16(uint16_t uint16);
void Console_Write_Uint32(uint32_t uint32);
void Console_Write_Uint64(uint64_t uint64);
void Console_Set_Color(uint8_t foreground, uint8_t background);