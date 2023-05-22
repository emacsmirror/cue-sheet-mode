;;; cue-mode.el --- Major mode for editing CUE files

;; Copyright © 2017, by Peter Hoeg

;; Author: Peter Hoeg (peter@hoeg.com)
;; Version: 1.0.0
;; Created: 2017
;; Keywords: languages
;; Homepage: https://hoeg.com
;; Package-Requires: ((emacs "24.3"))
;; SPDX-License-Identifier: GPL-3.0-or-later
;;
;; This file is not part of GNU Emacs.

;;; Commentary:

;; Support for .cue files in Emacs. The font-locking is very much *not*
;; consistent and needs to be cleaned up.

;;; Code:

(require 'rx)

;;;###autoload
(define-derived-mode cue-mode conf-mode "CUE mode"
  "Major mode for editing CUE files."

  (setq-local comment-start "REM"
              comment-end ""
              font-lock-defaults `(((,(rx (or "REM")) 'font-lock-comment-delimiter-face)
                                    (,(rx (or "CATALOG" "COMPOSER" "FLAGS" "INDEX" "ISRC" "PERFORMER" "TITLE")) . 'font-lock-keyword-face)
                                    (,(rx (or "COMMENT" "DATE" "DISCID" "GENRE")) . 'font-lock-builtin-face)
                                    (,(rx (or "AUDIO")) . 'font-lock-function-name-face)
                                    (,(rx (or "BINARY" "FILE" "MP3" "TRACK" "WAVE")) . 'font-lock-type-face)))
              imenu-generic-expression `(("Track" ,(rx bol (zero-or-more space) "TRACK" (one-or-more space) (group (one-or-more digit)) space "AUDIO" eol) 1)
                                         ("File"  ,(rx bol "FILE" (one-or-more space) "\"" (group (one-or-more not-newline)) "\"" space "WAVE" eol) 1 ))))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.cue\\'" . cue-mode))

;; add the mode to the `features' list
(provide 'cue-mode)

;;; cue-mode.el ends here
