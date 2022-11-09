CC = gcc
LDFLAGS += -lm
CFLAGS_M5 += /home/other/CSE530-FA2022/gem5/util/m5/src/m5_mmap.c /home/other/CSE530-FA2022/gem5/util/m5/src/abi/x86/m5op.S -I. -I/home/other/CSE530-FA2022/gem5/include -L/home/other/CSE530-FA2022/gem5/util/m5/build/x86/out -lm5 -DFRMWRK=1 
CFLAGS += 

SRCS=$(wildcard *.c)

ASMS=$(SRCS:.c=.s)

OBJS=$(SRCS:.c=)

all: $(OBJS) $(ASMS)

%: %.c
	$(CC) $< $(LDFALGS) $(CFLAGS) $(CFLAGS_M5) -o $@

%.s: %.c
	$(CC) -S $< $(CFLAGS) -o $@

clean:
	rm $(OBJS) $(ASMS)
