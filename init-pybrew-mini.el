;---------------
;lambda mode
;---------------
(load "cl-seq")
;(mapc (lambda (x) (add-to-list 'exec-path x))
; (mapcar (lambda (x) (concat (getenv "HOME") x))

;------------------
;load pythonbrew-mini
;------------------
(require 'pythonbrew-mini)
;(pythonbrew-mini-use-latest)


;--------------------
;set pythonbrew dir
;--------------------
;; by default pythonbrew-mini-set-pythons is set to $HOME/.pythonbrew/pythons/
(pythonbrew-mini-set-pythons-dir "/home/lphp/.pythonbrew/pythons/")


;-------------------
;deflt pythonbrew vs
;-------------------
;; by default it will use the latest python (alphanumeric comparison on the file name)
(pythonbrew-mini-use "Python-2.6.8")


;------------------
;cpy-mode
;------------------
(require 'pythonbrew-mini)
(pythonbrew-mini-use "python-2.6.8")


(provide 'init-pybrew-mini)
