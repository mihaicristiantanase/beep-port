;;;; beep-port.asd

(asdf:defsystem #:beep-port
  :description "Describe beep-port here"
  :author "Mihai Cristian Tănase"
  :license  "ARKON ©2024"
  :version "0.0.1"
  :serial t
  :depends-on (#:bordeaux-threads #:cl-ppcre)
  :components ((:file "package")
               (:file "beep-port")))
