#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <stddef.h>

int main()
{
        LPCSTR hello = "Oi mundo!\n";
        LPCSTR capt = "Compilado pelo MSVC.\n";
        MessageBoxA(NULL, hello, capt, MB_OK);
        ExitProcess(0);
}
