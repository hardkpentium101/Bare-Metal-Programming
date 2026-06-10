BUILD_DIR=../build
OS=$(BUILD_DIR)/os

OS_SRCS   := $(wildcard *.c)
OS_OBJS   := $(patsubst %.c,$(BUILD_DIR)/%.o,$(OS_SRCS))

CFLAGS+=-ffreestanding -nostdlib -gdwarf-4 -m32 -ggdb3

all: init $(OS)

init:
	mkdir -p $(BUILD_DIR) $(OS)

$(BUILD_DIR)/%.o: %.c
	gcc $(CFLAGS) -c $< -o $@		

$(OS): $(OS_OBJS)
	ld -m elf_i386 -nmagic -T os.lds $(OS_OBJS) -o $@/os.o

clean: 
	rm -rf $(BUILD_DIR)/*
