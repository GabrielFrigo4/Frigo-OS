#include "info.h"
#include "console.h"

KernelInfo Kernel_Get_Info()
{
    KernelInfo info = {
        0,
        0,
        1,
        0,
        "Frigo-OS",
    };
    return info;
}

void Kernel_Print_Info()
{
    KernelInfo info = Kernel_Get_Info();
    Console_Write_String(info.name);
    Console_Write_String(" version: ");
    Console_Write_Uint64(info.version.major);
    Console_Write_String(".");
    Console_Write_Uint64(info.version.minor);
    Console_Write_String(".");
    Console_Write_Uint64(info.version.build);
    Console_Write_String(".");
    Console_Write_Uint64(info.version.revision);
}