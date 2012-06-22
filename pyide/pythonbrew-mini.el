;;; pythonbrew-mini.el --- A simple pythonbrew wrapper for Emacs

;; Copyright (C) 2011 Damien Krotkine, Franck Cuny

;; Author: Damien Krotkine <dams@cpan.org>, Franck Cuny <franck@lumberjaph.net>
;; Keywords: Emacs, python, pythonbrew

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Simple Usage:

;;  This will look for available pythons in the default pythonbrew directory
;;  ($HOME/.pythonbrew/pythons/) and load the latest version

;; (require 'pythonbrew-mini)
;; (pythonbrew-mini-use-latest)

;; More options:

;; (require 'pythonbrew-mini)

;; the directory containing all the pythons (defaults to $HOME/.pythonbrew/pythons/)
;; (pythonbrew-mini-set-pythons-dir "/home/username/.pythonbrew/pythons/")

;; the version to use
;; (pythonbrew-mini-use "Python-2.7.1") ;; initialize python version to use

;; Later on, the following lisp functions will be available :
;;   pythonbrew-mini-get-current-python-path ;; returns the current python path
;;   pythonbrew-mini-get-current-version ;; returns the current python version in use

;; These functions are especially useful with flymake.

;;; Code:

(defvar pythonbrew-mini-pythons-dir (concat (getenv "HOME") "/.pythonbrew/pythons/"))
(defvar pythonbrew-mini-current-python-path nil)
(defvar pythonbrew-mini-current-version nil)

(defun pythonbrew-mini-use (version)
  (pythonbrew-mini-set-current-version version )
  (pythonbrew-mini-set-current-python-path)
  (pythonbrew-mini-set-current-exec-path)
)

(defun pythonbrew-mini-use-latest ()
  (let (latest)
    (setq latest (car (last (sort (directory-files pythonbrew-mini-pythons-dir) 'string<))))
    (pythonbrew-mini-use latest)
    )
)

(defun pythonbrew-mini-set-pythons-dir (path)
  (setq pythonbrew-mini-pythons-dir path)
)

(defun pythonbrew-mini-get-current-python-path ()
  pythonbrew-mini-current-python-path)

(defun pythonbrew-mini-get-current-version ()
  pythonbrew-mini-current-version)

(defun pythonbrew-mini-set-current-exec-path ()

  ;; Prepend pythonbrew paths to exec-path
  (add-to-list 'exec-path (concat pythonbrew-mini-pythons-dir pythonbrew-mini-current-version "/bin"))

  ;; set PATH to be the same as exec-path, clobber the old PATH value.
  (setenv "PATH"
          (reduce
           (lambda (a b) (concatenate 'string a ":" b))
           exec-path))
  (message "on se retrouve avec path -> %s"
                     (reduce
           (lambda (a b) (concatenate 'string a ":" b))
           exec-path
           )))

(defun pythonbrew-mini-set-current-python-path ()
  (setq pythonbrew-mini-current-python-path
	(pythonbrew-mini-join2
	 (list pythonbrew-mini-pythons-dir pythonbrew-mini-current-version "/bin/python")
	)
  )
)

(defun pythonbrew-mini-set-current-version (version)
  (setq pythonbrew-mini-current-version version))

(defun pythonbrew-mini-join2 (list)
  (mapconcat 'identity list ""))

(provide 'pythonbrew-mini)
;;; pythonbrew-mini.el ends here
