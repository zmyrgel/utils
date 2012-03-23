;;;; utils.asd

(asdf:defsystem #:utils
  :serial t
  :depends-on (:osicat :cl-utilities :alexandria :cl-ppcre)
  :components ((:file "package")
               (:file "utils")))
