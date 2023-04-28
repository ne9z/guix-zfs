;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu))
(use-service-modules desktop networking ssh)
(use-package-modules certs guile emacs emacs-xyz wm terminals)

(operating-system
  (locale "en_US.utf8")
  (timezone "Europe/Berlin")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "guix")

  (users (cons*
          (user-account
           (name "yc")
           (group "users")
           (supplementary-groups '("wheel" "seat" "video"))
           (password
            "$6$Cxvgcprw5eeIevs1$tWBHPoK4/dFe26NkTJBAfIvtTVnJ6Ti10QEgxMkRiXQj/YqTwrJ5d4r406maz0UXY6iE9kf9LqHJE1VbiyYOW1"))
          %base-user-accounts))

  (packages (append (list
                     nss-certs
                     emacs
                     emacs-pyim
                     foot
                     sway)
                    %base-packages))

  (services
   (append
    (list (service connman-service-type)
          (service wpa-supplicant-service-type)
          (service ntp-service-type)
          (service openssh-service-type)
          (service seatd-service-type))
    %base-services))

  (bootloader
   (bootloader-configuration
    (bootloader grub-bootloader)
    (targets (list "/dev/disk/by-id/virtio-test1"))
    (keyboard-layout keyboard-layout)))

  (swap-devices
   (list
    (swap-space
     (target "/dev/disk/by-id/virtio-test1-part3"))))

  (file-systems
   (cons*
    (file-system
     (mount-point "/boot/efi")
     (device (file-system-label "EFI"))
     (type "vfat"))
    (file-system
     (mount-point "/")
     (device (file-system-label "guix"))
     (type "ext4"))
    %base-file-systems)))
