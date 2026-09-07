#include <unistd.h>
#include <string.h>

char const *msg = "Hello World!\n";

int main()
{
        int len = strlen(msg);

        write(1, msg, len + 1);

        _exit(0);
}
