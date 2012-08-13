;;(require 'auto-complete)
(require 'php-mode)

;;根据扩展名绑定
(add-to-list 'auto-mode-alist '("\\.php[345]?\\'\\|\\.phtml\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.module\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc\\'" . php-mode))
;;-->> 把它移动到前面(require 'auto-complete)

(add-hook 'php-mode-hook
(lambda ()
(require 'php-completion)
(php-completion-mode t)
(define-key php-mode-map (kbd "M-m") 'phpcmp-complete)))



(add-hook  'php-mode-hook
(lambda ()
(when (require 'auto-complete nil t)
  (make-variable-buffer-local 'ac-sources)
  (add-to-list 'ac-sources 'ac-source-php-completion)
;; if you like patial match,
;; use `ac-source-php-completion-patial' instead of `ac-source-php-completion'.
  ;;(add-to-list 'ac-sources 'ac-source-php-completion-patial)
      (auto-complete-mode t))))

;;加载
(locate-library "auto-complete")

(defun ryan-php-tab ()
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

(define-key php-mode-map "\t" 'ryan-php-tab)
;(define-key php-mode-map (kbd "\t") 'php-complete-function)))


(provide 'init-my-phpmode)