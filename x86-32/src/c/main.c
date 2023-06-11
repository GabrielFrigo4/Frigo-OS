#include "kernel.h"

extern void main()
{
    cwrite('A');
    cwrite('B');
    cwrite('C');
    cwrite('\n');
    setTextColorForeBack(FOREGROUND_BLUE, BACKGROUND_BLACK);
    write(" ungabunga", 1, 4);
    setTextColor(DEFAULT_COLOR);
    print(" ungabunga");
    return;
}