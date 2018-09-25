


# C flags common to all targets
CFLAGS += -DNRF51
CFLAGS += -DNRF51422
CFLAGS += -DSWI_DISABLE0
CFLAGS += -DBOARD_PCA10028
CFLAGS += -mcpu=cortex-m0
CFLAGS += -mthumb -mabi=aapcs
CFLAGS += -Wall -Werror -O3 -g3
CFLAGS += -mfloat-abi=soft
# keep every function in separate section, this allows linker to discard unused ones
CFLAGS += -ffunction-sections -fdata-sections -fno-strict-aliasing
CFLAGS += -fno-builtin --short-enums 

# C++ flags common to all targets
CXXFLAGS += \

# Assembler flags common to all targets
ASMFLAGS += -x assembler-with-cpp
ASMFLAGS += -DNRF51
ASMFLAGS += -DNRF51422
ASMFLAGS += -DSWI_DISABLE0
ASMFLAGS += -DBOARD_PCA10028

# Linker flags
LDFLAGS += -mthumb -mabi=aapcs -L $(TEMPLATE_PATH) -T$(LINKER_SCRIPT)
LDFLAGS += -mcpu=cortex-m0
# let linker to dump unused sections
LDFLAGS += -Wl,--gc-sections
# use newlib in nano version
LDFLAGS += --specs=nano.specs -lc -lnosys




#KIND := NO_BLE
KIND := BLE

ifeq ($(KIND),NO_BLE)
	CFLAGS += -DBSP_DEFINES_ONLY

	ASMFLAGS += -DBSP_DEFINES_ONLY
endif

ifeq ($(KIND),BLE)
	CFLAGS += -DSOFTDEVICE_PRESENT
	CFLAGS += -D__HEAP_SIZE=0
	CFLAGS += -DS130
	CFLAGS += -DBLE_STACK_SUPPORT_REQD
	CFLAGS += -DNRF_SD_BLE_API_VERSION=2

	ASMFLAGS += -DSOFTDEVICE_PRESENT
	ASMFLAGS += -D__HEAP_SIZE=0
	ASMFLAGS += -DS130
	ASMFLAGS += -DBLE_STACK_SUPPORT_REQD
	ASMFLAGS += -DNRF_SD_BLE_API_VERSION=2
endif




# JLINK
NRF_JLINK_PROG = ../../../tool/nRF5x-Command-Line-Tools_9_7_3/nrfjprog/nrfjprog 
