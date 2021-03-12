/* 这个将强制我们创建一个内核进入函数，而不是跳转到kernel.c:0x00 */
void dummy_test_entrypoint() {
}

void main() {
    char * video_memory = (char*)0xb8000;
    *video_memory = 'X';
}