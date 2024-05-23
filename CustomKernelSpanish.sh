#!/bin/bash
# Enero 2023 Basado en las instrucciones de https://gist.github.com/MarioHewardt/5759641727aae880b29c8f715ba4d30f

# variables ansi de color
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
    echo "\n\n\n   ${red} ${bold} Por Favor corra el programa usando sudo   ${reset}\n\n\n"
    exit
fi
start=`date +%s`
clear
echo -e "\n\n\n\n ${blue} ${bold}---> Esto tomara algo de tiempo, Tal vez quieras prepararte un cafe :) <--- ${reset} \n\n\n"
echo -e "\n\n\n\n ${green} ${bold}Ingrese su nombe de usuario de Windows\n"
read -p "  (puede obtenerlo con el comando 'echo %USERNAME%' en cmd ) :  " winusr
echo -e "${reset}" 
directory=~/CustomKernel
File=/mnt/c/Users/$winusr/CustomKernel/bzImage
wslfile=/mnt/c/Users/$winusr/CustomKernel/.wslconfig
echo -e "\n\n\n\n ${blue} ${bold}---> Ahora se instalaran los componentes necesarios <--- ${reset} \n\n\n"
sudo apt update
sudo apt install flex bison build-essential libelf-dev libncurses-dev make libssl-dev bc pahole dwarves -y
clear
if [ -d "$directory" ]; then
	cd CustomKernel
else
	sudo mkdir CustomKernel
	cd CustomKernel
fi

echo -e "\n\n\n\n ${blue} ${bold}---> Ahora se clonara el repositorio del kernel para WSL <--- ${reset} \n\n\n"
sudo git clone https://github.com/microsoft/WSL2-Linux-Kernel.git
cd WSL2-Linux-Kernel
cp Microsoft/config-wsl .config
clear
echo -e "\n\n\n ${blue} ${bold}---> Ahora en este menu podras seleccionar los modulos que deseas activar en tu kernel < ---${reset} \n\n\n"
echo -e "CONFIG_BPF=y\nCONFIG_BPF_SYSCALL=y\nCONFIG_NET_CLS_BPF=m\nCONFIG_NET_ACT_BPF=m\nCONFIG_BPF_JIT=y\nCONFIG_HAVE_BPF_JIT=y\nCONFIG_HAVE_EBPF_JIT=y\nCONFIG_BPF_EVENTS=y\nCONFIG_IKHEADERS=y\nCONFIG_NET_SCH_SFQ=m\nCONFIG_NET_ACT_POLICE=m\nCONFIG_NET_ACT_GACT=m\nCONFIG_DUMMY=m\nCONFIG_VXLAN=m" >> .config
make menuconfig
clear
export KERNELRELEASE=$(uname -r)
echo -e "\n\n\n ${blue} ${bold}---> Ahora comenzara a compilarse el kernel < ---${reset}  \n\n\n"
make KERNELRELEASE=$KERNELRELEASE -j 4
echo -e "\n\n\n ${blue} ${bold}---> Ahora comenzaran a compilarse los modulos < ---${reset}  \n\n\n"
make KERNELRELEASE=$KERNELRELEASE modules -j 4
echo -e "\n\n\n ${blue} ${bold}---> Ahora comenzaran a instalarse los modulos < ---${reset} \n\n\n"
sudo make KERNELRELEASE=$KERNELRELEASE modules_install 
sudo mount -t debugfs debugfs /sys/kernel/debug
echo -e "\n\n\n ${blue} ${bold}---> Ahora el programa copiara el kernel a tu carpeta de usuario en windows < ---${reset} \n\n\n"
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
        Kernelcomp="${red} ${bold} Fallo ${reset}"
fi

if [ -f "$File" ]; then
        Filecreation="${green} ${bold} OK ${reset}"
else
        Filecreation="${red} ${bold} Fallo ${reset}"
fi

end=`date +%s`
runtime=$((end-start))

echo -e "\n\n\n ----> Resultados <---- "
echo -e "\n\n\n El tiempo de ejecucion fue : $runtime Segundos \n\n"
echo -e "\n Compilacion de kernel : $Kernelcomp"
echo -e "\n Kernel copiado a Windows : $Filecreation"

if [ "$Filecreation" == "${green} ${bold} OK ${reset}" ]; then
        echo -e "\n\n\n ${green} ${bold} Todo listo ahora solo copia los archivos de la carpeta Custom Kernel en Windows a la raiz de la carpeta de usuario "
else
        echo -e "\n\n\n ${red} Ocurrio un error, por favor abra un issue para reportarlo ${reset} \n\n\n"
        exit 9999
fi
