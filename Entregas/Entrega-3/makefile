TARGET = led_control.so
ALT_DEVICE_FAMILY ?= soc_cv_av
SOCEDS_ROOT ?= $(SOCEDS_DEST_ROOT)
HWLIBS_ROOT = $(SOCEDS_ROOT)/ip/altera/hps/altera_hps/hwlib
CROSS_COMPILE = arm-linux-gnueabihf-
CFLAGS = -g -Wall -D$(ALT_DEVICE_FAMILY) -I$(HWLIBS_ROOT)/include/$(ALT_DEVICE_FAMILY) -I$(HWLIBS_ROOT)/include/
LDFLAGS = -g -shared
CC = $(CROSS_COMPILE)gcc

all: $(TARGET)

$(TARGET): led_control.o
	$(CC) $(LDFLAGS) $^ -o $@

deploy:
	make all && sshpass -p "1234" scp -r /home/soc/Documents/SOC_linux/Entregas/Entrega-3/ root@169.254.0.13:/root/	
run:
	cat sshCommands.sh | ssh root@169.254.0.13 &

led_control.o: led_control.c
	$(CC) $(CFLAGS) -fPIC -c $< -o $@

.PHONY: clean
clean:
	rm -f $(TARGET) *.o

