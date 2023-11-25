#include "default.h"

typedef struct KernelVersion
{
    uint64_t major;
    uint64_t minor;
    uint64_t build;
    uint64_t revision;
} KernelVersion __attribute__((packed));

typedef struct KernelInfo
{
    KernelVersion version;
    char *name;
} KernelInfo __attribute__((packed));

extern KernelInfo Kernel_Get_Info();
extern void Kernel_Print_Info();