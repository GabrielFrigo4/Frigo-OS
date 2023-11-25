#include "console.h"
#include "stack.h"
#include "info.h"

void kernel_main()
{
	Console_Clear();
	Console_Set_Color(PRINT_COLOR_YELLOW, PRINT_COLOR_BLACK);

	Kernel_Print_Info();
	Console_Write_String("\nOur 64-bit Kernel!\n");

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