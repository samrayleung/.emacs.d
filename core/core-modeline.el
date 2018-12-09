;;; core-modeline.el --- modeline configuration
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

;; 背景色
(set-face-background 'mode-line "#6C5194")

;; 前景色
(set-face-foreground 'mode-line "#FFFFFF")

(defun mode-line-fill-right (face reserve)
  "Return empty space using FACE and leaving RESERVE space on the right."
  (unless reserve
    (setq reserve 20))
  (when (and window-system (eq 'right (get-scroll-bar-mode)))
    (setq reserve (- reserve 3)))
  (propertize " "
              'display `((space :align-to (- (+ right right-fringe right-margin) ,reserve)))
              'face face))

(defun mode-line-fill-center (face reserve)
  "Return empty space using FACE to the center of remaining space leaving RESERVE space on the right."
  (unless reserve
    (setq reserve 20))
  (when (and window-system (eq 'right (get-scroll-bar-mode)))
    (setq reserve (- reserve 3)))
  (propertize " "
              'display `((space :align-to (- (+ center (.5 . right-margin)) ,reserve
                                             (.5 . left-margin))))
              'face face))

(defconst RIGHT_PADDING 1)

(defun reserve-left/middle ()
  "居中布局."
  (/ (length (format-mode-line mode-line-align-middle)) 2))

(defun reserve-middle/right ()
  "右端排列."
  (+ RIGHT_PADDING (length (format-mode-line mode-line-align-right))))

(defun modeline-mode-icon ()
  "Major mode 类型图标."
  (cond
   ((string= major-mode "emacs-lisp-mode") (propertize "" 'face '(:foreground "#A52ECB")))
   ((string= major-mode "lisp-interaction-mode") (propertize "" 'face '(:foreground "#A52ECB")))
   ((string= major-mode "json-mode") (propertize "" 'face '(:foreground "#FBC02D")))
   ((string= major-mode "python-mode") (propertize "" 'face '(:foreground "#387EB8")))
   ((string= major-mode "css-mode") (propertize "" 'face '(:foreground "#1572B6")))
   ((string= major-mode "scss-mode") "\xe603")
   ((string= major-mode "js2-mode") "")
   ((string= major-mode "markdown-mode") "")
   ((string= major-mode "org-mode") (propertize "" 'face '(:foreground "#77AA99")))
   ((string= major-mode "web-mode") (propertize "" 'face '(:foreground "#E44F26")))
   (t (format "%s" major-mode))))

(defun modeline-flycheck-status ()
  "自定义 flycheck 状态."
  (let* ((text (pcase flycheck-last-status-change
		 (`finished (if flycheck-current-errors
				(let ((count (let-alist (flycheck-count-errors flycheck-current-errors)
					       (+ (or .warning 0) (or .error 0)))))
				  (propertize (format "✖ %s Issue%s" count (if (eq 1 count) "" "s"))
					      'face '(:foreground "#ff6c6b")))
			      (propertize "✔ No Issues"
					  'face '(:foreground "#61afef"))))

		 (`running (propertize "⟲ Running"
				       'face '(:foreground "#da8548")))
		 (`no-checker (propertize "⚠ No Checke"
					  'face '(:foreground "#da8548")))
		 (`not-checked "✖ Disabled")
		 (`errored (propertize "⚠ Error" 'face '(:foreground "#ff6c6b")))
		 (`interrupted "⛔ Interrupted")
		 (`suspicious  ""))))
    (propertize text
		'help-echo "Show Flycheck Errors"
		'mouse-face '(:box 1)
		'local-map (make-mode-line-mouse-map
			    'mouse-1 (lambda () (interactive) (flycheck-list-errors))))))

(defun modeline-git-vc ()
  "自定义 git 状态."
  (when vc-mode
    (cond
     ((string-match "Git[:-]" vc-mode)
      (let ((branch (mapconcat 'concat (cdr (split-string vc-mode "[:-]")) "-")))
	(concat
	 (propertize "\xf418")
	 (propertize (format " %s" branch) 'face `(:height 0.9)))))
     (t (format "%s" vc-mode)))))

(defun modeline-time ()
  "自定义时间显示."
  (concat
   (propertize "" 'face `(:height 0.9))
   (propertize (format-time-string " %H:%M") 'face `(:height 0.9))
   ))

(defvar mode-line-align-left
  '("%e"
    (:eval
     (concat
      "%2 "
      (modeline-mode-icon)
      (propertize " %b" 'face 'bold)
      "%2 "
      (modeline-flycheck-status)))))

(defvar mode-line-align-middle
  '(""
    (:eval (modeline-git-vc))))

(defvar mode-line-align-right
  '(""
    "(%l,%c)"
    "%2 "
    (:eval (modeline-time))))


(setq-default mode-line-format
              (list
               mode-line-align-left
               '(:eval (mode-line-fill-center 'mode-line
                                              (reserve-left/middle)))
               mode-line-align-middle
               '(:eval
                 (mode-line-fill-right 'mode-line
                                       (reserve-middle/right)))
               mode-line-align-right))

(provide 'core-modeline)

;;; core-modeline.el ends here
