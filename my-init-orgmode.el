;--------------
;org-mode setup
;--------------
;;;
;;; Org Mode
;;;
;;(add-to-list 'load-path (expand-file-name "~/git/org-mode/lisp"))
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))
;;(require 'org-install)
;;
;; Standard key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)


;---------------
;org agenda setup
;---------------
(setq org-agenda-files (quote (
                               "~/orgcvs/gtdsys"
                               "~/orgcvs/codai"
			       "~/orgcvs/codfm"
			       "~/orgcvs/tdysys"
			       ;"~/orgcvs/gnxcsys"
			       "~/orgcvs/oocsys"
			       )))


;-----------------
;key bindings
;-----------------
;; Custom Key Bindings
(global-set-key (kbd "<f9> a") 'org-agenda)			;show agenda items
(global-set-key (kbd "<f5>") 'bh/org-todo)			;show todo items of only this subtree
(global-set-key (kbd "<S-f5>") 'bh/widen)			;widen
(global-set-key (kbd "<f7>") 'bh/set-truncate-lines)		;开关：自动折行
(global-set-key (kbd "<f10>") 'org-cycle-agenda-files)		;goto next file in agenda files
(global-set-key (kbd "<f9> <f9>") 'bh/show-org-agenda)		;only show *org-agenda* buffer
(global-set-key (kbd "<f9> b") 'bbdb)				;quick access to bbdb [像“名片盒”的数据库]
(global-set-key (kbd "<f9> c") 'calendar)			;quick access to Calendar
(global-set-key (kbd "<f9> f") 'boxquote-insert-file)		;标题“框”
(global-set-key (kbd "<f9> g") 'gnus)				;goto news and mail reader gnus in emacs
(global-set-key (kbd "<f9> h") 'bh/hide-other)			;hide other tasks
(global-set-key (kbd "<f9> n") 'org-narrow-to-subtree)		;narrow to subtree of current level
(global-set-key (kbd "<f9> w") 'widen)				;widen opsite action to <f9> n
(global-set-key (kbd "<f9> u") 'bh/narrow-up-one-level)		;only narrow one-level

(global-set-key (kbd "<f9> I") 'bh/punch-in)			;计时开始
(global-set-key (kbd "<f9> O") 'bh/punch-out)			;计时结束

(global-set-key (kbd "<f9> o") 'bh/make-org-scratch)		;switch to *org-scratch* buffer

(global-set-key (kbd "<f9> r") 'boxquote-region)		;给选定的区块加 “框”
(global-set-key (kbd "<f9> s") 'bh/switch-to-scratch)

(global-set-key (kbd "<f9> t") 'bh/insert-inactive-timestamp)	;加入时间截
(global-set-key (kbd "<f9> T") 'tabify)				;整个区块 “缩进”
(global-set-key (kbd "<f9> U") 'untabify)			;整个区块 “反缩进”

(global-set-key (kbd "<f9> v") 'visible-mode)			;switch to visible-mode (to ediet or show links)
(global-set-key (kbd "<f9> SPC") 'bh/clock-in-last-task)	;switch clock to preivous clocked task
(global-set-key (kbd "C-<f9>") 'previous-buffer)		;切换到 前一个 buffer
(global-set-key (kbd "M-<f9>") 'org-toggle-inline-images)	;开/关 当前行的 图像显示
(global-set-key (kbd "C-x n r") 'narrow-to-region)		;限制操作：只能在选定区域内
(global-set-key (kbd "C-<f10>") 'next-buffer)			;下一个 buffer
(global-set-key (kbd "<f11>") 'org-clock-goto)			;goto current colocked item
(global-set-key (kbd "C-<f11>") 'org-clock-in)			;make current task item Clock in
(global-set-key (kbd "C-<f12>") 'bh/save-then-publish)		;保存然后发布
(global-set-key (kbd "<f8>") 'org-capture)
(global-set-key (kbd "<f9> e") 'org-export-as-html-and-open)	;导出当前org为html并打开
;;;;(global-set-key (kbd "C-c r") 'org-capture)

(defun bh/hide-other ()
  (interactive)
  (save-excursion
    (org-back-to-heading 'invisible-ok)
    (hide-other)
    (org-cycle)
    (org-cycle)
    (org-cycle)))

(defun bh/set-truncate-lines ()
  "Toggle value of truncate-lines and refresh window display."
  (interactive)
  (setq truncate-lines (not truncate-lines))
  ;; now refresh window display (an idiom from simple.el):
  (save-excursion
    (set-window-start (selected-window)
                      (window-start (selected-window)))))

(defun bh/make-org-scratch ()
  (interactive)
  (find-file "~/orgcvs/pub/scratch.org")
  (gnus-make-directory "~/orgcvs/pub"))

(defun bh/switch-to-scratch ()
  (interactive)
  (switch-to-buffer "*scratch*"))


;------------
;Todo keywords
;------------
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!/!)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold)
              ("PHONE" :foreground "forest green" :weight bold))))



;-------------
;fast todo selection
;-------------
(setq org-use-fast-todo-selection t)

(setq org-treat-S-cursor-todo-selection-as-state-change nil)
;;allows changing todo states with S-left and S-right skipping all of the normal processing when entering 
;;or leaving a todo state. This cycles through the todo states but skips setting timestamps and entering notes 
;;which is very convenient when all you want to do is fix up the status of an entry.


;--------------
;todo state triggers
;--------------
(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("HOLD" ("WAITING" . t) ("HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

;;------- Todo state triggers Rules --------
;;Moving a task to CANCELLED adds a CANCELLED tag
;;Moving a task to WAITING adds a WAITING tag
;;Moving a task to HOLD adds a WAITING tag
;;Moving a task to a done state removes a WAITING tag
;;Moving a task to TODO removes WAITING and CANCELLED tags
;;Moving a task to NEXT removes a WAITING tag
;;Moving a task to DONE removes WAITING and CANCELLED tags


;-----------------
;capture templetes
;-----------------
;;When a new task needs to be added 
;;I categorize it into one of a few things:
;;
;;A phone call (p)
;;An email I need to respond to (r)
;;A new task (t)
;;A new note (n)
;;An interruption (j)
;;A new habit (h)

(setq org-directory "~/orgcvs")
  (setq org-default-notes-file "~/orgcvs/oocsys/refile.org")

;; I use C-M-r to start capture mode
;;(global-set-key (kbd "C-M-r") 'org-capture)
;; I use C-c r to start capture mode when using SSH from my Android phone
;;(global-set-key (kbd "C-c r") 'org-capture)

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, and org-protocol
(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/orgcvs/oocsys/refile.org")
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)

              ("r" "respond" entry (file "~/orgcvs/oocsys/refile.org")
               "* TODO Respond to %:from on %:subject\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)

              ("n" "note" entry (file "~/orgcvs/oocsys/refile.org")
               "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)

              ("j" "Journal" entry (file+datetree "~/ogcvs/oocsys/diary.org")
               "* %?\n%U\n" :clock-in t :clock-resume t)

              ("w" "org-protocol" entry (file "~/orgcvs/oocsys/refile.org")
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



;-------------------------------------
;remove the 00:00 length clocked items
;-------------------------------------
;;I have the following setup to remove these empty LOGBOOK drawers if they occur.
;; Remove empty LOGBOOK drawers on clock out

(defun bh/remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at "LOGBOOK" (point))))

(add-hook 'org-clock-out-hook 'bh/remove-empty-drawer-on-clock-out 'append)


;------------------
;Refile Setup
;------------------
; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)

; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; Use IDO for both buffer and file completion and ido-everywhere to t
(setq org-completion-use-ido t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode (quote both))

;;;; Refile settings
; Exclude DONE state tasks from refile targets
(defun bh/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(setq org-refile-target-verify-function 'bh/verify-refile-target)

;;----------- how to use --------------
;;I just put the cursor on the task and hit C-c C-w and enter nor C-SPC sys RET and it's done


;-----------------
;custom agenda views
;-----------------
;;Custom agenda views are used for:
;;
;;Single block agenda shows the following
;;	overview of today
;;	Finding tasks to be refiled
;;	Finding stuck projects
;;	Finding NEXT tasks to work on
;;	Show all related tasks
;;	Reviewing projects
;;	Finding tasks waiting on something
;;	Findings tasks to be archived
;;Finding notes
;;Viewing habits
;;
;;If I want just today's calendar view then F12 a is still faster than generating the block agenda 
;;- especially if I want to view a week or month's worth of information, or check my clocking data. 


;; Dim blocked tasks
(setq org-agenda-dim-blocked-tasks t)

;; Compact the block agenda view
(setq org-agenda-compact-blocks t)

;; Custom agenda command definitions
;===================================
(setq org-agenda-custom-commands
      (quote (("N" "Notes" tags "NOTE"
               ((org-agenda-overriding-header "Notes")
                (org-tags-match-list-sublevels t)))
              ("h" "Habits" tags-todo "STYLE=\"habit\""
               ((org-agenda-overriding-header "Habits")
                (org-agenda-sorting-strategy
                 '(todo-state-down effort-up category-keep))))
              (" " "Agenda"
               ((agenda "" nil)
                (tags "REFILE"
                      ((org-agenda-overriding-header "Tasks to Refile")
                       (org-tags-match-list-sublevels nil)))
                (tags-todo "-CANCELLED/!"
                           ((org-agenda-overriding-header "Stuck Projects")
                            (org-agenda-skip-function 'bh/skip-non-stuck-projects)))
                (tags-todo "-WAITING-CANCELLED/!NEXT"
                           ((org-agenda-overriding-header "Next Tasks")
                            (org-agenda-skip-function 'bh/skip-projects-and-habits-and-single-tasks)
                            (org-agenda-todo-ignore-scheduled t)
                            (org-agenda-todo-ignore-deadlines t)
                            (org-agenda-todo-ignore-with-date t)
                            (org-tags-match-list-sublevels t)
                            (org-agenda-sorting-strategy
                             '(todo-state-down effort-up category-keep))))
                (tags-todo "-REFILE-CANCELLED/!-HOLD-WAITING"
                           ((org-agenda-overriding-header "Tasks")
                            (org-agenda-skip-function 'bh/skip-project-tasks-maybe)
                            (org-agenda-todo-ignore-scheduled t)
                            (org-agenda-todo-ignore-deadlines t)
                            (org-agenda-todo-ignore-with-date t)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "-HOLD-CANCELLED/!"
                           ((org-agenda-overriding-header "Projects")
                            (org-agenda-skip-function 'bh/skip-non-projects)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "-CANCELLED+WAITING/!"
                           ((org-agenda-overriding-header "Waiting and Postponed Tasks")
                            (org-agenda-skip-function 'bh/skip-stuck-projects)
                            (org-tags-match-list-sublevels nil)
                            (org-agenda-todo-ignore-scheduled 'future)
                            (org-agenda-todo-ignore-deadlines 'future)))
                (tags "-REFILE/"
                      ((org-agenda-overriding-header "Tasks to Archive")
                       (org-agenda-skip-function 'bh/skip-non-archivable-tasks)
                       (org-tags-match-list-sublevels nil))))
               nil)
              ("r" "Tasks to Refile" tags "REFILE"
               ((org-agenda-overriding-header "Tasks to Refile")
                (org-tags-match-list-sublevels nil)))
              ("#" "Stuck Projects" tags-todo "-CANCELLED/!"
               ((org-agenda-overriding-header "Stuck Projects")
                (org-agenda-skip-function 'bh/skip-non-stuck-projects)))
              ("n" "Next Tasks" tags-todo "-WAITING-CANCELLED/!NEXT"
               ((org-agenda-overriding-header "Next Tasks")
                (org-agenda-skip-function 'bh/skip-projects-and-habits-and-single-tasks)
                (org-agenda-todo-ignore-scheduled t)
                (org-agenda-todo-ignore-deadlines t)
                (org-agenda-todo-ignore-with-date t)
                (org-tags-match-list-sublevels t)
                (org-agenda-sorting-strategy
                 '(todo-state-down effort-up category-keep))))
              ("R" "Tasks" tags-todo "-REFILE-CANCELLED/!-HOLD-WAITING"
               ((org-agenda-overriding-header "Tasks")
                (org-agenda-skip-function 'bh/skip-project-tasks-maybe)
                (org-agenda-sorting-strategy
                 '(category-keep))))
              ("p" "Projects" tags-todo "-HOLD-CANCELLED/!"
               ((org-agenda-overriding-header "Projects")
                (org-agenda-skip-function 'bh/skip-non-projects)
                (org-agenda-sorting-strategy
                 '(category-keep))))
              ("w" "Waiting Tasks" tags-todo "-CANCELLED+WAITING/!"
               ((org-agenda-overriding-header "Waiting and Postponed tasks"))
               (org-tags-match-list-sublevels nil))
              ("A" "Tasks to Archive" tags "-REFILE/"
               ((org-agenda-overriding-header "Tasks to Archive")
                (org-agenda-skip-function 'bh/skip-non-archivable-tasks)
                (org-tags-match-list-sublevels nil))))))



;;I generally work top-down on the agenda. Things with deadlines and scheduled dates
;;(planned to work on today or earlier) show up in the agenda at the top.
;;
;;My day goes generally like this:
;;
;;	Punch in (this starts the clock on the default task)
;;	Look at the agenda and make a mental note of anything important to deal with today
;;	Read email and news
;;		create notes, and tasks for things that need responses with org-capture
;;	Check refile tasks and respond to emails
;;	Look at my agenda and work on important tasks for today
;;		Clock it in
;;		Work on it until it is DONE or it gets interrupted
;;	work on tasks
;;	Make journal entries (C-M-r j) for interruptions
;;	Punch out for lunch and punch back in after lunch
;;	work on more tasks
;;	Refile tasks to empty the list
;;		Tag tasks to be refiled with m collecting all tasks for the same target
;;		Bulk refile the tasks to the target location with B r
;;		Repeat (or refile individually with C-c C-w) until all refile tasks are gone
;;	Mark habits done today as DONE
;;	Punch out at the end of the work day


;----------------------
;Work on the next
;----------------------
;;When I look for a new task to work on I generally hit F12 SPC to get the block agenda and follow this order:
;;
;;	Pick something off today's agenda
;;		deadline for today (do this first - it's not late yet)
;;		deadline in the past (it's already late)
;;		a scheduled task for today (it's supposed to be done today)
;;		a scheduled task that is still on the agenda
;;		deadline that is coming up soon
;;	pick a NEXT task
;;	If you run out of items to work on look for a NEXT task in the current context pick a task from the Tasks list of the current project.


;-----------------------------------------------------------
;Automatically Removing Context Based Tasks With / RET
;-----------------------------------------------------------
(defun bh/org-auto-exclude-function (tag)
  "Automatic task exclusion in the agenda with / RET"
  (and (cond
        ((string= tag "hold")
         t)
        ((string= tag "farm")
         t))
       (concat "-" tag)))

(setq org-agenda-auto-exclude-function 'bh/org-auto-exclude-function)



;----------------
;time clocking
;----------------
;;My clocking setup basically works like this:
;;
;;Punch in (start the clock)
;;	This clocks in a predefined task by org-id that is the default task to clock in whenever the clock normally stops
;;Clock in tasks normally, and let moving to a DONE state clock out
;;	clocking out automatically clocks time on a parent task or moves back to the predefined default task if no parent exists.
;;Continue clocking whatever tasks you work on
;;Punch out (stop the clock)

;;If I punch-in with a prefix on a task in Project X then that task automatically becomes 
;;the default task and all clocked time goes on that project until I either punch out or punch in some other task.

;;For example, consider the following org file:
;;
;;* TODO Project A
;;** NEXT TASK 1
;;** TODO TASK 2
;;** TODO TASK 3
;;* Tasks
;;** TODO Some miscellaneous task
;;
;;I'll work on this file in the following sequence:
;;
;;1.I punch in with F9-I at the start of my day
;;	That clocks in the Organization task by id in my todo.org file.
;;
;;2.F12-SPC to review my block agenda
;;	Pick 'TODO Some miscellaneous task' to work on next and clock that in with I The clock is now on 'TODO Some miscellaneous task'
;;
;;3.I complete that task and mark it done with C-c C-t d
;;	This stops the clock and moves it back to the Organization task.
;;
;;4.Now I want to work on Project A so I clock in Task 1
;;	I work on Task 1 and mark it DONE. This clocks out Task 1 and moves the clock to Project A. Now I work on Task 2 and clock that in.


;-------------
;clock setup
;-------------
;;To get started we need to punch in which clocks in the default task and keeps the clock running. 
;;This is now simply a matter of punching in the clock with F9 I. You can do this anywhere. 
;;Clocking out will now clock in the parent task (if there is one with a todo keyword) or 
;;clock in the default task if not parent exists.
;;
;;Keeping the clock running when moving a subtask to a DONE state means clocking continues to apply to the project task.
;;I can pick the next task from the parent and clock that in without losing a minute or two while I'm deciding what to work on next.
;;
;;I keep clock times, state changes, and other notes in the :LOGBOOK: drawer.


;;;;I have the following org-mode settings for clocking:
;;========================================================
;;
;; Resume clocking task when emacs is restarted
(org-clock-persistence-insinuate)
;;
;; Show lot sof clocking history so it's easy to pick items off the C-F11 list
(setq org-clock-history-length 36)
;; Resume clocking task on clock-in if the clock is open
(setq org-clock-in-resume t)
;; Change tasks to NEXT when clocking in
(setq org-clock-in-switch-to-state 'bh/clock-in-to-next)
;; Separate drawers for clocking and logs
(setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))
;; Save clock data and state changes and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)
;; Clock out when moving task to a done state
(setq org-clock-out-when-done t)
;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persist t)
;; Do not prompt to resume an active clock
(setq org-clock-persist-query-resume nil)
;; Enable auto clock resolution for finding open clocks
(setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))
;; Include current clocking task in clock reports
(setq org-clock-report-include-clocking-task t)

(setq bh/keep-clock-running nil)

(defun bh/clock-in-to-next (kw)
  "Switch a task from TODO to NEXT when clocking in.
Skips capture tasks, projects, and subprojects.
Switch projects and subprojects from NEXT back to TODO"
  (when (not (and (boundp 'org-capture-mode) org-capture-mode))
    (cond
     ((and (member (org-get-todo-state) (list "TODO"))
           (bh/is-task-p))
      "NEXT")
     ((and (member (org-get-todo-state) (list "NEXT"))
           (bh/is-project-p))
      "TODO"))))

(defun bh/find-project-task ()
  "Move point to the parent (project) task if any"
  (save-restriction
    (widen)
    (let ((parent-task (save-excursion (org-back-to-heading 'invisible-ok) (point))))
      (while (org-up-heading-safe)
        (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
          (setq parent-task (point))))
      (goto-char parent-task)
      parent-task)))

(defun bh/punch-in (arg)
  "Start continuous clocking and set the default task to the
selected task.  If no task is selected set the Organization task
as the default task."
  (interactive "p")
  (setq bh/keep-clock-running t)
  (if (equal major-mode 'org-agenda-mode)
      ;;
      ;; We're in the agenda
      ;;
      (let* ((marker (org-get-at-bol 'org-hd-marker))
             (tags (org-with-point-at marker (org-get-tags-at))))
        (if (and (eq arg 4) tags)
            (org-agenda-clock-in '(16))
          (bh/clock-in-organization-task-as-default)))
    ;;
    ;; We are not in the agenda
    ;;
    (save-restriction
      (widen)
      ; Find the tags on the current task
      (if (and (equal major-mode 'org-mode) (not (org-before-first-heading-p)) (eq arg 4))
          (org-clock-in '(16))
        (bh/clock-in-organization-task-as-default)))))

(defun bh/punch-out ()
  (interactive)
  (setq bh/keep-clock-running nil)
  (when (org-clock-is-active)
    (org-clock-out))
  (org-agenda-remove-restriction-lock))

(defun bh/clock-in-default-task ()
  (save-excursion
    (org-with-point-at org-clock-default-task
      (org-clock-in))))

(defun bh/clock-in-parent-task ()
  "Move point to the parent (project) task if any and clock in"
  (let ((parent-task))
    (save-excursion
      (save-restriction
        (widen)
        (while (and (not parent-task) (org-up-heading-safe))
          (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
            (setq parent-task (point))))
        (if parent-task
            (org-with-point-at parent-task
              (org-clock-in))
          (when bh/keep-clock-running
            (bh/clock-in-default-task)))))))

(defvar bh/organization-task-id "eb155a82-92b2-4f25-a3c6-0304591af2f9")

(defun bh/clock-in-organization-task-as-default ()
  (interactive)
  (org-with-point-at (org-id-find bh/organization-task-id 'marker)
    (org-clock-in '(16))))

(defun bh/clock-out-maybe ()
  (when (and bh/keep-clock-running
             (not org-clock-clocking-in)
             (marker-buffer org-clock-default-task)
             (not org-clock-resolving-clocks-due-to-idleness))
    (bh/clock-in-parent-task)))

(add-hook 'org-clock-out-hook 'bh/clock-out-maybe 'append)


;;I used to clock in tasks by ID using the following function but with the new punch-in and punch-out I don't need these as much anymore. 
;;f9-SPC calls bh/clock-in-last-task which switches the clock back to the previously clocked task.

(require 'org-id)
(defun bh/clock-in-task-by-id (id)
  "Clock in a task by id"
  (org-with-point-at (org-id-find id 'marker)
    (org-clock-in nil)))

(defun bh/clock-in-last-task (arg)
  "Clock in the interrupted task if there is one
Skip the default task and get the next one.
A prefix arg forces clock in of the default task."
  (interactive "p")
  (let ((clock-in-to-task
         (cond
          ((eq arg 4) org-clock-default-task)
          ((and (org-clock-is-active)
                (equal org-clock-default-task (cadr org-clock-history)))
           (caddr org-clock-history))
          ((org-clock-is-active) (cadr org-clock-history))
          ((equal org-clock-default-task (car org-clock-history)) (cadr org-clock-history))
          (t (car org-clock-history)))))
    (org-with-point-at clock-in-to-task
      (org-clock-in nil))))


;;-------------- clock in ---------------
;;When I start or continue working on a task I clock it in with any of the following:
;;
;;C-c C-x C-i
;;I in the agenda
;;I speed key on the first character of the heading line
;;f9 I while on the task in the agenda
;;f9 I while in the task in an org file


;;-------------- set a default clock task ----------------
;;I have a default ** Organization task in my todo.org file that I tend to put miscellaneous clock time on. 
;;This is the task I clock in on when I punch in at the start of my work day with F9-I. While reorganizing my org-files, 
;;reading email, clearing my inbox, and doing other planning work that isn't for a specific project I'll clock in this task. 
;;Punching-in anywhere clocks in this Organization task as the default task.
;;
;;If I want to change the default clocking task I just visit the new task in any org buffer and clock it in with C-u C-u C-c C-x C-i. 
;;Now this new task that collects miscellaneous clock minutes when the clock would normally stop.
;;
;;You can quickly clock in the default clocking task with C-u C-c C-x C-i d. 
;;Another option is to repeatedly clock out so the clock moves up the project tree 
;;until you clock out the top-level task and the clock moves to the default task.

;----------------  Using The Clock History To Clock In Old Tasks ---------------
;;You can use the clock history to restart clocks on old tasks you've clocked or 
;;to jump directly to a task you have clocked previously. I use this mainly to clock in whatever got interrupted by something.
;;
;;Consider the following scenario:
;;
;;	You are working on and clocking Task A (Organization)
;;	You get interrupted and switch to Task B (Document my use of org-mode)
;;	You complete Task B (Document my use of org-mode)
;;	Now you want to go back to Task A (Organization) again to continue
;;
;;This is easy to deal with.
;;
;;	1.Clock in Task A, work on it
;;	2.Go to Task B (or create a new task) and clock it in
;;	3.When you are finished with Task B hit C-u C-c C-x C-i i
;;
;;This displays a clock history selection window like the following and selects the interrupted [i] entry.
;;
;;Clock history selection buffer for C-u C-c C-x C-i
;;
;;	Default Task
;;	[d] norang          Organization                          <-- Task B
;;	The task interrupted by starting the last one
;;	[i] norang          Organization                          <-- Task B
;;	Current Clocking Task
;;	[c] org             NEXT Document my use of org-mode      <-- Task A
;;	Recent Tasks
;;	[1] org             NEXT Document my use of org-mode      <-- Task A
;;	[2] norang          Organization                          <-- Task B
;;	...
;;	[Z] org             DONE Fix default section links        <-- 35 clock task entries ago


;;------------------ Clock Everything - Create New Tasks ----------------
;;In order to clock everything you need a task for everything. That's fine for planned projects but 
;;interruptions inevitably occur and you need some place to record whatever time you spend on that interruption.
;;
;;To deal with this we create a new capture task to record the thing we are about to do. The workflow goes something like this:
;;
;;	You are clocking some task and an interruption occurs
;;	Create a quick capture task journal entry C-M-r j
;;	Type the heading
;;	go do that thing (eat lunch, whatever)
;;	file it C-c C-c, this restores the clock back to the previous clocking task
;;	clock something else in or continue with the current clocking task


;;--------------- Finding Tasks To Clock In ---------------
;;To find a task to work on I use one of the following options (generally listed most frequently used first)
;;
;;	Use the clock history C-u C-c C-x C-i Go back to something I was clocking that is not finished
;;	Pick something off today's block agenda SCHEDULED or DEADLINE items that need to be done soon
;;	Pick something off the NEXT tasks agenda view Work on some unfinished task to move to completion
;;	Pick something off the other task list
;;	Use an agenda view with filtering to pick something to work on
;;
;;Punching in on the task you select will restrict the agenda view to 
;;that project so you can focus on just that thing for some period of time.


;-------------  Editing Clock Entries ------------------
;;To edit a clock entry just put the cursor on the part of the date you want to edit 
;;(use the keyboard not the mouse - since the clicking on the timestamp with the mouse goes back to the agenda for that day) 
;;and hit the S-<up arrow> or S-<down arrow> keys to change the time.

;;The following setting makes time editing use discrete minute intervals (no rounding) increments:
;;=================================================================================================
(setq org-time-stamp-rounding-minutes (quote (1 1)))


;;I always check that I haven't created task overlaps when fixing time clock entries by viewing them with log mode on in the agenda.
;;There is a new view in the agenda for this – just hit v c in the daily agenda and clock gaps and overlaps are identified.
;;
;;I want my clock entries to be as accurate as possible.
;;
;;The following setting shows 1 minute clocking gaps.
;;====================================================
(setq org-agenda-clock-consistency-checks
      (quote (:max-duration "4:00"
              :min-duration 0
              :max-gap 0
              :gap-ok-around ("4:00"))))


;-----------------------------
;automatically clocking tasks
;-----------------------------
;;I spend time on an open source project called BZFlag. During work for releases I want to clock the time I spend testing the new BZFlag client. 
;;I have a key binding in my window manager that runs a script which starts the clock on my testing task, runs the BZFlag client, 
;;and on exit resumes the clock on the previous clocking task.
;;
;;The testing task has an ID property of dcf55180-2a18-460e-8abb-a9f02f0893be and the following elisp code starts the clock on this task.
;;
;;(defun bh/clock-in-bzflagt-task ()
;;  (interactive)
;;  (bh/clock-in-task-by-id "dcf55180-2a18-460e-8abb-a9f02f0893be"))
;;This is invoked by a bash shell script as follows:
;;
;;#!/bin/sh
;;emacsclient -e '(bh/clock-in-bzflagt-task)'
;;~/git/bzflag/trunk/bzflag/src/bzflag/bzflag -directory ~/git/bzflag/trunk/bzflag/data $*
;;emacsclient -e '(bh/resume-clock)'
;;The resume clock function just returns the clock to the previous clocking task
;;
;;(defun bh/resume-clock ()
;;  (interactive)
;;  (if (marker-buffer org-clock-interrupted-task)
;;      (org-with-point-at org-clock-interrupted-task
;;        (org-clock-in))
;;    (org-clock-out)))


;------------------------
;Time Reporting And Tracking
;------------------------
;;------------ Billing Clients Based on Clock time ------------
;;At the beginning of the month I invoice my clients for work done last month. 
;;This is where I review my clocking data for correctness before billing for the clocked time.
;;
;;Billing for clocked time basically boils down to the following steps:
;;
;;1.Verify that the clock data is complete and correct
;;2.Use clock reports to summarize time spent
;;3.Create an invoice based on the clock data
;;	I currently create invoices in an external software package based on the org-mode clock data.
;;
;;4.Archive complete tasks so they are out of the way.
;;	See Archiving for more details.


;------ Verify That The Clock Data Is Complete And Correct -------
;;Since I change tasks often (sometimes more than once in a minute) 
;;I use the following setting to remove clock entries with a zero duration.

;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)


;;To check for unclosed clock times I use the agenda-view clock check (v c in the agenda). 
;;This view shows clocking gaps and overlaps in the agenda.

;;To check the last month's clock data I use F12 a v m b v c which shows a full month in the agenda, 
;;moves to the previous month, and shows the clocked times only. 
;;It's important to remove any agenda restriction locks and filters when checking the logs for gaps and overlaps.
;;
;;The clocked-time only display in the agenda makes it easy to quickly scan down the list to see 
;;if an entry is missing an end time. If an entry is not closed you can manually fix the clock entry 
;;based on other clock info around that time.


;-------------------------------------
;Using Clock Reports To Summarize Time Spent
;-------------------------------------
;;Billable time for clients are kept in separate org files.
;;
;;To get a report of time spent on tasks for XYZ.org you simply visit the XYZ.org file and run an agenda clock report 
;;for the last month with F12 < a v m b R.
;;This limits the agenda to this one file, shows the agenda for a full month, moves to last month, and generates a clock report.
;;
;;My agenda org clock report settings show 5 levels of detail with links to the tasks. 
;;I like wider reports than the default compact setting so I override the :narrow value.


;; Agenda clock report parameters
;;=================================
(setq org-agenda-clockreport-parameter-plist
      (quote (:link t :maxlevel 5 :fileskip0 t :compact t :narrow 80)))


;;------ Task Estimates And Column View -------
;;Estimating how long tasks take to complete is a difficult skill to master. 
;;Org-mode makes it easy to practice creating estimates for tasks and then clock the actual time it takes to complete.
;;By repeatedly estimating tasks and reviewing how your estimate relates to the actual time clocked
;;you can tune your estimating skills.

;;I use properties and column view to do project estimates.
;;
;;I set up column view globally with the following headlines
;;==========================================================
; Set default column view headings: Task Effort Clock_Summary
(setq org-columns-default-format "%80ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM")

;;This makes column view show estimated task effort and clocked times side-by-side 
;;which is great for reviewing your project estimates.
;;
;;A property called Effort records the estimated amount of time a given task will 
;;take to complete. The estimate times I use are one of:
	;;10 minutes
	;;30 minutes
	;;1 hour
	;;2 hours
	;;3 hours
	;;4 hours
	;;5 hours
	;;6 hours
	;;7 hours
	;;8 hours


;;These are stored for easy use in column mode in the global property Effort_ALL.
;;==============================================================================
; global Effort estimate values
; global STYLE property values for completion
(setq org-global-properties (quote (("Effort_ALL" . "0:15 0:30 0:45 1:00 2:00 3:00 4:00 5:00 6:00 0:00")
                                    ("STYLE_ALL" . "habit"))))



;------------------------------------
;Providing Progress Reports To Others
;------------------------------------
;;The following setting shows task state changes in the agenda. Combined with the agenda clock report ('R') 
;;I can quickly generate all of the details required.

;; Agenda log mode items to display (closed and state changes by default)
;;=======================================================================
(setq org-agenda-log-mode-items (quote (state)))


;;To generate the report I pull up the agenda for the appropriate time frame (today, yesterday, this week, or last week) 
;;and hit the key sequence l R to add the log report (without clocking data lines) and the agenda clock report at the end.
;;
;;Then it's simply a matter of exporting the resulting agenda in some useful format to provide to other people. 
;;C-x C-w /tmp/agenda.html RET exports to HTML and C-x C-w /tmp/agenda.txt RET exports to plain text. 
;;Other formats are available but I use these two the most.
;;
;;Combining this export with tag filters and C-u R can limit the report to exactly the tags that people are interested in.


;-----------------------------------
;Tags
;-----------------------------------
;;Tasks can have any number of arbitrary tags. Tags are used for:
;;
;;	filtering todo lists and agenda views
;;	providing context for tasks
;;	tagging notes
;;	tagging phone calls
;;	tagging tasks to be refiled
;;	tagging tasks in a WAITING state because a parent task is WAITING
;;	tagging cancelled tasks because a parent task is CANCELLED
;;	preventing export of some subtrees when publishing
;;
;;I use tags mostly for filtering in the agenda. This means you can find tasks with a specific tag easily across your large number of org-mode files.
;;
;;Some tags are mutually exclusive. These are defined in a group so that only one of the tags can be applied to a task at a time (disregarding tag inheritance). 
;;I use these types for tags for applying context to a task. 
;;(Work tasks have an @office tag, and are done at the office, Farm tasks have an @farm tag and are done at the farm 
;;– I can't change the oil on the tractor if I'm not at the farm… 
;;so I hide these and other tasks by filtering my agenda view to only @office tasks when I'm at the office.)
;;
;;Tasks are grouped together in org-files and a #+FILETAGS: entry applies a tag to all tasks in the file. 
;;I use this to apply a tag to all tasks in the file. My norang.org file creates a NORANG file tag so I can filter tasks in the agenda in the norang.org file easily.



;;Here are my tag definitions with associated keys for filtering in the agenda views.
;;
;;The startgroup - endgroup (@XXX) tags are mutually exclusive - selecting one removes a similar tag already on the task. 
;;These are the context tags - you can't be in two places at once so if a task is marked with @farm and you add @office then the @farm tag is removed automagically.
;;
;;The other tags PHONE .. FLAGGED are not mutually exclusive and multiple tags can appear on a single task.
;;Some of those tags are created by todo state change triggers. The shortcut key is used to add or remove the tag using C-c C-q or 
;;to apply the task for filtering on the agenda.
;;
;;I have both FARM and @farm tags. FARM is set by a FILETAGS entry and just gives me a way to filter anything farm related.
;;The @farm tag signifies that the task as to be done at the farm. If I have to call someone about something that would have a FARM tag but
;;I can do that at home on my lunch break. I don't physically have to be at the farm to make the call.


; Tags with fast selection keys
;;===============================
(setq org-tag-alist (quote ((:startgroup)
                            ("@errand" . ?e)
                            ("@office" . ?o)
                            ("@home" . ?H)
                            ("@farm" . ?f)
                            (:endgroup)
                            ("PHONE" . ?p)
                            ("WAITING" . ?w)
                            ("HOLD" . ?h)
                            ("PERSONAL" . ?P)
                            ("WORK" . ?W)
                            ("FARM" . ?F)
                            ("ORG" . ?O)	;;gtd,GTD,
                            ("NORANG" . ?N)
                            ("crypt" . ?E)
                            ("MARK" . ?M)
                            ("NOTE" . ?n)
                            ("BZFLAG" . ?B)
                            ("CANCELLED" . ?c)
                            ("FLAGGED" . ??))))

; Allow setting single tags without the menu
(setq org-fast-tag-selection-single-key (quote expert))

; For tag searches ignore tasks with scheduled and deadline dates
(setq org-agenda-tags-todo-honor-ignore-options t)


;------------------
;Filetags
;------------------
;;Filetags are a convenient way to apply one or more tags to all of the headings in a file.
;;
;;Filetags look like this:
;;
;;#+FILETAGS: NORANG @office
;;I have the following #+FILETAGS: entries in my org-mode files:


;;10.2.1 Non-Work Related Org-Mode Files
;;
;;	File		Tags
;;	todo.org	PERSONAL
;;	gsoc2009.org	GSOC PERSONAL
;;	bzflag.org	BZFLAG @home PERSONAL
;;	git.org		GIT WORK
;;	org.org		ORG WORK
;;	mark.org	MARK PERSONAL
;;	farm.org	FARM PERSONAL
;;
;;10.2.2 Work Related Org-Mode Files
;;
;;	File		Tags
;;	norang.org	NORANG @office
;;	ABC.org		ABC @office
;;	XYZ.org		XYZ @office
;;	ABC-DEF.org	ABC DEF @office
;;	ABC-KKK.org	ABC KKK @office
;;	YYY.org		YYY @office
;;
;;10.2.3 Refile Tasks
;;
;;	File		Tags
;;	refile.org	REFILE
;;
;;10.3 State Trigger Tags
;;
;;The following tags are automatically added or removed by todo state triggers described previously in ToDo state triggers
;;
;;	WAITING
;;	CANCELLED


;-----------------
;note gems
;-----------------
;;Often I'll find some cool feature or thing I want to remember while reading the org-mode and git mailing lists in Gnus.
;;To create a note I use my note capture template C-M-r n, type a heading for the note and C-c C-c to save it. 
;;The only other thing to do is to refile it (later) to the appropriate project file.


;-------------
;Handling Phone Calls
;-------------
;;Phone calls are interruptions and I use capture mode to deal with these (like all interruptions).
;;Most of the heavy lifting for phone calls is done by capture mode.
;;I use a special capture template for phone calls combined with a custom function that replaces text with information 
;;from my bbdb addressbook database.


;;Here is my set up for phone calls. I would like to thank Gregory
;;
;;Grubbs for the original bbdb lookup functions which this version is based on.

;;Below is the partial capture template showing the phone call template followed 
;;by the phone-call related lookup functions.
;;===========================================
;; Capture templates for: TODO tasks, Notes, appointments, phone calls, and org-protocol

;;(add-to-list 'load-path (expand-file-name "~/zzcfg.d/my-org-addon/bbdb"))
(require 'bbdb)
(require 'bbdb-com)

(global-set-key (kbd "<f9> p") 'bh/phone-call)

;;
;; Phone capture template handling with BBDB lookup
;; Adapted from code by Gregory J. Grubbs
(defun bh/phone-call ()
  "Return name and company info for caller from bbdb lookup"
  (interactive)
  (let* (name rec caller)
    (setq name (completing-read "Who is calling? "
                                (bbdb-hashtable)
                                'bbdb-completion-predicate
                                'confirm))
    (when (> (length name) 0)
      ; Something was supplied - look it up in bbdb
      (setq rec
            (or (first
                 (or (bbdb-search (bbdb-records) name nil nil)
                     (bbdb-search (bbdb-records) nil name nil)))
                name)))

    ; Build the bbdb link if we have a bbdb record, otherwise just return the name
    (setq caller (cond ((and rec (vectorp rec))
                        (let ((name (bbdb-record-name rec))
                              (company (bbdb-record-company rec)))
                          (concat "[[bbdb:"
                                  name "]["
                                  name "]]"
                                  (when company
                                    (concat " - " company)))))
                       (rec)
                       (t "NameOfCaller")))
    (insert caller)))  



;--------------------
;GTD stuff
;--------------------
;;Most of my day is deadline/schedule driven. I work off of the agenda first 
;;and then pick items from the todo lists as outlined in What do I work on next?

;;Weekly Review Process
;;=====================
;;The first day of the week (usually Monday) I do my weekly review. 
;;I keep a list like this one to remind me what needs to be done.
;;
;;To keep the agenda fast I set

(setq org-agenda-span 'day)


;;Project Definition And Finding Stuck Projects
;;============================================
;;I'm using a new lazy project definition to mark tasks as projects. 
;;This requires zero effort from me. Any task with a subtask using a todo keyword is a project. Period.
;;
;;Projects are 'stuck' if they have no subtask with a NEXT todo keyword task defined.
;;
;;The org-mode stuck projects agenda view lists projects that have no NEXT task defined. 
;;Stuck projects show up on my block agenda and I tend to assign a NEXT task so the list remains empty. 
;;This helps to keep projects moving forward.
;;
;;I disable the default org-mode stuck projects agenda view with the following setting.
;;=------------------------------------------------
(setq org-stuck-projects (quote ("" nil nil "")))


;;In the following example Stuck Project A is stuck because it has no subtask which is NEXT.
;;Project C is not stuck because it has NEXT tasks SubTask G and Task I.
;;Stuck Sub Project D is stuck because SubTask E is not NEXT and there are no other tasks available in this project.

;;	* Category
;;	** TODO Stuck Project A
;;	*** TODO Task B
;;	** TODO Project C
;;	*** TODO Stuck Sub Project D
;;	**** TODO SubTask E
;;	*** TODO Sub Project F
;;	**** NEXT SubTask G
;;	**** TODO SubTask H
;;	*** NEXT Task I
;;	*** TODO Task J


;;All of the stuck projects and subprojects show up in the stuck projects list and 
;;that is my indication to assign or create NEXT tasks until the stuck projects list is empty. 
;;Occasionally some subtask is WAITING for something and the project is stuck until that condition is satisfied.
;;In this case I leave it on the stuck project list and just work on something else. 
;;This stuck project 'bugs' me regularly when I see it on the block agenda and 
;;this prompts me to follow up on the thing that I'm waiting for.
;;
;;I have the following helper functions defined for projects which are used by agenda views.
;;==========================================================================================
(require 'org-agenda)

(defun bh/is-project-p ()
  "Any task with a todo keyword subtask"
  (save-restriction
    (widen)
    (let ((has-subtask)
          (subtree-end (save-excursion (org-end-of-subtree t)))
          (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
      (save-excursion
        (forward-line 1)
        (while (and (not has-subtask)
                    (< (point) subtree-end)
                    (re-search-forward "^\*+ " subtree-end t))
          (when (member (org-get-todo-state) org-todo-keywords-1)
            (setq has-subtask t))))
      (and is-a-task has-subtask))))

(defun bh/is-project-subtree-p ()
  "Any task with a todo keyword that is in a project subtree.
Callers of this function already widen the buffer view."
  (let ((task (save-excursion (org-back-to-heading 'invisible-ok)
                              (point))))
    (save-excursion
      (bh/find-project-task)
      (if (equal (point) task)
          nil
        t))))

(defun bh/is-task-p ()
  "Any task with a todo keyword and no subtask"
  (save-restriction
    (widen)
    (let ((has-subtask)
          (subtree-end (save-excursion (org-end-of-subtree t)))
          (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
      (save-excursion
        (forward-line 1)
        (while (and (not has-subtask)
                    (< (point) subtree-end)
                    (re-search-forward "^\*+ " subtree-end t))
          (when (member (org-get-todo-state) org-todo-keywords-1)
            (setq has-subtask t))))
      (and is-a-task (not has-subtask)))))

(defun bh/is-subproject-p ()
  "Any task which is a subtask of another project"
  (let ((is-subproject)
        (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
    (save-excursion
      (while (and (not is-subproject) (org-up-heading-safe))
        (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
          (setq is-subproject t))))
    (and is-a-task is-subproject)))

(defun bh/list-sublevels-for-projects-indented ()
  "Set org-tags-match-list-sublevels so when restricted to a subtree we list all subtasks.
  This is normally used by skipping functions where this variable is already local to the agenda."
  (if (marker-buffer org-agenda-restrict-begin)
      (setq org-tags-match-list-sublevels 'indented)
    (setq org-tags-match-list-sublevels nil))
  nil)

(defun bh/list-sublevels-for-projects ()
  "Set org-tags-match-list-sublevels so when restricted to a subtree we list all subtasks.
  This is normally used by skipping functions where this variable is already local to the agenda."
  (if (marker-buffer org-agenda-restrict-begin)
      (setq org-tags-match-list-sublevels t)
    (setq org-tags-match-list-sublevels nil))
  nil)

(defun bh/skip-stuck-projects ()
  "Skip trees that are not stuck projects"
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (if (bh/is-project-p)
          (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
                 (has-next ))
            (save-excursion
              (forward-line 1)
              (while (and (not has-next) (< (point) subtree-end) (re-search-forward "^\\*+ NEXT " subtree-end t))
                (unless (member "WAITING" (org-get-tags-at))
                  (setq has-next t))))
            (if has-next
                nil
              next-headline)) ; a stuck project, has subtasks but no next task
        nil))))

(defun bh/skip-non-stuck-projects ()
  "Skip trees that are not stuck projects"
  (bh/list-sublevels-for-projects-indented)
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (if (bh/is-project-p)
          (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
                 (has-next ))
            (save-excursion
              (forward-line 1)
              (while (and (not has-next) (< (point) subtree-end) (re-search-forward "^\\*+ NEXT " subtree-end t))
                (unless (member "WAITING" (org-get-tags-at))
                  (setq has-next t))))
            (if has-next
                next-headline
              nil)) ; a stuck project, has subtasks but no next task
        next-headline))))

(defun bh/skip-non-projects ()
  "Skip trees that are not projects"
  (bh/list-sublevels-for-projects-indented)
  (if (save-excursion (bh/skip-non-stuck-projects))
      (save-restriction
        (widen)
        (let ((subtree-end (save-excursion (org-end-of-subtree t))))
          (cond
           ((and (bh/is-project-p)
                 (marker-buffer org-agenda-restrict-begin))
            nil)
           ((and (bh/is-project-p)
                 (not (marker-buffer org-agenda-restrict-begin))
                 (not (bh/is-project-subtree-p)))
            nil)
           (t
            subtree-end))))
    (save-excursion (org-end-of-subtree t))))

(defun bh/skip-project-trees-and-habits ()
  "Skip trees that are projects"
  (save-restriction
    (widen)
    (let ((subtree-end (save-excursion (org-end-of-subtree t))))
      (cond
       ((bh/is-project-p)
        subtree-end)
       ((org-is-habit-p)
        subtree-end)
       (t
        nil)))))

(defun bh/skip-projects-and-habits-and-single-tasks ()
  "Skip trees that are projects, tasks that are habits, single non-project tasks"
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (cond
       ((org-is-habit-p)
        next-headline)
       ((bh/is-project-p)
        next-headline)
       ((and (bh/is-task-p) (not (bh/is-project-subtree-p)))
        next-headline)
       (t
        nil)))))

(defun bh/skip-project-tasks-maybe ()
  "Show tasks related to the current restriction.
When restricted to a project, skip project and sub project tasks, habits, NEXT tasks, and loose tasks.
When not restricted, skip project and sub-project tasks, habits, and project related tasks."
  (save-restriction
    (widen)
    (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
           (next-headline (save-excursion (or (outline-next-heading) (point-max))))
           (limit-to-project (marker-buffer org-agenda-restrict-begin)))
      (cond
       ((bh/is-project-p)
        next-headline)
       ((org-is-habit-p)
        subtree-end)
       ((and (not limit-to-project)
             (bh/is-project-subtree-p))
        subtree-end)
       ((and limit-to-project
             (bh/is-project-subtree-p)
             (member (org-get-todo-state) (list "NEXT")))
        subtree-end)
       (t
        nil)))))

(defun bh/skip-projects-and-habits ()
  "Skip trees that are projects and tasks that are habits"
  (save-restriction
    (widen)
    (let ((subtree-end (save-excursion (org-end-of-subtree t))))
      (cond
       ((bh/is-project-p)
        subtree-end)
       ((org-is-habit-p)
        subtree-end)
       (t
        nil)))))

(defun bh/skip-non-subprojects ()
  "Skip trees that are not projects"
  (let ((next-headline (save-excursion (outline-next-heading))))
    (if (bh/is-subproject-p)
        nil
      next-headline)))


;------------------------
;ARchiving out-time Dones
;------------------------
;;My archiving procedure has changed. I used to move entire subtrees to a separate archive file for the project. 
;;Task subtrees in FILE.org get archived to FILE.org_archive using the a y command in the agenda.
;;
;;I still archive to the same archive file as before but now I archive any done state todo task that is old enough 
;;to archive. Tasks to archive are listed automatically at the end of my block agenda and these are guaranteed to 
;;be old enough that I've already billed any time associated with these tasks. This cleans up my project trees and 
;;removes the old tasks that are no longer interesting. 
;;The archived tasks get extra property data created during the archive procedure so that
;;it is possible to reconstruct exactly where the archived entry came from in the rare case where you want to
;;unarchive something.
;;
;;My archive files are huge but so far I haven't found a need to split them by year (or decade) :)


;;Archivable tasks show up in the last section of my block agenda when a new month starts. 
;;Any tasks that are done but have no timestamps this month or last month (ie. they are over 30 days old) are available 
;;to archive. Timestamps include closed dates, notes, clock data, etc - any active or inactive timestamp in the task.
;;
;;Archiving is trivial. 
;;Just mark all of the entries in the block agenda using the m key and then archive them all to the appropriate place with B $. 
;;This normally takes less than 5 minutes once a month.

;;Archiving Setup
;;================
;;I not longer use an ARCHIVE property in my subtrees. 
;;Tasks can just archive normally to the Archived Tasks heading in the archive file.
;;
;;The following setting ensures that task states are untouched when they are archived. 
;;This makes it possible to archive tasks that are not marked DONE. 
;;By default tasks are archived under the heading * Archived Tasks in the archive file.
;;==-------------------------------
(setq org-archive-mark-done nil)
(setq org-archive-location "%s_archive::* Archived Tasks")

(defun bh/skip-non-archivable-tasks ()
  "Skip trees that are not available for archiving"
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      ;; Consider only tasks with done todo headings as archivable candidates
      (if (member (org-get-todo-state) org-done-keywords)
          (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
                 (daynr (string-to-int (format-time-string "%d" (current-time))))
                 (a-month-ago (* 60 60 24 (+ daynr 1)))
                 (last-month (format-time-string "%Y-%m-" (time-subtract (current-time) (seconds-to-time a-month-ago))))
                 (this-month (format-time-string "%Y-%m-" (current-time)))
                 (subtree-is-current (save-excursion
                                       (forward-line 1)
                                       (and (< (point) subtree-end)
                                            (re-search-forward (concat last-month "\\|" this-month) subtree-end t)))))
            (if subtree-is-current
                next-headline ; Has a date in this month or last month, skip it
              nil))  ; available to archive
        (or next-headline (point-max))))))



;;Archive Tag - Hiding Information
;----------------------------------
;;The only time I set the ARCHIVE tag on a task is to prevent it from opening by default 
;;because it has tons of information I don't really need to look at on a regular basis. I can open the task with C-TAB if 
;;I need to see the gory details (like a huge table of data related to the task) but normally I don't need that information displayed.

;;When To Archive
;----------------
;;Archiving monthly works well for me. I keep completed tasks around for at least 30 days before archiving them. 
;;This keeps current clocking information for the last 30 days out of the archives. 
;;This keeps my files that contribute to the agenda fairly current (this month, and last month, and anything that is unfinished). 
;;I only rarely visit tasks in the archive when I need to pull up ancient history for something.
;;
;;Archiving keeps my main working files clutter-free. 
;;If I ever need the detail for the archived tasks they are available in the appropriate archive file.


;-------------------------
;Publishing and Exporting
;-------------------------
;;I don't do a lot of publishing for other people but I do keep a set of private client system documentation online.
;;Most of this documentation is a collection of notes exported to HTML.
;;
;;Everything at http://doc.norang.ca/ is generated by publishing org-files. This includes the index pages on this site.
;;
;;Org-mode can export to a variety of publishing formats including (but not limited to)
;;
;;	ASCII (plain text - but not the original org-mode file)
;;	HTML
;;	LaTeX
;;	Docbook which enables getting to lots of other formats like ODF, XML, etc
;;	PDF via LaTeX or Docbook
;;	iCal


;;Babel: active code in Org-mode
;;===============================
;;Babel is Org-mode's ability to execute source code within Org-mode documents. 
;;Org-mode is an Emacs major mode for doing almost anything with plain text. 
;;If you are not familiar with Org-mode please take a moment to read the Org-mode homepage before continuing. 
;;Babel started life as Org-babel, an extension to Org-mode. It was integrated into the Org-mode core at version 7.0. 
;;The author of Babel is Eric Schulte. The secondary author is Dan Davison.
;;
;;	1. A Multi-Language Computing Environment for Literate Programming and Reproducible Research: 
;;	   a journal paper providing the most up to date and complete introduction to using Org-mode and Babel for Reproducible research and literate programming.
;;	2. Introductory Tutorial: a smaller online set of installation and setup instructions, as well as an overview of the main features of Babel, with plenty of examples.
;;	   Reference and Documentation: is available online and in Chapter 14 of the Org-mode manual. A tabular listing of header args and result types for Babel code 
;;	   blocks can be found here.
;;	3. Languages: list of supported languages with information on requirements, configuration instructions, and pointers to language specific documentation.
;;	4. Uses: user-submitted examples of Babel work flows – this is a good place to get an idea of what can be done and see how Babel may fit into your life.


;;;;Org-babel makes it easy to generate decent graphics using external packages like ditaa, graphviz, PlantUML, and others.
;;;;The setup is really easy. ditaa is provided with the org-mode source. 
;;;;You'll have to install the graphviz and PlantUML packages on your system.
;;=======================================================================
(setq org-ditaa-jar-path "~/zzcfg.d/my-org-addon/ditaa0_9/ditaa0_9.jar")
(setq org-plantuml-jar-path "~/zzcfg.d/my-org-addon/plantuml/plantuml.jar")

(add-hook 'org-babel-after-execute-hook 'bh/display-inline-images 'append)

; Make babel results blocks lowercase
(setq org-babel-results-keyword "results")

(defun bh/display-inline-images ()
  (condition-case nil
      (org-display-inline-images)
    (error nil)))

(org-babel-do-load-languages
 (quote org-babel-load-languages)
 (quote ((emacs-lisp . t)
         (dot . t)
         (ditaa . t)
         (R . t)
         (python . t)
         (ruby . t)
         (gnuplot . t)
         (clojure . t)
         (sh . t)
         (ledger . t)
         (org . t)
         (plantuml . t)
         (latex . t))))

; Do not prompt to confirm evaluation
; This may be dangerous - make sure you understand the consequences
; of setting this -- see the docstring for details
(setq org-confirm-babel-evaluate nil)

; Use fundamental mode when editing plantuml blocks with C-c '
(add-to-list 'org-src-lang-modes (quote ("plantuml" . fundamental)))


;;Now you just create a begin-src block for the appropriate tool, edit the text, and build the pictures with C-c C-c. 
;;After evaluating the block results are displayed. You can toggle display of inline images with C-c C-x C-v
;;
;;I disable startup with inline images because when I access my org-files from an SSH session without X this breaks 
;;(say from my Android phone) it fails when trying to display the images on a non-X session. 
;;It's much more important for me to be able to access my org files from my Android phone remotely than it is to see images on startup.

;; Don't enable this because it breaks access to emacs from my Android phone
(setq org-startup-with-inline-images nil)



;;Playing With Ditaa
;;====================
;;ditaa is a great tool for quickly generating graphics to convey ideas and ditaa is distributed with org-mode! 
;;All of the graphics in this document are automatically generated by org-mode using plain text source.
;;
;;Artist mode makes it easy to create boxes and lines for ditaa graphics.
;;
;;The source for a ditaa graphic looks like this in org-mode:
;;
;;#+begin_src ditaa :file some_filename.png :cmdline -r -s 0.8
;;  <context of ditaa source goes here>
;;#+end_src
;;
;;Here's an example without the #+begin_src and #+end_src lines.
;;=--------------------------------------------------------------

;;    +-----------+        +---------+  
;;    |    PLC    |        |         |                
;;    |  Network  +<------>+   PLC   +<---=---------+ 
;;    |    cRED   |        |  c707   |              | 
;;    +-----------+        +----+----+              | 
;;                              ^                   | 
;;                              |                   | 
;;                              |  +----------------|-----------------+
;;                              |  |                |                 |
;;                              v  v                v                 v
;;      +----------+       +----+--+--+      +-------+---+      +-----+-----+       Windows clients
;;      |          |       |          |      |           |      |           |      +----+      +----+
;;      | Database +<----->+  Shared  +<---->+ Executive +<-=-->+ Operator  +<---->|cYEL| . . .|cYEL|
;;      |   c707   |       |  Memory  |      |   c707    |      | Server    |      |    |      |    |
;;      +--+----+--+       |{d} cGRE  |      +------+----+      |   c707    |      +----+      +----+
;;         ^    ^          +----------+             ^           +-------+---+
;;         |    |                                   |                        
;;         |    +--------=--------------------------+                    
;;         v                                                             
;;+--------+--------+                                                         
;;|                 |                                                         
;;| Millwide System |            -------- Data ---------                      
;;| cBLU            |            --=----- Signals ---=--                      
;;+-----------------+                                        



;;Playing With Graphviz
;;======================
;;Graphviz is another great tool for creating graphics in your documents.
;;
;;The source for a graphviz graphic looks like this in org-mode:
;;
;;#+begin_src dot :file some_filename.png :cmdline -Kdot -Tpng
;;  <context of graphviz source goes here>
;;#+end_src


;;Here's an example without the #+begin_src and #+end_src lines.
;;=------------------------------------------------------------
;;digraph G {
;;  size="8,6"
;;  ratio=expand
;;  edge [dir=both]
;;  plcnet [shape=box, label="PLC Network"]
;;  subgraph cluster_wrapline {
;;    label="Wrapline Control System"
;;    color=purple
;;    subgraph {
;;    rank=same
;;    exec
;;    sharedmem [style=filled, fillcolor=lightgrey, shape=box]
;;    }
;;    edge[style=dotted, dir=none]
;;    exec -> opserver
;;    exec -> db
;;    plc -> exec
;;    edge [style=line, dir=both]
;;    exec -> sharedmem
;;    sharedmem -> db
;;    plc -> sharedmem
;;    sharedmem -> opserver
;;  }
;;  plcnet -> plc [constraint=false]
;;  millwide [shape=box, label="Millwide System"]
;;  db -> millwide
;;
;;  subgraph cluster_opclients {
;;    color=blue
;;    label="Operator Clients"
;;    rankdir=LR
;;    labelloc=b
;;    node[label=client]
;;    opserver -> client1
;;    opserver -> client2
;;    opserver -> client3
;;  }
;;}


;;Playing With PlantUML
;;======================
;;I have just started using PlantUML which is built on top of Graphviz. 
;;I'm still experimenting with this but so far I like it a lot. 
;;The todo state change diagrams in this document are created with PlantUML.
;;
;;The source for a PlantUML graphic looks like this in org-mode:
;;
;;#+begin_src plantuml :file somefile.png
;;  <context of PlantUML source goes here>
;;#+end_src
;;
;;here is a example of Sequence Diagram with plantUML
;;=---------------------------------------------------
;;title Example Sequence Diagram
;;activate Client
;;Client -> Server: Session Initiation
;;note right: Client requests new session
;;activate Server
;;Client <-- Server: Authorization Request
;;note left: Server requires authentication
;;Client -> Server: Authorization Response
;;note right: Client provides authentication details
;;Server --> Client: Session Token
;;note left: Session established
;;deactivate Server
;;Client -> Client: Saves token
;;deactivate Client


;;here is a example of Activity Diagram with plantUML
;;=--------------------------------------------------
;;title Example Activity Diagram
;;note right: Example Function
;;(*)--> "Step 1"
;;--> "Step 2"
;;-> "Step 3"
;;--> "Step 4"
;;--> === STARTLOOP ===
;;note top: For each element in the array
;;if "Are we done?" then
;;  -> [no] "Do this"
;;  -> "Do that"
;;  note bottom: Important note\ngoes here
;;  -up-> "Increment counters"
;;  --> === STARTLOOP ===
;;else
;;  --> [yes] === ENDLOOP ===
;;endif
;;--> "Last Step"
;;--> (*)


;;here is a example of Usecase Diagram with plantUML
;;=-------------------------------------------------
;;LabUser --> (Runs Simulation)
;;LabUser --> (Analyses Results)


;;here is a example of Object Diagram with plantUML
;;=-------------------------------------------------
;;Object1 <|-- Object2
;;Object1: someVar
;;Object1: execute()
;;Object2: getState()
;;Object2: setState()
;;Object2: state


;;Object Diagram
;;===============
;;Object1 <|-- Object2
;;Object1: someVar
;;Object1: execute()
;;Object2: getState()
;;Object2: setState()
;;Object2: state


;;State Diagram
;;===============
;;[*] --> Start
;;Start -> State2
;;State2 -> State3
;;note right of State3: Notes can be\nattached to states
;;State2 --> State4
;;State4 -> Finish
;;State3 --> Finish
;;Finish --> [*]



;;Publishing Single Files
;;=========================
;;Org-mode exports the current file to one of the standard formats by invoking an export function. 
;;he standard key binding for this is C-c C-e followed by the key for the type of export you want.


;;Publishing Projects
;;===================
;;I have 5 main projects I use org-mode publishing for currently:
;;
;;	norang (website)
;;	doc.norang.ca (website, published documents)
;;	doc.norang.ca/private (website, non-published documents)
;;	www.norang.ca/tmp (temporary publishing site for testing org-mode stuff)
;;	org files (which are selectively included by other websites)
;;
;;Here's my publishing setup:

;;; experimenting with docbook exports - not finished
;;(setq org-export-docbook-xsl-fo-proc-command "fop %s %s")
;;(setq org-export-docbook-xslt-proc-command "xsltproc --output %s E:/soft/editor/emacsPortable/emacs-24.0.93/config/zzcfg.d/my-org-addon/docbook-xsl-1.77.1/fo/docbook.xsl %s")
;;;
;;; Inline images in HTML instead of producting links to the image
;;(setq org-export-html-inline-images t)
;;; Do not use sub or superscripts - I currently don't need this functionality in my documents
;;(setq org-export-with-sub-superscripts nil)
;;; Use org.css from the norang website for export document stylesheets
;;(setq org-export-html-style-extra "<link rel=\"stylesheet\" href=\"~/orgcvs/zcss/org.css\" type=\"text/css\" />")
;;(setq org-export-html-style-include-default nil)
;;; Do not generate internal css formatting for HTML exports
;;(setq org-export-htmlize-output-type (quote css))
;;; Export with LaTeX fragments
;;(setq org-export-with-LaTeX-fragments t)
;;
;;; List of projects
;;;;; norang       - http://www.norang.ca/
;;;;; doc          - http://doc.norang.ca/
;;;;; org-mode-doc - http://doc.norang.ca/org-mode.html and associated files
;;;;; org          - miscellaneous todo lists for publishing
;;(setq org-publish-project-alist
;;;;      ;
;;;;      ; http://www.norang.ca/  (norang website)
;;;;      ; norang-org are the org-files that generate the content
;;;;      ; norang-extra are images and css files that need to be included
;;;;      ; norang is the top-level project that gets published
;;      (quote ((
;;		;;"norang-org"
;;		"orgcvs-pub"
;;               :base-directory "~/git/www.norang.ca"
;;               ;;:publishing-directory "/ssh:www-data@www:~/www.norang.ca/htdocs"
;;	       :publishing-directory "~/orgcvs/pub"
;;               :recursive t
;;               :table-of-contents nil
;;               :base-extension "org"
;;               :publishing-function org-publish-org-to-html
;;               :style-include-default nil
;;               :section-numbers nil
;;               :table-of-contents nil
;;               :style "<link rel=\"stylesheet\" href=\"norang.css\" type=\"text/css\" />"
;;	       :style "<link rel=\"stylesheet\" href=\"~/orgcvs/zcss/org.css\" type=\"text/css\" />"
;;               :author-info nil
;;               :creator-info nil)
;;              ("norang-extra"
;;               ;;:base-directory "~/git/www.norang.ca/"
;;               ;;:publishing-directory "/ssh:www-data@www:~/www.norang.ca/htdocs"
;;	       :base-directory "~/orgcvs"
;;               :publishing-directory "~/orgcvs/pub"
;;               :base-extension "css\\|pdf\\|png\\|jpg\\|gif"
;;               :publishing-function org-publish-attachment
;;               :recursive t
;;               :author nil)
;;              ("norang"
;;               ;;:components ("norang-org" "norang-extra"
;;	       :components ("orgcvs-pub" "orgcvs-extra"
;;	       ))
;;              ;
;;              ; http://doc.norang.ca/  (norang website)
;;              ; doc-org are the org-files that generate the content
;;              ; doc-extra are images and css files that need to be included
;;              ; doc is the top-level project that gets published
;;              ("doc-org"
;;               :base-directory "~/git/doc.norang.ca/"
;;               :publishing-directory "/ssh:www-data@www:~/doc.norang.ca/htdocs"
;;               :recursive nil
;;               :section-numbers nil
;;               :table-of-contents nil
;;               :base-extension "org"
;;               :publishing-function (org-publish-org-to-html org-publish-org-to-org)
;;               :style-include-default nil
;;               :style "<link rel=\"stylesheet\" href=\"/org.css\" type=\"text/css\" />"
;;               :author-info nil
;;               :creator-info nil)
;;              ("doc-extra"
;;               :base-directory "~/git/doc.norang.ca/"
;;               :publishing-directory "/ssh:www-data@www:~/doc.norang.ca/htdocs"
;;               :base-extension "css\\|pdf\\|png\\|jpg\\|gif"
;;               :publishing-function org-publish-attachment
;;               :recursive nil
;;               :author nil)
;;              ("doc"
;;               :components ("doc-org" "doc-extra"))
;;              ("doc-private-org"
;;               :base-directory "~/git/doc.norang.ca/private"
;;               :publishing-directory "/ssh:www-data@www:~/doc.norang.ca/htdocs/private"
;;               :recursive nil
;;               :section-numbers nil
;;               :table-of-contents nil
;;               :base-extension "org"
;;               :publishing-function (org-publish-org-to-html org-publish-org-to-org)
;;               :style-include-default nil
;;               :style "<link rel=\"stylesheet\" href=\"/org.css\" type=\"text/css\" />"
;;               :auto-sitemap t
;;               :sitemap-filename "index.html"
;;               :sitemap-title "Norang Private Documents"
;;               :sitemap-style "tree"
;;               :author-info nil
;;               :creator-info nil)
;;              ("doc-private-extra"
;;               :base-directory "~/git/doc.norang.ca/private"
;;               :publishing-directory "/ssh:www-data@www:~/doc.norang.ca/htdocs/private"
;;               :base-extension "css\\|pdf\\|png\\|jpg\\|gif"
;;               :publishing-function org-publish-attachment
;;               :recursive nil
;;               :author nil)
;;              ("doc-private"
;;               :components ("doc-private-org" "doc-private-extra"))
;;              ;
;;              ; Miscellaneous pages for other websites
;;              ; org are the org-files that generate the content
;;              ("org-org"
;;               :base-directory "~/git/org/"
;;               :publishing-directory "/ssh:www-data@www:~/org"
;;               :recursive t
;;               :section-numbers nil
;;               :table-of-contents nil
;;               :base-extension "org"
;;               :publishing-function org-publish-org-to-html
;;               :style-include-default nil
;;               :style "<link rel=\"stylesheet\" href=\"/org.css\" type=\"text/css\" />"
;;               :author-info nil
;;               :creator-info nil)
;;              ;
;;              ; http://doc.norang.ca/  (norang website)
;;              ; org-mode-doc-org this document
;;              ; org-mode-doc-extra are images and css files that need to be included
;;              ; org-mode-doc is the top-level project that gets published
;;              ; This uses the same target directory as the 'doc' project
;;              ("org-mode-doc-org"
;;               :base-directory "~/git/org-mode-doc/"
;;               :publishing-directory "/ssh:www-data@www:~/doc.norang.ca/htdocs"
;;               :recursive t
;;               :section-numbers nil
;;               :table-of-contents nil
;;               :base-extension "org"
;;               :publishing-function (org-publish-org-to-html org-publish-org-to-org)
;;               :plain-source t
;;               :htmlized-source t
;;               :style-include-default nil
;;               :style "<link rel=\"stylesheet\" href=\"/org.css\" type=\"text/css\" />"
;;               :author-info nil
;;               :creator-info nil)
;;              ("org-mode-doc-extra"
;;               :base-directory "~/git/org-mode-doc/"
;;               :publishing-directory "/ssh:www-data@www:~/doc.norang.ca/htdocs"
;;               :base-extension "css\\|pdf\\|png\\|jpg\\|gif"
;;               :publishing-function org-publish-attachment
;;               :recursive t
;;               :author nil)
;;              ("org-mode-doc"
;;               :components ("org-mode-doc-org" "org-mode-doc-extra"))
;;              ;
;;              ; http://doc.norang.ca/  (norang website)
;;              ; org-mode-doc-org this document
;;              ; org-mode-doc-extra are images and css files that need to be included
;;              ; org-mode-doc is the top-level project that gets published
;;              ; This uses the same target directory as the 'doc' project
;;              ("tmp-org"
;;               :base-directory "/tmp/publish/"
;;               :publishing-directory "/ssh:www-data@www:~/www.norang.ca/htdocs/tmp"
;;               :recursive t
;;               :section-numbers nil
;;               :table-of-contents nil
;;               :base-extension "org"
;;               :publishing-function (org-publish-org-to-html org-publish-org-to-org)
;;               :style "<link rel=\"stylesheet\" href=\"http://doc.norang.ca/org.css\" type=\"text/css\" />"
;;               :plain-source t
;;               :htmlized-source t
;;               :style-include-default nil
;;               :auto-sitemap t
;;               :sitemap-filename "index.html"
;;               :sitemap-title "Test Publishing Area"
;;               :sitemap-style "tree"
;;               :author-info t
;;               :creator-info t)
;;              ("tmp-extra"
;;               :base-directory "/tmp/publish/"
;;               :publishing-directory "/ssh:www-data@www:~/www.norang.ca/htdocs/tmp"
;;               :base-extension "css\\|pdf\\|png\\|jpg\\|gif"
;;               :publishing-function org-publish-attachment
;;               :recursive t
;;               :author nil)
;;              ("tmp"
;;               :components ("tmp-org" "tmp-extra")))))
;;
;;; I'm lazy and don't want to remember the name of the project to publish when I modify
;;; a file that is part of a project.  So this function saves the file, and publishes
;;; the project that includes this file
;;
;;; It's bound to C-S-F12 so I just edit and hit C-S-F12 when I'm done and move on to the next thing
;;(defun bh/save-then-publish ()
;;  (interactive)
;;  (save-buffer)
;;  (org-save-all-org-buffers)
;;  (org-publish-current-project))
;;
;;(global-set-key (kbd "C-s-<f12>") 'bh/save-then-publish)


;;Miscellaneous Export Settings
;;=============================
;;This is a collection of export and publishing related settings that I use.

;;Fontify Latex Listings For Source Blocks
;;For export to latex I use the following setting to get fontified listings from source blocks:
;;=--------------------------------
(setq org-export-latex-listings t)


;;Export HTML Without XML Header
;;=------------------------------
;;I use the following setting to remove the xml header line for HTML exports.
;;This xml line was confusing Open Office when opening the HTML to convert to ODT

(setq org-export-html-xml-declaration (quote (("html" . "")
                                              ("was-html" . "<?xml version=\"1.0\" encoding=\"%s\"?>")
                                              ("php" . "<?php echo \"<?xml version=\\\"1.0\\\" encoding=\\\"%s\\\" ?>\"; ?>"))))


;;Allow Binding Variables On Export Without Confirmation
;;=------------------------------------------------------
;;The following setting allows #+BIND: variables to be set on export without confirmation. 
;;In rare situations where I want to override some org-mode variable for export this allows exporting the document without a prompt.
;;=-----------------------------
(setq org-export-allow-BIND t)


;---------------
;Reminder
;---------------
;;I use appt for reminders. 
;;It's simple and unobtrusive – putting pending appointments in the status bar and beeping as 12, 9, 6, 3, and 0 minutes 
;;before the appointment is due.
;;
;;Everytime the agenda is displayed (and that's lots for me) the appointment list is erased and 
;;rebuilt from the current agenda details for today. This means everytime I reschedule something, 
;;add or remove tasks that are time related the appointment list is automatically updated the next time I look at the agenda.

;;Reminder Setup
;;===============
; Erase all reminders and rebuilt reminders for today from the agenda
(defun bh/org-agenda-to-appt ()
  (interactive)
  (setq appt-time-msg-list nil)
  (org-agenda-to-appt))

; Rebuild the reminders everytime the agenda is displayed
(add-hook 'org-finalize-agenda-hook 'bh/org-agenda-to-appt 'append)

; This is at the end of my .emacs - so appointments are set up when Emacs starts
(bh/org-agenda-to-appt)

; Activate appointments so we get notifications
(appt-activate t)

; If we leave Emacs running overnight - reset the appointments one minute after midnight
(run-at-time "24:01" nil 'bh/org-agenda-to-appt)


;---------------------
;Productivity Tools
;---------------------
;;This section is a miscellaneous collection of Emacs customizations that I use with org-mode 
;;so that it Works-For-Me(tm).

;--------- Abbrev-Mode And Skeletons -----------
;;I use skeletons with abbrev-mode to quickly add preconfigured blocks to my Emacs edit buffers.
;;
;;I have blocks for creating:
;;
;;generic blocks in org-mode
;;plantuml blocks in org-mode
;;graphviz dot blocks in org-mode
;;ditaa blocks in org-mode
;;elisp source blocks in org-mode
;;I still use < e TAB and < s TAB for creating example blocks and simple shell script blocks that need no further parameters.
;;
;;Here's my current setup for org-mode related skeletons. Each one defines an abbrev-mode shortcut so 
;;I can type splantumlRET to create a Plantuml block. This prompts for the filename (without extension) for the generated image file.
;;
;;At work I add a :tangle header to the skeleton and explicitly include the @startuml and @enduml marker lines in the skeleton so 
;;I can tangle the source file and share it with my colleagues.
;;This makes the tangled source useable in Notepad and the PlantUML jar file running standalone.
;;
;;I have put the s (src) prefix on the shortcuts to prevent abbrev-mode from trying to expand PlantUML when I'm typing it in a sentence.
;;===============================================
;; Enable abbrev-mode
(add-hook 'org-mode-hook (lambda () (abbrev-mode 1)))

;; Skeletons
;;
;; sblk - Generic block #+begin_FOO .. #+end_FOO
(define-skeleton skel-org-block
  "Insert an org block, querying for type."
  "Type: "
  "#+begin_" str "\n"
  _ - \n
  "#+end_" str "\n")

(define-abbrev org-mode-abbrev-table "sblk" "" 'skel-org-block)

;; splantuml - PlantUML Source block
(define-skeleton skel-org-block-plantuml
  "Insert a org plantuml block, querying for filename."
  "File (no extension): "
  "#+begin_src plantuml :file " str ".png :cache yes\n"
  _ - \n
  "#+end_src\n")

(define-abbrev org-mode-abbrev-table "splantuml" "" 'skel-org-block-plantuml)

;; sdot - Graphviz DOT block
(define-skeleton skel-org-block-dot
  "Insert a org graphviz dot block, querying for filename."
  "File (no extension): "
  "#+begin_src dot :file " str ".png :cache yes :cmdline -Kdot -Tpng\n"
  "graph G {\n"
  _ - \n
  "}\n"
  "#+end_src\n")

(define-abbrev org-mode-abbrev-table "sdot" "" 'skel-org-block-dot)

;; sditaa - Ditaa source block
(define-skeleton skel-org-block-ditaa
  "Insert a org ditaa block, querying for filename."
  "File (no extension): "
  "#+begin_src ditaa :file " str ".png :cache yes\n"
  _ - \n
  "#+end_src\n")

(define-abbrev org-mode-abbrev-table "sditaa" "" 'skel-org-block-ditaa)

;; selisp - Emacs Lisp source block
(define-skeleton skel-org-block-elisp
  "Insert a org emacs-lisp block"
  ""
  "#+begin_src emacs-lisp\n"
  _ - \n
  "#+end_src\n")

(define-abbrev org-mode-abbrev-table "selisp" "" 'skel-org-block-elisp)


;;I also use abbrev-mode when taking notes at work. 
;;I tend to write first names for people which get expanded to their complete name in my notes. 
;;So if I write mickey it gets automatically expanded to Mickey Mouse as I type. 
;;To create an abbreviation just type in the short form followed by C-x a i l to create an abbreviation for the current mode I'm in.
;;
;;The only thing you have to be careful with is not to use a common word for your abbreviation since abbrev-mode will try to 
;;expand it everytime you enter it. I found this annoying when I used plantuml as one of my abbreviations.
;;
;;I also use skeletons and abbrev-mode for C source files at work. This works really well for me.



;;Focus On Current Work
;;=======================
;;Narrowing To A Subtree With Bh/Org-Todo
;;=--------------------------------------
;;f5 and S-f5 are bound the functions for narrowing and widening the emacs buffer as defined below.
;;
;;We now use:
;;
;;	T (tasks) for C-c / t on the current buffer
;;	N (narrow) narrows to this task subtree
;;	U (up) narrows to the immediate parent task subtree without moving
;;	P (project) narrows to the parent project subtree without moving
;;	F (file) narrows to the current file or file of the existing restriction
;;
;;The agenda keeps widening the org buffer so this gives a convenient way to focus on what we are doing.
;;=======================================================================================================
(global-set-key (kbd "<f5>") 'bh/org-todo)

(defun bh/org-todo (arg)
  (interactive "p")
  (if (equal arg 4)
      (save-restriction
        (bh/narrow-to-org-subtree)
        (org-show-todo-tree nil))
    (bh/narrow-to-org-subtree)
    (org-show-todo-tree nil)))

(global-set-key (kbd "<S-f5>") 'bh/widen)

(defun bh/widen ()
  (interactive)
  (if (equal major-mode 'org-agenda-mode)
      (org-agenda-remove-restriction-lock)
    (widen)
    (org-agenda-remove-restriction-lock)))

(add-hook 'org-agenda-mode-hook
          '(lambda () (org-defkey org-agenda-mode-map "W" 'bh/widen))
          'append)

(defun bh/restrict-to-file-or-follow (arg)
  "Set agenda restriction to 'file or with argument invoke follow mode.
I don't use follow mode very often but I restrict to file all the time
so change the default 'F' binding in the agenda to allow both"
  (interactive "p")
  (if (equal arg 4)
      (org-agenda-follow-mode)
    (if (equal major-mode 'org-agenda-mode)
        (bh/set-agenda-restriction-lock 4)
      (widen))))

(add-hook 'org-agenda-mode-hook
          '(lambda () (org-defkey org-agenda-mode-map "F" 'bh/restrict-to-file-or-follow))
          'append)

(defun bh/narrow-to-org-subtree ()
  (widen)
  (org-narrow-to-subtree)
  (save-restriction
    (org-agenda-set-restriction-lock)))

(defun bh/narrow-to-subtree ()
  (interactive)
  (if (equal major-mode 'org-agenda-mode)
      (org-with-point-at (org-get-at-bol 'org-hd-marker)
        (bh/narrow-to-org-subtree))
    (bh/narrow-to-org-subtree)))

(add-hook 'org-agenda-mode-hook
          '(lambda () (org-defkey org-agenda-mode-map "N" 'bh/narrow-to-subtree))
          'append)

(defun bh/narrow-up-one-org-level ()
  (widen)
  (save-excursion
    (outline-up-heading 1 'invisible-ok)
    (bh/narrow-to-org-subtree)))

(defun bh/get-pom-from-agenda-restriction-or-point ()
  (or (org-get-at-bol 'org-hd-marker)
      (and (marker-position org-agenda-restrict-begin) org-agenda-restrict-begin)
      (and (equal major-mode 'org-mode) (point))
      org-clock-marker))

(defun bh/narrow-up-one-level ()
  (interactive)
  (if (equal major-mode 'org-agenda-mode)
      (org-with-point-at (bh/get-pom-from-agenda-restriction-or-point)
        (bh/narrow-up-one-org-level))
    (bh/narrow-up-one-org-level)))

(add-hook 'org-agenda-mode-hook
          '(lambda () (org-defkey org-agenda-mode-map "U" 'bh/narrow-up-one-level))
          'append)

(defun bh/narrow-to-org-project ()
  (widen)
  (save-excursion
    (bh/find-project-task)
    (bh/narrow-to-org-subtree)))

(defun bh/narrow-to-project ()
  (interactive)
  (if (equal major-mode 'org-agenda-mode)
      (org-with-point-at (bh/get-pom-from-agenda-restriction-or-point)
        (bh/narrow-to-org-project))
    (bh/narrow-to-org-project)))

(add-hook 'org-agenda-mode-hook
          '(lambda () (org-defkey org-agenda-mode-map "P" 'bh/narrow-to-project))
          'append)

(defvar bh/current-view-project nil)

(defun bh/view-next-project ()
  (interactive)
  (unless (marker-position org-agenda-restrict-begin)
    (goto-char (point-min))
    (setq bh/current-view-project (point)))
  (bh/widen)
  (goto-char bh/current-view-project)
  (forward-visible-line 1)
  (while (and (< (point) (point-max))
              (or (not (org-get-at-bol 'org-hd-marker))
                  (org-with-point-at (org-get-at-bol 'org-hd-marker)
                    (or (not (bh/is-project-p))
                        (bh/is-project-subtree-p)))))
    (forward-visible-line 1))
  (setq bh/current-view-project (point))
  (if (org-get-at-bol 'org-hd-marker)
      (bh/narrow-to-project)
    (message "All projects viewed.")
    (ding)))

(add-hook 'org-agenda-mode-hook
          '(lambda () (org-defkey org-agenda-mode-map "V" 'bh/view-next-project))
          'append)


;;This makes it easy to hide all of the other details in your org-file temporarily by limiting your view to this task subtree.
;;Tasks are folded and hilighted so that only tasks which are incomplete are shown.
;;
;;I hit f5 (or the T speed key) a lot. 
;;This basically does a org-narrow-to-subtree and C-c / t combination leaving the buffer in a narrowed state. 
;;I use S-f5 (or some other widening speed key like U, W, F) to widen back to the normal view.
;;
;;I also have the following setting to force showing the next headline.
;;=-------------------------------------------------------------
(setq org-show-entry-below (quote ((default))))

;;This prevents too many headlines from being folded together when I'm working with collapsed trees.


;;Limiting The Agenda To A Subtree
;;=================================
;;C-c C-x < turns on the agenda restriction lock for the current subtree. This keeps your agenda focused on only this subtree. 
;;Alarms and notifications are still active outside the agenda restriction. 
;;C-c C-x > turns off the agenda restriction lock returning your agenda view back to normal.
;;
;;I have added key bindings for the agenda to allow using C-c C-x < in the agenda to set the restriction lock to the current task directly.
;;The following elisp accomplishes this.
;;=--------------------------------------

(add-hook 'org-agenda-mode-hook
          '(lambda () (org-defkey org-agenda-mode-map "\C-c\C-x<" 'bh/set-agenda-restriction-lock))
          'append)

(defun bh/set-agenda-restriction-lock (arg)
  "Set restriction lock to current task subtree or file if prefix is specified"
  (interactive "p")
  (let* ((pom (bh/get-pom-from-agenda-restriction-or-point))
         (tags (org-with-point-at pom (org-get-tags-at))))
    (let ((restriction-type (if (equal arg 4) 'file 'subtree)))
      (save-restriction
        (cond
         ((and (equal major-mode 'org-agenda-mode) pom)
          (org-with-point-at pom
            (org-agenda-set-restriction-lock restriction-type)))
         ((and (equal major-mode 'org-mode) (org-before-first-heading-p))
          (org-agenda-set-restriction-lock 'file))
         (pom
          (org-with-point-at pom
            (org-agenda-set-restriction-lock restriction-type))))))))

;;This allows me to set the restriction lock from agenda to task directly. 
;;I work from the agenda a lot and I find this very convenient.

;;I've added new convenience keys for restricting the agenda and org-buffer to subtree, parent task, and project task, 
;;as well as removing the restriction. These keys work both in the agenda and as speed commands on a headline in the org-file.
;;
;;	N narrows to the current task subtree
;;	  This is the same as same as C-c C-x <
;;
;;	U narrows to the parent subtree of this task
;;	  This goes up one level and narrows to that subtree.
;;
;;	P narrows to the entire project containing this task
;;	  This goes up the tree to the top-level TODO keyword and selects that as the subtree to narrow to
;;
;;	W removes the restriction, widening the buffer


;;Limiting The Agenda To A File
;;==============================
;;You can limit the agenda view to a single file in multiple ways.
;;
;;You can use the agenda restriction lock C-c C-x < on the any line before the first heading to set the agenda restriction lock to this file only. 
;;This is equivalent using a prefix argumment (C-u C-c C-x <) anywhere in the file. 
;;This lock stays in effect until you remove it with C-c C-x >.
;;
;;This also works in the agenda with my C-u C-c c-x < key binding.
;;
;;Another way is to invoke the agenda with F12 < a while visiting an org-mode file. This limits the agenda view to just this file. 
;;I occasionally use this to view a file not in my org-agenda-files in the agenda.


;;Tuning The Agenda Views
;;==========================

;;Various customizations affect how the agenda views show task details. This section shows each of the customizations I use in my workflow.

;;Highlight The Current Agenda Line
;;=---------------------------------
;;The following code in my .emacs file keeps the current agenda line highlighted. 
;;This makes it obvious what task will be affected by commands issued in the agenda. 
;;No more acting on the wrong task by mistake!
;;
;;The clock modeline time is also shown with a reverse background.
;;================================================================
;; Always hilight the current agenda line
(add-hook 'org-agenda-mode-hook
          '(lambda () (hl-line-mode 1))
          'append)


;; The following custom-set-faces create the highlights
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(org-mode-line-clock ((t (:background "grey75" :foreground "red" :box (:line-width -1 :style released-button)))) t))


;;Keep Tasks With Timestamps Visible On The Global Todo Lists
;;=----------------------------------------------------------
;;Tasks with dates (SCHEDULED:, DEADLINE:, or active dates) show up in the agenda when appropriate. T
;;he block agenda view (F12 a) tries to keep tasks showing up only in one location (either in the calendar or 
;;other todo lists in later sections of the block agenda.) I now rarely use the global todo list search in org-mode (F12 t, F12 m) 
;;and when I do I'm trying to find a specific task quickly.
;;These lists now include everything so I can just search for the item I want and move on.

;;The block agenda prevents display of tasks with deadlines or scheduled dates in the future so 
;;you can safely ignore these until the appropriate time.
;;=----------------------------------------------------------------
;; Keep tasks with dates on the global todo lists
(setq org-agenda-todo-ignore-with-date nil)

;; Keep tasks with deadlines on the global todo lists
(setq org-agenda-todo-ignore-deadlines nil)

;; Keep tasks with scheduled dates on the global todo lists
(setq org-agenda-todo-ignore-scheduled nil)

;; Keep tasks with timestamps on the global todo lists
(setq org-agenda-todo-ignore-timestamp nil)

;; Remove completed deadline tasks from the agenda view
(setq org-agenda-skip-deadline-if-done t)

;; Remove completed scheduled tasks from the agenda view
(setq org-agenda-skip-scheduled-if-done t)

;; Remove completed items from search results
(setq org-agenda-skip-timestamp-if-done t)


;;Use The Diary For Holidays And Appointments
;;=-----------------------------------------
;;I don't use the emacs Diary for anything but I like seeing the holidays on my agenda. 
;;This helps with planning for those days when you're not supposed to be working.
;;=---------------------------------
(setq org-agenda-include-diary nil)
(setq org-agenda-diary-file "~/orgcvs/diary.org")

;;I use the following setting so any time strings in the heading are shown in the agenda.
;;===========================================
(setq org-agenda-insert-diary-extract-time t)



;; Searches Include Archive Files
;;================================
;;I keep a single archive file for each of my org-mode project files. 
;;This allows me to search the current file and the archive when I need to dig up old information from the archives.
;;
;;I don't need this often but it sure is handy on the occasions that I do need it.
;;=----------------------------------------------------------------------------
;; Include agenda archive files when searching for things
(setq org-agenda-text-search-extra-files (quote (agenda-archives)))


;;Agenda View Tweaks
;;====================

;;The following agenda customizations control
;;
;;	display of repeating tasks
;;	display of empty dates on the agenda
;;	task sort order
;;	start the agenda weekly view with Sunday
;;	display of the grid
;;	habits at the bottom
;;
;;I use a custom sorting function so that my daily agenda lists tasks in order of importance. Tasks on the daily agenda are listed in the following order:
;;
;;	tasks with times at the top so they are hard to miss
;;	entries for today (active timestamp headlines that are not scheduled or deadline tasks)
;;	deadlines due today
;;	late deadline tasks
;;	scheduled items for today
;;	pending deadlines (due soon)
;;	late scheduled items
;;	habits
;;The lisp for this isn't particularly pretty but it works.
;;=-------------------------------------------------------
;; Show all future entries for repeating tasks
(setq org-agenda-repeating-timestamp-show-all t)

;; Show all agenda dates - even if they are empty
(setq org-agenda-show-all-dates t)

;; Sorting order for tasks on the agenda
(setq org-agenda-sorting-strategy
      (quote ((agenda habit-down time-up user-defined-up priority-down effort-up category-keep)
              (todo category-up priority-down effort-up)
              (tags category-up priority-down effort-up)
              (search category-up))))

;; Start the weekly agenda on Monday
(setq org-agenda-start-on-weekday 1)

;; Enable display of the time grid so we can see the marker for the current time
(setq org-agenda-time-grid (quote ((daily today remove-match)
                                   #("----------------" 0 16 (org-heading t))
                                   (830 1000 1200 1300 1500 1700))))

;; Display tags farther right
(setq org-agenda-tags-column -102)

;;
;; Agenda sorting functions
;;
(setq org-agenda-cmp-user-defined 'bh/agenda-sort)

(defun bh/agenda-sort (a b)
  "Sorting strategy for agenda items.
Late deadlines first, then scheduled, then non-late deadlines"
  (let (result num-a num-b)
    (cond
     ; time specific items are already sorted first by org-agenda-sorting-strategy

     ; non-deadline and non-scheduled items next
     ((bh/agenda-sort-test 'bh/is-not-scheduled-or-deadline a b))

     ; deadlines for today next
     ((bh/agenda-sort-test 'bh/is-due-deadline a b))

     ; late deadlines next
     ((bh/agenda-sort-test-num 'bh/is-late-deadline '< a b))

     ; scheduled items for today next
     ((bh/agenda-sort-test 'bh/is-scheduled-today a b))

     ; late scheduled items next
     ((bh/agenda-sort-test-num 'bh/is-scheduled-late '> a b))

     ; pending deadlines last
     ((bh/agenda-sort-test-num 'bh/is-pending-deadline '< a b))

     ; finally default to unsorted
     (t (setq result nil)))
    result))

(defmacro bh/agenda-sort-test (fn a b)
  "Test for agenda sort"
  `(cond
    ; if both match leave them unsorted
    ((and (apply ,fn (list ,a))
          (apply ,fn (list ,b)))
     (setq result nil))
    ; if a matches put a first
    ((apply ,fn (list ,a))
     (setq result -1))
    ; otherwise if b matches put b first
    ((apply ,fn (list ,b))
     (setq result 1))
    ; if none match leave them unsorted
    (t nil)))

(defmacro bh/agenda-sort-test-num (fn compfn a b)
  `(cond
    ((apply ,fn (list ,a))
     (setq num-a (string-to-number (match-string 1 ,a)))
     (if (apply ,fn (list ,b))
         (progn
           (setq num-b (string-to-number (match-string 1 ,b)))
           (setq result (if (apply ,compfn (list num-a num-b))
                            -1
                          1)))
       (setq result -1)))
    ((apply ,fn (list ,b))
     (setq result 1))
    (t nil)))

(defun bh/is-not-scheduled-or-deadline (date-str)
  (and (not (bh/is-deadline date-str))
       (not (bh/is-scheduled date-str))))

(defun bh/is-due-deadline (date-str)
  (string-match "Deadline:" date-str))

(defun bh/is-late-deadline (date-str)
  (string-match "In *\\(-.*\\)d\.:" date-str))

(defun bh/is-pending-deadline (date-str)
  (string-match "In \\([^-]*\\)d\.:" date-str))

(defun bh/is-deadline (date-str)
  (or (bh/is-due-deadline date-str)
      (bh/is-late-deadline date-str)
      (bh/is-pending-deadline date-str)))

(defun bh/is-scheduled (date-str)
  (or (bh/is-scheduled-today date-str)
      (bh/is-scheduled-late date-str)))

(defun bh/is-scheduled-today (date-str)
  (string-match "Scheduled:" date-str))

(defun bh/is-scheduled-late (date-str)
  (string-match "Sched\.\\(.*\\)x:" date-str))


;;Q Buries The Agenda View Buffer
;;=-----------------------------
;;I change the q key in the agenda so instead of killing the agenda buffer it merely buries it to the end of the buffer list. 
;;This allows me to pull it back up quickly with the q speed key or f9 f9 and regenerate the results with g.
;;=-----------------------------------------
(add-hook 'org-agenda-mode-hook
          (lambda ()
            (define-key org-agenda-mode-map "q" 'bury-buffer))
          'append)


;;Checklist Handling
;;==================
;;Checklists are great for repeated tasks with lots of things that need to be done. 
;;For a long time I was manually resetting the check boxes to unchecked when marking the repeated task DONE but no more! 
;;There's a contributed org-checklist that can uncheck the boxes automagically when the task is marked done.
;;=-----------------------------------------------------------------
;;(add-to-list 'load-path (expand-file-name "~/zzcfg.d/my-org-addon"))
(require 'org-checklist)


;;and then to use it in a task you simply set the property RESET_CHECK_BOXES to t like this
;;
;;* TODO Invoicing and Archive Tasks [0/7]
;;   DEADLINE: <2009-07-01 Wed +1m -0d> 
;;PROPERTIES:
;;RESET_CHECK_BOXES: t
;;END:
;;
;;   - [ ] Do task 1
;;   - [ ] Do task 2
;;   ...
;;   - [ ] Do task 7


;;Backups
;;========
;;Backups that you have to work hard at don't get done.
;;
;;I lost a bunch of data over 10 years ago due to not having a working backup solution. 
;;At the time I said I'm not going to lose any important data ever again. So far so good :)
;;
;;My backups get done religiously. What does this have to do with org-mode? Not much really, 
;;other than I don't spend time doing backups – they just happen – which saves me time for other more interesting things.
;;
;;My backup philosophy is to make it possible to recover your data -- not necessarily easy. 
;;It doesn't have to be easy/fast to do the recovery because I'll rarely have to recover data from the backups. 
;;Saving time for recovery doesn't make sense to me. I want the backup to be fast and painless since I do those all the time.
;;
;;I set up an automated network backup over 10 years ago that is still serving me well today. 
;;All of my systems gets daily backups to a network drive. These are collected monthly and written to an external removable USB disk.
;;
;;Once a month my task for backups prompts me to move the current collection of montly backups to the USB drive for external storage. 
;;Backups take minimal effort currently and I'm really happy about that.
;;
;;Since then git came into my life, so backups of git repositories that are on multiple machines is much less critical than it used to be. 
;;There is an automatic backup of everything pushed to the remote repository.


;;Handling Blocked Tasks
;;======================
;;Blocked tasks are tasks that have subtasks which are not in a done todo state. 
;;Blocked tasks show up in a grayed font by default in the agenda.
;;
;;To enable task blocking set the following variable:
(setq org-enforce-todo-dependencies t)

;;
;;This setting prevents tasks from changing to DONE if any subtasks are still open. This works pretty well except for repeating tasks. 
;;I find I'm regularly adding TODO tasks under repeating tasks and not all of the subtasks need to be complete before the next repeat cycle.
;;
;;You can override the setting temporarily by changing the task with C-u C-u C-u C-c C-t but I never remember that. 
;;I set a permanent property on the repeated tasks as follows:
;;
;;* TODO New Repeating Task
;;  SCHEDULED: <2009-06-16 Tue +1w>
;;PROPERTIES:
;;NOBLOCKING: t
;;END:
;;...
;;** TODO Subtask 
;;
;;This prevents the New Repeating Task from being blocked if some of the items under it are not complete.
;;
;;Occassionally I need to complete tasks in a given order. Org-mode has a property ORDERED that enforces this for subtasks.
;;
;;* TODO Some Task
;;PROPERTY:
;;ORDERED: t
;;END:
;;** TODO Step 1
;;** TODO Step 2
;;** TODO Step 3 
;;
;;In this case you need to complete Step 1 before you can complete Step 2, etc. 
;;and org-mode prevents the state change to a done task until the preceding tasks are complete.


;;Org Task Structure And Presentation
;;===================================
;;Controlling Display Of Leading Stars On Headlines
;;=------------------------------------------------
;;Org-mode has the ability to show or hide the leading stars on task headlines. 
;;It's also possible to have headlines at odd levels only so that the stars and heading task names line up in sublevels.
;;
;;To make org show leading stars use

(setq org-hide-leading-stars nil)

;;I now use org-indent mode which hides leading stars.


;;Org-Indent Mode
;;================
;;I recently started using org-indent mode. I like this setting a lot. 
;;It removes the indentation in the org-file but displays it as if it was indented while you are working on the org file buffer.
;;
;;org-indent mode displays as if org-odd-levels-only is true but it has a really clean look that I prefer over my old setup.
;;
;;I have org-indent mode on by default at startup with the following setting:
;;=---------------------------
(setq org-startup-indented t)



;;Handling Blank Lines
;;=====================
;;Blank lines are evil :). They keep getting inserted in between headlines and I don't want to see them in collapsed (contents) views. 
;;When I use TAB to fold (cycle) tasks I don't want to see any blank lines between headings.
;;
;;The following setting hides blank lines between headings which keeps folded view nice and compact.
;;=-----------------------------------
(setq org-cycle-separator-lines 0)


;;I find extra blank lines in lists and headings a bit of a nuisance.
;;To get a body after a list you need to include a blank line between the list entry and the body – and indent the body appropriately. 
;;Most of my lists have no body detail so I like the look of collapsed lists with no blank lines better.
;;
;;The following setting prevents creating blank lines before headings but allows list items to adapt to existing blank lines around the items:
;;=--------------------
(setq org-blank-before-new-entry (quote ((heading)
                                         (plain-list-item . auto))))


;;Adding New Tasks Quickly Without Disturbing The Current Task Content
;;===================================================================
;;To create new headings in a project file it is really convenient to use C-RET, C-S-RET, M-RET, and M-S-RET. 
;;This inserts a new headline possibly with a TODO keyword. With the following setting
;;=------------------------------------------
(setq org-insert-heading-respect-content nil)


;;org inserts the heading at point for the M- versions and respects content for the C- versions. 
;;The respect content setting is temporarily turned on for the C- versions which adds the new heading after the content of the current item.
;;This lets you hit C-S-RET in the middle of an entry and the new heading is added after the body of the current entry but 
;;still allow you to split an entry in the middle with M-S-RET.


;;Notes At The Top
;;===================
;;I enter notes for tasks with C-c C-z (or just z in the agenda).
;;Changing tasks states also sometimes prompt for a note (e.g. moving to WAITING prompts for a note and I enter a reason for why it is waiting). 
;;These notes are saved at the top of the task so unfolding the task shows the note first.
;;=------------------------------
(setq org-reverse-note-order nil)



;;Searching And Showing Results
;;==============================
;;Org-mode's searching capabilities are really effective at finding data in your org files.
;;C-c / / does a regular expression search on the current file and shows matching results in a collapsed view of the org-file.
;;
;;I have org-mode show the hierarchy of tasks above the matched entries and
;;also the immediately following sibling task (but not all siblings) with the following settings:
;;=------------------------------------
(setq org-show-following-heading t)
(setq org-show-hierarchy-above t)
(setq org-show-siblings (quote ((default))))

;;This keeps the results of the search relatively compact and mitigates accidental errors by cutting too much data from your org file with C-k. 
;;Cutting folded data (including the …) can be really dangerous since it cuts text (including following subtrees) which you can't see.
;;For this reason I always show the following headline when displaying search results.


;;Editing And Special Key Handling
;;=================================
;;Org-mode allows special handling of the C-a, C-e, and C-k keys while editing headlines. 
;;I also use the setting that pastes (yanks) subtrees and adjusts the levels to match the task I am pasting to. 
;;See the docstring (C-h v org-yank-adjust-subtrees) for more details on each variable and what it does.
;;
;;I have org-special-ctrl-a/e set to enable easy access to the beginning and end of headlines. 
;;I use M-m or C-a C-a to get to the beginning of the line so the speed commands work and 
;;C-a to give easy access to the beginning of the heading text when I need that.
;;=----------------------
(setq org-special-ctrl-a/e 'reversed)
(setq org-special-ctrl-k t)
(setq org-yank-adjusted-subtrees t)


;;Attachments
;;==============
;;Attachments are great for getting large amounts of data related to your project out of your org-mode files. 
;;Before attachments came along I was including huge blocks of SQL code in my org files to keep track of changes I made to project databases. 
;;This bloated my org file sizes badly.
;;
;;Now I can create the data in a separate file and attach it to my project task so it's easily located again in the future.

;;I set up org-mode to generate unique attachment IDs with org-id-method as follows:
;;=---------------------------------
(setq org-id-method (quote uuidgen))


;;Say you want to attach a file x.sql to your current task. Create the file data in /tmp/x.sql and save it.
;;
;;Attach the file with C-c C-a a and enter the filename: x.sql. 
;;This generates a unique ID for the task and adds the file in the attachment directory.
;;
;;* Attachments                                                        :ATTACH:
;;PROPERTIES:
;;Attachments: x.sql
;;ID:       f1d38e9a-ff70-4cc4-ab50-e8b58b2aaa7b
;;END:  
;;The attached file is saved in data/f1/d38e9a-ff70-4cc4-ab50-e8b58b2aaa7b/. 
;;
;;Where it goes exactly isn't important for me – as long as it is saved and retrievable easily. 
;;Org-mode copies the original file /tmp/x.sql into the appropriate attachment directory.
;;
;;Tasks with attachments automatically get an ATTACH tag so you can easily find tasks with attachments with a tag search.
;;
;;To open the attachment for a task use C-c C-a o. This prompts for the attachment to open and TAB completion works here.
;;
;;The ID changes for every task header when a new ID is generated.
;;
;;It's possible to use named directories for attachments but I haven't needed this functionality yet – it's there if you need it.
;;
;;I store my org-mode attachments with my org files in a subdirectory data. 
;;These are automatically added to my git repository along with any other org-mode changes I've made.


;;Deadlines And Agenda Visibility
;;================================
;;Deadlines and due dates are a fact or life. 
;;By default I want to see deadlines in the agenda 30 days before the due date.
;;
;;The following setting accomplishes this:
;;=--------------------------------------
(setq org-deadline-warning-days 30)


;;This gives me plenty of time to deal with the task so that it is completed on or before the due date.
;;
;;I also use deadlines for repeating tasks. 
;;If the task repeats more often than once per month it would be always bugging me on the agenda view. 
;;For these types of tasks I set an explicit deadline warning date as follows:
;;
;;* TODO Pay Wages
;;  DEADLINE: <2009-07-01 Wed +1m -0d>
;;
;;This example repeats monthly and shows up in the agenda on the day it is due (with no prior warning). 
;;You can set any number of lead days you want on DEADLINES using -Nd where N is the number of days in advance the task should show up in the agenda. 
;;If no value is specified the default org-deadline-warning-days is used.


;;Exporting Tables To CSV
;;==========================
;;I generate org-mode tables with details of task specifications and record structures for some of my projects. 
;;My clients like to use spreadsheets for this type of detail.
;;
;;It's easy to share the details of the org-mode table by exporting in HTML but that isn't easy for anyone else to work with if they need to edit data.
;;
;;To solve this problem I export my table as comma delimited values (CSV) and then 
;;send that to the client (or read it into a spreadsheet and email the resulting spreadsheet file).
;;
;;Org-mode can export tables as TAB or comma delimited formats. I set the default format to CSV with:
;;=---------------------------------------------------
(setq org-table-export-default-format "orgtbl-to-csv")


;;Exporting to CSV format is the only one I use and this provides the default so I can just hit RETURN when prompted for the format.
;;
;;To export the following table I put the cursor inside the table and hit M-x org-table-export 
;;which prompts for a filename and the format which defaults to orgtbl-to-csv from the setting above.
;;
;;	One	Two	Three
;;	1	1	2
;;	3	6	5
;;	fred	kpe	mary
;;	234.5	432.12	324.3
;;
;;This creates the file with the following data
;;
;;	One,Two,Three
;;	1,1,2
;;	3,6,5
;;	fred,kpe,mary
;;	234.5,432.12,324.3


;;Minimize Emacs Frames
;;======================
;;Links to emails, web pages, and other files are sprinkled all over my org files. 
;;The following setting control how org-mode handles opening the link.
;;=--------------------------------------------------------------
(setq org-link-frame-setup (quote ((vm . vm-visit-folder)
                                   (gnus . org-gnus-no-new-news)
                                   (file . find-file))))

; Use the current window for C-c ' source editing
(setq org-src-window-setup 'current-window)

;;I like to keep links in the same window so that I don't end up with a ton of frames in my window manager.
;;I normally work in a full-screen window and having links open in the same window just works better for me.
;;
;;If I need to work in multiple files I'll manually create the second frame with C-x 5 2 or split the window with C-x 4 2 or C-X 4 3. 
;;When I visit files in Emacs I normally want to replace the current window with the new content.



;;Logging Stuff
;;==============
;;Most of my logging is controlled by the global org-todo-keywords
;;
;;My logging settings are set as follows:
;;=-----------------------------------
(setq org-log-done (quote time))
(setq org-log-into-drawer "LOGBOOK")

;;My org-todo-keywords are set as follows:

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!/!)")
              (sequence "WAITING(w@/@)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE"))))

;;This adds a log entry whenever a task moves to any of the following states:
;;
;;	to or out of DONE status
;;	to WAITING status (with a note) or out of WAITING status
;;	to HOLD status
;;	to CANCELLED status (with a note) or out of CANCELLED status
;;
;;I keep clock times and states in the LOGBOOK drawer to keep my tasks uncluttered. 
;;If a task is WAITING then the reason for why it is waiting is near the top of the LOGBOOK and unfolding the LOGBOOK drawer provides that information. 
;;From the agenda simply hitting SPC on the task will reveal the LOGBOOK drawer.



;;Limiting Time Spent On Tasks
;;==============================
;;Org-mode has this great new feature for signalling alarms when the estimated time for a task is reached. 
;;I use this to limit the amount of time I spend on a task during the day.
;;
;;As an example, I've been working on this document for over two months now. 
;;I want to get it finished but I can't just work on it solely until it's done because then nothing else gets done.
;;I want to do a little bit every day but limit the total amount of time I spend documenting org-mode to an hour a day.
;;
;;To this end I have a task
;;
;;	* NEXT Document my use of org-mode
;;	LOGBOOK:...
;;	PROPERTIES:
;;	CLOCK_MODELINE_TOTAL: today
;;	Effort:   1:00
;;	END:  
;;
;;The task has an estimated effort of 1 hour and when I clock in the task it gives me a total in the mode-line like this
;;
;;	--:**  org-mode.org   91% (2348,73) Git:master  (Org Fly yas Font)-----[0:35/1:00 (Document my use of org-mode)]-------
;;
;;I've spent 35 minutes of my 1 hour so far today on this document and other help on IRC.
;;
;;I set up an alarm so the Star Trek door chime goes off when the total estimated time is hit. (Yes I'm a Trekkie :) )
;;=-------------------------------------
(setq org-clock-sound "~/zzcfg.d/my-org-addon/message.wav")

;;When the one hour time limit is hit the alarm sound goes off and a message states that I should be done working on this task. 
;;If I switch tasks and try to clock in this task again I get the sound each and every time I clock in the task. This nags me to go work on something else :)
;;
;;You can use similar setups for repeated tasks. By default the last repeat time is recorded as a property when a repeating task is marked done. 
;;For repeating tasks the mode-line clock total counts since the last repeat time by default. 
;;This lets you accumulate time over multiple days and counts towards your estimated effort limit.



;;Habit Tracking
;;================
;;John Wiegley recently added support for Habit tracking to org-mode.
;;
;;I have lots of habits (some bad) but I'd still like to improve and build new good habits. 
;;This is what habit tracking is for. It shows a graph on the agenda of how well you have been doing on developing your habits.
;;
;;I have habits like:
;;
;;	Hand wash the dishes
;;	30 minute brisk walk
;;	Clean the house
;;etc. and most of these need a push to get done regularly. Logging of the done state needs to be enabled for habit tracking to work.
;;
;;A habit is just like a regular task except it has a special PROPERTY value setting and a special SCHEDULED date entry like this:
;;
;;* TODO Update Org Mode Doc
;;   SCHEDULED: <2009-11-21 Sat .+7d/30d>
;;   [2009-11-14 Sat 11:45]
;;PROPERTIES:
;;STYLE: habit
;;END:  


;;This marks the task as a habit and separates it from the regular task display on the agenda. 
;;When you mark a habit done it shows up on your daily agenda the next time based on the first interval in the SCHEDULED entry (.+7d)
;;
;;The special SCHEDULED entry states that I want to do this every day but at least every 2 days. 
;;If I go 3 days without marking it DONE it shows up RED on the agenda indicating that I have been neglecting this habit.
;;
;;The world isn't going to end if you neglect your habits. You can hide and display habits quickly using the K key on the agenda.
;;
;;These are my settings for habit tracking.
;;=----------------------------------------
; Enable habit tracking (and a bunch of other modules)
(setq org-modules (quote (org-bbdb
                          org-bibtex
                          org-crypt
                          org-gnus
                          org-id
                          org-info
                          org-jsinfo
                          org-habit
                          org-inlinetask
                          org-irc
                          org-mew
                          org-mhe
                          org-protocol
                          org-rmail
                          org-vm
                          org-wl
                          org-w3m)))

; position the habit graph on the agenda to the right of the default
(setq org-habit-graph-column 50)
;;
;;During the day I'll turn off the habit display in the agenda with K. 
;;This is a persistent setting and since I leave my Emacs running for days at a time my habit display doesn't come back. 
;;To make sure I look at the habits daily I have the following settings to redisplay the habits in the agenda each day. 
;;This turns the habit display on again at 6AM each morning.
;;=---------------------------------------------------------
(run-at-time "06:00" 86400 '(lambda () (setq org-habit-show-habits t)))


;;Habits Only Log DONE State Changes
;;===================================
;;I tend to keep habits under a level 1 task * Habits with a special logging property that only logs changes to the DONE state. 
;;This allows me to cancel a habit and not record a timestamp for it since that messes up the habit graph. 
;;Cancelling a habit just to get it off my agenda because it's undoable (like get up before 6AM) should not mark the habit as done today. 
;;I only cancel habits that repeat every day.
;;
;;My habit tasks look as follows - and I tend to have one in every org file that can have habits defined

;;	* Habits
;;	PROPERTIES:
;;	LOGGING:  DONE(!)
;;	ARCHIVE:  %s_archive::* Habits
;;	END:  


;;Auto Revert Mode
;;=================
;;I use git to synchronize my org-mode files between my laptop and my workstation. 
;;This normally requires saving all the current changes, pushing to a bare repo, and fetching on the other system. 
;;After that I need to revert all of my org-mode files to get the updated information.
;;
;;I used to use org-revert-all-org-buffers but have since discovered global-auto-revert-mode. 
;;With this setting any files that change on disk where there are no changes in the buffer automatically revert to the on-disk version.
;;
;;This is perfect for synchronizing my org-mode files between systems.
;;=------------------------------
(setq global-auto-revert-mode t)


;;Handling Encryption
;;====================
;;I used to keep my encrypted data like account passwords in a separate GPG encrypted file. 
;;Now I keep them in my org-mode files with a special tag instead. Encrypted data is kept in the org-mode file that it is associated with.
;;
;;org-crypt allows you to tag headings with a special tag crypt and org-mode can keep data in these headings encrypted when saved to disk.
;;You decrypt the heading temporarily when you need access to the data and org-mode re-encrypts the heading as soon as you save the file.
;;
;;I use the following setup for encryption:
;;=---------------------------------------
;;(add-to-list 'load-path (expand-file-name "~/zzcfg.d/orgcvs/zgpg4win"))
;;(require 'epa)
;;d(epa-file-enable)

(require 'org-crypt)
; Encrypt all entries before saving
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
; GPG key to use for encryption
(setq org-crypt-key "8905C5DC")


;;M-x org-decrypt-entry will prompt for the passphrase associated with your encryption key and 
;;replace the encrypted data where the point is with the plaintext details for your encrypted entry. 
;;As soon as you save the file the data is re-encrypted for your key. 
;;Encrypting does not require prompting for the passphrase - that's only for looking at the plain text version of the data.
;;
;;I tend to have a single level 1 encrypted entry per file (like * Passwords). 
;;I prevent the crypt tag from using inheritance so that I don't have encrypted data inside encrypted data. 
;;I found M-x org-decrypt-entries prompting for the passphrase to decrypt data over and over again (once per entry to decrypt) too inconvenient.
;;
;;I leave my entries encrypted unless I have to look up data - I decrypt on demand and then save the file again to re-encrypt the data. 
;;This keeps the data in plain text as short as possible.



;;Auto Save Files
;;================
;;Emacs temporarily saves your buffer in an autosave file while you are editing your org buffer and a sufficient number of changes have accumulated. 
;;If you have decrypted subtrees in your buffer these will be written to disk in plain text which possibly leaks sensitive information. 
;;To combat this org-mode now asks if you want to disable the autosave functionality in this buffer.
;;
;;Personally I really like the autosave feature. 
;;99% of the time my encrypted entries are perfectly safe to write to the autosave file since they are still encrypted. 
;;I tend to decrypt an entry, read the details for 
;;what I need to look up and then immediately save the file again with C-x C-s which re-encrypts the entry immediately. 
;;This pretty much guarantees that my autosave files never have decrypted data stored in them.
;;
;;I disable the default org crypt auto-save setting as follows:
;;=------------------------------------
(setq org-crypt-disable-auto-save nil)


;;Speed Commands
;;================
;;There's an exciting feature called org-speed-commands in the org-mode.
;;
;;Speed commands allow access to frequently used commands when on the beginning of a headline - similar to one-key agenda commands. 
;;Speed commands are user configurable and org-mode provides a good set of default commands.
;;
;;I have the following speed commands set up in addition to the defaults. 
;;I don't use priorities so I override the default settings for the 1, 2, and 3 keys. 
;;I also disable cycling with 'c' and add 'q' as a quick way to get back to the agenda and update the current view.
;;=--------------------------------------------------------
(setq org-use-speed-commands t)
(setq org-speed-commands-user (quote (("0" . ignore)
                                      ("1" . ignore)
                                      ("2" . ignore)
                                      ("3" . ignore)
                                      ("4" . ignore)
                                      ("5" . ignore)
                                      ("6" . ignore)
                                      ("7" . ignore)
                                      ("8" . ignore)
                                      ("9" . ignore)

                                      ("a" . ignore)
                                      ("d" . ignore)
                                      ("h" . bh/hide-other)
                                      ("i" progn
                                       (forward-char 1)
                                       (call-interactively 'org-insert-heading-respect-content))
                                      ("k" . org-kill-note-or-show-branches)
                                      ("l" . ignore)
                                      ("m" . ignore)
                                      ("q" . bh/show-org-agenda)
                                      ("r" . ignore)
                                      ("s" . org-save-all-org-buffers)
                                      ("w" . org-refile)
                                      ("x" . ignore)
                                      ("y" . ignore)
                                      ("z" . org-add-note)

                                      ("A" . ignore)
                                      ("B" . ignore)
                                      ("E" . ignore)
                                      ("F" . bh/restrict-to-file-or-follow)
                                      ("G" . ignore)
                                      ("H" . ignore)
                                      ("J" . org-clock-goto)
                                      ("K" . ignore)
                                      ("L" . ignore)
                                      ("M" . ignore)
                                      ("N" . bh/narrow-to-subtree)
                                      ("P" . bh/narrow-to-project)
                                      ("Q" . ignore)
                                      ("R" . ignore)
                                      ("S" . ignore)
                                      ("T" . bh/org-todo)
                                      ("U" . bh/narrow-up-one-level)
                                      ("V" . ignore)
                                      ("W" . bh/widen)
                                      ("X" . ignore)
                                      ("Y" . ignore)
                                      ("Z" . ignore))))

(defun bh/show-org-agenda ()
  (interactive)
  (switch-to-buffer "*Org Agenda*")
  (delete-other-windows))

;;The variable org-speed-commands-default sets a lot of useful defaults for speed command keys. 
;;The default keys I use the most are I and O for clocking in and out and t to change todo state.
;;
;;J jumps to the current or last clocking task.
;;
;;c and C are disabled so they self insert. I use TAB and S-TAB for cycling - I don't need c and C as well. 
;;TAB works everywhere while c and C only works on the headline and sometimes I accidentally cycle when I don't intend to.


;;Org Protocol
;;===============
;;Org protocol is a great way to create capture notes in org-mode from other applications. 
;;I use this to create tasks to review interesting web pages I visit in Firefox.
;;
;;I have a special capture template set up for org-protocol to use (set up with the w key).
;;
;;My org-mode setup for org-protocol is really simple. 
;;It enables org-protocol and creates a single org-protocol capture template as described in Capture Templates.
;;=---------------------
;;(server-start)
(require 'org-protocol)

;;
;;The bulk of the setup is in the Firefox application so that C-M-r on a page in Firefox 
;;will trigger the org-protocol capture template with details of the page I'm currently viewing in firefox.
;;
;;I set up org-protocol in firefox as described in Keybindings for Firefox.



;;Require A Final Newline When Saving Files
;;=========================================

;;The following setting was mainly for editing yasnippets where I want to be able to expand a snippet but stay on the same line.
;;I used this mainly for replacing short strings or initials with full names for people during meeting notes.
;;I now use abbrev-mode- for this and no longer need this setting.
;;=------------------------------
;;(setq require-final-newline nil)
;;
;;When I save a file in Emacs I want a final newline - this fits better with the source code projects I work on.
;;This is the setting I use now:
;;=-----------------------------
(setq require-final-newline t)


;;Insert Inactive Timestamps And Exclude From Export
;;==================================================
;;I insert inactive timestamps when working on org-mode files.
;;
;;For remember tasks the timestamp is in the remember template but for regular structure editing 
;;I want the timestamp automatically added when I create the headline.
;;
;;I have a function that is run by an org-mode hook to automatically insert the inactive timestamp whenever a headline is created.
;;=-------------------------------------
(defun bh/insert-inactive-timestamp ()
  (interactive)
  (org-insert-time-stamp nil t t nil nil nil))

(defun bh/insert-heading-inactive-timestamp ()
  (save-excursion
    (org-return)
    (org-cycle)
    (bh/insert-inactive-timestamp)))

(add-hook 'org-insert-heading-hook 'bh/insert-heading-inactive-timestamp 'append)


;;Everytime I create a heading with M-RET or M-S-RET the hook invokes the function and it inserts an inactive timestamp like this
;;
;;* <point here>
;;  [2009-11-22 Sun 18:45]
;;  
;;This keeps an automatic record of when tasks are created which I find very useful.


;;I also have a short cut key defined to invoke this function on demand so that I can insert the inactive timestamp anywhere on demand.
;;=---------------------------------------------------------
(global-set-key (kbd "<f9> t") 'bh/insert-inactive-timestamp)

;;To prevent the timestamps from being exported in documents I use the following setting
;;=----------------------------------
(setq org-export-with-timestamps nil)



;;Return Follows Links
;;======================
;;The following setting make RET insert a new line instead of opening links. 
;;This setting is a love-hate relationship for me. 
;;When it first came out I immediately turned it off because 
;;I wanted to insert new lines in front of my links and RET would open the link instead which at the time 
;;I found extremely annoying. Since then I've retrained my fingers to hit RET at the end of the previous line.
;;=----------------------------
(setq org-return-follows-link t)



;;Highlight Clock When Running Overtime
;;=====================================
;;The current clocking task is displayed on the modeline. 
;;If this has an estimated time and we run over the limit I make this stand out on the modeline by changing the background to red as follows
;;=------------------------------------------
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(org-mode-line-clock ((t (:foreground "red" :box (:line-width -1 :style released-button)))) t))



;;Meeting Notes
;;===============
;;I take meeting notes with org-mode. I record meeting conversations in point-form using org-mode lists. 
;;If action items are decided on in the meeting I'll denote them with a bullet and a TODO: or DONE: flag.
;;
;;A meeting is a task and it is complete when the meeting is over. The body of the task records all of the interesting meeting details. 
;;If TODO items are created in the meeting I make separate TODO tasks from those.
;;
;;I use the function bh/prepare-meeting-notes to prepare the meeting notes for emailing to the participants 
;;(in a fixed-width font like "Courier New"). 
;;As soon as the meeting is over the notes are basically ready for distribution – 
;;there's not need to waste lots of time rewriting the minutes before they go out. 
;;I haven't bothered with fancy HTML output – the content is more important than the style.
;;
;;* TODO Sample Meeting
;;  - Attendees
;;    - [ ] Joe
;;    - [X] Larry
;;    - [X] Mary
;;    - [X] Fred
;;  - Joe is on vacation this week
;;  - Status Updates
;;    + Larry
;;      - did this
;;      - and that
;;      - TODO: Needs to follow up on this
;;    + Mary
;;      - got a promotion for her recent efforts
;;    + Fred
;;      - completed all his tasks 2 days early
;;      - needs more work
;;      - DONE: everything 
;;
;;
;;* TODO Sample Meeting
;;   - Attendees
;;     - [ ] Joe
;;     - [X] Larry
;;     - [X] Mary
;;     - [X] Fred
;;   - Joe is on vacation this week
;;   - Status Updates
;;     + Larry
;;       - did this
;;       - and that
;;>>>>>>>> TODO: Needs to follow up on this
;;     + Mary
;;       - got a promotion for her recent efforts
;;     + Fred
;;       - completed all his tasks 2 days early
;;       - needs more work
;;>>>>>>>> DONE: everything  
;;
;;Here is the formatting function. 
;;Just highlight the region for the notes and it turns tabs into spaces, and highlights todo items.
;;The resulting notes are in the kill buffer ready to paste to another application.
;;=---------------------------------
(defun bh/prepare-meeting-notes ()
  "Prepare meeting notes for email
   Take selected region and convert tabs to spaces, mark TODOs with leading >>>, and copy to kill ring for pasting"
  (interactive)
  (let (prefix)
    (save-excursion
      (save-restriction
        (narrow-to-region (region-beginning) (region-end))
        (untabify (point-min) (point-max))
        (goto-char (point-min))
        (while (re-search-forward "^\\( *-\\\) \\(TODO\\|DONE\\): " (point-max) t)
          (replace-match (concat (make-string (length (match-string 1)) ?>) " " (match-string 2) ": ")))
        (goto-char (point-min))
        (kill-ring-save (point-min) (point-max))))))



;;Highlights Persist After Changes
;;==================================
;;I'm finding I use org-occur C-c / / a lot when trying to find details in my org-files. 
;;The following setting keeps the highlighted results of the search even after modifying the text. 
;;This allows me to edit the file without having to reissue the org-occur command to find the other matches in my file.
;;==--------------------------------------------
(setq org-remove-highlights-with-change nil)
;;
;;Setting this variable to t will automatically remove the yellow highlights as soon as the buffer is modified.



;;Getting Up To Date Org-Mode Info Documentation
;;===============================================
;;I use the org-mode info documentation from the git repository 
;;so I set up emacs to find the info files from git before the regular (out of date) system versions.
;;
;;(add-to-list 'Info-default-directory-list "~/git/org-mode/doc")



;;Prefer Future Dates Or Not?
;;============================
;;By default org-mode prefers dates in the future. 
;;This means that if today's date is May 2 and you enter a date for April 30th (2 days ago) org-mode will jump to April 30th of next year. 
;;I used to find this annoying when I wanted to look at what happened last Friday since I have to specify the year. 
;;Now I've trained my fingers to go back relatively in the agenda with b so this isn't really an issue for me anymore.
;;
;;To make org-mode prefer the current year when entering dates I set the following variable:
;;=------------------------------------
;;(setq org-read-date-prefer-future nil)

;;I now have this variable set to t.



;;Automatically Change List Bullets
;;=================================
;;I take point-form notes during meetings. 
;;Having the same list bullet for every list level makes it hard to read the details when lists are indented more than 3 levels.
;;
;;Org-mode has a way to automatically change the list bullets when you change list levels.
;;
;;	Current List Bullet	Next indented list bullet
;;	+			-
;;	*			-
;;	1.			-
;;	1)			-
;;=-----------------------------------------------------
(setq org-list-demote-modify-bullet (quote (("+" . "-")
                                            ("*" . "-")
                                            ("1." . "-")
                                            ("1)" . "-"))))



;;Remove Indentation On Agenda Tags View
;;=======================================
;;I don't like the indented view for sublevels on a tags match in the agenda but 
;;I want to see all matching tasks (including sublevels) when I do a agenda tag search (F12 m).
;;
;;To make all of the matched headings for a tag show at the same level in the agenda set the following variable:
;;=-----------------------------------
(setq org-tags-match-list-sublevels t)



;;Fontify Source Blocks Natively
;;================================
;;I use babel for including source blocks in my documents with
;;
;;	#+begin_src LANG
;;	  ...
;;	#+end_src
;;
;;where LANG specifies the language to use (ditaa, dot, sh, emacs-lisp, etc) 
;;This displays the language contents fontified in both the org-mode source buffer and the exported document.
;;
;;See this Git Repository synchronization in this document for an example..



;;Agenda Persistent Filters
;;==========================
;;This is a great feature! Persistent agenda filters means i
;;f you limit a search with / TAB SomeTag the agenda remembers this filter until you change it.
;;
;;Enable persistent filters with the following variable
;;=---------------------------------
(setq org-agenda-persistent-filter t)
;;
;;The current filter is displayed in the modeline as {+SomeTag} so you can easily see what filter currently applies to your agenda view.
;;
;;I use this with FILETAGS to limit the displayed results to a single client or context.



;;Add Tags For Flagged Entries
;;=============================
;;Everyone so often something will come along that is really important and you know you want to be able to find it back fast sometime in the future.
;;
;;For these types of notes and tasks I add a special :FLAGGED: tag. This tag gets a special fast-key ? 
;;which matches the search key in the agenda for flagged items. See Tags for the setup of org-tag-alist for the FLAGGED entry.
;;
;;Finding flagged entries is then simple - just F12 ? and you get them all.



;;Mail Links Open Compose-Mail
;;============================
;;The following setting makes org-mode open mailto: links using compose-mail.
;;=-----------------------------------------------------------
(setq org-link-mailto-program (quote (compose-mail "%a" "%s")))


;;Composing Mail From Org Mode Subtrees
;;=====================================
;;It's possible to create mail from an org-mode subtree. 
;;I use C-c M-o to start an email message with the details filled in from the current subtree. 
;;I use this for repeating reminder tasks where I need to send an email to someone else. 
;;The email contents are already contained in the org-mode subtree and all I need to do is C-c M-o and any minor edits before sending it off.



;;Use Smex For M-X Ido-Completion
;;==================================
;;I discovered smex for IDO-completion for M-x commands after reading a post of the org-mode mailing list.
;;I actually use M-x a lot now because IDO completion is so easy.
;;
;;Here's the smex setup I use
;;(add-to-list 'load-path (expand-file-name "~/zzcfg.d/my-org-addon/smex-20120301"))

(require 'smex)
(smex-initialize)

;;(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-a") 'smex)
(global-set-key (kbd "C-x x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)


;;Use Emacs Bookmarks For Fast Navigation
;;=======================================
;;I've started using emacs bookmarks to save a location and return to it easily. 
;;Normally I want to get back to my currently clocking task and that's easy - just hit F11. 
;;When I'm working down a long checklist I find it convenient to set a bookmark on the next item to check, 
;;then go away and work on it, and return to the checkbox to mark it done.
;;
;;I use Emacs bookmarks for this setup as follows:
;;
;;;; Bookmark handling
;;=---------------------------
(global-set-key (kbd "<C-f12>") '(lambda () (interactive) (bookmark-set "SAVED")))
(global-set-key (kbd "<f12>") '(lambda () (interactive) (bookmark-jump "SAVED")))

;;(global-set-key (kbd "<C-f6>") '(lambda () (interactive) (bookmark-set "SAVED")))
;;(global-set-key (kbd "<f6>") '(lambda () (interactive) (bookmark-jump "SAVED")))
;;
;;When I want to save the current location I just hit C-f6 and then I can return to it with f6 anytime. 
;;I overwrite the same bookmark each time I set a new position.




;;Using Org-Mime To Email
;;========================
;;I'm experimenting with sending mime mail from org. 
;;I've added C-c M=o key bindings in the org-mode-hook to generate mail from an org-mode subtree.
;;
;;(require 'org-mime)


;;Remove Multiple State Change Log Details From The Agenda
;;========================================================
;;I skip multiple timestamps for the same entry in the agenda view with the following setting.
;;=------------------------------------------------------
(setq org-agenda-skip-additional-timestamps-same-entry t)
;;
;;This removes the clutter of extra state change log details when multiple timestamps exist in a single entry.


;;Drop Old Style References In Tables
;;====================================
;;I drop the old A3/B4 style references from tables when editing with the following setting.

(setq org-table-use-standard-references (quote from))



;;Use System Settings For File-Application Selection
;;==================================================
;;To get consistent applications for opening tasks I set the org-file-apps variable as follows:
;;
(setq org-file-apps (quote ((auto-mode . emacs)
                            ("\\.mm\\'" . system)
                            ("\\.x?html?\\'" . system)
                            ("\\.pdf\\'" . system))))
;;
;;This uses the entries defined in my system mailcap settings when opening file extensions. 
;;This gives me consistent behaviour when opening an link to some HTML file with C-c C-o or when previewing an export.



;;Use The Current Window For The Agenda
;;=====================================
; Overwrite the current window with the agenda
(setq org-agenda-window-setup 'current-window)


;;Delete IDs When Cloning
;;========================
(setq org-clone-delete-id t)



;;Cycling Plain Lists
;;====================
;;Org mode can fold (cycle) plain lists.
;;
(setq org-cycle-include-plain-lists t)
;;
;;I find this setting useful when I have repeating tasks with lots of sublists with checkboxes. 
;;I can fold the completed list entries and focus on what is remaining easily.



;;Showing Source Block Syntax Highlighting
;;=========================================
;;It is possible to display org-mode source blocks fontified in their native mode. 
;;This allows colourization of keywords for C and shell script source etc. 
;;If I edit the source I use =C-c '= (control-c single quote) to bring up the source window 
;;which is then rendered with syntax highlighting in the native mode. 
;;This setting also shows the syntax highlighting when viewing in the org-mode buffer.
;;=------------------------------
(setq org-src-fontify-natively t)



;;Inserting Structure Template Blocks
;;====================================
;;There is a shortcut key sequence in org-mode to insert structure templates quickly into your org files.
;;
;;I use example and source blocks often in my org files.
;;
;;	Key Sequence	Expands to
;;	< s TAB		#+begin_src … #+end_src
;;	< e TAB		#+begin_example … #+end_example
;;	< m TAB		#+begin_src message … #+end_src
;;
;;I've added a block for saving email text which I copy from MS Outlook at work so I have context associated with my org-mode tasks.
;;
;;The following lisp makes the blocks lowercase instead of the default upper case in org-mode.
;;=------------------------------------
(setq org-structure-template-alist
      (quote (("s" "#+begin_src ?\n\n#+end_src" "<src lang=\"?\">\n\n</src>")
              ("e" "#+begin_example\n?\n#+end_example" "<example>\n?\n</example>")
              ("m" "#+begin_src message\n\n#+end_src" "<src lang=message>\n\n</src>")
              ("q" "#+begin_quote\n?\n#+end_quote" "<quote>\n?\n</quote>")
              ("v" "#+begin_verse\n?\n#+end_verse" "<verse>\n?\n</verse>")
              ("c" "#+begin_center\n?\n#+end_center" "<center>\n?\n</center>")
              ("l" "#+begin_latex\n?\n#+end_latex" "<literal style=\"latex\">\n?\n</literal>")
              ("L" "#+latex: " "<literal style=\"latex\">?</literal>")
              ("h" "#+begin_html\n?\n#+end_html" "<literal style=\"html\">\n?\n</literal>")
              ("H" "#+html: " "<literal style=\"html\">?</literal>")
              ("a" "#+begin_ascii\n?\n#+end_ascii")
              ("A" "#+ascii: ")
              ("i" "#+index: ?" "#+index: ?")
              ("I" "#+include %file ?" "<include file=%file markup=\"?\">"))))



;;NEXT Is For Tasks
;;===================
;;NEXT keywords are for tasks and not projects. 
;;I've added a function to the todo state change hook and clock in hook so that 
;;any parent tasks marked NEXT automagically change from NEXT to TODO since they are now projects and not tasks.

(defun bh/mark-next-parent-tasks-todo ()
  "Visit each parent task and change NEXT states to TODO"
  (let ((mystate (or (and (fboundp 'state)
                          state)
                     (nth 2 (org-heading-components)))))
    (when (equal mystate "NEXT")
      (save-excursion
        (while (org-up-heading-safe)
          (when (member (nth 2 (org-heading-components)) (list "NEXT"))
            (org-todo "TODO")))))))

(add-hook 'org-after-todo-state-change-hook 'bh/mark-next-parent-tasks-todo 'append)
(add-hook 'org-clock-in-hook 'bh/mark-next-parent-tasks-todo 'append)



;;Startup In Content View
;;========================
;;Startup in content view. 
;;This allows us to quickly visit all archive tasks in follow mode to check that we want to archive everything in the list before we archive anything.

(setq org-startup-folded 'content)



;;Allow Alphabetical List Entries
;;================================
;;The following setting adds alphabetical lists like
;;
;;	a. item one
;;	b. item two

(setq org-alphabetical-lists t)



;;Using Orgstruct Mode For Mail
;;==============================
;;orgstruct++-mode is enabled in Gnus message buffers to aid in creating structured email messages.
;;
;;(add-hook 'message-mode-hook 'orgstruct++-mode 'append)
;;(add-hook 'message-mode-hook 'turn-on-auto-fill 'append)
;;(add-hook 'message-mode-hook 'bbdb-define-all-aliases 'append)
;;(add-hook 'message-mode-hook 'orgtbl-mode 'append)
;;(add-hook 'message-mode-hook 'turn-on-flyspell 'append)
;;(add-hook 'message-mode-hook
;;          '(lambda () (setq fill-column 72))
;;          'append)
;;(add-hook 'message-mode-hook
;;          '(lambda () (local-set-key (kbd "C-c M-o") 'org-mime-htmlize))
;;          'append)




;;Using Flyspell Mode To Reduce Spelling Errors
;;==============================================
;;flyspell-mode is enabled for almost everything to help prevent creating documents with spelling errors.
;;
;;;; flyspell mode for spell checking everywhere
;;(add-hook 'org-mode-hook 'turn-on-flyspell 'append)
;;
;;;; Disable C-c [ and C-c ] and C-c ; in org-mode
;;(add-hook 'org-mode-hook
;;          '(lambda ()
;;             ;; Undefine C-c [ and C-c ] since this breaks my
;;             ;; org-agenda files when directories are include It
;;             ;; expands the files in the directories individually
;;             (org-defkey org-mode-map "\C-c["    'undefined)
;;             (org-defkey org-mode-map "\C-c]"    'undefined)
;;             (org-defkey org-mode-map "\C-c;"    'undefined))
;;          'append)
;;
;;(add-hook 'org-mode-hook
;;          (lambda ()
;;            (local-set-key (kbd "C-c M-o") 'bh/mail-subtree))
;;          'append)
;;
;;(defun bh/mail-subtree ()
;;  (interactive)
;;  (org-mark-subtree)
;;  (org-mime-subtree))



;;Task Priorities
;;================
;;I use the agenda to figure out what to do work on next. 
;;I don't use priorities at all normally but at work I occasionally get priorities from my manager. 
;;In this case I mark my tasks with the priorities from the external source just to track the values 
;;and force the agenda to display tasks in the priority order.
;;
;;I disable the priority setting keys in org-mode using

(setq org-enable-priority-commands t)
(setq org-default-priority ?E)
(setq org-lowest-priority ?E)



;;New Exporter
;;=============
;;The current export engine invoked with C-c C-e is going to be replaced with a new system soon. 
;;I have the following settings so I can invoke the new exporter to see how it behaves compared to the existing one.

;;(setq org-e-html-inline-images t)
;;;;(setq org-export-html-style-extra "<link rel=\"stylesheet\" href=\"http://doc.norang.ca/org.css\" type=\"text/css\" />")
;;;;(setq org-e-html-style-extra "<link rel=\"stylesheet\" href=\"http://doc.norang.ca/org.css\" type=\"text/css\" />")
;;(setq org-export-html-style-extra "<link rel=\"stylesheet\" href=\"~/orgcvs/zcss/org.css\" type=\"text/css\" />")
;;(setq org-e-html-style-extra "<link rel=\"stylesheet\" href=\"~/orgcvs/zcss/org.css\" type=\"text/css\" />")
;;(setq org-e-html-style-include-default nil)
;;(setq org-e-html-xml-declaration
;;      (quote
;;       (("was-html" . "")
;;        ("html" . "<?xml version=\"1.0\" encoding=\"%s\"?>")
;;        ("php" . "<?php echo \"<?xml version=\\\"1.0\\\" encoding=\\\"%s\\\" ?>\"; ?>"))))
;;(setq org-e-latex-listings t)
;;(setq org-e-html-style-include-scripts nil)
;;(setq org-e-html-validation-link nil)
;;
;;(setq org-export-coding-system 'utf-8)
;;
;;(require 'org-export)



;;Preserving Source Block Indentation
;;=====================================
;;I do not preserve indentation for source blocks mainly because this doesn't look nice with indented org-files. 
;;The only reason I've found to preserve indentation is when TABs in files need to be preserved (e.g. Makefiles). 
;;I don't normally edit these files in org-mode so I leave this setting turned off.
;;
;;I've changed the default block indentation so that it is not indented from the text in the org file. 
;;This allows editing source blocks in place without requiring use of =C-c '= so that code lines up correctly.
;;=-------------------------------------
(setq org-src-preserve-indentation nil)
(setq org-edit-src-content-indentation 0)



;;Prevent Editing Invisible Text
;;===============================
;;The following setting prevents accidentally editing hidden text when the point is inside a folded region. 
;;This can happen if you are in the body of a heading and globally fold the org-file with S-TAB
;;
;;I find invisible edits (and undo's) hard to deal with so now I can't edit invisible text. 
;;C-c C-r (org-reveal) will display where the point is if it is buried in invisible text to allow editing again.
;;=--------------------------------------
(setq org-catch-invisible-edits 'error)



;----------------------------------------------------------------
;Using Git For Automatic History, Backups, And Synchronization
;----------------------------------------------------------------
;;Editing folded regions of your org-mode file can be hazardous to your data. 
;;My method for dealing with this is to put my org files in a Git source repository.
;;
;;My setup saves all of my org-files every hour and creates a commit with my changes automatically. 
;;This lets me go back in time and view the state of my org files for any given hour over the lifetime of the document. 
;;I've used this once or twice to recover data I accidentally removed while editing folded regions.

;;Automatic Hourly Commits
;;========================
;;My Emacs setup saves all org buffers at 1 minute before the hour using the following code in my .emacs
;;
(run-at-time "00:59" 3600 'org-save-all-org-buffers)
;;
;;A cron job runs at the top of the hour to commit any changes just saved by the call to org-save-all-org-buffers above. 
;;I use a script to create the commits so that I can run it on demand to easily commit all modified work when moving from one machine to another.

;;	crontab details:
;;
;;	0 * * * * ~/bin/org-git-sync.sh >/dev/null



;;~/Bin/Org-Git-Sync.Sh
;;======================
;;Here is the shell script I use to create a git commit for each of my org-repositories. 
;;This loops through multiple repositories and commits any modified files. I have the following org-mode repositories:
;;
;;	org
;;	for all of my organization project files and todo lists
;;
;;	doc-norang.ca
;;	for any changes to documents under http://doc.norang.ca/
;;
;;	www.norang.ca
;;	for any changes to my other website http://www.norang.ca/
;;
;;This script does not create empty commits - git only creates a commit if something was modified.

;;	#!/bin/sh
;;	# Add org file changes to the repository
;;	REPOS="org doc.norang.ca www.norang.ca"
;;
;;	for REPO in $REPOS
;;	do
;;	    echo "Repository: $REPO"
;;	    cd ~/git/$REPO
;;	    # Remove deleted files
;;	    git ls-files --deleted -z | xargs -0 git rm >/dev/null 2>&1
;;	    # Add new files
;;	    git add . >/dev/null 2>&1
;;	    git commit -m "$(date)"
;;	done



;;I use the following .gitignore file in my org-mode git repositories to keep export generated files out of my git repositories. 
;;If I include a graphic from some other source than ditaa or graphviz then I'll add it to the repository manually. 
;;By default all PNG graphic files are ignored (since I assume they are produced by ditaa during export)
;;
;;	core
;;	core.*
;;	*.html
;;	*~
;;	.#*
;;	\#*\#
;;	*.txt
;;	*.tex
;;	*.aux
;;	*.dvi
;;	*.log
;;	*.out
;;	*.ics
;;	*.pdf
;;	*.xml
;;	*.org-source
;;	*.png
;;	*.toc



;;Git - Edit Files With Confidence
;;=================================
;;I use git in all of my directories where editing a file should be tracked.
;;
;;This means I can edit files with confidence. I'm free to change stuff and break things because it won't matter. 
;;It's easy to go back to a previous working version or to see exactly what changed since the last commit. 
;;This is great when editing configuration files (such as apache webserver, bind9 DNS configurations, etc.)
;;
;;I find this extremely useful where your edits might break things and having git tracking the changes means 
;;if you break it you can just go back to the previous working version easily.
;;This is also true for package upgrades for software where the upgrade modifies the configuration files.
;;
;;I have every version of my edits in a local git repository.


;;Git Repository Synchronization
;;===============================
;;I acquired a Eee PC 1000 HE which now serves as my main road-warrior laptop replacing my 6 year old Toshiba Tecra S1.
;;
;;I have a server on my LAN that hosts bare git repositories for all of my projects. 
;;The problem I was facing is I have to leave in 5 minutes and want to make sure I have up-to-date copies of everything I work on 
;;when I take it on the road (without Internet access).
;;
;;To solve this I use a server with bare git repositories on it. 
;;This includes my org-mode repositories as well as any other git repositories I'm interested in.
;;
;;Just before I leave I run the git-sync script on my workstation to update the bare git repositories and 
;;then I run it again on my Eee PC to update all my local repositories on the laptop. 
;;For any repositories that give errors due to non-fast-forward merges I manually merge as required and rerun git-sync until it reports no errors. 
;;This normally takes a minute to two to do. Then I grab my Eee PC and leave. 
;;When I'm on the road I have full up-to-date history of all my git repositories.
;;
;;The git-sync script replaces my previous scripts with an all-in-one tool that basically does this:
;;
;;	for each repository on the current system
;;		fetch objects from the remote
;;		for each branch that tracks a remote branch
;;			Check if the ref can be moved
;;				fast-forwards if behind the remote repository and is fast-forwardable
;;				Does nothing if ref is up to date
;;				Pushes ref to remote repository if ref is ahead of remote repository and fast-forwardable
;;				Fails if ref and remote have diverged
;;
;;This automatically advances changes on my 35+ git repositories with minimal manual intervention. 
;;The only time I need to manually do something in a repository is when I make changes on my Eee PC and my workstation at the same time - 
;;so that a merge is required.
;;
;;Here is the git-sync script
;;=----------------------------
;;	#!/bin/sh
;;	#
;;
;;	# Local bare repository name
;;	syncrepo=norang
;;	reporoot=~/git
;;
;;	# Display repository name only once
;;	log_repo() {
;;	  [ "x$lastrepo" == "x$repo" ] || {
;;	    printf "\nREPO: ${repo}\n"
;;	    lastrepo="$repo"
;;	  }
;;	}
;;
;;	# Log a message for a repository
;;	log_msg() {
;;	  log_repo
;;	  printf "  $1\n"
;;	}
;;
;;	# fast-forward reference $1 to $syncrepo/$1
;;	fast_forward_ref() {
;;	  log_msg "fast-forwarding ref $1"
;;	  current_ref=$(cat .git/HEAD)
;;	  if [ "x$current_ref" = "xref: refs/heads/$1" ]
;;	  then
;;	    # Check for dirty index
;;	    files=$(git diff-index --name-only HEAD --)
;;	    git merge refs/remotes/$syncrepo/$1
;;	  else
;;	    git branch -f $1 refs/remotes/$syncrepo/$1
;;	  fi
;;	}
;;
;;	# Push reference $1 to $syncrepo
;;	push_ref() {
;;	  log_msg "Pushing ref $1"
;;	  if ! git push --tags $syncrepo $1
;;	  then
;;	    exit 1
;;	  fi
;;	}
;;
;;	# Check if a ref can be moved
;;	#   - fast-forwards if behind the sync repo and is fast-forwardable
;;	#   - Does nothing if ref is up to date
;;	#   - Pushes ref to $syncrepo if ref is ahead of syncrepo and fastforwardable
;;	#   - Fails if ref and $syncrop/ref have diverged
;;	check_ref() {
;;	  revlist1=$(git rev-list refs/remotes/$syncrepo/$1..$1)
;;	  revlist2=$(git rev-list $1..refs/remotes/$syncrepo/$1)
;;	  if [ "x$revlist1" = "x" -a "x$revlist2" = "x" ]
;;	  then
;;	    # Ref $1 is up to date.
;;	    :
;;	  elif [ "x$revlist1" = "x" ]
;;	  then
;;	    # Ref $1 is behind $syncrepo/$1 and can be fast-forwarded.
;;	    fast_forward_ref $1 || exit 1
;;	  elif [ "x$revlist2" = "x" ]
;;	  then
;;	    # Ref $1 is ahead of $syncrepo/$1 and can be pushed.
;;	    push_ref $1 || exit 1
;;	  else
;;	    log_msg "Ref $1 and $syncrepo/$1 have diverged."
;;	    exit 1
;;	  fi
;;	}
;;
;;	# Check all local refs with matching refs in the $syncrepo
;;	check_refs () {
;;	  git for-each-ref refs/heads/* | while read sha1 commit ref
;;	  do
;;	    ref=${ref/refs\/heads\//}
;;	    git for-each-ref refs/remotes/$syncrepo/$ref | while read sha2 commit ref2
;;	    do
;;	      if [ "x$sha2" != "x" -a "x$sha2" != "x" ]
;;	      then
;;		check_ref $ref || exit 1
;;	      fi
;;	    done
;;	  done
;;	}
;;
;;	# For all repositories under $reporoot
;;	#   Check all refs matching $syncrepo and fast-forward, or push as necessary
;;	#   to synchronize the ref with $syncrepo
;;	#   Bail out if ref is not fastforwardable so user can fix and rerun
;;	time {
;;	  retval=0
;;	  if find $reporoot -type d -name '*.git' | { 
;;	      while read repo
;;	      do
;;		repo=${repo/\/.git/}
;;		cd ${repo}
;;		upd=$(git remote update $syncrepo 2>&1 || retval=1)
;;		[ "x$upd" = "xFetching $syncrepo" ] || {
;;		  log_repo
;;		  printf "$upd\n"
;;		}
;;		check_refs || retval=1
;;	      done
;;	      exit $retval
;;	    }
;;	  then
;;	    printf "\nAll done.\n"
;;	  else
;;	    printf "\nFix and redo.\n"
;;	  fi
;;	}
;;
;;	exit $retval




;--------------------------
;来自init-my-orgmode的设置
;--------------------------

;;Publishing all together
;;========================
;; publish all together with C-c C-e E
(setq org-publish-project-alist
           '(("org"
              :base-directory "~/orgcvs/"
			  :base-extension "org"
              :publishing-directory "~/orgcvs/pub"
			  :style "<link rel=stylesheet
|                      href=\"~/orgcvs/zcss/org.css\"
|                      type=\"text/css\">"
;;              :section-numbers nil
              :table-of-contents t
                                      )))



;;Org Exporting
;;===============
;;org-export-as-html-and-open
(setq org-export-html-style
     "<link rel=\"stylesheet\" type=\"text/css\" href=\"~/orgcvs/zcss/org.css\" />")



;;Org-capture short key
;;======================
(define-key global-map "\M-m" 'org-capture-finalize)
;(define-key org-capture-mode-map "\C-c\C-k" 'org-capture-kill)
;(define-key org-capture-mode-map "\C-c\C-w" 'org-capture-refile)




;;org-export ical
;;================
;;; define categories that should be excluded
(setq org-export-exclude-category (list "google" "private"))

;;; define filter. The filter is called on each entry in the agenda.
;;; It defines a regexp to search for two timestamps, gets the start
;;; and end point of the entry and does a regexp search. It also
;;; checks if the category of the entry is in an exclude list and
;;; returns either t or nil to skip or include the entry.

(defun org-mycal-export-limit ()
  "Limit the export to items that have a date, time and a range. Also exclude certain categories."
  (setq org-tst-regexp "<\\([0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\} ... [0-9]\\{2\\}:[0-9]\\{2\\}[^\r\n>]*?\
\)>")
  (setq org-tstr-regexp (concat org-tst-regexp "--?-?" org-tst-regexp))
  (save-excursion
    ; get categories
    (setq mycategory (org-get-category))
    ; get start and end of tree
    (org-back-to-heading t)
    (setq mystart    (point))
    (org-end-of-subtree)
    (setq myend      (point))
    (goto-char mystart)
    ; search for timerange
    (setq myresult (re-search-forward org-tstr-regexp myend t))
    ; search for categories to exclude
    (setq mycatp (member mycategory org-export-exclude-category))
    ; return t if ok, nil when not ok
    (if (and myresult (not mycatp)) t nil)))

;;; activate filter and call export function
(defun org-mycal-export () 
  (let ((org-icalendar-verify-function 'org-mycal-export-limit))
    (org-export-icalendar-combine-agenda-files)))

(setq org-icalendar-use-scheduled '(todo-start event-if-todo))




;; Warning Warning: ad-Orig-kill-region called with 3 arguments, but accepts only 2
;;=------------------------------------
(ad-deactivate 'kill-region)


(provide 'my-init-orgmode)