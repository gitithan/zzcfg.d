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



;;临时记号
;;=========
;;有时你需要跳到另一个文件进行一些操作，然后很快的跳回来。你当然可以 使用 bookmark或者寄存器。
;;但是这些实在是太慢了。你多想拥有vi那样的 ma, mb, 'a, 'b 的操作。现在你可以用几行 elisp 达到类似的目的
(global-set-key [(control ?\.)] 'ska-point-to-register)	;;bound to C-.
(global-set-key [(control ?\,)] 'ska-jump-to-register)	;;bound to C-,

(defun ska-point-to-register()
  "Store cursorposition _fast_ in a register.
Use ska-jump-to-register to jump back to the stored
position."
  (interactive)
  (setq zmacs-region-stays t)
  (point-to-register 8))
  
(defun ska-jump-to-register()
  "Switches between current cursorposition and position
that was stored with ska-point-to-register."
  (interactive)
  (setq zmacs-region-stays t)
  (let ((tmp (point-marker)))
        (jump-to-register 8)
        (set-register 8 tmp)))

;;模拟Vi f命令
;;=============
;; go-to-char 非常感谢 Oliver Scholz 提供这个函数给 我。
;;这个函数是一个 vi 的 "f" 命令的替代品。vi的用户知道，vi有 一个特别好的命令 "f"。当你按 "fx", x 是任意一个字符时
;;光标 就会移动到下一个 "x" 处。这之后只要按 ";"(分号)，光标就到再 下一个 "x"。
;;举个例子说明这个命令的用途。比如我们有这样一行字，光标在 行首。
;;(setq unread-command-events (list last-input-event)))
;;                                             ^^^^^
;;我们希望迅速的到达最后那个 event 处，于是我在 vi 里按 "fe"。结果光标到了 "setq" 的那个 e 上面，这时候我接着按 ";",
;;不一会儿就到了我们想要的地方。很方便吧？可能起初不觉得，后来 你发现这真的非常好！
  
;;我一直觉得 Emacs 没有这样一个方便的命令，但是 Oliver 给了 我一个完美的答案：
;;有了这段代码之后，当你按 C-c a x (x 是任意一个字符) 时，光 标就会到下一个 x 处。再次按 x，光标就到下一个 x。比如 C-c a w w w w ..., C-c a b b b b b b ...
;;我觉得这个方式比 vi 的 "f" 要快。

(defun wy-go-to-char (n char)
  "Move forward to Nth occurence of CHAR.
Typing `wy-go-to-char-key' again will move forwad to the next Nth
occurence of CHAR."
  (interactive "p\ncGo to char: ")
  (search-forward (string char) nil nil n)
  (while (char-equal (read-char)
             char)
    (search-forward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))
;;(define-key global-map (kbd "C-u a") 'wy-go-to-char)
(define-key global-map (kbd "C-0") 'wy-go-to-char)


(provide 'little-tips)