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
(use-service-modules desktop networking ssh sound)
(use-package-modules certs guile emacs emacs-xyz wm terminals
		     mail gnuzilla tor i2p networking tex tmux pulseaudio
		     engineering linux gps image-viewers julia pdf virtualization image w3m video password-utils dns version-control
		     ;; qrencode
		     aidc
		     ;;gammastep
		     xdisorg)

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
                     ;; https certs
                     nss-certs
                     ;; emacs
                     emacs
                     emacs-pyim
                     emacs-pyim-basedict
                     emacs-auctex
                     emacs-use-package
                     emacs-notmuch
                     emacs-julia-mode
                     ;; firefox
                     icecat
                     ;; hidden
                     tor-client
                     i2pd
                     yggdrasil
                     ;; tex
                     texlive-base
                     ;; tmux
                     tmux
                     ;; vol
                     pavucontrol
                     ;; misc
                     qrencode
                     minicom
                     sterm
                     jmtpfs
                     gpxsee
                     nomacs
                     julia
                     qpdf
                     ;; virt
                     virt-manager
                     ;; wm
                     foot
                     sway
                     waybar
                     swayidle
                     swaylock
                     gammastep
                     brightnessctl
                     fuzzel
                     grim
                     w3m
                     wl-clipboard
                     ;; tablet
                     xournalpp
                     ;; media
                     mpv
                     yt-dlp
                     ;; mail
                     isync
                     msmtp
                     notmuch
                     ;; pdf
                     zathura
                     zathura-pdf-mupdf
                     ;; passwords
                     password-store
                     ;; dns
                     dnscrypt-proxy
                     ;; git
                     git-minimal)
                    %base-packages))

  (services
   (append
    (list (service connman-service-type)
          (service wpa-supplicant-service-type)
          (service ntp-service-type)
          (service openssh-service-type)
          (service alsa-service-type)
          (service pulseaudio-service-type)
          (service libvirt-service-type)
          (service tor-service-type)
          (service yggdrasil-service-type)
          (service sddm-service-type
                   (sddm-configuration
                    (display-server "wayland")))
          (service seatd-service-type))
    %base-services))

  (bootloader
   (bootloader-configuration
    (bootloader grub-bootloader)
    (targets (list "/dev/disk/by-id/virtio-test1"))
    (keyboard-layout keyboard-layout)))

  (mapped-devices
   (list (mapped-device
          ;; get uuid with cryptsetup luksUUID /dev/sda3
          (source (uuid "4355ca4e-e2be-4cd7-ae81-31c6325744c7"))
          (target "encrypted-root")
          (type luks-device-mapping))))

  (swap-devices
   (list
    (swap-space
     (target "/swapfile"))))

  (file-systems
   (cons*
    (file-system
     (mount-point "/boot/efi")
     (device (file-system-label "EFI"))
     (type "vfat"))
    (file-system
     (mount-point "/")
     (device "/dev/mapper/encrypted-root")
     (type "xfs")
     (dependencies mapped-devices))
    %base-file-systems)))
