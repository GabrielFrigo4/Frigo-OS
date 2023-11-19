#include "console.h"

const static size_t NUM_COLS = 80;
const static size_t NUM_ROWS = 25;

struct Char
{
	uint8_t character;
	uint8_t color;
};

struct Char *VIDEO_MEMORY_POINTER = (struct Char *)0xB8000;
size_t col = 0;
size_t row = 0;
uint8_t color = PRINT_COLOR_WHITE | PRINT_COLOR_BLACK << 4;

void clear_row(size_t row)
{
	struct Char empty = (struct Char){' ', color};

	for (size_t col = 0; col < NUM_COLS; col++)
	{
		VIDEO_MEMORY_POINTER[col + NUM_COLS * row] = empty;
	}
}

void Console_Clear()
{
	for (size_t i = 0; i < NUM_ROWS; i++)
	{
		clear_row(i);
	}
}

void Console_NewLine()
{
	col = 0;

	if (row < NUM_ROWS - 1)
	{
		row++;
		return;
	}

	for (size_t row = 1; row < NUM_ROWS; row++)
	{
		for (size_t col = 0; col < NUM_COLS; col++)
		{
			struct Char character = VIDEO_MEMORY_POINTER[col + NUM_COLS * row];
			VIDEO_MEMORY_POINTER[col + NUM_COLS * (row - 1)] = character;
		}
	}

	clear_row(NUM_COLS - 1);
}

void Console_Write_Char(char character)
{
	if (character == '\n')
	{
		Console_NewLine();
		return;
	}

	if (col > NUM_COLS)
	{
		Console_NewLine();
	}

	VIDEO_MEMORY_POINTER[col + NUM_COLS * row] = (struct Char){(uint8_t)character, color};
	col++;
}

void Console_Write_String(char *str)
{
	for (size_t i = 0; 1; i++)
	{
		char character = (uint8_t)str[i];

		if (character == '\0')
		{
			return;
		}

		Console_Write_Char(character);
	}
}

void Console_Set_Color(uint8_t foreground, uint8_t background)
{
	color = foreground + (background << 4);
}