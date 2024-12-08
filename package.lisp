;;;; package.lisp

(defpackage #:beep-port
  (:use #:cl #:bordeaux-threads)
  (:export
   #:*port*
   #:run))
