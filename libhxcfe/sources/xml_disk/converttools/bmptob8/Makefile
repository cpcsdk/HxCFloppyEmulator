CFLAGS = -O3 -I../../.. -Wall
LDFLAGS =
TARGET := $(shell uname)

CFLAGS += -fPIC -Wl,-Map,foo.map
EXEC=bmptoh

ifeq ($(TARGET),)
EXEC=bmptoh.exe
LDFLAGS += -lm 
else
LDFLAGS += -lc -lm  -ldl
endif



all: $(EXEC)

$(EXEC): bmptoh.o lzw.o pack.o rle.o
	$(CC) -o $@    $^ $(LDFLAGS)

bmptoh.o: bmptoh.c
	$(CC) -o $@ -c $< $(CFLAGS)

lzw.o: ../../packer/lzw.c
	$(CC) -o $@ -c $< $(CFLAGS)

pack.o: ../../packer/pack.c
	$(CC) -o $@ -c $< $(CFLAGS)

rle.o: ../../packer/rle.c
	$(CC) -o $@ -c $< $(CFLAGS)


clean:
	rm -rf *.o

mrproper: clean
	rm -rf $(EXEC)
	rm -rf Debug*
	rm -rf Release*
	rm -rf *.obj *.ncb *.plg *.opt

.PHONY: clean mrproper
