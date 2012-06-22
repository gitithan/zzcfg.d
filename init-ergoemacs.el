;-------------------
;keybinding of ergoemacs
;-------------------
(setenv "ERGOEMACS_KEYBOARD_LAYOUT" "us") ; US
;;load ErgoEmacs keybinding
(load "ergoemacs-mode")
;;turn on minor mode ergoemacs-mode
(ergoemacs-mode 1)
(icomplete-mode 1)

(provide 'init-ergoemacs)
