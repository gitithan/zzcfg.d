
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;cnblog emacs for python IDE Config
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;-----------------
;;yasnippet
;;-----------------
;(add-to-list 'load-path "~/zzcfg.d/pyide/yasnippet-0.6.1c")
;;(require 'yasnippet) ;; not yasnippet-bundle
;(require 'yasnippet-bundle)
;(yas/initialize)
;(yas/load-directory "~/zzcfg.d/pyide/yasnippet-0.6.1c/snippets")
;(yas/global-mode 1)


;;--------------------
;;AC
;;--------------------
;(add-to-list 'load-path "~/zzcfg.d/pyide/auto-complete-1.3.1")
;(require 'auto-complete-config)
;(add-to-list 'ac-dictionary-directories "~/zzcfg.d/pyide/auto-complete-1.3.1/dict")
;(ac-config-default)


;--------------
;python-mode
;--------------
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)
(setq interpreter-mode-alist (cons '("python" . python-mode)
      interpreter-mode-alist))
(setq py-python-command "python")
(autoload 'python-mode "python-mode" "Pythonediting mode." t)

(require 'python-mode)
;(add-hook 'python-mode-hook
;      (lambda ()
;        (set-variable 'py-indent-offset 4)
;        ;(set-variable 'py-smart-indentation nil)
;        (set-variable 'indent-tabs-mode nil)
;        (define-key py-mode-map (kbd "RET") 'newline-and-indent)
;        ;(define-key py-mode-map [tab] 'yas/expand)
;        ;(setq yas/after-exit-snippet-hook 'indent-according-to-mode)
;        (smart-operator-mode-on)
;        ))



;-----------------
;lambda
;-----------------
(require 'lambda-mode)
(add-hook 'python-mode-hook #'lambda-mode 1)





;--------------------
;config of anyting
;--------------------
(require 'anything)
;(require 'anything-ipython)
;(when (require 'anything-show-completion nil t)
;   (use-anything-show-completion 'anything-ipython-complete
;                                 '(length initial-pattern)))

(require 'anything-ipython)
(add-hook 'python-mode-hook #'(lambda ()
                                (define-key py-mode-map (kbd "M-<tab>") 'anything-ipython-complete)))
(add-hook 'ipython-shell-hook #'(lambda ()
                                  (define-key py-mode-map (kbd "M-<tab>") 'anything-ipython-complete)))
;;If you want to use anything-show-completion.el,(facultative)
;;<http://www.emacswiki.org/cgi-bin/emacs/anything-show-completion.el>
;;add these lines:
(when (require 'anything-show-completion nil t)
  (use-anything-show-completion 'anything-ipython-complete
                                '(length initial-pattern)))

 

;------------------
;ipython setting
;------------------
(require 'ipython)
(setq py-python-command-args '( "--colors" "Linux"))	;;解决了-olors 错误提示
(setq ipython-completion-command-string "print(';'.join(get_ipython().Completer.complete('%s')[1])) #PYTHON-MODE SILENT\n")

;------------------
;comint
;------------------
(require 'comint)
(define-key comint-mode-map (kbd "M-") 'comint-next-input)
(define-key comint-mode-map (kbd "M-") 'comint-previous-input)
(define-key comint-mode-map [down] 'comint-next-matching-input-from-input)
(define-key comint-mode-map [up] 'comint-previous-matching-input-from-input)



;----------------------
;pylookup
;----------------------
;(autoload 'pylookup-lookup "pylookup")
;(autoload 'pylookup-update "pylookup")
;(setq pylookup-program "~/zzcfg.d/pyide/pylookup/pylookup.py")
;(setq pylookup-db-file "~/zzcfg.d/pyide/pylookup/pylookup.db")
;(global-set-key "\C-ch" 'pylookup-lookup)



;--------------------
;w3m cfg
;--------------------
;(autoload 'w3m "w3m" "Interface for w3m on Emacs." t)
;(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
;(autoload 'w3m-search "w3m-search" "Search words using emacs-w3m." t)

;(setq browse-url-browser-function 'w3m-browse-url)


;----------------------
;autopair
;----------------------
(autoload 'autopair-global-mode "autopair" nil t)
(autopair-global-mode)
(add-hook 'lisp-mode-hook
          #'(lambda () (setq autopair-dont-activate t)))

(add-hook 'python-mode-hook
          #'(lambda ()
              (push '(?' . ?')
                    (getf autopair-extra-pairs :code))
              (setq autopair-handle-action-fns
                    (list #'autopair-default-handle-action
                          #'autopair-python-triple-quote-action))))



;-------------------
;pylint and pep8
;-------------------
(require `tramp)
(require 'compile)
(require 'python-pep8)
(require 'python-pylint)


;-----------------
;delete trailing space
;-----------------
(add-hook 'before-save-hook 'delete-trailing-whitespace)


;----------------------
;Pymacs cfg
;----------------------
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(require 'pymacs)
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)
(ac-ropemacs-setup)
(setq  ropemacs-guess-project t)
(setq ropemacs-confirm-saving 'nil)

;(autoload 'python-mode "init-ropemacs-setup" "" t)

;;;(setq py-load-pymacs-p 'nil)
;;;fix the issue of pymacs-report-error: Pymacs helper did not start within 30 seconds'

;----------------------
;python debuger
;----------------------
;;; pdb setup, note the python version
;(setq pdb-path 'c:/python25/Lib/pdb.py
;       gud-pdb-command-name (symbol-name pdb-path))
; (defadvice pdb (before gud-query-cmdline activate)
;   "Provide a better default command line when called interactively."
;   (interactive
;    (list (gud-query-cmdline pdb-path
;                 (file-name-nondirectory buffer-file-name)))))




;----------------------
;pychecker and pep8
;----------------------
;;pycheck grammer ; indent something
;
;(add-hook 'find-file-hook 'flymake-find-file-hook)
;(when (load "flymake" t)
;  (defun flymake-pyflakes-init ()
;    (let* ((temp-file (flymake-init-create-temp-buffer-copy
;               'flymake-create-temp-inplace))
;       (local-file (file-relative-name
;            temp-file
;            (file-name-directory buffer-file-name))))
;      (list "pychecker"  (list local-file))))
;   (add-to-list 'flymake-allowed-file-name-masks
;             '("\\.py\\'" flymake-pyflakes-init)))
;(load-library "flymake-cursor")
;;(global-set-key [f10] 'flymake-goto-prev-error)
;;(global-set-key [f11] 'flymake-goto-next-error)
;(setq python-check-command "pyflakes")



;-----------------
;AC for python
;-----------------
;;-->>
;(require 'auto-complete)
;======================
;(global-auto-complete-mode t)
(setq-default ac-sources '(ac-source-words-in-same-mode-buffers))
(setq-default ac-sources '(ac-source-yasnippet
                 ac-source-semantic
                 ac-source-ropemacs     ;;Rope project root folder:
                 ac-source-imenu
                 ac-source-words-in-buffer
                 ac-source-dictionary
                 ac-source-abbrev
                 ac-source-words-in-buffer
                 ac-source-files-in-current-dir
                 ac-source-filename))

(add-hook 'emacs-lisp-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-symbols)))
(add-hook 'auto-complete-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-filename)))

;;it works with
;(add-hook 'python-mode-hook (lambda () (add-to-list 'ac-omni-completion-sources (cons "\\." '(ac-source-ropemacs)))  ) ;前面有ropemacs setup,这里可以不要这句


(set-face-background 'ac-candidate-face "lightgray")
(set-face-underline 'ac-candidate-face "darkgray")
(set-face-background 'ac-selection-face "steelblue") ;;; 设置比上面截图中更好看的背景颜色
(setq ac-auto-show-menu 0.8)
(setq ac-dwim t)


(provide 'init-my-pyide)


