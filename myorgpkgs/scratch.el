;; Scratch file for org-mode.

(defun bh/make-org-scratch ()
  "Create a scratch file"
  (interactive)
  (find-file "~/orgcvs/pub/scratch.org")
  (gnus-make-directory "~/orgcvs/pub"))

(defun bh/switch-to-scratch ()
  "Switch to scratch file"
  (interactive)
  (switch-to-buffer "*scratch*"))
