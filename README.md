# WSLCustomKernelCompiler
<details><summary>English Instructions</summary>
<p>
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
</p>
</details>


<details><summary>Instrucciones en Español</summary>
<p>
Un Script de automatizacion para la creacion de Kernels para WSL personalizados 

El script te guía a través del proceso de compilación de un kernel personalizado para WSL. Instala todas las dependencias. Clona el repositorio oficial de Kernel para WSL. Muestra el menú de personalización del kernel de WSL. Compila los módulos del Kernel. Copia el Kernel y el archivo .wslconf a tu carpeta de Windows para que esté listo para usarse.

#Uso
Clonar el repositorio usando ```git clone https://github.com/Yaliance/WSLCustomKernelCompiler``` 
Luego simplemente hay que seguir los commandos
```bash
cd WSLCustomKernelCompiler/
```
```
sudo CustomKernelSpanish.sh
```
el script te pedirá tu nombre de usuario de Windows para poder copiar los archivos en la carpeta correcta. puedes obtener el nombre de usuario de Windows abriendo cmd y usando el comando
```bash
echo %USERNAME%
```
#Proposito
El uso principal que le di a la compilación de un kernel personalizado es poder compilar controladores usando make y cargarlos usando modprobe para poder usar tarjetas wifi a través de USBIP. Compilar tu kernel personalizado para WSL te permitirá hacer muchas más cosas, pero eso depende de tus necesidades.
</p>
</details>
