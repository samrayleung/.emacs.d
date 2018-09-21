;;; init-shell.el --- shell mode
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

(setq shell-file-name "/bin/zsh")
(add-to-list 'auto-mode-alist '("\\.zsh$" . shell-script-mode))

(provide 'init-shell)


;;; init-shell.el ends here
