;----------------
;flymake mode
;-----------------
(require 'flymake)

(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
           (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
      (list "pep8" (list "--repeat" local-file))))
 (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pylint-init)))

(add-hook 'python-mode-hook
        '(lambda ()
           (setq python-indent 4)
           (setq fill-column 79)
           (flymake-mode)))

(provide 'init-pybrew-flymake)

