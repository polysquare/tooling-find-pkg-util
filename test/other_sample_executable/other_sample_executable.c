#include <string.h>
#include <stdio.h>

int main (int argc, char **argv)
{
    if (argc == 2 && strcmp (argv[1], "--version") == 0) {
        printf ("OTHER_EXEC_VERSION_HEADER 3.2.1 VERSION_FOOTER\n");
    }

    return 0;
}
