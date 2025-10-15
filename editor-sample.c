#include <stdio.h>

struct ExampleThing {
	void* data;
	int* moreData;
	size_t lengthOfData;
};

struct IWriter {
	void* ctx;
	void (*write)(void* ctx, char const* data, size_t count);
};

int main() {
	for (int i = 0; i < 10; i ++) {
		printf("Hello, World!\n");
	}
	for (int i = 0; i < 30; i ++) {
		printf("Hello, World!\n");
	}

	// I can make a recursive call
	main();

	// Define Garbage
	struct IWriter writer;

	return 0;
}
