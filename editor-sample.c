#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

uint32_t square(uint32_t x);

struct ExampleThing {
	void* data;
	int* moreData;
	size_t lengthOfData;
};

struct IWriter {
	void* ctx;
	void (*write)(void* ctx, char const* data, size_t count);
};

typedef struct { int a; } nothing_t;

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
	struct IWriter writers[2] = {writer, writer};
	struct IWriter writerthing; 

	int discard = square(3);

	return 0;
}


uint32_t square(uint32_t x) {
	uint32_t root = sqrt(x);
	return root * root * x;
}
