#!/bin/bash
# Jan 2023 Based on instructions from https://gist.github.com/MarioHewardt/5759641727aae880b29c8f715ba4d30f

# ANSI color variables
red="\e[0;91m"
blue="\e[0;94m"
expand_bg="\e[K"
blue_bg="\e[0;104m${expand_bg}"
red_bg="\e[0;101m${expand_bg}"
green_bg="\e[0;102m${expand_bg}"
green="\e[0;92m"
white="\e[0;97m"
bold="\e[1m"
uline="\e[4m"
reset="\e[0m"
Kernelcomp=""
Filecreation=""

if [ `whoami` != root ]; then
    echo "\n\n\n   ${red} ${bold} Please Run the program using Sudo   ${reset}\n\n\n"
    exit
fi
start=`date +%s`
clear
echo -e "\n\n\n\n ${blue} ${bold}---> This will take some time, you may want to get some coffee :) <--- ${reset} \n\n\n"
echo -e "\n\n\n\n ${green} ${bold}Please input your windows username\n"
read -p "  (to get it you can use the command 'echo %USERNAME%' on cmd ) :  " winusr
echo -e "${reset}" 
directory=~/CustomKernel
File=/mnt/c/Users/$winusr/CustomKernel/bzImage
wslfile=/mnt/c/Users/$winusr/CustomKernel/.wslconfig
echo -e "\n\n\n\n ${blue} ${bold}---> Now we will install all necessary components <--- ${reset} \n\n\n"
sudo apt install flex bison build-essential libelf-dev libncurses-dev  libssl-dev -y
clear
if [ -d "$directory" ]; then
	cd CustomKernel
else
	sudo mkdir CustomKernel
	cd CustomKernel
fi

echo -e "\n\n\n\n ${blue} ${bold}---> Now we will clone the official WSL repository <--- ${reset} \n\n\n"
sudo git clone https://github.com/microsoft/WSL2-Linux-Kernel.git
cd WSL2-Linux-Kernel
cp Microsoft/config-wsl .config
clear
echo -e "\n\n\n ${blue} ${bold}---> Now on this menu you will be able to choose the components for your Custom kernel < ---${reset} \n\n\n"
echo -e "CONFIG_BPF=y\nCONFIG_BPF_SYSCALL=y\nCONFIG_NET_CLS_BPF=m\nCONFIG_NET_ACT_BPF=m\nCONFIG_BPF_JIT=y\nCONFIG_HAVE_BPF_JIT=y\nCONFIG_HAVE_EBPF_JIT=y\nCONFIG_BPF_EVENTS=y\nCONFIG_IKHEADERS=y\nCONFIG_NET_SCH_SFQ=m\nCONFIG_NET_ACT_POLICE=m\nCONFIG_NET_ACT_GACT=m\nCONFIG_DUMMY=m\nCONFIG_VXLAN=m" >> .config
make menuconfig
clear
export KERNELRELEASE=$(uname -r)
echo -e "\n\n\n ${blue} ${bold}---> Now the kernel will start compiling < ---${reset}  \n\n\n"
make KERNELRELEASE=$KERNELRELEASE -j 4
echo -e "\n\n\n ${blue} ${bold}---> Now the kernel modules will start compiling < ---${reset}  \n\n\n"
make KERNELRELEASE=$KERNELRELEASE modules -j 4
echo -e "\n\n\n ${blue} ${bold}---> Now the modules will be installed < ---${reset} \n\n\n"
sudo make KERNELRELEASE=$KERNELRELEASE modules_install 
sudo mount -t debugfs debugfs /sys/kernel/debug
echo -e "\n\n\n ${blue} ${bold}---> Now he script will copy the files created to your windows user folder < ---${reset} \n\n\n"
if [ -d "/mnt/c/Users/$winusr/CustomKernel" ]; then
	sudo cp arch/x86/boot/bzImage /mnt/c/Users/$winusr/CustomKernel/bzImage
else
	sudo mkdir /mnt/c/Users/$winusr/CustomKernel
	sudo cp arch/x86/boot/bzImage /mnt/c/Users/$winusr/CustomKernel/bzImage
fi

if [ -f "$wslfile" ]; then
	sudo echo -e "[wsl2]" > /mnt/c/Users/$winusr/CustomKernel/.wslconfig
	sudo echo -n "kernel=C:\\\\Users\\\\$winusr\\\\bzImage" >> /mnt/c/Users/$winusr/CustomKernel/.wslconfig
	sudo echo -e "\nswap=0\nlocalhostForwarding=true" >> /mnt/c/Users/$winusr/CustomKernel/.wslconfig
else 
	sudo touch /mnt/c/Users/$winusr/CustomKernel/.wslconfig
	sudo echo -e "[wsl2]" >> /mnt/c/Users/$winusr/CustomKernel/.wslconfig
	sudo echo -n "kernel=C:\\\\Users\\\\$winusr\\\\bzImage" >> /mnt/c/Users/$winusr/CustomKernel/.wslconfig
	sudo echo -e "\nswap=0\nlocalhostForwarding=true" >> /mnt/c/Users/$winusr/CustomKernel/.wslconfig
fi

if [ -d "/lib/modules/$(uname -r)/kernel" ]; then
        Kernelcomp="${green} ${bold} OK ${reset}"
else
        Kernelcomp="${red} ${bold} Fail ${reset}"
fi

if [ -f "$File" ]; then
        Filecreation="${green} ${bold} OK ${reset}"
else
        Filecreation="${red} ${bold} Fail ${reset}"
fi

end=`date +%s`
runtime=$((end-start))

echo -e "\n\n\n ----> Results <---- "
echo -e "\n\n\n Execution time was : $runtime Seconds \n\n"
echo -e "\n Kernel Compilation : $Kernelcomp"
echo -e "\n Kernel moved to Windows : $Filecreation"

if [ "$Filecreation" == "${green} ${bold} OK ${reset}" ]; then
        echo -e "\n\n\n ${green} ${bold} All set now just copy the files from the Custom Kernel folder within Windows (C:/Users/YourUser/CustomKernel) to the root of the Windows user folder. "
else
        echo -e "\n\n\n ${red} Something went wrong, Please submit an issue to report it ${reset} \n\n\n"
        exit 9999
fi
