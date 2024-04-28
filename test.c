#include <stdlib.h>

extern void init(int);

int main(const int argc, const char *argv[argc])
{
    init(atoi(argv[1]));
    return 0;
}
