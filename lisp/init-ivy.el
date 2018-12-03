;;; init-ivy.el --- ivy configuration
;;
;; Copyright (c) 2018 Chunhui Ren
;;
;; Author  : Chunhui Ren <renchunhui2008@gmail.com>
;; URL     : https://github.com/RenChunhui/.emacs.d
;; Version : 1.0.0
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;;; Code:

(use-package counsel
  :ensure t
  :defer 2
  :init
  (progn
    (evil-leader/set-key
      "ff" 'counsel-find-file
      "fel" 'counsel-find-library
      "fL" 'counsel-locate))
  :config
  (progn
    (define-key counsel-find-file-map (kbd "C-h") 'counsel-up-directory)
    (counsel-mode 1)))

(use-package counsel-projectile
  :ensure t
  :defer 2
  :init
  (progn
    (evil-leader/set-key
      "pf" 'counsel-projectile-find-file
      "pb" 'counsel-projectile-switch-to-buffer
      "pd" 'counsel-projectile-find-dir
      "pp" 'counsel-projectile-switch-project)))

(use-package swiper
  :ensure t
  :init
  (progn
    (evil-leader/set-key
      "ss" 'swiper))
  :config
  (ivy-mode 1))

(provide 'init-ivy)

;;; init-ivy.el ends here
