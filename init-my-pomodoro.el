;; Emacs macro to add a pomodoro item
(fset 'pomodoro
   "[ ]")
 
;; Emacs macro to add a pomodoro table
;;
;; | G | Organization | [ ] |
;; |   |              |     |
(fset 'pomodoro-table
   [?| ?  ?G ?  ?| ?  ?O ?r ?g ?a ?n ?i ?z ?a ?t ?i ?o ?n ?  ?| ?  ?\[ ?  ?\] ?  ?| tab])

(provide 'init-my-pomodoro)