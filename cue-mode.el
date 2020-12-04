;;; cue-mode.el --- sample major mode for editing CUE files

;; Copyright © 2017, by Peter Hoeg

;; Author: Peter Hoeg (peter@hoeg.com)
;; Version: 1.0.0
;; Created: 2017
;; Keywords: languages
;; Homepage: https://hoeg.com

;; This file is not part of GNU Emacs.

;;; License:

;; You can redistribute this program and/or modify it under the terms of the GNU
;; General Public License version 2.

;;; Commentary:

;; Add support for .cue files in Emacs.

;;; Code:

(defvar cue-keywords '("CATALOG" "COMPOSER" "FILE" "FLAGS" "INDEX" "ISRC" "PERFORMER" "TITLE")
  "Keywords.")
(defvar cue-constants '()
  "Constants.")
(defvar cue-events '("COMMENT" "DATE" "DISCID" "GENRE" "REM")
  "Events.")
(defvar cue-functions '("TRACK" "AUDIO")
  "Functions.")
(defvar cue-types '("BINARY" "MP3" "WAVE")
  "Types.")
(defvar cue-mode-imenu-generic-expression
  '(("File"  "^FILE *\\(.*\\)" 1)
    ("Track" "^ *TRACK *\\(.*\\)" 1))
  "Imenu regexp."
  )

(defvar cue-font-lock-keywords
  `(
    ;; NOTE: order matters, because once colored, that part won't change.
    (,(regexp-opt cue-keywords  'words) . font-lock-keyword-face)
    (,(regexp-opt cue-constants 'words) . font-lock-constant-face)
    (,(regexp-opt cue-events    'words) . font-lock-builtin-face)
    (,(regexp-opt cue-functions 'words) . font-lock-function-name-face)
    (,(regexp-opt cue-types     'words) . font-lock-type-face))
  "CUE mode syntax coloring.")

;;;###autoload
(define-derived-mode cue-mode conf-mode "CUE mode"
  "Major mode for editing CUE files"

  (setq-local
   comment-start "REM "
   font-lock-defaults '((cue-font-lock-keywords))
   imenu-generic-expression cue-mode-imenu-generic-expression))

(add-to-list 'auto-mode-alist '("\\.cue\\'" . cue-mode))

;; add the mode to the `features' list
(provide 'cue-mode)

;; Local Variables:
;; coding: utf-8
;; End:

;;; cue-mode.el ends here
