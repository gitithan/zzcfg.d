;;=============== 初始配置^^=======================================
;;(add-to-list 'load-path "~/zzcfg.d/init-my-php")
;;(add-to-list 'load-path "~/zzcfg.d/init-my-php/php-mode") 
;;
;;(require 'install-elisp) 
;;(setq install-elisp-repository-directory "~/zzcfg.d/init-my-php/");;设置使用install-elisp-from-emacswiki 后下载下来的文件路径，我把它们放在一个文件夹里面
;;
;;(require 'php-mode)
;;(require 'auto-complete)
;;(add-hook 'php-mode-hook 
;;      (lambda() 
;;        (require 'php-completion) 
;;        (php-completion-mode t) 
;;        (define-key php-mode-map (kbd "C-j ,") 'phpcmp-complete)
;;        (when (require 'auto-complete nil t) 
;;          (make-variable-buffer-local 'ac-sources) 
;;          (add-to-list 'ac-sources 'ac-source-php-completion) 
;;          (auto-complete-mode t))))
;;(locate-library "auto-complete.el")



;;PHP Auto Indent
;;================
(c-set-offset 'topmost-intro 4)		;;for everything
(c-set-offset 'cpp-macro -4)		;;for <?php tag


;;PHP TAB-key
;;============
(require 'php-mode)	;;add it for php-mode-map
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


(provide 'init-my-php)
