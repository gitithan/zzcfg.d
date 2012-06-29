;(setq slime-lisp-implementations
;'((clisp ("c:/home/bin/clisp/full/lisp.exe" "-B" "c:/home/bin/clisp/full" "-M" "c:/home/bin/clisp/full/lispinit.mem" "-ansi" "-q"))
;(sbcl ("C:/home/bin/sbcl/sbcl.exe"))
;(ccl ("C:/home/bin/ccl/wx86cl.exe"))
;))

(eval-after-load 'slime
  '(progn
     (add-to-list 'slime-lisp-implementations
		  '(clisp ("c:/home/bin/clisp/full/lisp.exe" "-B" "c:/home/bin/clisp/full" "-M" "c:/home/bin/clisp/full/lispinit.mem" "-ansi" "-q") :coding-system utf-8-unix))
     (add-to-list 'slime-lisp-implementations
		  '(sbcl ("C:/home/bin/sbcl/sbcl.exe") :coding-system utf-8-unix))
     (add-to-list 'slime-lisp-implementations
		  '(ccl ("C:/home/bin/ccl/wx86cl.exe") :coding-system utf-8-unix))))

(require 'slime-autoloads)
;(require 'slime)
;(slime-setup '(slime-fancy))



(provide 'init-my-slime)