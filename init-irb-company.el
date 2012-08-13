;------ for company -----
(autoload 'company-mode "company" nil t)
(require 'ac-company)

;------ for irb -------
(add-hook 'inf-ruby-mode-hook (lambda () (require 'inf-ruby-company)))
(setq company-idle-delay 0.1)
(setq company-minimum-prefix-length 2)

;------ for irb cmp -------
;(defun check-expansion ()
;(save-excursion
;(if (looking-at "\\_>") t
;(backward-char 1)
;(if (looking-at "\\.") t
;  (backward-char 1)
;  (if (looking-at "->") t nil)))))
;(defun do-yas-expand ()  
;(let ((yas/fallback-behavior 'return-nil))
;(yas/expand)))
;
;(defun tab-indent-or-complete ()
;(interactive)
;(if (minibufferp)
;(minibuffer-complete)
;(if (or (not yas/minor-mode)
;      (null (do-yas-expand)))
;  (if (check-expansion)
;      (company-complete-common)
;    (indent-for-tab-command)))))
;(global-set-key [tab] 'tab-indent-or-complete)
;;(define-key ruby-mode-map "\t" 'ryan-ruby-tab)

;;;Ryan's python specific tab completion
(require 'ruby-mode)
(defun ryan-ruby-tab ()
  ; Try the following:
  ; 1) Do a yasnippet expansion
  ; 2) Do a Rope code completion
  ; 3) Do an indent
  (interactive)
  (if (eql (ac-start) 0)
      (indent-for-tab-command)))

(defadvice ac-start (before advice-turn-on-auto-start activate)
  (set (make-local-variable 'ac-auto-start) t))
(defadvice ac-cleanup (after advice-turn-off-auto-start activate)
  (set (make-local-variable 'ac-auto-start) nil))

(define-key ruby-mode-map "\t" 'ryan-ruby-tab)


(provide 'init-irb-company)