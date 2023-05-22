;;; cue-sheet-mode.el --- Major mode for editing CUE sheet files

;; Copyright © 2017, by Peter Hoeg

;; Author: Peter Hoeg (peter@hoeg.com)
;; Version: 1.0.0
;; Created: 2017
;; Keywords: languages
;; Homepage: https://github.com/peterhoeg/cue-sheet-mode
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
(define-derived-mode cue-sheet-mode conf-mode "CUESheet"
  "Major mode for editing CUE sheet files."

  (setq-local comment-start "REM"
              comment-end ""
              font-lock-defaults `(((,(rx bol (or "REM")) . 'font-lock-comment-face)
                                    (,(rx (or "CATALOG" "CDTEXTFILE" "COMMENT" "COMPOSER" "DATE" "DISCID" "FILE" "FLAGS" "GENRE" "INDEX" "ISRC" "PERFORMER" "POSTGAP" "PREGAP" "SONGWRITER" "TITLE" "TRACK")) . 'font-lock-keyword-face)
                                    (,(rx (or "AUDIO" "BINARY" "CDI/2336" "CDI/2352" "CDG" "MODE1/2048" "MODE1/2352" "MODE2/2336" "MODE2/2352" "MP3" "WAVE")) . 'font-lock-type-face)))
              imenu-generic-expression `(("Track" ,(rx bol (zero-or-more space) "TRACK" (one-or-more space) (group (one-or-more digit)) space "AUDIO" eol) 1)
                                         ("File"  ,(rx bol "FILE" (one-or-more space) "\"" (group (one-or-more not-newline)) "\"" space "WAVE" eol) 1 ))))

;;;###autoload
(add-to-list 'auto-mode-alist `(,(rx ".cue" eos) . cue-sheet-mode))

(provide 'cue-sheet-mode)

;;; cue-sheet-mode.el ends here
