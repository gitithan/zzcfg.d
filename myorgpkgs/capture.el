;; Configuration for capturing tasksm, notes, ... in org-mode.

(setq org-directory "~/orgcvs")
;; To set up with version control using git:
;; mkdir ~/git/org; cd ~/git/org;
;; git init .
;; git add refile.org
;; git commit -m "org-mode notes file"
(setq org-default-notes-file "~/orgcvs/oocsys/refile.org")

;; Use C-M-r to start capture mode
(global-set-key (kbd "C-M-r") 'org-capture)
;; Use C-c r to start capture mode when using SSH from eg an Android phone
(global-set-key (kbd "C-c r") 'org-capture)

;; Org protocol is a great way to create capture notes in org-mode from
;; other applications. I use this to create tasks to review interesting
;; web pages I visit in Firefox.
(require 'org-protocol)

;; Capture templates for: TODO tasks, Notes, appointments, phone calls,
;; and org-protocol.
(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/orgcvs/oocsys/refile.org")
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)

              ("r" "respond" entry (file "~/orgcvs/oocsys/refile.org")
               "* TODO Respond to %:from on %:subject\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)

              ("n" "note" entry (file "~/orgcvs/oocsys/refile.org")
               "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)

              ("j" "Journal" entry (file+datetree "~/ogcvs/oocsys/diary.org")
               "* %?\n%U\n" :clock-in t :clock-resume t)

              ("w" "org-protocol to refile" entry (file "~/orgcvs/oocsys/refile.org")
               "* TODO Review %c\n%U\n" :immediate-finish t)

              ("e" "org-protocol for bookmarks" entry (file "~/orgcvs/orgbkmk.org")
               "* TODO Review %c\n%U\n" :immediate-finish t)

              ("p" "Phone call" entry (file "~/orgcvs/oocsys/refile.org")
               "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)


	      ("x" "xs" entry (file+headline "~/orgcvs/gnxcsys/xsc.org" "xs-tips")
		;;"* Tips %U\n\n\s\s%?\n %i\n" :prepend t :empty-lines 1)
	       "* %A%?\n %i\n" :prepend t :empty-lines 1)

	      ("g" "gs" entry (file+headline "~/orgcvs/gnxcsys/gsc.org" "gs-tips")
	        ;;"* Tips %U\n\n\s\s%?\n %i\n" :prepend t :empty-lines 1)
	       "* %A%?\n %i\n" :prepend t :empty-lines 1)

	      ("m" "ns" entry (file+headline "~/orgcvs/gnxcsys/nsc.org" "ns-tips")
		;;"* Tips %U\n\n\s\s%?\n %i\n" :prepend t :empty-lines 1)
	       "* %A%?\n %i\n" :prepend t :empty-lines 1)


              ("h" "Habit" entry (file "~/orgcvs/oocsys/refile.org")
               "* NEXT %?\n%U\n%a\nSCHEDULED: %t .+1d/3d\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))
