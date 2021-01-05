TARGET = blink-cmsis

TOOLCHAIN = ../gcc-arm-none-eabi
AS = arm-none-eabi-as
LD = arm-none-eabi-gcc
CC = arm-none-eabi-gcc
OC = arm-none-eabi-objcopy
OD = arm-none-eabi-objdump
OS = arm-none-eabi-size

LINKSCRIPT = ./ld/stm32h745xx_flash_CM7.ld

#Hal
CMSISSRC += ./Drivers/CMSIS/Device/ST/STM32H7xx/Source/Templates/system_stm32h7xx.c
#RCC
STSRC += ./Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_rcc.c
#GPIO
STSRC += ./Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_gpio.c
#EXTI
STSRC += ./Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_exti.c
#HAL
STSRC += ./Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal.c
#pwr
STSRC += ./Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_pwr_ex.c
#cortex
STSRC += ./Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_cortex.c

SRC += $(wildcard src/*.c)
SRC += $(CMSISSRC)
SRC += $(STSRC)

#Ref Design
SRC += ./Drivers/BSP/STM32H7xx_Nucleo_144/stm32h7xx_nucleo_144.c
#BSP
INCLUDE += -I./Drivers/BSP/STM32H743I_EVAL/

#start up Drivers\CMSIS\Device\ST\STM32H7xx\Source\Templates\gcc\startup_stm32h743xx.s
ASRC = ./Drivers/CMSIS/Device/ST/STM32H7xx/Source/Templates/gcc/startup_stm32h743xx.s

INCLUDE += -I./inc
INCLUDE += -I./Drivers/CMSIS/Device/ST/STM32H7xx/Include
INCLUDE += -I./Drivers/CMSIS/Core/Include
INCLUDE += -I./Drivers/STM32H7xx_HAL_Driver/inc

#Gather objects to build
OBJS = $(ASRC:.s=.o) $(SRC:.c=.o)

####### Build flags
ARCH_FLAGS=-mthumb -mcpu=cortex-m7 -mfpu=fpv5-sp-d16 -mfloat-abi=hard -ffunction-sections -fdata-sections -ffast-math
CFLAGS=-ggdb -O2 -std=c99 -Wall -Wextra -Warray-bounds -Wno-unused-parameter $(ARCH_FLAGS) $(INC) -DSTM32H743xx -DUSE_HAL_DRIVER
LDFLAGS=-Wl,--gc-sections -Xlinker -Map=output.map  -lm
##########

all: $(TARGET).elf flash 

$(TARGET).elf: $(OBJS)
	@echo	
	@echo Linking: $@
	$(LD) $(ARCH_FLAGS) -T $(LINKSCRIPT) -o $@ $(OBJS) $(LDFLAGS) 
	$(OD) -h -S $(TARGET).elf > $(TARGET).lst
		
flash: $(TARGET).elf size
	@echo
	@echo Creating .hex and .bin flash images:
	$(OC) -O ihex $< $(TARGET)_firmware.hex
	$(OC) -O binary $< $(TARGET)_firmware.bin
	
size: $(TARGET).elf
	@echo
	@echo == Object size ==
	@$(OS) --format=berkeley $<
	
%.o: %.c
	@echo
	@echo Compiling: $<
	$(CC) -c $(CFLAGS) $(INCLUDE) -I. $< -o $@

%.o: %.s
	@echo
	@echo Assembling: $<
	$(CC) -x assembler-with-cpp -c $(ARCH_FLAGS) $< -o $@	

clean: 
	@echo Cleaning:
	$(RM) $(OBJS)
	$(RM) *.elf
	$(RM) *.lst
	$(RM) *.map
	$(RM) *.bin
	$(RM) *.hex
