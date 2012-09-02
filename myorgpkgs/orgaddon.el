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
;;;Ryan's org specific tab completion                                                                        
(defun ryan-org-tab ()
  ; Try the following:                                                                                         
  ; 1) Do a yasnippet expansion                                                                                
  ; 2) Do a Rope code completion                                                                               
  ; 3) Do an indent                                                                                            
  (interactive)
  (if (eql (ac-start) 0)
      (indent-for-tab-command)))

(defadvice ac-start (before advice-turn-on-auto-start activate)
  (set (make-local-variable 'ac-auto-start) t))
(defadvice ac-cleanup (after advice-turn-off-auto-start activate)
  (set (make-local-variable 'ac-auto-start) nil))

(define-key org-mode-map "\t" 'ryan-org-tab)
;;(org-defkey org-mode-map "\t" 'ryan-org-tab)


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



(provide 'orgaddon)