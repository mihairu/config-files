(require 'site-gentoo)

; folding
(load "folding" 'nomessage 'noerror)
  (folding-mode-add-find-file-hook)
  (folding-add-to-marks-list 'php-mode                "//{"  "//}"  nil t)

(require 'speedbar)

(defconst my-speedbar-buffer-name "SPEEDBAR")
 ;  (defconst my-speedbar-buffer-name " SPEEDBAR") ; try this if you get "Wrong type argument: stringp, nil"
 
   (defun my-speedbar-no-separate-frame ()
     (interactive)
   ;  (when (not (buffer-live-p speedbar-buffer))
       (setq speedbar-buffer (get-buffer-create my-speedbar-buffer-name)
	     speedbar-frame (selected-frame)
	     dframe-attached-frame (selected-frame)
	     speedbar-select-frame-method 'attached
	     speedbar-verbosity-level 0
	     speedbar-last-selected-file nil)
       (set-buffer speedbar-buffer)
       (speedbar-mode)
       (speedbar-reconfigure-keymaps)
       (speedbar-update-contents)
       (speedbar-set-timer 1)
       (split-window-horizontally 30) 
       (set-window-buffer (selected-window) "SPEEDBAR"))

    ;   (make-local-hook 'kill-buffer-hook)
    ;   (add-hook 'kill-buffer-hook
;		 (lambda () (when (eq (current-buffer) speedbar-buffer)
;			      (setq speedbar-frame nil
;				    dframe-attached-frame nil
;				    speedbar-buffer nil)

;			      (speedbar-set-timer nil)))))
    ; (set-window-buffer (selected-window) 
;			(get-buffer my-speedbar-buffer-name)))


; flymake
(require 'flymake)

(defun flymake-php-init ()
    "Use php to check the syntax of the current file."
      (let* ((temp (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))
	     	 (local (file-relative-name temp (file-name-directory buffer-file-name))))
	    (list "php" (list "-f" local "-l"))))

(add-to-list 'flymake-err-line-patterns
	       '("\\(Parse\\|Fatal\\) error: +\\(.*?\\) in \\(.*?\\) on line \\([0-9]+\\)$" 3 4 nil 2))

(add-to-list 'flymake-allowed-file-name-masks '("\\.php$" flymake-php-init))

(add-hook 'php-mode-hook (lambda () (flymake-mode 1)))
 

; git setting
(require 'vc-git)
(when (featurep 'vc-git) (add-to-list 'vc-handled-backends 'git))
(autoload 'git-blame-mode "git-blame"
	     "Minor mode for incremental blame for Git." t)

(setq inhibit-startup-message   t)   ; Don't want any startup message 

; php setting
(autoload 'php-mode "php-mode.el" "Php mode." t)
(setq auto-mode-alist (append '(("/*.\.php[345]?$" . php-mode)) auto-mode-alist))
(add-hook 'php-mode-user-hook 'turn-on-font-lock)
(add-hook 'php-mode-hook (lambda () (setq c-basic-offset 4)))

; css setting
(autoload 'css-mode "css-mode")
(setq auto-mode-alist (cons '("\.css\'" . css-mode) auto-mode-alist))

; pkgbuild setting
(autoload 'pkgbuild-mode "pkgbuild-mode.el" "PKGBUILD mode." t)
(setq auto-mode-alist (append '(("/PKGBUILD$" . pkgbuild-mode)) auto-mode-alist))

; lua setting
(setq auto-mode-alist (cons '("\.lua$" . lua-mode) auto-mode-alist))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)

(add-to-list 'load-path "/usr/share/emacs/22.2/lisp/")
(add-to-list 'load-path "/home/mihairu/.emacs.d/")

; dont backup
(setq backup-directory-alist (list (cons ".*" (expand-file-name "~/.emacsbackup/"))))

; key settings
(global-set-key [f4] 'bubble-buffer) 
(global-set-key [f9] 'php-header) 
(global-set-key "\C-x\M-s" 'my-speedbar-no-separate-frame) 
(global-set-key [f11] 'flymake-goto-prev-error)
(global-set-key [f12] 'flymake-goto-next-error)

; setting how emacs may look
;(set-face-background 'region "yellow") ; Set region background color
;(set-background-color        "black") ; Set emacs bg color 
;(set-foreground-color        "white")

; setting of buffer switching
(defvar LIMIT 1)
(defvar time 0)
(defvar mylist nil)

(defun time-now ()
     (car (cdr (current-time))))

(defun bubble-buffer ()
  (interactive)
  (if (or (> (- (time-now) time) LIMIT) (null mylist))
    (progn (setq mylist (copy-alist (buffer-list)))
	   (delq (get-buffer " *Minibuf-0*") mylist)
	   (delq (get-buffer " *Minibuf-1*") mylist)))
  (bury-buffer (car mylist))
  (setq mylist (cdr mylist))
  (setq newtop (car mylist))
  (switch-to-buffer (car mylist))
  (setq rest (cdr (copy-alist mylist)))
  (while rest
	 (bury-buffer (car rest))
	 (setq rest (cdr rest)))
  (setq time (time-now))) 

; setting of PHP skelet
(defun php-header ()
  (interactive)
  (insert
    "// filename.php, (c) Michal Orlík <thror.fw@gmail.com>
// -- description
//
// -- rev.0.1, now(), time()
")/
    (previous-line 8)
    (end-of-line)) 
