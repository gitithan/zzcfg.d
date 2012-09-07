;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; �������� 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq default-buffer-file-coding-system 'gbk)     ;�����ļ�����
(setq default-file-name-coding-system 'gbk)		  ;�ļ�������
(setq default-keyboard-coding-system 'gbk)		  ;�����������
(setq default-process-coding-system '(gbk . gbk)) ;��������������
(setq default-sendmail-coding-system 'gbkx)		  ;�����ʼ�����
(setq default-terminal-coding-system 'gbk)		  ;�ն˱���

;; GBK settings:
(set-language-environment 'Chinese-gbk)
(set-terminal-coding-system 'chinese-gbk)
(set-selection-coding-system 'chinese-gbk)
(set-keyboard-coding-system 'chinese-gbk)
(set-clipboard-coding-system 'chinese-gbk)
(set-buffer-file-coding-system 'chinese-gbk)
(modify-coding-system-alist 'process "*" 'chinese-gbk)


;; UTF-8 settings
;; (set-language-environment "UTF-8")
;; (set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)
;; (set-clipboard-coding-system 'utf-8)
;; (set-buffer-file-coding-system 'utf-8)
;; (set-selection-coding-system 'utf-8)
;; (modify-coding-system-alist 'process "*" 'utf-8)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ��������
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Chinese font setteing ��������
;;(set-frame-font "�ź�����-11")
;;(set-fontset-font "fontset-default" 'han '("�ź�����-11" . "unicode-bmp"))
;;func1-���ж�ĳ��������ϵͳ���Ƿ�װ
(defun qiang-font-existsp (font)
  (if (null (x-list-fonts font))
      nil
    t))

;;func2-��˳���ҵ�һ�������б�list���е�һ���Ѿ���װ���õ�����
(defvar font-list '("Microsoft YaHie Monotype" "Yahei Mono" "Microsoft Yahei" "��Ȫ��ȿ�΢�׺�" "����" "������" "����"))
(require 'cl) ;; find-if is in common list package
(find-if #'qiang-font-existsp font-list)

;;func3-��Ҫ�и����������������������� font size ��Ϣ�� font �����ı�
(defun qiang-make-font-string (font-name font-size)
  (if (and (stringp font-size)
           (equal ":" (string (elt font-size 0))))
      (format "%s%s" font-name font-size)
    (format "%s %s" font-name font-size)))

;;func4-��������func1-func3��Щ��������������ľ����Զ��������庯����
(defun qiang-set-font (english-fonts
                       english-font-size
                       chinese-fonts
                       &optional chinese-font-size)

  "english-font-size could be set to \":pixelsize=18\" or a integer.
If set/leave chinese-font-size to nil, it will follow english-font-size"
  (require 'cl) ; for find if
  (let ((en-font (qiang-make-font-string
                  (find-if #'qiang-font-existsp english-fonts)
                  english-font-size))
        (zh-font (font-spec :family (find-if #'qiang-font-existsp chinese-fonts)
                            :size chinese-font-size)))

    ;; Set the default English font
    ;;
    ;; The following 2 method cannot make the font settig work in new frames.
    ;; (set-default-font "Consolas:pixelsize=18")
    ;; (add-to-list 'default-frame-alist '(font . "Consolas:pixelsize=18"))
    ;; We have to use set-face-attribute
    (message "Set English Font to %s" en-font)
    (set-face-attribute 'default nil :font en-font)

    ;; Set Chinese font
    ;; Do not use 'unicode charset, it will cause the English font setting invalid
    (message "Set Chinese Font to %s" zh-font)
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font)
                        charset zh-font))))

;;����func4-���������Emacs �������þ���С��һ�����������ã�Emacs ������ѡ�� Consolas + ���źڡ�����ϡ�
;;������źڡ�û��װ�Ļ�����ʹ�á���Ȫ��ȿ�΢�׺ڡ����������ơ�����������ò��øĶ������ڲ�ͬ�Ĳ���ϵͳ���廷������ʹ��
(qiang-set-font
 '("Inconsolata" "Monaco" "DejaVu Sans Mono" "Monospace" "Courier New") ":pixelsize=14"
 '("Microsoft YaHie Monotype" "Yahei Mono" "Microsoft Yahei" "��Ȫ��ȿ�΢�׺�" "����" "������" "����")15)	;;Origin 16, ������ݶ����Ժã����������������в�����, ������15�ű������ܺá�

;; Microsoft YaHie Monotype ����Աר�õȿ����壺 ���ź�����Ч��һ����
;; YaHei Consolas Hybird ������
;; "Consolas" "Monaco" "DejaVu Sans Mono" "Monospace" "Courier New"
;; "Consolas" "Monaco" "Microsoft YaHie Monotype" "DejaVu Sans Mono" "Monospace" "Courier New"

;; For Windows�� Ctrl ���������ֲ��������������С
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)


(provide 'init-my-lng-font)