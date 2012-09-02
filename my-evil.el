;;;;
;;;; EVIL
;;;;
(require 'evil)

;;; org agenda -- leave in emacs mode but add j & k

(define-key org-agenda-mode-map "j" 'evil-next-line)
(define-key org-agenda-mode-map "k" 'evil-previous-line)


;;; key chords for simultaneous key presses for common commands

(require 'key-chord) ; for mapping simultaneous key presses 
;; http://www.emacswiki.org/emacs/key-chord.el
(key-chord-mode 1)

(key-chord-define-global "ds"  'evil-normal-state) ; super ESC
(key-chord-define-global "ew"  'evil-emacs-state)
(key-chord-define-global "kl"  'evil-window-map)
;;(key-chord-define evil-window-map "df" 'evil-window-prev) ; df twice


;;;;;;;; space chords
;;;;
;;;;(require 'space-chord)
;;;;(space-chord-define-global "j" 'evil-normal-state)	;;conflict with "space" command
;;;;(space-chord-define-global "i"  'evil-emacs-state)


(provide 'my-evil)