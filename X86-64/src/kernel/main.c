#include "console.h"

void kernel_main()
{
    Console_Clear();
    Console_Set_Color(PRINT_COLOR_YELLOW, PRINT_COLOR_BLACK);
    Console_Write_String("Welcome to our 64-bit kernel!");
}