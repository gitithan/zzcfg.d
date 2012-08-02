;(add-to-list 'load-path "(path-to)/Enhanced-Ruby-Mode") ; must be added after any path containing old ruby-mode
;(setq enh-ruby-program "(path-to-ruby1.9.3)/bin/ruby") ; so that still works if ruby points to ruby1.8
(require 'ruby-mode)

(provide 'init-my-ehc_ruby_mode)