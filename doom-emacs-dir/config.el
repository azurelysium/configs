;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Minhwan Kim"
      user-mail-address "azurelysium@gmail.com")

(setq doom-theme 'doom-vibrant)

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
(global-set-key (kbd "C-c C-g") 'evil-escape)

(global-set-key [left] 'windmove-left)          ; move to left window
(global-set-key [right] 'windmove-right)        ; move to right window
(global-set-key [up] 'windmove-up)              ; move to upper window
(global-set-key [down] 'windmove-down)          ; move to lower window
(global-set-key (kbd "C-c z") 'zoom-window-zoom)

(map!
 (:leader
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
