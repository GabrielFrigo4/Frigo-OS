#include "console.h"

const static size_t NUM_COLS = 80;
const static size_t NUM_ROWS = 25;

struct Char
{
	uint8_t character;
	uint8_t color;
} __attribute__((packed));

struct SingleChar
{
	struct Char chars[sizeof(uint8_t)];
} __attribute__((packed));

struct DoubleChar
{
	struct Char chars[sizeof(uint16_t)];
} __attribute__((packed));

struct QuadChar
{
	struct Char chars[sizeof(uint32_t)];
} __attribute__((packed));

struct OctoChar
{
	struct Char chars[sizeof(uint64_t)];
} __attribute__((packed));

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

void Console_Write_Byte(uint8_t byte)
{
	struct SingleChar schar = {{
		(struct Char){byte, color},
	}};

	struct SingleChar *VideoPtr = (struct SingleChar *)((void *)VIDEO_MEMORY_POINTER + (col + NUM_COLS * row) * 2);
	*VideoPtr = schar;
	col += sizeof(uint8_t);
}

void Console_Write_Word(uint16_t word)
{
	uint8_t *bytes = (uint8_t *)&word;
	struct DoubleChar dchar = {{
		(struct Char){bytes[0], color},
		(struct Char){bytes[1], color},
	}};

	struct DoubleChar *VideoPtr = (struct DoubleChar *)((void *)VIDEO_MEMORY_POINTER + (col + NUM_COLS * row) * 2);
	*VideoPtr = dchar;
	col += sizeof(uint16_t);
}

void Console_Write_DWord(uint32_t dword)
{
	uint8_t *bytes = (uint8_t *)&dword;
	struct QuadChar qchar = {{
		{bytes[0], color},
		{bytes[1], color},
		{bytes[2], color},
		{bytes[3], color},
	}};

	struct QuadChar *VideoPtr = (struct QuadChar *)((void *)VIDEO_MEMORY_POINTER + (col + NUM_COLS * row) * 2);
	*VideoPtr = qchar;
	col += sizeof(uint32_t);
}

void Console_Write_QWord(uint64_t qword)
{
	uint8_t *bytes = (uint8_t *)&qword;
	struct OctoChar ochar = {{
		{bytes[0], color},
		{bytes[1], color},
		{bytes[2], color},
		{bytes[3], color},
		{bytes[4], color},
		{bytes[5], color},
		{bytes[6], color},
		{bytes[7], color},
	}};

	struct OctoChar *VideoPtr = (struct OctoChar *)((void *)VIDEO_MEMORY_POINTER + (col + NUM_COLS * row) * 2);
	*VideoPtr = ochar;
	col += sizeof(uint64_t);
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

	VIDEO_MEMORY_POINTER[col + NUM_COLS * row] = (struct Char){character, color};
	col += sizeof(char);
}

void Console_Write_String(char *str)
{
	uint8_t *bytes = (uint8_t *)str;
	for (size_t i = 0; bytes[i] != '\0'; i++)
	{
		Console_Write_Char((char)bytes[i]);
	}
}

void Console_Write_Buffer(void *buffer, uint64_t offset, uint64_t lenght)
{
	uint8_t *bytes = (uint8_t *)buffer;
	for (size_t i = offset; i < offset + lenght; i++)
	{
		Console_Write_Char((char)bytes[i]);
	}
}

void Console_Set_Color(uint8_t foreground, uint8_t background)
{
	color = foreground + (background << 4);
}