#define VMA 0xb8000

void print_string(const char* s)
{
    char* vma = (char*)VMA;

    while(*s)
    {
        *vma = *(s++);
        vma += 2;
    }
}

int main()
{
    print_string("Hello kernel!");
    return 0;
}

