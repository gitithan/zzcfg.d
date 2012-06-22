;-----------------
;eim input
;-----------------
;; EIM Input Method. Use C-\ to toggle input method.
(add-to-list 'load-path "~/zzcfg.d/eim")

(autoload 'eim-use-package "eim" "Another emacs input method")
(setq eim-use-tooltip nil)              ; don't use tooltip
(setq eim-punc-translate-p nil)         ; use English punctuation

(register-input-method
 "eim-py" "euc-cn" 'eim-use-package
 "pinyin" "EIM Chinese Pinyin Input Method" "py.txt"
 'my-eim-py-activate-function)

(register-input-method
 "eim-wb" "euc-cn" 'eim-use-package
 "wubi" "EIM Chinese Wubi Input Method" "wb.txt"
 'my-eim-wb-activate-function)

;(set-input-method "eim-py")             ; use Pinyin input method
(setq eim-wb-use-gbk t)                 ; import gbk for wb
(set-input-method "eim-wb")             ; use Wubi input method
(setq activate-input-method t)          ; active input method
(toggle-input-method nil)               ; default is turn off


(defun my-eim-wb-activate-function ()
  (add-hook 'eim-active-hook
        (lambda ()
          (let ((map (eim-mode-map)))
            (define-key map "-" 'eim-previous-page)
            (define-key map "=" 'eim-next-page)))))


(defun my-eim-py-activate-function ()
  (add-hook 'eim-active-hook
            (lambda ()
              (let ((map (eim-mode-map)))
                (define-key eim-mode-map "-" 'eim-previous-page)
                (define-key eim-mode-map "=" 'eim-next-page)))))

;prevent the command line to stay at the bottom of the window
(add-hook 'shell-mode-hook
          (lambda()
            (remove-hook 'comint-output-filter-functions
                         'comint-postoutput-scroll-to-bottom t)))



(provide 'init-my-eim)
