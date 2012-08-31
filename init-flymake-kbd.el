(global-set-key (kbd "S-<up>") 'flymake-goto-prev-error)	;s means Superkey, S means Shift
(global-set-key (kbd "S-<down>") 'flymake-goto-next-error)

;;(custom-set-faces
;;     '(flymake-errline ((((class color)) (:underline "red"))))
;;     '(flymake-warnline ((((class color)) (:underline "yellow")))))


(require 'fringe-helper)
(require 'flymake)

(set-face-background 'flymake-errline nil)
(set-face-foreground 'flymake-errline nil)
(set-face-background 'flymake-warnline nil)
(set-face-foreground 'flymake-warnline nil)

(make-face 'my-flymake-warning-face)
(set-face-foreground 'my-flymake-warning-face "yellow")
(set-face-background 'my-flymake-warning-face "black")
(setq my-flymake-warning-face 'my-flymake-warning-face)

(defvar flymake-fringe-overlays nil)
(make-variable-buffer-local 'flymake-fringe-overlays)

(defadvice flymake-make-overlay (after add-to-fringe first
                                       (beg end tooltip-text face mouse-face)
                                       activate compile)
  (push (fringe-helper-insert-region
           beg end
           (fringe-lib-load (if (eq face 'flymake-warnline)
                                fringe-lib-exclamation-mark
                              fringe-lib-question-mark))
           'left-fringe 'my-flymake-warning-face)
           ;; 'left-fringe 'font-lock-warning-face)
        flymake-fringe-overlays))

(defadvice flymake-delete-own-overlays (after remove-from-fringe activate
                                              compile)
  (mapc 'fringe-helper-remove flymake-fringe-overlays)
  (setq flymake-fringe-overlays nil))

;;-----------------------------------------
(setq flymake-no-changes-timeout 600)

(provide 'init-flymake-kbd)