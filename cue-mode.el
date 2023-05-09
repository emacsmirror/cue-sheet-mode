;;; cue-mode.el --- Major mode for editing CUE files

;; Copyright © 2017, by Peter Hoeg

;; Author: Peter Hoeg (peter@hoeg.com)
;; Version: 1.0.0
;; Created: 2017
;; Keywords: languages
;; Homepage: https://hoeg.com
;; Package-Requires: ((emacs "24.3"))

;; This file is not part of GNU Emacs.

;;; License:

;; You can redistribute this program and/or modify it under the terms of the GNU
;; General Public License version 2.

;;; Commentary:

;; Add support for .cue files in Emacs.

;;; Code:

(defvar cue-font-lock-keywords
  `(;; NOTE: order matters, because once colored, that part won't change.
    (,(regexp-opt '("CATALOG" "COMPOSER" "FILE" "FLAGS" "INDEX" "ISRC" "PERFORMER" "TITLE") 'words) . font-lock-keyword-face)
    (,(regexp-opt '() 'words) . font-lock-constant-face)
    (,(regexp-opt '("COMMENT" "DATE" "DISCID" "GENRE" "REM") 'words) . font-lock-builtin-face)
    (,(regexp-opt '("TRACK" "AUDIO") 'words) . font-lock-function-name-face)
    (,(regexp-opt '("BINARY" "MP3" "WAVE") 'words) . font-lock-type-face))
  "CUE mode syntax coloring.")

;;;###autoload
(define-derived-mode cue-mode conf-mode "CUE mode"
  "Major mode for editing CUE files."

  (setq-local comment-start "REM "
              comment-end ""
              font-lock-defaults '((cue-font-lock-keywords))
              imenu-generic-expression '(("Track" "^\\(TRACK\\)[ \t\n]+\\([a-zA-Z0-9_.:]+\\)" 2)
                                         ("File"  "^FILE *\\(.*\\)" 1))))

(add-to-list 'auto-mode-alist '("\\.cue\\'" . cue-mode))

;; add the mode to the `features' list
(provide 'cue-mode)

;; Local Variables:
;; coding: utf-8
;; End:

;;; cue-mode.el ends here
