;;当你没有选中一个区域的时候，C-w会剪切光标所在行，不管光标的位置在哪里；而用M-w的时候，则会复制光标所在的行，不管光标的位置在行首还是行尾还是行中间的任意位置。
;;当你有选中区域的时候，C-w和M-w的功能和Emacs自带的没啥两样

;(defadvice kill-ring-save (before slickcopy activate compile)
;“When called interactively with no active region, copy a single line instead.”
;(interactive
;(if mark-active (list (region-beginning) (region-end))
;(list (line-beginning-position)
;(line-beginning-position 2)))))
;(defadvice kill-region (before slickcut activate compile)
;“When called interactively with no active region, kill a single line instead.”
;(interactive
;(if mark-active (list (region-beginning) (region-end))
;(list (line-beginning-position)
;(line-beginning-position 2)))))


;huangq-save-one-line 是复制一行；如果有参数，则从第一个不是空格的字符开始复制。
;huangq-kill-ring-save 如果选定了区域，则复制区域；否则复制行。
;huangq-save-line-dwim 如果选定了区域，复制区域；否则从第一个不是空格的字符开始复制。

(global-set-key (kbd "M-y") 'huangq-save-line-dwim)

;;;###autoload
(defun huangq-save-one-line (&optional arg)
  "save one line. If ARG, save one line from first non-white."
  (interactive "P")
  (save-excursion
    (if arg
        (progn
          (back-to-indentation)
          (kill-ring-save (point) (line-end-position)))
      (kill-ring-save (line-beginning-position) (line-end-position)))))

;;;###autoload
(defun huangq-kill-ring-save (&optional n)
  "If region is active, copy region. Otherwise, copy line."
  (interactive "p")
  (if (and mark-active transient-mark-mode)
      (kill-ring-save (region-beginning) (region-end))
    (if (> n 0)
        (kill-ring-save (line-beginning-position) (line-end-position n))
      (kill-ring-save (line-beginning-position n) (line-end-position)))))

;;;###autoload
(defun huangq-save-line-dwim (&optional arg)
  "If region is active, copy region.
If ARG is nil, copy line from first non-white.
If ARG is numeric, copy ARG lines.
If ARG is non-numeric, copy line from beginning of the current line."
  (interactive "P")
  (if (and mark-active transient-mark-mode)
      ;; mark-active, save region
      (kill-ring-save (region-beginning) (region-end))
    (if arg
        (if (numberp arg)
            ;; numeric arg, save ARG lines
            (huangq-kill-ring-save arg)
          ;; other ARG, save current line
          (huangq-save-one-line))
      ;; no ARG, save current line from first non-white
      (huangq-save-one-line t))))


(provide 'little-tips)