(add-to-list 'load-path "~/zzcfg.d/init-my-php")
(add-to-list 'load-path "~/zzcfg.d/init-my-php/php-mode") 

(require 'install-elisp) 
(setq install-elisp-repository-directory "~/zzcfg.d/init-my-php/");;����ʹ��install-elisp-from-emacswiki �������������ļ�·�����Ұ����Ƿ���һ���ļ�������

(require 'php-mode)
(require 'auto-complete)
(add-hook 'php-mode-hook 
      (lambda() 
        (require 'php-completion) 
        (php-completion-mode t) 
        (define-key php-mode-map (kbd "C-j ,") 'phpcmp-complete)
        (when (require 'auto-complete nil t) 
          (make-variable-buffer-local 'ac-sources) 
          (add-to-list 'ac-sources 'ac-source-php-completion) 
          (auto-complete-mode t))))
(locate-library "auto-complete.el")

(provide 'init-my-php)
