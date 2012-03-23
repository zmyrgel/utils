;;;; utils.lisp

(in-package #:utils)

;;; "utils" goes here. Hacks and glory await!

(defmacro with-open-file* (bindings &body body)
  "Evaluates BODY with multiple open files by calling with-open-file
   for each binding in BINDINGS."
  (first
   (labels ((rec (specs)
              (if (null specs)
                  body
                  (list (cons 'with-open-file
                              (cons (first specs) (rec (rest specs))))))))
     (rec bindings))))
