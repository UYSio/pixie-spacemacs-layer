;;; packages.el --- pixie Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.
(setq pixie-packages
    '(
      ;; package names go here
;;      clojure-mode
      inf-clojure
      pixie-mode
      ))

;; List of packages to exclude.
(setq pixie-excluded-packages '())

(defun pixie/post-init-inf-clojure ()
  (add-hook 'pixie-mode-hook 'inf-clojure-minor-mode))

(defun pixie/init-pixie-mode ()
  (use-package pixie-mode
    :defer t
    :config
    (progn
      (defun spacemacs/pixie-eval-last-sexp ()
        "Call `inf-clojure-eval-last-sexp' and switch to REPL buffer in `insert state'"
        (interactive)
        (inf-clojure-eval-last-sexp)
        (inf-clojure-switch-to-repl t)
        (evil-insert-state))

      (defun spacemacs/pixie-eval-region (start end)
        "Call `inf-clojure-eval-region' and switch to REPL buffer in `insert state'"
        (interactive "r")
        (if (region-active-p)
            (progn
              (let ((region (buffer-substring-no-properties start end)))
                (inf-clojure-switch-to-repl t)
                (inf-clojure-eval-string region)
                (evil-insert-state)))
            (message "No region.")))

      (evil-leader/set-key-for-mode 'pixie-mode
        ;; REPL
        "msi" 'inf-clojure-switch-to-repl
        "msb" 'inf-clojure-eval-last-sexp
        "msB" 'spacemacs/pixie-eval-last-sexp
        "msr" 'inf-clojure-eval-region
        "msR" 'spacemacs/pixie-eval-region)
      )))

;; For each package, define a function pixie/init-<package-name>
;;
;; (defun pixie/init-my-package ()
;;   "Initialize my package"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
