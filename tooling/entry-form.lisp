;;;; entry-form.lisp
;;;; ================
;;;; 
;;;; An MVP GUI tool for generating pwd.lisp entries for the HNPWD project.
;;;; 
;;;; Usage:
;;;;   1. Load this file: (load "tooling/entry-form.lisp")
;;;;   2. Fill in the form fields
;;;;   3. Click "Generate" to print the S-expression to the REPL
;;;;   4. Copy the output into pwd.lisp
;;;;
;;;; Requirements:
;;;;   - SBCL
;;;;   - Quicklisp
;;;;   - Tcl/Tk (brew install tcl-tk on macOS)
;;;;
;;;; Author: Alex Conway

(ql:quickload :ltk)

;;; Configuration

(defparameter *fields* '(:name :site :blog :feed :about :now :hnuid :bio))

;;; GUI Helpers

(defun title-gui (title)
  "Sets the GUI title."
  (ltk:wm-title ltk:*tk* title))

(defun make-field (label-text row)
  "Create a label and entry at ROW. 
   Return the entry so its value can be read later."
  (let ((label (make-instance 'ltk:label :text label-text))
        (entry (make-instance 'ltk:entry)))
    (ltk:grid label row 0)
    (ltk:grid entry row 1)
    entry))

(defun make-button (text row column command)
  "Create a button with TEXT at ROW and COLUMN. Run COMMAND when clicked."
  (let ((button (make-instance 'ltk:button
                               :text text
                               :command command)))
    (ltk:grid button row column)
    button))

(defun clear-entries (entries)
  "Clear all entry fields."
  (dolist (entry entries)
    (setf (ltk:text entry) "")))

;;; S-expression Generation

(defun keyword-to-label (kw)
  "Convert keyword :NAME to string \":name\"."
  (format nil ":~(~A~)" kw))

(defun pair-fields-with-values (entries)
  "Pair each field keyword with its entry's value."
  (mapcar #'cons *fields* (mapcar #'ltk:text entries)))

(defun remove-empty-pairs (pairs)
  "Remove pairs where the value is an empty string."
  (remove-if (lambda (pair) (string= "" (cdr pair))) pairs))

(defun format-sexp (pairs)
  "Print PAIRS as an S-expression."
  (if (= 1 (length pairs))
      (format t "~% (:~(~A~) ~S)~%" (caar pairs) (cdar pairs))
      (progn
        (format t "~% (:~(~A~) ~S~%" (caar pairs) (cdar pairs))
        (dolist (pair (butlast (cdr pairs)))
          (format t "  :~(~A~) ~S~%" (car pair) (cdr pair)))
        (let ((last-pair (car (last pairs))))
          (format t "  :~(~A~) ~S)~%" (car last-pair) (cdr last-pair))))))

(defun generate-sexp (entries)
  "Read values from ENTRIES and print the S-expression."
  (format-sexp (remove-empty-pairs (pair-fields-with-values entries))))

;;; Main

(defun build-entries ()
  "Build entry fields for each field in *fields*. Return list of entries."
  (loop for field in *fields*
        for row from 0
        collect (make-field (keyword-to-label field) row)))

(defun build-gui ()
  "Build the GUI contents."
  (title-gui "HNPWD Backlog Entry Form")
  (let* ((entries (build-entries))
         (button-row (length *fields*)))
    (make-button "Clear" button-row 3 (lambda () (clear-entries entries)))
    (make-button "Generate" button-row 1 (lambda () (generate-sexp entries)))))

(defun run-gui ()
  "Runs the GUI."
  (ltk:with-ltk ()
    (build-gui)))

(run-gui)