;; Example for Windows
;; (setq rsense-home "C:\\rsense-0.2")
;(setq rsense-home "$RSENSE_HOME")
(setq rsense-home "E:\\soft\\editor\\emacs-24.0.93\\config\\zzcfg.d\\rsense-0.3")
(add-to-list 'load-path (concat rsense-home "/etc"))
(require 'rsense)

;;;;;You may like to bind some key like:
;;; Complete by C-c .
;(add-hook 'ruby-mode-hook
;          (lambda ()
;            (local-set-key (kbd "C-c .") 'ac-complete-rsense)))

;;;;If you want to start completion automatically after inserting . and ::, add ac-source-rsense-method and ac-source-rsense-constant to ac-sources. This is called omni completion.
(add-hook 'ruby-mode-hook
          (lambda ()
            (add-to-list 'ac-sources 'ac-source-rsense-method)
            (add-to-list 'ac-sources 'ac-source-rsense-constant)))


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


(provide 'init-my-rsense)