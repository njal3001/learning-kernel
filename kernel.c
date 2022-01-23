int main()
{
    char* video_buffer = (char*)0xb8000;
    *video_buffer = '?';

    return 0;
}
