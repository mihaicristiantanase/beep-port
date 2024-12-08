;;;; beep-port.asd

(asdf:defsystem #:beep-port
  :description "Speak something when connections to the chosen port change."
  :author "Mihai Cristian Tănase"
  :license  "MIT License"
  :version "1.0.0"
  :serial t
  :depends-on (#:bordeaux-threads #:cl-ppcre)
  :components ((:file "package")
               (:file "beep-port")))
