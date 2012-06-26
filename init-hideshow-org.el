;(require 'hideshow-org)
;(global-set-key "\C-ch" 'hs-org/minor-mode)

(dolist (hook (list 'c-mode-common-hook
            'emacs-lisp-mode-hook
            'java-mode-hook
            'lisp-mode-hook
            'perl-mode-hook
	    'python-mode-hook
            'sh-mode-hook))
  (add-hook hook 'my-hideshow-hook))

(defun my-hideshow-hook ()
  "thisandthat."
  (interactive)
  (progn (require 'hideshow-org)
     (global-set-key (kbd "C-c h") 'hs-org/minor-mode)
     (hs-org/minor-mode)))

(defadvice goto-line (after expand-after-goto-line activate compile)
  "hideshow-expand affected block when using goto-line in a collapsed buffer"
  (save-excursion
    (hs-show-block)))

(provide 'init-hideshow-org)