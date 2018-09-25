#### 1. Brief introduction

The project provides a nRF51 APP command-line development environment based on Linux system.

You can directly write、build、install APP(HEX/BIN) without using IDE.


#### 2. How to use

Enter the root directory, run the run.sh

If it is the first time to compile, It is recommended to run `make tool` to download platform、SDK、build-tools etc.

	cd ./example/HelloAndroid
	make tool

Build the project:

	make build
	
Install the APP:

	make program
	

**more：**[https://www.cnblogs.com/zjutlitao/p/9672376.html](https://www.cnblogs.com/zjutlitao/p/9672376.html)


#### 3. Demos
