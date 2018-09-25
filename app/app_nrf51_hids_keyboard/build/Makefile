PROJECT_NAME     := blinky_pca10028
TARGETS          := nrf51422_xxac
OUTPUT_DIRECTORY := _build

SDK_ROOT := ../../../sdk/nRF5_SDK_12.3.0_d7731ad
PROJ_DIR := ..

$(OUTPUT_DIRECTORY)/nrf51422_xxac.out: \
  LINKER_SCRIPT  := ble_app_gcc_nrf51.ld


-include sources.mk
-include objects.mk


.PHONY: $(TARGETS) default all clean help flash 

# Default target - first one defined
default: nrf51422_xxac

# Print all targets that can be built
help:
	@echo following targets are available:
	@echo 	nrf51422_xxac

TEMPLATE_PATH := $(SDK_ROOT)/components/toolchain/gcc

include $(TEMPLATE_PATH)/Makefile.common

$(foreach target, $(TARGETS), $(call define_target, $(target)))

# Flash the program
flash: $(OUTPUT_DIRECTORY)/nrf51422_xxac.hex
	@echo Flashing: $<
	${NRF_JLINK_PROG} --program $< -f nrf51 --sectorerase
	${NRF_JLINK_PROG} --reset -f nrf51

# Flash softdevice
flash_softdevice:
	@echo Flashing: s130_nrf51_2.0.1_softdevice.hex
	${NRF_JLINK_PROG} --program $(SDK_ROOT)/components/softdevice/s130/hex/s130_nrf51_2.0.1_softdevice.hex -f nrf51 --sectorerase 
	${NRF_JLINK_PROG} --reset -f nrf51


erase:
	${NRF_JLINK_PROG} --eraseall -f nrf51
