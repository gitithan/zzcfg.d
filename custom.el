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
(add-to-list 'load-path (expand-file-name "~/zzcfg.d/ecb"))
(add-to-list 'load-path (expand-file-name "~/zzcfg.d/w3/lisp"))
(add-to-list 'load-path (expand-file-name "~/zzcfg.d//cscope-15.8/contrib/xcscope"))
(add-to-list 'load-path (expand-file-name "~/zzcfg.d/doxymacs-1.8.0/no-autoconf"))
(add-to-list 'load-path (expand-file-name "~/zzcfg.d/csslint/release"))



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
;;(require 'init-my-pyide)
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
(require 'init-my-slime)


;----------------
;ecb
;----------------
(require 'init-my-ecb)


;-----------------
;init-my-doxymacs
;-----------------
(require 'init-doxymacs)


;----------------
;my init for fuzzy
;----------------
;;(require 'my-init-fuzzy)


;----------------
;little tips
;----------------
(require 'little-tips)


;----------------
;binchen-yasnippet
;-----------------
(require 'binchen-yasnippet)


;-----------------
;icomplete+
;-----------------
(require 'my-init-icompleteplus)


;--------------
;bmz-outline-orglike
;--------------
;;(require 'bmz-outline-orglike)


;-----------------
;my ruby cfg
;-----------------
;;(require 'init-my-ruby)

;----------
;字体
;----------
(require 'init-my-lng-font)
