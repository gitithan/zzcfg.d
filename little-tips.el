;;����û��ѡ��һ�������ʱ��C-w����й�������У����ܹ���λ�����������M-w��ʱ����Ḵ�ƹ�����ڵ��У����ܹ���λ�������׻�����β�������м������λ�á�
;;������ѡ�������ʱ��C-w��M-w�Ĺ��ܺ�Emacs�Դ���ûɶ����

;(defadvice kill-ring-save (before slickcopy activate compile)
;��When called interactively with no active region, copy a single line instead.��
;(interactive
;(if mark-active (list (region-beginning) (region-end))
;(list (line-beginning-position)
;(line-beginning-position 2)))))
;(defadvice kill-region (before slickcut activate compile)
;��When called interactively with no active region, kill a single line instead.��
;(interactive
;(if mark-active (list (region-beginning) (region-end))
;(list (line-beginning-position)
;(line-beginning-position 2)))))


;huangq-save-one-line �Ǹ���һ�У�����в�������ӵ�һ�����ǿո���ַ���ʼ���ơ�
;huangq-kill-ring-save ���ѡ���������������򣻷������С�
;huangq-save-line-dwim ���ѡ�������򣬸������򣻷���ӵ�һ�����ǿո���ַ���ʼ���ơ�

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



;;��ʱ�Ǻ�
;;=========
;;��ʱ����Ҫ������һ���ļ�����һЩ������Ȼ��ܿ�����������㵱Ȼ���� ʹ�� bookmark���߼Ĵ�����
;;������Щʵ����̫���ˡ������ӵ��vi������ ma, mb, 'a, 'b �Ĳ���������������ü��� elisp �ﵽ���Ƶ�Ŀ��
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

;;ģ��Vi f����
;;=============
;; go-to-char �ǳ���л Oliver Scholz �ṩ��������� �ҡ�
;;���������һ�� vi �� "f" ��������Ʒ��vi���û�֪����vi�� һ���ر�õ����� "f"�����㰴 "fx", x ������һ���ַ�ʱ
;;��� �ͻ��ƶ�����һ�� "x" ������֮��ֻҪ�� ";"(�ֺ�)�����͵��� ��һ�� "x"��
;;�ٸ�����˵������������;����������������һ���֣������ ���ס�
;;(setq unread-command-events (list last-input-event)))
;;                                             ^^^^^
;;����ϣ��Ѹ�ٵĵ�������Ǹ� event ������������ vi �ﰴ "fe"�������굽�� "setq" ���Ǹ� e ���棬��ʱ���ҽ��Ű� ";",
;;��һ����͵���������Ҫ�ĵط����ܷ���ɣ�������������ã����� �㷢������ķǳ��ã�
  
;;��һֱ���� Emacs û������һ�������������� Oliver ���� ��һ�������Ĵ𰸣�
;;������δ���֮�󣬵��㰴 C-c a x (x ������һ���ַ�) ʱ���� ��ͻᵽ��һ�� x �����ٴΰ� x�����͵���һ�� x������ C-c a w w w w ..., C-c a b b b b b b ...
;;�Ҿ��������ʽ�� vi �� "f" Ҫ�졣

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