;;; Define Ruby Mode Hook
;(defun my-ruby-mode-hook ()
;  (progn
;    (setq comint-process-echoes t)
;    (turn-on-font-lock)
;    (auto-fill-mode)
;    (yas/minor-mode)
;    ;;(inf-ruby-keys)
;    (inf-ruby-setup-keybindings)))

;;; Register Ruby Mode Hook
;(add-hook 'ruby-mode-hook 'my-ruby-mode-hook)

;---------------------------------------------
(defun echo-false () (setq comint-process-echoes t))
(add-hook 'comint-mode-hook 'echo-false)


(provide 'init-my-irb)