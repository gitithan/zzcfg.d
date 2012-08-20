(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

(add-hook 'lua-mode-hook 'turn-on-font-lock)
(add-hook 'lua-mode-hook 'hs-minor-mode)

;---- lua-block -----
(require 'lua-block)
(lua-block-mode t)


;---- lua-flymake ----
(require 'flymake-lua)
(add-hook 'lua-mode-hook 'flymake-lua-load)


;----- in AC mode -----
(eval-after-load "auto-complete" '(add-to-list 'ac-modes 'lua-mode))


;------ yasnippet and lua ---------


;------ lua tab ------
;;;Ryan's python specific tab completion                                                                        
(defun ryan-lua-tab ()
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

(define-key lua-mode-map "\t" 'ryan-lua-tab)


(provide 'init-my-luamode)