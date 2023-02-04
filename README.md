# WSLCustomKernelCompiler

An Automation bash script to compile custom kernels for WSL

The script walks you though the process of compiling a custom kernel for WSL. 
It installs all dependencies.
Clones the official WSLKernel repository.
Brings up the customization menu for the WSL Kernel. 
Compiles the Kernel modules
Copies the Kernel and .wslconf file to your windows folder so it is ready to be used 

# Usage
clone the repository using ```git clone https://github.com/Yaliance/WSLCustomKernelCompiler```
then just follow this simple commands
```bash
cd WSLCustomKernelCompiler/
```
```bash
sudo CustomKernelSpanish.sh
```
the script will ask you for your windows user name so it can copy the files to the right folder. you can get the windows user name by opening cmd and using the command
```bash
echo %USERNAME%
```

# Use
The main usage I gave to compiling a custom kernel is for me to be able to compile drivers using make and load them using modprobe so i can use wifi cards over USBIP.
Compiling your custom kernel for WSL will allow you to do many more things but that depends on your needs.
