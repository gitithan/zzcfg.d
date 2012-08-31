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
;(add-to-list 'load-path (expand-file-name "~/zzcfg.d/rcodetools"))
;----------- pry of ruby -------------
;(add-to-list 'load-path (expand-file-name "~/zzcfg.d/pry"))
;(add-to-list 'load-path (expand-file-name "~/zzcfg.d/Enhanced_Ruby_Mode"))
;(setq enh-ruby-program "C:/Ruby193/bin/ruby") ; so that still works if ruby points to ruby1.8
;(setq enh-ruby-program "C:/Ruby187/bin/ruby") ; so that still works if ruby points to ruby1.8
;------------ Rsense -----------------
(add-to-list 'load-path (expand-file-name "~/zzcfg.d/rsense-0.3/etc"))
;------------ irbsh -------------
;(add-to-list 'load-path (expand-file-name "~/zzcfg.d/irbsh-1.0.1/data/emacs/site-lisp"))
;------------ geben -------------
(add-to-list 'load-path (expand-file-name "~/zzcfg.d/geben-0.26"))
(add-to-list 'load-path (expand-file-name "~/zzcfg.d/geben-0.26/tree-widget/geben"))
;------------- my-php-mode ----------
;(add-to-list 'load-path (expand-file-name "~/zzcfg.d/php-completion"))
;(add-to-list 'load-path (expand-file-name "~/zzcfg.d/php-completion/php-mode-1.5.0"))
;------------- my-init-orgmode ----------
(add-to-list 'load-path (expand-file-name "~/zzcfg.d/my-org-addon"))
(add-to-list 'load-path (expand-file-name "~/zzcfg.d/my-org-addon/bbdb"))
(add-to-list 'load-path (expand-file-name "~/zzcfg.d/orgcvs/zgpg4win"))
;;(add-to-list 'load-path (expand-file-name "~/zzcfg.d/my-org-addon/smex-20120301"))
;------------- lua-mode --------------
(add-to-list 'load-path (expand-file-name "~/zzcfg.d/lua-mode"))
;------------- emacs-quickrun -------------
(add-to-list 'load-path (expand-file-name "~/zzcfg.d/emacs-quickrun"))
;-------------- init-org-sync -------------------------------
(add-to-list 'load-path (expand-file-name "~/zzcfg.d/org-sync"))


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
;;(require 'init-my-orgmode)


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
;(require 'init-hideshow-org)


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
;(require 'init-doxymacs)


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


;-----------------
;rcodetools
;-----------------
;(require 'auto-complete-ruby)


;---------------
;init-my-irb
;---------------
(require 'init-my-irb)


;-------------
;init-my-pry
;-------------
;(require 'init-my-pry)


;--------------
;init-my-ehc_ruby_mode
;--------------
;(require 'init-my-ehc_ruby_mode)


;---------------
;flymake: goto
;---------------
(require 'init-flymake-kbd)


;---------------
;init-my-rsense
;---------------
(require 'init-my-rsense)

;-----------
;my-kbd
;-----------
(require 'init-my-kbd)

;------------
;init-irb-company
;------------
;(require 'init-irb-company)


;-------------
;init-my-irbsh
;-------------
;(require 'init-my-irbsh)


;------------
;ruby-block
;------------
;(require 'init-ruby-block)


;-----------
;load geben
;-----------
(require 'init-my-geben)


;------------
;init my-php
;------------
;(require 'init-my-phpmode)
(require 'init-my-php)



;-------------
;lua-mode
;-------------
(require 'init-my-luamode)



;------------
;init-man-html
;------------
(require 'init-man-html)


;------------
;my-init-orgmode
;------------
(require 'my-init-orgmode)


;-------------------
;init-my-pomodoro
;-------------------
(require 'init-my-pomodoro)


;-------------------
;init-kanban
;-------------------
(require 'kanban)


;------------
;my org-sync
;------------
(require 'init-my-orgsync)


;----------
;字体
;----------
(require 'init-my-lng-font)
