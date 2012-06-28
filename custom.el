;----------------------------------------------------------------------------
; 我的emacs额外定制
;----------------------------------------------------------------------------

;-------------
;加载路径设置
;-------------
(add-to-list 'load-path (expand-file-name "~/zzcfg.d"))
(add-to-list 'load-path (expand-file-name "~/zzcfg.d/pyide"))
(add-to-list 'load-path (expand-file-name "~/zzcfg.d/ergoemacs-keybindings-5.3.9"))
(add-to-list 'load-path (expand-file-name "~/zzcfg.d/sunrise-commander"))
(add-to-list 'load-path (expand-file-name "~/.vtenvs"))
(add-to-list 'load-path (expand-file-name "~/zzcfg.d/hideshow-org"))
(add-to-list 'load-path (expand-file-name "~/zzcfg.d/slime"))
(add-to-list 'load-path (expand-file-name "~/zzcfg.d/slime/contrib"))
(add-to-list 'load-path (expand-file-name "~/zzcfg.d/slime/doc"))


;---------------------------------------
;Identify coding (language) automatically
;----------------------------------------
;(require 'unicad)


;-------------
;用户界面
;------------
(require 'init-facet)


;-----------
;pybrew-mini
;-----------
;(require 'init-pybrew-mini)


;-----------
;python定制
;-----------
(require 'init-my-pyide)
;-----------
;ergokey键盘
;------------
(require 'init-ergoemacs)


;------------
;orgmode定制
;------------
(require 'init-my-orgmode)


;------------
;其它小功能
;------------
(require 'init-others)


;-----------
;my EIM
;-----------
;(require 'init-my-eim)


;-----------
;flymake
;-----------
;(require 'init-pybrew-flymake)


;-----------
;init-test
;-----------
(require 'init-test)


;--------------
;'init-smooth-scroll
;---------------------
(require 'init-smooth-scroll)


;---------------
;hideshow-code
;---------------
(require 'init-hideshow-org)


;---------------
;py-hideshow-mode
;---------------
;(require 'init-py-hideshow)


;----------------
;my slime cfg
;----------------
;(require 'init-my-slime)

;----------
;字体
;----------
(require 'init-my-lng-font)
