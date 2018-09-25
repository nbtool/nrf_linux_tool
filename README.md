#### 1. Brief introduction

The project provides a nRF51 APP command-line development environment based on Linux system.

You can directly write、build、install APP(HEX/BIN) without using IDE.


#### 2. How to use

If it is the first time to compile, It is recommended to run goto tool directly, and then run the './run.sh tool' to download gcc、SDK、build-tools etc.

	cd ./tool
	./run.sh tool

Build the project(for example:app_nrf51_hids_keyboard):

	cd ./app/app_nrf51_hids_keyboard/build
    make clean
    make all

Install the APP:

    make erase
    make flash_flash_softdevice
    make flash
	

**more：**[https://www.cnblogs.com/zjutlitao/p/9614787.html](https://www.cnblogs.com/zjutlitao/p/9614787.html)


#### 3. Demos

- app_nrf51_peri_blinky
- app_nrf51_ble_hrs
- app_nrf51_hids_mouse
- app_nrf51_hids_keyboard
