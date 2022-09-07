#include "types.h"
#include "colors.h"
#define VGA_MEMORY (uint_8 *)0xb8000
#define VGA_HIGHT 80

extern void setCursorPosition(uint_16 position);
extern uint_16 positionFroomCoords(uint_8 x, uint_8 y);
extern void coordsFromPosition(uint_8 *x, uint_8 *y, uint_16 position);
extern void setTextColor(uint_8 color);
extern void setTextColorForeBack(uint_8 foreground, uint_8 background);
extern void cwrite(const char _char);
extern void write(const void *buffer, int offset, int size);
extern void print(const char *str);