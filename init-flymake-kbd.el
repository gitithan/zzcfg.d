(global-set-key (kbd "S-<up>") 'flymake-goto-prev-error)	;s means Superkey, S means Shift
(global-set-key (kbd "S-<down>") 'flymake-goto-next-error)

(custom-set-faces
     '(flymake-errline ((((class color)) (:underline "red"))))
     '(flymake-warnline ((((class color)) (:underline "yellow")))))
(setq flymake-no-changes-timeout 600)

(provide 'init-flymake-kbd)