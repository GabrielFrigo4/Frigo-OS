#include "kernel.h"
#include "io.h"

uint_16 cursorPosition;
uint_8 textColor;

extern void init_kernel()
{
    cursorPosition = 0;
    textColor = DEFAULT_COLOR;
}

extern void setCursorPosition(uint_16 position)
{
    outb(0x3D4, 0x0F);
    outb(0x3D5, (uint_8)(position & 0xFF));
    outb(0x3D4, 0x0E);
    outb(0x3D5, (uint_8)((position >> 8) & 0xFF));

    cursorPosition = position;
}

extern uint_16 positionFroomCoords(uint_8 x, uint_8 y)
{
    return y * VGA_HIGHT + x;
}

extern void coordsFromPosition(uint_8 *x, uint_8 *y, uint_16 position)
{
    *x = position % VGA_HIGHT;
    position -= *x;
    *y = position / VGA_HIGHT;
}

extern void setTextColor(uint_8 color)
{
    textColor = color;
}

extern void setTextColorForeBack(uint_8 foreground, uint_8 background)
{
    textColor = foreground | background;
}

extern void cwrite(const char _char)
{
    int pos = cursorPosition;
    switch (_char)
    {
    case '\n':
        pos += VGA_HIGHT - cursorPosition % VGA_HIGHT;
        break;
    default:
        *(VGA_MEMORY + cursorPosition * 2) = _char;
        *(VGA_MEMORY + cursorPosition * 2 + 1) = textColor;
        pos += 1;
        break;
    }
    setCursorPosition(pos);
}

extern void write(const void *buffer, int offset, int size)
{
    for (int i = offset; i < size + offset; i++)
    {
        cwrite(((char *)buffer)[i]);
    }
}

extern void print(const char *str)
{
    for (int i = 0; str[i] != '\0'; i++)
    {
        cwrite(str[i]);
    }
}