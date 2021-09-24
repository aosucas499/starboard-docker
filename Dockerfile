##aosucas499/starboard:0.1
# Cambio:
#Basado en Guadalinex Edu 2013 repositories 
#Basado en ubuntu 14 trusty
#Comando para crear imagen docker, usar comando en la misma carpeta de este archivo
# sudo docker build -t aosucas499/starboard:0.1 .

# Uso de la imagen y variables
FROM aosucas499/guadalinex:edu
MAINTAINER Andrés Osuna <aosucas499gmail.com>
ENV DEBIAN_FRONTEND=noninteractive
ENV QT_X11_NO_MITSHM=1

RUN mkdir /var/run/dbus && chown messagebus:messagebus /var/run/dbus/

# Instala paquetes básicos
RUN apt-get update && apt-get install apt-utils -y && apt-get install libusb-1.0 libglib2.0-bin gsettings-desktop-schemas  gconf2 unzip -y

# No necesario pues el módulo táctil de la pizarra hay que compilarlo con el kernel del host no con el docker
#RUN apt-get install make gcc -y

# Instala paquetes necesarios software starboard
RUN apt-get install -y libjpeg62 libxtst6 libusb-0.1-4 libstdc++6 libfreetype6 libsm6 libglib2.0-0 libxrender1 libfontconfig1 libqtgui4
 
# Instala el software de la pizarra
#RUN wget http://migasfree.educa.aragon.es/pdis/HITACHI/StarBoardSoftware_9.62_i586.deb
RUN wget http://www.charmexdocs.com/int/software/SBS0962_LINUX.zip && unzip SBS0962_LINUX.zip && rm SBS0962_LINUX.zip
RUN dpkg -i SBS0962_LINUX/StarBoardSoftware/StarBoardSoftware_9.62_i586.deb
RUN rm -r SBS0962_LINUX

# Eliminación de paquetes y cache
RUN apt-get clean && apt-get autoclean 

COPY init.sh /
RUN chmod +x /init.sh
ENTRYPOINT /init.sh





