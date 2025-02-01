;;;; beep-port.lisp

(in-package #:beep-port)

(defun scan-port (port)
  (let ((cmd (format nil "netstat -tanlp tcp | egrep -w ~a" port)))
    (uiop:run-program cmd :output '(:string :stripped t)
                          :error-output :output
                          :ignore-error-status t)))

(defparameter *prev* nil)

(defun beep (sound)
  (let ((something-to-say (ecase sound
                            (start-sound "COMMENCE")
                            (change-sound "") ; silence
                            (end-sound "C'EST FINI [[slnc 500]] LA COMÉDIE")
                            (just-listening-sound "ÉCOUTE"))))
    (let ((cmd (format nil "say -v Amélie \"~a\"" something-to-say)))
      (uiop:run-program cmd))))

(defun important-statuses-only (buf)
  "Documentation for important-statuses-only with parameters buf"
  (format nil "~{~a~%~}"
          (remove-if (lambda (line) (or (search "FIN_WAIT_2" line)
                                        (search "CLOSE_WAIT" line)))
                     (cl-ppcre:split "
" buf))))

(defun check-it (port)
  (let ((current (important-statuses-only (scan-port port)))
        (needs-update-p t))
    (cond
      ((string-equal *prev* current)
       (setf needs-update-p nil))
      ((or (null current) (zerop (length current)))
       (beep 'end-sound))
      ((or (null *prev*) (zerop (length *prev*)))
       (beep 'start-sound))
      ((cl-ppcre:scan "^.*LISTEN.*$" current)
       (beep 'just-listening-sound))
      (t
       (beep 'change-sound)))
    (if needs-update-p
        (format t "====================~%~a~%" current))
    (setf *prev* current)))

(defparameter *port* 8888)

(defun run ()
  (make-thread (lambda ()
                 (loop do
                   (check-it *port*)
                   (sleep 1)))
               :name "beep-port"))
