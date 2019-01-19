FROM debian:buster

#   add the dependencies

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends apt-utils build-essential locales git cmake ca-certificates ssl-cert meson libglib2.0-dev libgdk-pixbuf2.0-dev libgtk-3-dev libgphoto2-dev gphoto2 libgudev-1.0-dev gobject-introspection liblcms2-dev libpeas-dev libgexiv2-dev libraw-dev libgstreamer1.0-0 gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-doc gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 gstreamer1.0-pulseaudio libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev gettext gtk-doc-tools dbus-x11 adwaita-icon-theme

#   prepare the environment

RUN locale-gen C.UTF-8
ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8:en
ENV LC_ALL C.UTF-8

#   clone source code, checkout dev branch

RUN mkdir -p ~/programs && git clone https://gitlab.com/entangle/entangle.git ~/programs/code-entangle &&  cd ~/programs/code-entangle && git checkout v2.0

#   configure build system and compile

RUN cd ~/programs/code-entangle && meson build-dir && ninja -C build-dir all && ninja -C build-dir install && ldconfig

#   set the entrypoint command

LABEL maintainer="kd6kxr@gmail.com"
CMD echo "This is a test..." && entangle && ditto /Captures /hi/Captures && echo "THATS ALL FOLKS!!!"
