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



;----------------
;test for yasnippet-ac-indet
;---------------
;;-slfm-;;;;;Ryan's org specific tab completion                                                                        
;;-slfm-;;(defun ryan-org-tab ()
;;-slfm-;;  ; Try the following:                                                                                         
;;-slfm-;;  ; 1) Do a yasnippet expansion                                                                                
;;-slfm-;;  ; 2) Do a Rope code completion                                                                               
;;-slfm-;;  ; 3) Do an indent                                                                                            
;;-slfm-;;  (interactive)
;;-slfm-;;  (if (eql (ac-start) 0)
;;-slfm-;;      (indent-for-tab-command)))
;;-slfm-;;
;;-slfm-;;(defadvice ac-start (before advice-turn-on-auto-start activate)
;;-slfm-;;  (set (make-local-variable 'ac-auto-start) t))
;;-slfm-;;(defadvice ac-cleanup (after advice-turn-off-auto-start activate)
;;-slfm-;;  (set (make-local-variable 'ac-auto-start) nil))
;;-slfm-;;
;;-slfm-;;(define-key org-mode-map "\t" 'ryan-org-tab)
;;-slfm-;;;;(org-defkey org-mode-map "\t" 'ryan-org-tab)



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
;;(epa-file-enable)

(require 'org-crypt)
; Encrypt all entries before saving
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
; GPG key to use for encryption
(setq org-crypt-key "8905C5DC")

;;Auto Save Files
;;================
(setq org-crypt-disable-auto-save nil)



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



;;Handling Blank Lines
;;=====================
;;Blank lines are evil :). They keep getting inserted in between headlines and I don't want to see them in collapsed (contents) views. 
;;When I use TAB to fold (cycle) tasks I don't want to see any blank lines between headings.
;;
;;The following setting hides blank lines between headings which keeps folded view nice and compact.
;;=-----------------------------------
(setq org-cycle-separator-lines 0)



;;I find extra blank lines in lists and headings a bit of a nuisance.
;;To get a body after a list you need to include a blank line between the list entry and the body иC and indent the body appropriately. 
;;Most of my lists have no body detail so I like the look of collapsed lists with no blank lines better.
;;
;;The following setting prevents creating blank lines before headings but allows list items to adapt to existing blank lines around the items:
;;=--------------------
(setq org-blank-before-new-entry (quote ((heading)
                                         (plain-list-item . auto))))



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



; Use the current window for C-c ' source editing
;===============================================
(setq org-src-window-setup 'current-window)



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



;;Highlight Clock When Running Overtime
;;=====================================
;;The current clocking task is displayed on the modeline. 
;;If this has an estimated time and we run over the limit I make this stand out on the modeline by changing the background to red as follows
;;=------------------------------------------
;;-slfm-;;(custom-set-faces
;;-slfm-;;  ;; custom-set-faces was added by Custom.
;;-slfm-;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;-slfm-;;  ;; Your init file should contain only one such instance.
;;-slfm-;;  ;; If there is more than one, they won't work right.
;;-slfm-;; '(org-mode-line-clock ((t (:foreground "red" :box (:line-width -1 :style released-button)))) t))



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



;;Inserting Structure Template Blocks
;;====================================
;;There is a shortcut key sequence in org-mode to insert structure templates quickly into your org files.
;;
;;I use example and source blocks often in my org files.
;;
;;	Key Sequence	Expands to
;;	< s TAB		#+begin_src бн #+end_src
;;	< e TAB		#+begin_example бн #+end_example
;;	< m TAB		#+begin_src message бн #+end_src
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



;; Don't enable this because it breaks access to emacs from my Android phone
;;========================
(setq org-startup-with-inline-images nil)



;;Miscellaneous Export Settings
;;=============================
;;This is a collection of export and publishing related settings that I use.

;;Fontify Latex Listings For Source Blocks
;;For export to latex I use the following setting to get fontified listings from source blocks:
;;=--------------------------------
(setq org-export-latex-listings t)



;;Allow Binding Variables On Export Without Confirmation
;;=------------------------------------------------------
;;The following setting allows #+BIND: variables to be set on export without confirmation. 
;;In rare situations where I want to override some org-mode variable for export this allows exporting the document without a prompt.
;;=-----------------------------
(setq org-export-allow-BIND t)



; Use IDO for both buffer and file completion and ido-everywhere to t
;;===================================================================
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode (quote both))



;; Compact the block agenda view
;;============= More narrow agenda views ========
(setq org-agenda-compact-blocks t)



;;Org-mode alist
;;===============
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))



(provide 'orgaddon)