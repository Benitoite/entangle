FROM debian:stretch

#   add the dependencies

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends build-essential locales meson libglib2.0-dev libgdk-pixbuf2.0-dev libgtk-3-dev libgphoto2-dev libgudev-1.0-dev gobject-introspection liblcms2-dev libpeas-dev libgexiv2-dev libraw-dev adwaita-icon-theme

#   prepare the environment

RUN locale-gen C.UTF-8
ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8:en
ENV LC_ALL C.UTF-8

#   clone source code, checkout dev branch

RUN mkdir -p ~/programs && git clone https://gitlab.com/entangle/entangle.git ~/programs/code-entangle &&  cd ~/programs/code-entangle && git checkout v2.0

#   configure build system and compile

RUN cd ~/programs/code-entangle && meson build-dir && ninja -C build-dir all && ninja -C build-dir install

#   set the entrypoint command

LABEL maintainer="kd6kxr@gmail.com"
CMD echo "This is a test..." && entangle && echo "THATS ALL FOLKS!!!"
