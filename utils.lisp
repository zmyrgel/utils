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

;; File utils

(defun for-lines (fn file)
  "Executes function FN for each line of FILE and returns the result as a list."
  (when (probe-file file)
    (with-open-file (stream file)
      (loop for line = (read-line stream nil 'eof)
            until (eq line 'eof)
            collect (funcall fn line)))))

(defun do-lines (fn file)
  "Executes function FN for each line of FILE, returns nil."
  (when (probe-file file)
    (with-open-file (stream file)
      (loop for line = (read-line stream nil 'eof)
            until (eq line 'eof)
            do (funcall fn line)))))
