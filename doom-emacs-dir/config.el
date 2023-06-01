;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(setq doom-theme 'doom-zenburn)

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Minhwan Kim"
      user-mail-address "azurelysium@gmail.com")

(setq select-enable-clipboard t
      select-enable-primary t)

(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

;; (tmux-load-buffer.sh)
;; !/bin/bash
;; cat | tmux load-buffer -
(defun paste-to-tmux (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "tmux-load-buffer" "*Messages*" "~/Bin/tmux-load-buffer.sh")))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-tmux)
;(setq interprogram-paste-function 'copy-from-osx)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; Azurelysium's Settings
(remove-hook 'doom-first-buffer-hook #'global-hl-line-mode)
(setq make-backup-files nil)
(setq-default indent-tabs-mode nil)

(set-language-environment "korean")
(setq default-input-method "korean-hangul")
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; bindings
;(global-set-key (kbd "C-c C-g") 'evil-escape)
(setq-default evil-escape-key-sequence "df")
(setq-default evil-escape-delay 0.2)

(global-set-key [left] 'windmove-left)          ; move to left window
(global-set-key [right] 'windmove-right)        ; move to right window
(global-set-key [up] 'windmove-up)              ; move to upper window
(global-set-key [down] 'windmove-down)          ; move to lower window
(global-set-key (kbd "C-c z") 'zoom-window-zoom)

(use-package org
  :bind (:map org-mode-map
              ("C-c TAB" . nil)))

(global-set-key (kbd "C-c TAB n") '+workspace/new)
(global-set-key (kbd "C-c TAB r") '+workspace/rename)
(global-set-key (kbd "C-c TAB d") '+workspace/delete)
(global-set-key (kbd "C-c TAB `") '+workspace/other)
(global-set-key (kbd "C-c TAB [") '+workspace/switch-left)
(global-set-key (kbd "C-c TAB ]") '+workspace/switch-right)

(define-key evil-motion-state-map (kbd "[ t") 'centaur-tabs-backward)
(define-key evil-motion-state-map (kbd "] t") 'centaur-tabs-forward)
(define-key evil-motion-state-map (kbd "[ T") 'centaur-tabs-move-current-tab-to-left)
(define-key evil-motion-state-map (kbd "] T") 'centaur-tabs-move-current-tab-to-right)

(global-set-key (kbd "C-c t [") 'centaur-tabs-backward)
(global-set-key (kbd "C-c t ]") 'centaur-tabs-forward)
(global-set-key (kbd "C-c t {") 'centaur-tabs-move-current-tab-to-left)
(global-set-key (kbd "C-c t }") 'centaur-tabs-move-current-tab-to-right)

(use-package! centaur-tabs
  :config
  (setq centaur-tabs-set-close-button nil)
  (setq centaur-tabs-show-new-tab-button nil)
  (setq centaur-tabs-show-count t)
  (setq centaur-tabs-style "bar")
  (set-face-attribute 'centaur-tabs-selected nil
   :background "black" :foreground "white")
  (set-face-attribute 'centaur-tabs-selected-modified nil
   :background "red" :foreground "white")
  )

(map!
 (:leader
  (:desc "Switch to the last buffer" "l" 'evil-switch-to-windows-last-buffer)
  (:prefix "t"
   :desc "Toggle Treemacs" "t" '+treemacs/toggle)
  (:prefix "o"
   :desc "Open kill ring" "k" #'+default/yank-pop))

 (:map evilem-map
  :after evil-easymotion
  "<down>" #'evilem-motion-next-line
  "<up>" #'evilem-motion-previous-line)

 (:map evil-window-map
  "<left>"     #'evil-window-left
  "<right>"    #'evil-window-right
  "<up>"       #'evil-window-up
  "<down>"     #'evil-window-down)

 "<home>" #'back-to-indentation-or-beginning
 "<end>" #'end-of-line)

;; orgmode settings

;(add-to-list 'evil-emacs-state-modes 'org-mode)
(setq org-element-use-cache nil)

(add-hook 'org-mode-hook
  (lambda () (local-set-key (kbd "C-c C-b") 'org-mark-ring-goto)))
(add-hook 'org-mode-hook (lambda () (display-line-numbers-mode -1)))

;; programming

(add-hook! prog-mode #'rainbow-delimiters-mode)

(use-package! typescript-mode
  :init
  (define-derived-mode typescript-tsx-ts-mode typescript-mode "typescript-tsx")
  (add-to-list 'auto-mode-alist (cons (rx ".tsx" string-end) #'typescript-tsx-ts-mode))
  t)

(setq typescript-indent-level 2)
(setq js-indent-level 2)
;(add-hook! typescript-tsx-ts-mode 'lsp!)
;(setq lsp-idle-delay 1)

(use-package! tree-sitter
  :hook (prog-mode . turn-on-tree-sitter-mode)
  :hook (tree-sitter-after-on . tree-sitter-hl-mode)
  :config
  (require 'tree-sitter-langs)

  (tree-sitter-require 'tsx)
  (add-to-list 'tree-sitter-major-mode-language-alist '(typescript-tsx-ts-mode . tsx))

  ;; This makes every node a link to a section of code
  (setq tree-sitter-debug-jump-buttons t
        ;; and this highlights the entire sub tree in your code
        tree-sitter-debug-highlight-jump-region t))

(with-eval-after-load 'treemacs
  (defun treemacs-ignore-pycache(file _)
    (string= file "__pycache__"))
  (push #'treemacs-ignore-pycache treemacs-ignored-file-predicates))

;; w3m
(use-package! w3m
  :config
  (setq w3m-use-cookies t)
  (setq w3m-fill-column 0)
  (setq w3m-home-page "http://www.google.com/ncr")
  (autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
  (autoload 'w3m-region "w3m" "Render region in current buffer and replace with result." t)
  (setq w3m-coding-system 'utf-8
        w3m-file-coding-system 'utf-8
        w3m-file-name-coding-system 'utf-8
        w3m-input-coding-system 'utf-8
        w3m-output-coding-system 'utf-8
        w3m-terminal-coding-system 'utf-8)
  )

(add-hook 'w3m-mode-hook
          (lambda ()
            (local-set-key [(up)] 'w3m-view-this-url-new-session)
            (local-set-key [(down)] 'w3m-delete-buffer)
            (local-set-key [(left)] 'w3m-previous-buffer)
            (local-set-key [(right)] 'w3m-next-buffer)
            (local-set-key [(p)] 'w3m-previous-anchor)
            (local-set-key [(n)] 'w3m-next-anchor)
            ))

;; Multi-sensory Programming

;; $ cat generate-tone.sh
;; !/bin/bash
;; ffplay -f lavfi -i "sine=frequency=$1:duration=$2" -autoexit -nodisp 2>/dev/null
(defun generate-tone (frequency duration)
  (start-process "generate-tone" "*Messages*"
                 "~/Bin/generate-tone.sh"
                 (number-to-string (+ 300 frequency))
                 (number-to-string duration)))

(defun generate-total-lines-tone()
  (let ((lines (count-lines (point-min) (point-max))))
    (when (> lines 10)
      (generate-tone lines 0.5))))

(defun generate-current-line-tone()
  (let* ((lines (count-lines (point-min) (point-max)))
         (current-line-number (line-number-at-pos))
         (freq (+ 100 (* 900 (/ (float current-line-number) lines)))))
    ;(message (number-to-string freq))
    (generate-tone freq 0.1)))

;(add-hook 'window-selection-change-functions (lambda (frame) (generate-total-lines-tone)))
;(add-hook 'window-buffer-change-functions (lambda (frame) (generate-total-lines-tone)))

(defvar last-timer-function-position 0
  "Holds the cursor position from the last run of timer function.")
(make-variable-buffer-local 'last-timer-function-position)

(defun current-line-changed()
  ;(message (number-to-string last-timer-function-position))
  (unless (equal (line-number-at-pos) last-timer-function-position)
    (generate-current-line-tone))
  (setq last-timer-function-position (line-number-at-pos)))

;(run-with-idle-timer 1 1 'current-line-changed)
;(cancel-function-timers 'current-line-changed)
