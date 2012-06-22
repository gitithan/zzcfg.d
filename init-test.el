;---------------
;lambda mode
;---------------
;(load "cl-seq")


;--------------
;ebug of eshell from autopair
;--------------
(set-default 'autopair-dont-activate #'(lambda ()
					 (eq major-mode 'term-mode)))



;----------------
;test for yasnippet-ac-indet
;---------------
;;;Ryan's python specific tab completion                                                                        
(defun ryan-python-tab ()
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

(define-key py-mode-map "\t" 'ryan-python-tab)


;------------------------------------------------------

;; fullscreen
(defvar my-full-screen-var nil)
(defun toggle-fullscreen ()
  (interactive)
  (if my-full-screen-var
      (progn
        (set-frame-parameter nil 'fullscreen 'nil)
        (setq my-full-screen-var nil))
    (progn
      (set-frame-parameter nil 'fullscreen 'fullscreen)
      (setq my-full-screen-var t))))
 
;;(global-set-key [M-RET] 'toggle-fullscreen)
(global-set-key (kbd "M-RET") 'toggle-fullscreen)

;-------------------------------------------------------


;;emacs shell÷–Œƒ¬“¬Î≤‚ ‘
(ansi-color-for-comint-mode-on)


;-------------------
;add virtualenv
;-------------------
(require 'virtualenv)
;;(setq debug-on-error t)


;----------------------
;add sunrise-commander
;----------------------
;;;;(require 'sunrise-commander)


;--------------------
;patch for ergoemacs's key-binding
;--------------------
;(setq map (make-sparse-keymap))
;(define-key map "\M-o" 'forward-char)
;(define-key map "\M-o" 'forward-paragraph)

;-------------------
;graphviz-dot-mode
;-------------------
;(load-file "~/zzcfg.d/graphviz-dot-mode.el")


(provide 'init-test)
