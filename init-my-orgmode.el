;;ORG-MODE设置
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-hide-leading-stars t)
(setq org-log-done t)
;;(global-font-lock-mode 1)                     ; for all buffers
(add-hook 'org-mode-hook 'turn-on-font-lock)  ; Org buffers only

;;(setq org-todo-keywords
;;       '((sequence "TODO" "FEEDBACK" "VERIFY" "|" "DONE" "DELEGATED")))

;;TODO entry to automatically change to DONE when all chilrden are done, you can use the following setup:
     (defun org-summary-todo (n-done n-not-done)
       "Switch entry to DONE when all subentries are done, to TODO otherwise."
       (let (org-log-done org-log-states)   ; turn off logging
         (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
     (add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

(setq org-link-abbrev-alist
       '(
	 ("my1" . "http://127.0.0.1/")
         ("goog". "http://www.google.com/search?q=")
        )
)

;; publish all together with C-c C-e E
(setq org-publish-project-alist
           '(("org"
              :base-directory "~/Plans/"
			  :base-extension "org"
              :publishing-directory "~/Plans/"
			  :style "<link rel=stylesheet
|                      href=\"~/Plans/css/core.css\"
|                      type=\"text/css\">"
;;              :section-numbers nil
              :table-of-contents t
                                      )))

;;Including all org files from a directory into the agenda
;;(setq org-agenda-files (file-expand-wildcards "~/org/*.org"))
(setq org-agenda-files (list
				"~/Plans/sandbox.org"
				"~/Plans/try.org"
))
;;(setq org-todo-keyword-faces '(("DONE"  (:strike-through t))))
(setq org-fontify-done-headline t)


;; exporting agenda views
(setq org-agenda-exporter-settings
      '((ps-number-of-columns 2)
	(ps-landscape-mode t)
	(org-agenda-add-entry-text-maxlines 5)
	(htmlize-output-type 'css)))

(setq org-agenda-custom-commands
      '(("X" agenda "" nil ("~/Plans/agenda.html" "~/Plans/agenda.ps"))
	("Y" alltodo "" nil ("~/Plans/todo.html" "~/Plans/todo.txt" "Plans/todo.ps"))
	("i" "Agenda and important tasks"
	 ((agenda "")
	  (tags-todo "重要")
	  (tags "重要"))
	 nil
	 ("~/Plans/important.html"))
))


(setq org-agenda-custom-commands
      '(("X" agenda ""
	 ((ps-number-of-columns 2)
	  (ps-landscape-mode t)
	  (org-agenda-prefix-format " [ ] ")
	  (org-agenda-with-colors nil)
	  (org-agenda-remove-tags t))
	 ("~/Plans/theagenda.html"))))


;;org-export-as-html-and-open
(global-set-key [f9] 'org-export-as-html-and-open)
(setq org-export-html-style
     "<link rel=\"stylesheet\" type=\"text/css\" href=\"~/Plans/css/core.css\" />")


;;org Color
;; TODO keyword faces
(setq org-todo-keyword-faces
      '(("PBUG" . (:background "gold" :foreground "indianred3" :weight bold))
    ("CBUG" . (:background "gold" :foreground "indianred3" :weight bold))
    ("SEGF" . (:background "gold" :foreground "indianred3" :weight bold))
    ("CNCL" . (:background "snow3" :foreground "black" :weight bold))
    ))

;; TAG faces
(setq org-tag-faces
      '(("PROJ" :background "indianred3" :foreground "cornsilk2" :weight bold)
    ))


;;======================================================

;;org Color
;; TODO keyword faces
(setq org-todo-keyword-faces
      '(("PBUG" . (:background "gold" :foreground "indianred3" :weight bold))
    ("CBUG" . (:background "gold" :foreground "indianred3" :weight bold))
    ("SEGF" . (:background "gold" :foreground "indianred3" :weight bold))
    ("CNCL" . (:background "snow3" :foreground "black" :weight bold))
    ))

;; TAG faces
(setq org-tag-faces
      '(("PROJ" :background "indianred3" :foreground "cornsilk2" :weight bold)
    ))


;;Org Capture模板设置
(define-key global-map [(f8)] 'org-capture)
(require 'org-capture)
(setq org-capture-templates
      `(("t" "Task" entry (file+headline "~/Plans/sandbox.org" "Tasks")
         "* TODO %^{Brief Description} %^g\n\s\sAdded: %U" :prepend t)

	("i" "Idea" entry (file+headline "~/Plans/sandbox.org" "Idea")
         "* %^{Brief Description} %^g\n\s\sAdded: %U" :prepend t)

        ("s" "Someday" entry (file+headline "~/Plans/sandbox.org" "Someday/Maybe")
         "* %^{Brief Description} %^g\n\s\sAdded: %U" :prepend t)

        ;;("p" "P.S." entry (file+headline "~/Plans/noteps.org" "*Note*")
        ;; "* Tips %U\n\n\s\s%?\n %i\n  %a" :prepend t :empty-lines 1)

	("x" "xs" entry (file+headline "~/Plans/xs.org" "xs-tips")
         ;;"* Tips %U\n\n\s\s%?\n %i\n" :prepend t :empty-lines 1)
	 "* %A%?\n %i\n" :prepend t :empty-lines 1)

	 ("g" "gs" entry (file+headline "~/Plans/gs.org" "gs-tips")
         ;;"* Tips %U\n\n\s\s%?\n %i\n" :prepend t :empty-lines 1)
	 "* %A%?\n %i\n" :prepend t :empty-lines 1)

	 ("n" "ns" entry (file+headline "~/Plans/ns.org" "ns-tips")
         ;;"* Tips %U\n\n\s\s%?\n %i\n" :prepend t :empty-lines 1)
	 "* %A%?\n %i\n" :prepend t :empty-lines 1)

	("m" "DailyReview" entry (file+headline "~/Plans/notes.org.gpg" "Daily Review")
         "* %U :COACH: \n\n%[~/org/dailyreview.txt]\n" :prepend t)

	("p" "strong" entry (file+headline "~/Plans/one.org.gpg" "Strong")
         "* %^{Brief Description} %^g\n\s\sAdded: %U" :prepend t)

	("w" "unstrong" entry (file+headline "~/Plans/one.org.gpg" "Unstrong")
         "* %^{Brief Description} %^g\n\s\sAdded: %U" :prepend t)

        ;; ...
        ("k" "Innovation" table-line
         (file+headline "~/Plans/innovation.org.gpg" "Idea Of Innovation")
         "| %? | | %a | %U |")

        ("a" "Account" table-line
         (file+headline "~/Plans/account.org.gpg" "Web accounts")
         "| %? | | %a | %U |")))


;;;;;;;;;;;;;;;;;; End of org-mode config ;;;;;;;;;;;;;;;;;;

;-----------------
;custom capture-org cmd
;-----------------
(define-key global-map "\M-m" 'org-capture-finalize)
;(define-key org-capture-mode-map "\C-c\C-k" 'org-capture-kill)
;(define-key org-capture-mode-map "\C-c\C-w" 'org-capture-refile)



(provide 'init-my-orgmode)
