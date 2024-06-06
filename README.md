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
clone the repository using ```git clone https://github.com/Yaliance/WSLCustomKernelCompiler.git```
then just follow this simple commands
```bash
cd WSLCustomKernelCompiler/
```
Currently the script needs to be converted to unix format since it was uploaded using Windows, for that use the following command:
```bash
sudo dos2unix CustomKernel.sh
```
then just run it using:
```bash
sudo bash CustomKernel.sh
```
the script will ask you for your windows user name so it can copy the files to the right folder. you can get the windows user name by opening cmd and using the command
```bash
echo %USERNAME%
```
By default the file bzImage (kernel) will be copied to a folder called "CustomKernel" inside your Windows user folder (C:/Users/yourusername/) along with a .wslconfig file.
To start using your new kernel you will just have to copy both files to the root of the windows user folder (C:/Users/yourusername/) and execute the following command on cmd:
```bash
wsl.exe --shutdown
```
this way you will restart WSL and will boot using your custom kernel, it may take a little longer to start for the first time with the new kernel.

Enjoy!

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
Clonar el repositorio usando ```git clone https://github.com/Yaliance/WSLCustomKernelCompiler.git``` 
Luego simplemente hay que seguir los commandos
```bash
cd WSLCustomKernelCompiler/
```
Por el momento se debe convertir el script al formato unix ya que fue subido usando Windows. Puedes convertirlo usando el siguiente comando:
```bash
sudo dos2unix CustomKernelSpanish.sh
```
Luego solo ejecutar usando:
```
sudo bash CustomKernelSpanish.sh
```
el script te pedirá tu nombre de usuario de Windows para poder copiar los archivos en la carpeta correcta. puedes obtener el nombre de usuario de Windows abriendo cmd y usando el comando
```bash
echo %USERNAME%
```
Por defecto el archivo bzImage(kernel) sera copiado a la carpeta "CustomKernel" dentro de la carpeta raiz de usuario en windows(C:/Usuarios/tu-nombre-de-usuario/) junto con un archive .wslconfig
Para comenzar a utilizar tu nuevo kernel sera necesario copiar los dos archivos a la carpeta raiz de usuario en windows(C:/Usuarios/tu-nombre-de-usuario/) y ejecutar el siguiente comando en cmd:

```bash
wsl.exe --shutdown
```
De esta manera reiniciaras WSL e iniciara usando tu nuevo kernel personalizado, puede que tome un poco mas de tiempo en iniciar la primera vez usando el nuevo kernel.

Que lo disfrutes!

#Proposito
El uso principal que le di a la compilación de un kernel personalizado es poder compilar controladores usando make y cargarlos usando modprobe para poder usar tarjetas wifi a través de USBIP. Compilar tu kernel personalizado para WSL te permitirá hacer muchas más cosas, pero eso depende de tus necesidades.
</p>
</details>
