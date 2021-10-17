##aosucas499/starboard:0.2
# Cambio:
#Basado en Guadalinex Edu 2013 repositories 
#Basado en ubuntu 14 trusty
#Comando para crear imagen docker, usar comando en la misma carpeta de este archivo
# sudo docker build -t aosucas499/starboard:0.2 .

# Uso de la imagen y variables
FROM i386/ubuntu:trusty
MAINTAINER Andrés Osuna <aosucas499gmail.com>
ENV DEBIAN_FRONTEND=noninteractive
ENV QT_X11_NO_MITSHM=1

# Paquetes de ubuntu trusty

RUN apt-get update && apt-get install -y nano wget grep screen unzip libglib2.0-bin x11-xserver-utils gsettings-desktop-schemas gsettings-ubuntu-schemas onboard gconf2 && apt-get clean

# Instala repositorios guadalinex edu 2013

RUN rm /etc/apt/sources.list && rm /etc/apt/sources.list.d/*

ARG REPO1=http://centros.edu.guadalinex.org/Edu/catcorner
ARG REPO2=http://centros.edu.guadalinex.org/Edu/catcornerdda
ARG REPO3=http://centros.edu.guadalinex.org/Edu/catcornerdda2
ARG REPO4=http://centros.edu.guadalinex.org/Edu/catcornersc
ARG REPO5=http://centros.edu.guadalinex.org/Edu/precise
ARG REPO6=http://centros.edu.guadalinex.org/Edu/precisedda
ARG REPO7=http://centros.edu.guadalinex.org/Edu/precisedda2

RUN echo deb $REPO1 guadalinexedu main > /etc/apt/sources.list && echo deb $REPO2 guadalinexedu main > /etc/apt/sources.list.d/guadalinex.list && echo deb $REPO3 guadalinexedu main >> /etc/apt/sources.list.d/guadalinex.list && echo deb $REPO4 guadalinexedu main >> etc/apt/sources.list.d/guadalinex.list && echo deb $REPO5 precise main >> /etc/apt/sources.list && echo deb $REPO6 precise main >> /etc/apt/sources.list.d/guadalinex.list && echo deb $REPO7 precise main >> /etc/apt/sources.list.d/guadalinex.list 

#wget http://centros.edu.guadalinex.org/Edu/catcorner/pool/main/g/guadalinexedu-keyring/guadalinexedu-keyring_0.1-10_all.deb
COPY guadalinexedu-keyring_0.1-10_all.deb /

RUN dpkg -i guadalinexedu-keyring_0.1-10_all.deb && rm *.deb

RUN apt-get update && apt-get install libnotify-bin dbus dbus-x11 libusb-1.0 -y && apt-get clean

RUN mkdir /var/run/dbus && chown messagebus:messagebus /var/run/dbus/

# Instala paquetes necesarios software starboard

RUN apt-get install -y libjpeg62:i386 libxtst6:i386 libusb-0.1-4:i386 libstdc++6:i386 libfreetype6:i386 libsm6:i386 libglib2.0-0:i386 libxrender1:i386 libfontconfig1:i386 libqtgui4:i386 && apt-get clean

RUN mkdir /usr/share/applications -p && mkdir /usr/share/desktop-directories -p

# Instala el software de la pizarra
#RUN wget http://migasfree.educa.aragon.es/pdis/HITACHI/StarBoardSoftware_9.62_i586.deb
RUN wget http://www.charmexdocs.com/int/software/SBS0962_LINUX.zip && unzip SBS0962_LINUX.zip && rm SBS0962_LINUX.zip
RUN dpkg -i SBS0962_LINUX/StarBoardSoftware/StarBoardSoftware_9.62_i586.deb
RUN rm -r SBS0962_LINUX

# Eliminación de paquetes y cache
RUN apt-get clean && apt-get autoclean 

COPY ./docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]












