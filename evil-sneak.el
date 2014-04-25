(require 'evil)

(defgroup evil-sneak nil
  "vim-sneak emulation for Emacs"
  :prefix "evil-sneak-"
  :group 'evil)

(defvar evil-sneak-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "s") 'evil-sneak-next)
    (define-key map (kbd "S") 'evil-sneak-previous)
    (define-key map [t] 'evil-sneak-exit)
    map))

(define-minor-mode evil-sneak-mode
  "Evil-sneak minor mode."
  :init-value nil
  :lighter " debug"
  :keymap evil-sneak-mode-map
  :group evil-sneak
  (evil-normalize-keymaps))

(evil-make-overriding-map evil-sneak-mode-map nil)
;; (evil-make-intercept-map evil-sneak-mode-map nil)

(evil-define-motion evil-sneak (count first second)
  "Jump to the position of a two-character string."
  :jump t
  :type exclusive
  (interactive "p\nc\nc")
  (evil-search (string first second) t nil)
  (evil-sneak-mode 1))

(evil-define-motion evil-sneak-next (count)
  "Repeat last evil-sneak forward."
  :jump t
  :type exclusive
  (let ((evil-regexp-search nil))
    (evil-search-next count)))

(evil-define-motion evil-sneak-previous (count)
  "Repeat the last evil-sneak backwards."
  :jump t
  :type exclusive
  (let ((evil-regexp-search nil))
    (evil-search-previous count)))

(defun evil-sneak-exit (&optional arg)
  (interactive "P")
  (message "%s" (listify-key-sequence (this-command-keys)))
  (evil-sneak-mode 0))

(define-key evil-normal-state-map (kbd "s") 'evil-sneak)
