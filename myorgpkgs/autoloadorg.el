;; Set up org-mode
;; This set up is based on http://doc.norang.ca/org-mode.html
;; "Org Mode - Organize Your Life In Plain Text!" by Bernt Hansen,
;; with time stamp: 2012-06-06T22:30-0400
(require 'org-install)
(require 'org-habit)
(load-file "~/zzcfg.d/myorgpkgs/basic.el")
(load-file "~/zzcfg.d/myorgpkgs/agenda.el")
(load-file "~/zzcfg.d/myorgpkgs/narrow.el")
(load-file "~/zzcfg.d/myorgpkgs/archiving.el")
(load-file "~/zzcfg.d/myorgpkgs/diary.el")
(load-file "~/zzcfg.d/myorgpkgs/meeting_notes.el")
(load-file "~/zzcfg.d/myorgpkgs/capture.el")
;; Note: Some IDO settings are in refile.el
(load-file "~/zzcfg.d/myorgpkgs/refile.el")
;; Note: Some keyword colors are set in todo.el
(load-file "~/zzcfg.d/myorgpkgs/todo.el")
(load-file "~/zzcfg.d/myorgpkgs/time_clocking.el")
(load-file "~/zzcfg.d/myorgpkgs/visibility.el")
(load-file "~/zzcfg.d/myorgpkgs/scratch.el")
(load-file "~/zzcfg.d/myorgpkgs/babel.el")
(load-file "~/zzcfg.d/myorgpkgs/publish.el")
(load-file "~/zzcfg.d/myorgpkgs/speed_commands.el")
(load-file "~/zzcfg.d/myorgpkgs/key_bindings.el")
(load-file "~/zzcfg.d/myorgpkgs/cosmetic.el")
(load-file "~/zzcfg.d/myorgpkgs/orgaddon.el")

;; new patch
(require 'org-agenda)
(require 'org-checklist)


(provide 'autoloadorg)