;----------------
;other settings
;================

;;;;(setq initial-frame-alist '((width . 90) (height . 35)))
(scroll-bar-mode -1)	;;from nil to -1
(tool-bar-mode 0)
(menu-bar-mode 0)
(global-set-key [f11] 'menu-bar-mode)

;;setting line-space
(setq-default line-spacing 3)

(setq version-control t)
(setq kept-old-versions 2)
(setq kept-new-versions 8)
(setq delete-old-versions t)
(setq backup-directory-alist '(("." . "~/zzcfg.d/backup")))
(setq backup-by-copying t)
(setq make-backup-file t)
(icomplete-mode 1)
;(fset 'yes-or-no-p 'y-or-n-p)
;;设置打开的默认路径
(setq default-directory "~/")

(provide 'init-others)
