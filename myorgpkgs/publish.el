;;-no-config-;;;; Configuration for publishing of org-mode files.
;;-no-config-;;
;;-no-config-;;;; Experimenting with docbook exports - not finished
;;-no-config-;;(setq org-export-docbook-xsl-fo-proc-command "fop %s %s")
;;-no-config-;;(setq org-export-docbook-xslt-proc-command
;;-no-config-;;      "xsltproc --output %s /usr/share/xml/docbook/stylesheet/nwalsh/fo/docbook.xsl %s")
;;-no-config-;;
;;-no-config-;;;; Inline images in HTML instead of producting links to the image
;;-no-config-;;(setq org-export-html-inline-images t)
;;-no-config-;;
;;-no-config-;;;; Do not use sub or superscripts. I currently don't need this
;;-no-config-;;;; functionality in my documents
;;-no-config-;;(setq org-export-with-sub-superscripts nil)
;;-no-config-;;
;;-no-config-;;;; Use org.css from the norang website for export document stylesheets
;;-no-config-;;(setq org-export-html-style-extra
;;-no-config-;;      "<link rel=\"stylesheet\" href=\"http://doc.norang.ca/org.css\" type=\"text/css\" />")
;;-no-config-;;(setq org-export-html-style-include-default nil)
;;-no-config-;;
;;-no-config-;;;; Do not generate internal css formatting for HTML exports
;;-no-config-;;(setq org-export-htmlize-output-type (quote css))
;;-no-config-;;
;;-no-config-;;;; I use the following setting to remove the xml header line for HTML
;;-no-config-;;;; exports. This xml line was confusing Open Office when opening the
;;-no-config-;;;; HTML to convert to ODT.
;;-no-config-;;(setq org-export-html-xml-declaration
;;-no-config-;;      (quote (("html" . "")
;;-no-config-;;              ("was-html" . "<?xml version=\"1.0\" encoding=\"%s\"?>")
;;-no-config-;;              ("php" . "<?php echo \"<?xml version=\\\"1.0\\\" encoding=\\\"%s\\\" ?>\"; ?>"))))
;;-no-config-;;
;;-no-config-;;;; Export with LaTeX fragments
;;-no-config-;;(setq org-export-with-LaTeX-fragments t)
;;-no-config-;;
;;-no-config-;;(setq org-export-latex-listings t)
;;-no-config-;;
;;-no-config-;;;; Org-mode can export tables as TAB or comma delimited formats. Set
;;-no-config-;;;; the default format to CSV.
;;-no-config-;;(setq org-table-export-default-format "orgtbl-to-csv")
;;-no-config-;;
;;-no-config-;;;; Prevent the timestamps from being exported in documents.
;;-no-config-;;(setq org-export-with-timestamps nil)
;;-no-config-;;
;;-no-config-;;;; The following setting allows #+BIND: variables to be set on export
;;-no-config-;;;; without confirmation. In rare situations where I want to override
;;-no-config-;;;; some org-mode variable for export this allows exporting the document
;;-no-config-;;;; without a prompt.
;;-no-config-;;(setq org-export-allow-BIND t)
;;-no-config-;;
;;-no-config-;;;; List of projects
;;-no-config-;;;; norang       - http://www.norang.ca/
;;-no-config-;;;; doc          - http://doc.norang.ca/
;;-no-config-;;;; org-mode-doc - http://doc.norang.ca/org-mode.html and associated files
;;-no-config-;;;; org          - miscellaneous todo lists for publishing
;;-no-config-;;(setq org-publish-project-alist
;;-no-config-;;      ;
;;-no-config-;;      ; http://www.norang.ca/  (norang website)
;;-no-config-;;      ; norang-org are the org-files that generate the content
;;-no-config-;;      ; norang-extra are images and css files that need to be included
;;-no-config-;;      ; norang is the top-level project that gets published
;;-no-config-;;      (quote (("norang-org"
;;-no-config-;;               :base-directory "~/git/www.norang.ca"
;;-no-config-;;               :publishing-directory "/ssh:www-data@www:~/www.norang.ca/htdocs"
;;-no-config-;;               :recursive t
;;-no-config-;;               :table-of-contents nil
;;-no-config-;;               :base-extension "org"
;;-no-config-;;               :publishing-function org-publish-org-to-html
;;-no-config-;;               :style-include-default nil
;;-no-config-;;               :section-numbers nil
;;-no-config-;;               :table-of-contents nil
;;-no-config-;;               :style "<link rel=\"stylesheet\" href=\"norang.css\" type=\"text/css\" />"
;;-no-config-;;               :author-info nil
;;-no-config-;;               :creator-info nil)
;;-no-config-;;              ("norang-extra"
;;-no-config-;;               :base-directory "~/git/www.norang.ca/"
;;-no-config-;;               :publishing-directory "/ssh:www-data@www:~/www.norang.ca/htdocs"
;;-no-config-;;               :base-extension "css\\|pdf\\|png\\|jpg\\|gif"
;;-no-config-;;               :publishing-function org-publish-attachment
;;-no-config-;;               :recursive t
;;-no-config-;;               :author nil)
;;-no-config-;;              ("norang"
;;-no-config-;;               :components ("norang-org" "norang-extra"))
;;-no-config-;;              ;
;;-no-config-;;              ; http://doc.norang.ca/  (norang website)
;;-no-config-;;              ; doc-org are the org-files that generate the content
;;-no-config-;;              ; doc-extra are images and css files that need to be included
;;-no-config-;;              ; doc is the top-level project that gets published
;;-no-config-;;              ("doc-org"
;;-no-config-;;               :base-directory "~/git/doc.norang.ca/"
;;-no-config-;;               :publishing-directory "/ssh:www-data@www:~/doc.norang.ca/htdocs"
;;-no-config-;;               :recursive nil
;;-no-config-;;               :section-numbers nil
;;-no-config-;;               :table-of-contents nil
;;-no-config-;;               :base-extension "org"
;;-no-config-;;               :publishing-function (org-publish-org-to-html org-publish-org-to-org)
;;-no-config-;;               :style-include-default nil
;;-no-config-;;               :style "<link rel=\"stylesheet\" href=\"/org.css\" type=\"text/css\" />"
;;-no-config-;;               :author-info nil
;;-no-config-;;               :creator-info nil)
;;-no-config-;;              ("doc-extra"
;;-no-config-;;               :base-directory "~/git/doc.norang.ca/"
;;-no-config-;;               :publishing-directory "/ssh:www-data@www:~/doc.norang.ca/htdocs"
;;-no-config-;;               :base-extension "css\\|pdf\\|png\\|jpg\\|gif"
;;-no-config-;;               :publishing-function org-publish-attachment
;;-no-config-;;               :recursive nil
;;-no-config-;;               :author nil)
;;-no-config-;;              ("doc"
;;-no-config-;;               :components ("doc-org" "doc-extra"))
;;-no-config-;;              ("doc-private-org"
;;-no-config-;;               :base-directory "~/git/doc.norang.ca/private"
;;-no-config-;;               :publishing-directory "/ssh:www-data@www:~/doc.norang.ca/htdocs/private"
;;-no-config-;;               :recursive nil
;;-no-config-;;               :section-numbers nil
;;-no-config-;;               :table-of-contents nil
;;-no-config-;;               :base-extension "org"
;;-no-config-;;               :publishing-function (org-publish-org-to-html
;;-no-config-;;                                     org-publish-org-to-org)
;;-no-config-;;               :style-include-default nil
;;-no-config-;;               :style "<link rel=\"stylesheet\" href=\"/org.css\" type=\"text/css\" />"
;;-no-config-;;               :auto-sitemap t
;;-no-config-;;               :sitemap-filename "index.html"
;;-no-config-;;               :sitemap-title "Norang Private Documents"
;;-no-config-;;               :sitemap-style "tree"
;;-no-config-;;               :author-info nil
;;-no-config-;;               :creator-info nil)
;;-no-config-;;              ("doc-private-extra"
;;-no-config-;;               :base-directory "~/git/doc.norang.ca/private"
;;-no-config-;;               :publishing-directory "/ssh:www-data@www:~/doc.norang.ca/htdocs/private"
;;-no-config-;;               :base-extension "css\\|pdf\\|png\\|jpg\\|gif"
;;-no-config-;;               :publishing-function org-publish-attachment
;;-no-config-;;               :recursive nil
;;-no-config-;;               :author nil)
;;-no-config-;;              ("doc-private"
;;-no-config-;;               :components ("doc-private-org" "doc-private-extra"))
;;-no-config-;;              ;
;;-no-config-;;              ; Miscellaneous pages for other websites
;;-no-config-;;              ; org are the org-files that generate the content
;;-no-config-;;              ("org-org"
;;-no-config-;;               :base-directory "~/git/org/"
;;-no-config-;;               :publishing-directory "/ssh:www-data@www:~/org"
;;-no-config-;;               :recursive t
;;-no-config-;;               :section-numbers nil
;;-no-config-;;               :table-of-contents nil
;;-no-config-;;               :base-extension "org"
;;-no-config-;;               :publishing-function org-publish-org-to-html
;;-no-config-;;               :style-include-default nil
;;-no-config-;;               :style "<link rel=\"stylesheet\" href=\"/org.css\" type=\"text/css\" />"
;;-no-config-;;               :author-info nil
;;-no-config-;;               :creator-info nil)
;;-no-config-;;              ;
;;-no-config-;;              ; http://doc.norang.ca/  (norang website)
;;-no-config-;;              ; org-mode-doc-org this document
;;-no-config-;;              ; org-mode-doc-extra are images and css files that need to be included
;;-no-config-;;              ; org-mode-doc is the top-level project that gets published
;;-no-config-;;              ; This uses the same target directory as the 'doc' project
;;-no-config-;;              ("org-mode-doc-org"
;;-no-config-;;               :base-directory "~/git/org-mode-doc/"
;;-no-config-;;               :publishing-directory "/ssh:www-data@www:~/doc.norang.ca/htdocs"
;;-no-config-;;               :recursive t
;;-no-config-;;               :section-numbers nil
;;-no-config-;;               :table-of-contents nil
;;-no-config-;;               :base-extension "org"
;;-no-config-;;               :publishing-function (org-publish-org-to-html org-publish-org-to-org)
;;-no-config-;;               :plain-source t
;;-no-config-;;               :htmlized-source t
;;-no-config-;;               :style-include-default nil
;;-no-config-;;               :style "<link rel=\"stylesheet\" href=\"/org.css\" type=\"text/css\" />"
;;-no-config-;;               :author-info nil
;;-no-config-;;               :creator-info nil)
;;-no-config-;;              ("org-mode-doc-extra"
;;-no-config-;;               :base-directory "~/git/org-mode-doc/"
;;-no-config-;;               :publishing-directory "/ssh:www-data@www:~/doc.norang.ca/htdocs"
;;-no-config-;;               :base-extension "css\\|pdf\\|png\\|jpg\\|gif"
;;-no-config-;;               :publishing-function org-publish-attachment
;;-no-config-;;               :recursive t
;;-no-config-;;               :author nil)
;;-no-config-;;              ("org-mode-doc"
;;-no-config-;;               :components ("org-mode-doc-org" "org-mode-doc-extra"))
;;-no-config-;;              ;
;;-no-config-;;              ; http://doc.norang.ca/  (norang website)
;;-no-config-;;              ; org-mode-doc-org this document
;;-no-config-;;              ; org-mode-doc-extra are images and css files that need to be included
;;-no-config-;;              ; org-mode-doc is the top-level project that gets published
;;-no-config-;;              ; This uses the same target directory as the 'doc' project
;;-no-config-;;              ("tmp-org"
;;-no-config-;;               :base-directory "/tmp/publish/"
;;-no-config-;;               :publishing-directory "/ssh:www-data@www:~/www.norang.ca/htdocs/tmp"
;;-no-config-;;               :recursive t
;;-no-config-;;               :section-numbers nil
;;-no-config-;;               :table-of-contents nil
;;-no-config-;;               :base-extension "org"
;;-no-config-;;               :publishing-function (org-publish-org-to-html org-publish-org-to-org)
;;-no-config-;;               :style "<link rel=\"stylesheet\" href=\"http://doc.norang.ca/org.css\" type=\"text/css\" />"
;;-no-config-;;               :plain-source t
;;-no-config-;;               :htmlized-source t
;;-no-config-;;               :style-include-default nil
;;-no-config-;;               :auto-sitemap t
;;-no-config-;;               :sitemap-filename "index.html"
;;-no-config-;;               :sitemap-title "Test Publishing Area"
;;-no-config-;;               :sitemap-style "tree"
;;-no-config-;;               :author-info t
;;-no-config-;;               :creator-info t)
;;-no-config-;;              ("tmp-extra"
;;-no-config-;;               :base-directory "/tmp/publish/"
;;-no-config-;;               :publishing-directory "/ssh:www-data@www:~/www.norang.ca/htdocs/tmp"
;;-no-config-;;               :base-extension "css\\|pdf\\|png\\|jpg\\|gif"
;;-no-config-;;               :publishing-function org-publish-attachment
;;-no-config-;;               :recursive t
;;-no-config-;;               :author nil)
;;-no-config-;;              ("tmp"
;;-no-config-;;               :components ("tmp-org" "tmp-extra")))))
;;-no-config-;;
;;-no-config-;;;; I'm lazy and don't want to remember the name of the project to
;;-no-config-;;;; publish when I modify a file that is part of a project.  So this
;;-no-config-;;;; function saves the file, and publishes the project that includes
;;-no-config-;;;; this file.
;;-no-config-;;;; It's bound to C-S-F12 so I just edit and hit C-S-F12 when I'm done
;;-no-config-;;;; and move on to the next thing
;;-no-config-;;(defun bh/save-then-publish ()
;;-no-config-;;  (interactive)
;;-no-config-;;  (save-buffer)
;;-no-config-;;  (org-save-all-org-buffers)
;;-no-config-;;  (org-publish-current-project))

;;Now use config
;;==============
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