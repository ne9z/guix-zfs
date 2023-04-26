;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu) (guix packages) (guix ci) (guix channels))
(use-service-modules cups desktop networking ssh xorg)
(use-package-modules certs file-systems linux)

(list (channel-with-substitutes-available
       %default-guix-channel
       "https://ci.guix.gnu.org/"))

;; credits to raid5atemyhomework

(define my-kernel linux-libre-5.10)

(define my-zfs
  (package
    (inherit zfs)
    (arguments
      (cons* #:linux my-kernel
             (package-arguments zfs)))))


(operating-system
  (kernel my-kernel)
  (locale "en_US.utf8")
  (timezone "Europe/Berlin")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "guix")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* %base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  (packages (append (list nss-certs my-zfs)
                    %base-packages))

  (kernel-loadable-modules (list (list my-zfs "module")))
  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   (append (list (service connman-service-type)
                 (service wpa-supplicant-service-type)
                 (service ntp-service-type))

           ;; This is the default list of services we
           ;; are appending to.
           %base-services))
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))
  (swap-devices (list (swap-space
                        (target (uuid
                                 "a11257dc-7c60-4e49-ac89-8a3da336252f")))))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "D402-E003"
                                       'fat32))
                         (type "vfat"))
                       (file-system
                         (mount-point "/")
                         (device (uuid
                                  "37638ef6-974a-4466-93e2-3150c90cee15"
                                  'ext4))
                         (type "ext4")) %base-file-systems)))
