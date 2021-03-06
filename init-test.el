;---------------
;lambda mode
;---------------
;(load "cl-seq")


;--------------
;ebug of eshell from autopair
;--------------
(set-default 'autopair-dont-activate #'(lambda ()
					 (eq major-mode 'term-mode)))



;;----------------
;;test for yasnippet-ac-indet
;;---------------
;;;;Ryan's python specific tab completion                                                                        
;(defun ryan-python-tab ()
;  ; Try the following:                                                                                         
;  ; 1) Do a yasnippet expansion                                                                                
;  ; 2) Do a Rope code completion                                                                               
;  ; 3) Do an indent                                                                                            
;  (interactive)
;  (if (eql (ac-start) 0)
;      (indent-for-tab-command)))
;
;(defadvice ac-start (before advice-turn-on-auto-start activate)
;  (set (make-local-variable 'ac-auto-start) t))
;(defadvice ac-cleanup (after advice-turn-off-auto-start activate)
;  (set (make-local-variable 'ac-auto-start) nil))
;
;(define-key py-mode-map "\t" 'ryan-python-tab)


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
;;(global-set-key (kbd "M-RET") 'toggle-fullscreen)
(global-set-key (kbd "M-<f12>") 'toggle-fullscreen)

;-------------------------------------------------------


;;emacs shell�����������
(ansi-color-for-comint-mode-on)


;-------------------
;add virtualenv
;-------------------
(require 'virtualenv)
(setq debug-on-error t)


;----------------------
;add sunrise-commander
;----------------------
;;;;(require 'sunrise-commander)


;-------------------
;graphviz-dot-mode
;-------------------
;(load-file "~/zzcfg.d/graphviz-dot-mode.el")


;---------------------
;keyhh.exe chm file lookup
;---------------------
(defun chm-keyword-lookup (typeid help-file)
    "lookup a keyword in a CHM file and display it"
    (interactive)
    (start-process "CHM keyword lookup" nil
       "keyhh.exe"
       (concat "-" typeid) "-#klink"
       (format "'%s'" (thing-at-point 'symbol))
       help-file )
)



;;;note: KeyHH.exe needs to be in $PATH.
;;;KeyHH -MyHelp -#klink "ActiveX Control Wizard" htmlhelp.chm
;(defun keyword-help-lookup-chm (help-file keyword)
;  "lookup a keyword in a CHM file and display it"
;    (start-process "keyhh" nil
;		   "keyhh.exe"
;		   (concat "-" (symbol-name major-mode))
;		   "-#klink" (format "'%s'" keyword)
;		   help-file )
;    (set-process-query-on-exit-flag (get-process "keyhh") nil)
;    )


;;php
;(defun chm-keyword-lookup-php ()
;   (interactive)
;   (chm-keyword-lookup "PHP" "e:/Apache2.2/php_manual_en.chm")
;)
;
;(define-key php-mode-map (kbd "C-h C-k") 'chm-keyword-lookup-php )



;;;python
;(defun chm-keyword-lookup-py ()
;   (interactive)
;   (chm-keyword-lookup "PYTHON" "C:/Python27/Doc/python273.chm")
;)
;
;(define-key py-mode-map (kbd "C-h C-k") 'chm-keyword-lookup-py )
;
;
;;;scrapy
;(defun chm-keyword-lookup-scrapy ()
;   (interactive)
;   (chm-keyword-lookup "Scrapy" "E:/Python programming books/scrapy0.14.doc.chm")
;)
;
;(define-key py-mode-map (kbd "C-h C-o") 'chm-keyword-lookup-scrapy )


;----------
;test for ioccur
;----------
(require 'ioccur)


;------------------
;mult-occur
;------------------
(defun my-multi-occur-in-matching-buffers (regexp &optional allbufs)
  "Show all lines matching REGEXP in all buffers."
  (interactive (occur-read-primary-args))
  (multi-occur-in-matching-buffers ".*" regexp))
;;;;(global-set-key (kbd "C-M-o") 'my-multi-occur-in-matching-buffers)
(global-set-key (kbd "C-8") 'my-multi-occur-in-matching-buffers)


;-------------------
;slime auto-pair bug
;-------------------
;(add-hook 'slime-repl-mode-hook
;          #'(lambda ()
;              (setq autopair-dont-activate t)))

(add-hook 'repl-mode-hook
           #'(lambda () 
               (setq autopair-dont-activate t) ;; for emacsen < 24
               (autopair-mode -1))             ;; for emacsen >= 24
)


;(set-default 'autopair-dont-activate #'(lambda ()
;			(eq major-mode 'slime-repl-mode)))



;------------------
;lambda clojure-mode
;------------------
(add-hook 'slime-connected-hook (lambda () 
                                  (require 'clojure-mode))) 



;-----------------
;emacs-quickrun
;-----------------
(require 'quickrun)



;------------------
;server test ;;
;------------------
(require 'server)

;;(when (and (eq window-system 'w32) (file-exists-p (getenv "APPDATA")))
;;  (setq server-auth-dir (concat (getenv "APPDATA") "\\.emacs.d\\server"))
;;  (make-directory server-auth-dir)  )

(when (and (eq window-system 'w32) (file-exists-p (getenv "APPDATA")))
	(if (not (file-exists-p (concat (getenv "APPDATA") "\\.emacs.d\\server")))
		(make-directory (concat (getenv "APPDATA") "\\.emacs.d\\server")))
	(setq server-auth-dir (concat (getenv "APPDATA") "\\.emacs.d\\server")))

(server-start)


(provide 'init-test)
