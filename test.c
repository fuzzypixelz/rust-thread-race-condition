#include <stdlib.h>
#include <Windows.h>

extern void init(int);

int main(const int argc, const char *argv[argc])
{
    init(atoi(argv[1]));
    Sleep(atoi(argv[2]));
    return 0;
}
