PROJECT_NAME     := ble_app_blinky_pca10040_s132
TARGETS          := nrf52832_xxaa
OUTPUT_DIRECTORY := _build

SDK_ROOT := ../../../sdk/nRF5_SDK_15.2.0_9412b96
PROJ_DIR := ..

$(OUTPUT_DIRECTORY)/nrf52832_xxaa.out: \
  LINKER_SCRIPT  := ble_app_blinky_gcc_nrf52.ld


-include sources.mk
-include objects.mk


.PHONY: default help

# Default target - first one defined
default: nrf52832_xxaa

# Print all targets that can be built
help:
	@echo following targets are available:
	@echo		nrf52832_xxaa
	@echo		flash_softdevice
	@echo		sdk_config - starting external tool for editing sdk_config.h
	@echo		flash      - flashing binary

TEMPLATE_PATH := $(SDK_ROOT)/components/toolchain/gcc


include $(TEMPLATE_PATH)/Makefile.common

$(foreach target, $(TARGETS), $(call define_target, $(target)))

.PHONY: flash flash_softdevice erase

# Flash the program
flash: default
	@echo Flashing: $(OUTPUT_DIRECTORY)/nrf52832_xxaa.hex
	${NRF_JLINK_PROG} -f nrf52 --program $(OUTPUT_DIRECTORY)/nrf52832_xxaa.hex --sectorerase
	${NRF_JLINK_PROG}  -f nrf52 --reset

# Flash softdevice
flash_softdevice:
	@echo Flashing: s132_nrf52_6.1.0_softdevice.hex
	${NRF_JLINK_PROG}  	 -f nrf52 --program $(SDK_ROOT)/components/softdevice/s132/hex/s132_nrf52_6.1.0_softdevice.hex --sectorerase
	${NRF_JLINK_PROG} -f nrf52 --reset

erase:
	${NRF_JLINK_PROG} -f nrf52 --eraseall

SDK_CONFIG_FILE := ../config/sdk_config.h
CMSIS_CONFIG_TOOL := $(SDK_ROOT)/external_tools/cmsisconfig/CMSIS_Configuration_Wizard.jar
sdk_config:
	java -jar $(CMSIS_CONFIG_TOOL) $(SDK_CONFIG_FILE)
