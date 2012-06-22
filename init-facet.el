;----------------
;font set
;----------------
;(set-default-font "WenQuanYi Zen Hei Mono-11")
;(add-to-list 'default-frame-alist '(font . "WenQuanYi Zen Hei Mono-11"))



;---------------
;color setting
;---------------
;;color setting
;;(set-cursor-color "white")
;;(set-mouse-color "white")

;(set-foreground-color "#A7A7A7")
;(set-background-color "darkblue")
;(set-foreground-color "white")
;(set-background-color "#1C1C1C")

;(set-face-foreground 'highlight "white")
;(set-face-background 'highlight "blue")

;(set-face-foreground 'region "cyan")
;(set-face-background 'region "blue")

;(set-face-foreground 'secondary-selection "skyblue")
;(set-face-background 'secondary-selection "darkblue")
;(setq calendar-load-hook
;'(lambda ()
;(set-face-foreground 'diary-face "skyblue")
;(set-face-background 'holiday-face "slate blue")
;(set-face-foreground 'holiday-face "white")))

;;END   color setting


;----------------
;theme setting
;----------------
(add-to-list 'load-path "~/zzcfg.d/theme/color-theme-6.6.0")
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)))

(load "~/zzcfg.d/theme/color-theme-tango.el")
(color-theme-tango)

(provide 'init-facet)
