### Entangle

* The Entangle repo is located at https://gitlab.com/entangle/entangle/

<hr>

# macOS 

### Runs entangle in boot2docker VM and copies captures to timestamped dir in ~ on host.

<hr>

* ## First Terminal

1. `open -a Xquartz`
2. `socat TCP-LISTEN:6000,bind=$(ifconfig -a|tail +9|grep 'inet '|cut -d ' ' -f 2|head -1),reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"`

* ## In Second Terminal

3. `echo $(ifconfig -a|tail +9|grep 'inet '|cut -d ' ' -f 2|head -1) > /private/var/tmp/hostip`
4. `echo $HOME>/private/var/tmp/homedir` 

* ## In VirtualBox / boot2docker (

5. Settings > Ports: add USB2 or USB3 driver and add the filter for your connected camera.
6. Setting > Shared Folders: add Folder Path `/private/var/tmp` with Mount Point `/tmp2` and Folder Path `/Users` with mount point `/Users`
7. Start the boot2docker VM
8. `docker pull kd6kxr/entangle`
9. `docker run -it -e DISPLAY=$(cat /tmp2/hostip):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v $(cat /tmp2/homedir):/hi -v /dev/bus/usb:/dev/bus/usb --privileged kd6kxr/entangle`
10. `exit` when finished

<hr>

* If you'd like to download the above `docker run` command to your boot2docker VM, issue the following commands:
`curl https://tinyurl.com/entangleme -L > cmnd && chmod +x cmnd`
Then run the image with `./cmnd`

* The latest release of the boot2docker ISO can be found here: https://github.com/boot2docker/boot2docker/releases


```
       Entangle: Tethered Camera Control & Capture
       ===========================================

Entangle is an application which uses GTK and libgphoto2 to provide a
graphical interface for tethered photography with digital cameras.

It includes control over camera shooting and configuration settings
and 'hands off' shooting directly from the controlling computer.

Installation
------------

The Entangle package uses the Meson build system available from:

  http://mesonbuild.com/

As a quick start you can do

  meson build-dir
  ninja -C build-dir all
  sudo ninja -C build-dir install

Or to install into a private user specific location

  meson build-dir --prefix=$HOME/entangle
  ninja -C build-dir all
  ninja -C build-dir install

NB, if not installing in the default prefix "/usr", GTK will
probably have trouble finding the gsettings files and the GI
typelib files needed by the plugins. To fix this set some
environment variables

 - XDG_DATA_DIRS variable to point to the data directory,
   which is usually "$prefix/share" where $prefix is the
   arg given to meson. eg

    XDG_DATA_DIRS=/usr/share:/usr/local/share:$HOME/entangle/share
    export XDG_DATA_DIRS

 - GI_TYPELIB_PATH variable to point to the gobject introspection
   typelib repository which is usually "$prefix/lib/girepository-1.0"
   Some distros will need "lib64" instead of "lib".

    GI_TYPELIB_PATH=$HOME/entangle/lib/girepository-1.0
    export GI_TYPELIB_PATH

OS distro packagers should use the --disable-schemas-compile arg
to configure to skip the compilation stage for schema files if
installing to the /usr prefix

Building entangle requires the following external packages to
be present

 meson                 >= 0.41.0
 glib2                 >= 2.26.0
 gdk-pixbf             >= 2.12.0
 gtk3                  >= 3.22.0
 libgphoto2            >= 2.4.11
 gudev                 >= 145
 gobject-introspection >= 1.54.0
 lcms2                 >= 2.0
 libpeas               >= 0.5.5
 gexiv2                >= 0.2.2
 LibRaw                >= 0.9.0
 adwaita-icon-theme


Communication
-------------

To communicate with the development team, or to post patches
there is a technical mailing list:

   https://groups.google.com/forum/#!forum/entangle-devel

Bugs found when using an OS distribution's binary packages should
be reported to the OS vendors' own bug tracker first. Otherwise
they can be reported to

   https://gitlab.com/entangle/entangle/issues

The latest entangle code can be found in GIT at:

   https://gitlab.com/entangle/entangle

For further information visit

   http://entangle-photo.org/

Translators please see po/README.I18N for more guidance.

UI shortcuts
------------

There are a number of shortcuts available for common operations

 - 's' - Trigger the shutter, to shoot a picture
 - 'p' - Toggle 'live view' preview mode
 - 'esc' - Cancel the current operation
 - 'm' - Toggle aspect ratio image mask
 - 'h' - Toggle linear / logarithmic histogram
 - 'a' - Drive autofocus during preview
 - ',' or '.' - Drive manual focus during preview (fine control)
 - '<' or '>' - Drive manual focus during preview (coarse control)

License
-------

Entangle is distributed under the terms of the GNU GPL v3+, except
for the Logo which is under the Creative Commons 1.0 Public
Domain Dedication.

Please see the COPYING file for the complete GPLv3+ license
terms, or visit <http://www.gnu.org/licenses/>.

-- End
```
