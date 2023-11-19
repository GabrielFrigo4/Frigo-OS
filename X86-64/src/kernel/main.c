#include "console.h"
#include "stack.h"

void kernel_main()
{
	Console_Clear();
	Console_Set_Color(PRINT_COLOR_YELLOW, PRINT_COLOR_BLACK);
	Console_Write_String("Welcome to our 64-bit kernel!\n");

	Console_Write_String("Total Stack Memory: ");
	Console_Write_Uint64(Kernel_StackMemory_Total());
	Console_NewLine();

	Console_Write_String("Used Stack Memory: ");
	Console_Write_Uint64(Kernel_StackMemory_Used());
	Console_NewLine();

	Console_Write_String("Free Stack Memory: ");
	Console_Write_Uint64(Kernel_StackMemory_Free());
	Console_NewLine();
}