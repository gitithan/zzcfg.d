;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 编码设置 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq default-buffer-file-coding-system 'gbk)     ;缓存文件编码
(setq default-file-name-coding-system 'gbk)		  ;文件名编码
(setq default-keyboard-coding-system 'gbk)		  ;键盘输入编码
(setq default-process-coding-system '(gbk . gbk)) ;进程输出输入编码
(setq default-sendmail-coding-system 'gbkx)		  ;发送邮件编码
(setq default-terminal-coding-system 'gbk)		  ;终端编码

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
;; 字体设置
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Chinese font setteing 字体设置
;;(set-frame-font "雅黑宋体-11")
;;(set-fontset-font "fontset-default" 'han '("雅黑宋体-11" . "unicode-bmp"))
;;func1-能判断某个字体在系统中是否安装
(defun qiang-font-existsp (font)
  (if (null (x-list-fonts font))
      nil
    t))

;;func2-按顺序找到一个字体列表（list）中第一个已经安装可用的字体
(defvar font-list '("Microsoft YaHie Monotype" "Yahei Mono" "Microsoft Yahei" "文泉驿等宽微米黑" "黑体" "新宋体" "宋体"))
(require 'cl) ;; find-if is in common list package
(find-if #'qiang-font-existsp font-list)

;;func3-还要有个辅助函数，用来产生带上 font size 信息的 font 描述文本
(defun qiang-make-font-string (font-name font-size)
  (if (and (stringp font-size)
           (equal ":" (string (elt font-size 0))))
      (format "%s%s" font-name font-size)
    (format "%s %s" font-name font-size)))

;;func4-有了以上func1-func3这些函数，下面出场的就是自动设置字体函数了
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

;;利用func4-这个函数，Emacs 字体设置就是小菜一碟了这样设置，Emacs 会优先选用 Consolas + “雅黑”的组合。
;;如果“雅黑”没有装的话，就使用“文泉驿等宽微米黑”，依此类推。这份字体配置不用改动就能在不同的操作系统字体环境下面使用
(qiang-set-font
 '("Inconsolata" "Monaco" "DejaVu Sans Mono" "Monospace" "Courier New") ":pixelsize=14"
 '("Microsoft YaHie Monotype" "Yahei Mono" "Microsoft Yahei" "文泉驿等宽微米黑" "黑体" "新宋体" "宋体")15)	;;Origin 16, 表格内容对齐性好，但表格内容与标题列不对齐, 新宋体15号本身对齐很好。

;; Microsoft YaHie Monotype 程序员专用等宽字体： 和雅黑宋体效果一样。
;; YaHei Consolas Hybird 不对齐
;; "Consolas" "Monaco" "DejaVu Sans Mono" "Monospace" "Courier New"
;; "Consolas" "Monaco" "Microsoft YaHie Monotype" "DejaVu Sans Mono" "Monospace" "Courier New"

;; For Windows用 Ctrl 加上鼠标滚轮操作来调整字体大小
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)


(provide 'init-my-lng-font)