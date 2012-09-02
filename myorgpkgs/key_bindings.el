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
(global-set-key (kbd "<f7>") 'bh/set-truncate-lines)		;���أ��Զ�����
(global-set-key (kbd "<f10>") 'org-cycle-agenda-files)		;goto next file in agenda files
(global-set-key (kbd "<f9> <f9>") 'bh/show-org-agenda)		;only show *org-agenda* buffer
(global-set-key (kbd "<f9> b") 'bbdb)				;quick access to bbdb [����Ƭ�С������ݿ�]
(global-set-key (kbd "<f9> c") 'calendar)			;quick access to Calendar
(global-set-key (kbd "<f9> f") 'boxquote-insert-file)		;���⡰��
(global-set-key (kbd "<f9> g") 'gnus)				;goto news and mail reader gnus in emacs
(global-set-key (kbd "<f9> h") 'bh/hide-other)			;hide other tasks
(global-set-key (kbd "<f9> n") 'org-narrow-to-subtree)		;narrow to subtree of current level
(global-set-key (kbd "<f9> w") 'widen)				;widen opsite action to <f9> n
(global-set-key (kbd "<f9> u") 'bh/narrow-up-one-level)		;only narrow one-level

(global-set-key (kbd "<f9> I") 'bh/punch-in)			;��ʱ��ʼ
(global-set-key (kbd "<f9> O") 'bh/punch-out)			;��ʱ����

(global-set-key (kbd "<f9> o") 'bh/make-org-scratch)		;switch to *org-scratch* buffer

(global-set-key (kbd "<f9> r") 'boxquote-region)		;��ѡ��������� ����
(global-set-key (kbd "<f9> s") 'bh/switch-to-scratch)

(global-set-key (kbd "<f9> t") 'bh/insert-inactive-timestamp)	;����ʱ���
(global-set-key (kbd "<f9> T") 'tabify)				;�������� ��������
(global-set-key (kbd "<f9> U") 'untabify)			;�������� ����������

(global-set-key (kbd "<f9> v") 'visible-mode)			;switch to visible-mode (to ediet or show links)
(global-set-key (kbd "<f9> SPC") 'bh/clock-in-last-task)	;switch clock to preivous clocked task
(global-set-key (kbd "C-<f9>") 'previous-buffer)		;�л��� ǰһ�� buffer
(global-set-key (kbd "M-<f9>") 'org-toggle-inline-images)	;��/�� ��ǰ�е� ͼ����ʾ
(global-set-key (kbd "C-x n r") 'narrow-to-region)		;���Ʋ�����ֻ����ѡ��������
(global-set-key (kbd "C-<f10>") 'next-buffer)			;��һ�� buffer
(global-set-key (kbd "<f11>") 'org-clock-goto)			;goto current colocked item
(global-set-key (kbd "C-<f11>") 'org-clock-in)			;make current task item Clock in
(global-set-key (kbd "C-<f12>") 'bh/save-then-publish)		;����Ȼ�󷢲�
(global-set-key (kbd "<f8>") 'org-capture)
(global-set-key (kbd "<f9> e") 'org-export-as-html-and-open)	;������ǰorgΪhtml����


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
