;;;; utils.lisp

(in-package #:utils)

;;; "utils" goes here. Hacks and glory await!

(defmacro ql (&rest packages)
  (dolist (p packages)
    (ql:quickload p)))

;; File utils

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

(defun map-lines (fn file)
  "Executes function f for each line of file and returns the result as a list."
  (when (probe-file file)
    (with-open-file (stream file)
      (loop for line = (read-line stream nil 'eof)
            until (eq line 'eof)
            collect (funcall fn line)))))

(defun do-lines (fn file)
  "Executes function F for each line of FILE."
  (when (probe-file file)
    (with-open-file (stream file)
      (loop for line = (read-line stream nil 'eof)
            until (eq line 'eof)
            do (funcall fn line)))))
