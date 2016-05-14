/* /test/sample_executable.c
 *
 * Executable that prints a version on being passed --version.
 *
 * See /LICENCE.md for Copyright information */

#include <string.h>
#include <stdio.h>

int main (int argc, char **argv)
{
    if (argc == 2 && strcmp (argv[1], "--version") == 0) {
        printf ("VERSION_HEADER 1.2.3 VERSION_FOOTER\n");
    }

    return 0;
}
