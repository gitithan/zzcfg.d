;; Key bindings for org-mode.
;; Standard key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
;;;;-slfm--;;(add-hook 'org-mode-hook (lambda () (abbrev-mode 1)))

;; Custom Key Bindings
(global-set-key (kbd "<f9> a") 'org-agenda)			;show agenda items
(global-set-key (kbd "<f6>") 'bh/org-todo)			;show todo items of only this subtree
(global-set-key (kbd "<S-f6>") 'bh/widen)			;widen
(global-set-key (kbd "<f7>") 'bh/set-truncate-lines)		;开关：自动折行
(global-set-key (kbd "<f10>") 'org-cycle-agenda-files)		;goto next file in agenda files
(global-set-key (kbd "<f9> <f9>") 'bh/show-org-agenda)		;only show *org-agenda* buffer
(global-set-key (kbd "<f9> b") 'bbdb)				;quick access to bbdb [像“名片盒”的数据库]
(global-set-key (kbd "<f9> c") 'calendar)			;quick access to Calendar
(global-set-key (kbd "<f9> f") 'boxquote-insert-file)		;标题“框”
(global-set-key (kbd "<f9> g") 'gnus)				;goto news and mail reader gnus in emacs
(global-set-key (kbd "<f9> h") 'bh/hide-other)			;hide other tasks
(global-set-key (kbd "<f9> n") 'org-narrow-to-subtree)		;narrow to subtree of current level
(global-set-key (kbd "<f9> w") 'widen)				;widen opsite action to <f9> n
(global-set-key (kbd "<f9> u") 'bh/narrow-up-one-level)		;only narrow one-level

(global-set-key (kbd "<f9> I") 'bh/punch-in)			;计时开始
(global-set-key (kbd "<f9> O") 'bh/punch-out)			;计时结束

(global-set-key (kbd "<f9> o") 'bh/make-org-scratch)		;switch to *org-scratch* buffer

(global-set-key (kbd "<f9> r") 'boxquote-region)		;给选定的区块加 “框”
(global-set-key (kbd "<f9> s") 'bh/switch-to-scratch)

(global-set-key (kbd "<f9> t") 'bh/insert-inactive-timestamp)	;加入时间截
(global-set-key (kbd "<f9> T") 'tabify)				;整个区块 “缩进”
(global-set-key (kbd "<f9> U") 'untabify)			;整个区块 “反缩进”

(global-set-key (kbd "<f9> v") 'visible-mode)			;switch to visible-mode (to ediet or show links)
(global-set-key (kbd "<f9> SPC") 'bh/clock-in-last-task)	;switch clock to preivous clocked task
(global-set-key (kbd "C-<f9>") 'previous-buffer)		;切换到 前一个 buffer
(global-set-key (kbd "M-<f9>") 'org-toggle-inline-images)	;开/关 当前行的 图像显示
(global-set-key (kbd "C-x n r") 'narrow-to-region)		;限制操作：只能在选定区域内
(global-set-key (kbd "C-<f10>") 'next-buffer)			;下一个 buffer
(global-set-key (kbd "<f11>") 'org-clock-goto)			;goto current colocked item
(global-set-key (kbd "C-<f11>") 'org-clock-in)			;make current task item Clock in
(global-set-key (kbd "C-<f12>") 'bh/save-then-publish)		;保存然后发布
(global-set-key (kbd "<f8>") 'org-capture)
(global-set-key (kbd "<f9> e") 'org-export-as-html-and-open)	;导出当前org为html并打开


;;slfm
;;============================================
;;(require 'smex)
;;(smex-initialize)

;;(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-a") 'smex)
(global-set-key (kbd "C-x x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)


;;;; Bookmark handling
;;=---------------------------
(global-set-key (kbd "<C-f12>") '(lambda () (interactive) (bookmark-set "SAVED")))
(global-set-key (kbd "<f12>") '(lambda () (interactive) (bookmark-jump "SAVED")))


(define-key global-map "\M-m" 'org-capture-finalize)
