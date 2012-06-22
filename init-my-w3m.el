;--------------------
;w3m cfg
;--------------------
(autoload 'w3m "w3m" "Interface for w3m on Emacs." t)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
(autoload 'w3m-search "w3m-search" "Search words using emacs-w3m." t)

(setq browse-url-browser-function 'w3m-browse-url)

(provide 'init-my-w3m)
