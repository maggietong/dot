#!/bin/sh

 #!/bin/sh

 export CONCURRENCY_LEVEL=2

 cd ~/kernel

 #rsync -xa --delete linux-3.8.10.orig/ linux-3.8.10/

 cd linux-3.8.10
 cp -f /boot/config-3.8.0-19-generic ./.config

 make olddefconfig

 fakeroot make-kpkg clean
 fakeroot make-kpkg --uc --us --initrd --revision=0.1 kernel_image kernel_source kernel_headers modules
