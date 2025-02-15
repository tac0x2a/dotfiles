;;; .emacs
;;; TAC <tac@tac42.net>

;;;;;;;;;;;;;;;;;;
;; キーバインド ;;
;;;;;;;;;;;;;;;;;;
;; 現在のキーバインドを確認する
;; (describe-bindings)

;; backspaceをC-hに割り当て
(global-set-key [?\C-h] `delete-backward-char)

;; C-\にリドゥを割り当て
(global-set-key [?\C-\\] `redo)

;; C-oで次ウィンドウに移動
(global-set-key [?\C-o] `other-window)

;;ミニバッファをスペースで補完
(if (boundp 'minibuffer-local-filename-completion-map)
(define-key minibuffer-local-filename-completion-map
" " 'minibuffer-complete-word))
(if (boundp 'minibuffer-local-must-match-filename-map)
(define-key minibuffer-local-must-match-filename-map
" " 'minibuffer-complete-word))

;; overwrite-modeつかわん
(global-unset-key [insert])

;; M-e で動的略語展開
(global-set-key [?\M-e] 'dabbrev-expand)

;; M-g で goto-line
(global-set-key [?\M-g] 'goto-line)

;; M-r で置換
(global-set-key [?\M-r] 'query-replace)

;; M-g r でrgrep
(define-prefix-command 'lrgrep-map)
(global-set-key (kbd "M-g") 'lrgrep-map)
(global-set-key (kbd "M-g M-r") 'rgrep)

;; M-g l でlgrep
(global-set-key (kbd "M-g M-l") 'lgrep)


;;;;;;;;;;;;
;; その他 ;;
;;;;;;;;;;;;

;クリップボードへ経由のコピペ
(setq x-select-enable-clipboard t)

; C-x C-f を強化
(ffap-bindings)

;; バッファ切り替えを便利に
(iswitchb-mode 1) ;;iswitchbモードON
;;; C-f, C-b, C-n, C-p で候補を切り替えることができるように。
(add-hook 'iswitchb-define-mode-map-hook
      (lambda ()
        (define-key iswitchb-mode-map "\C-n" 'iswitchb-next-match)
        (define-key iswitchb-mode-map "\C-p" 'iswitchb-prev-match)
        (define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
        (define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match)))

;; 行末の空白をバッファ保存時に削除
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; 改行コードを表示
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")

;;最初に出てくるmessageを消す
(setq inhibit-startup-message t)

;;最初に出てくる *scratch* を消す
(setq initial-scratch-message "")

;;ベルをやめる
(setq visible-bell nil)

;;時間表示
(display-time)

;; バッファ一覧をまともに
(global-set-key [?\C-x?\C-b] 'bs-show)

;; find-fileのファイル名補完で大文字小文字を区別しない
(setq read-file-name-completion-ignore-case t)

;;矩形選択を簡単に
(cua-mode t)
(setq cua-enable-cua-keys nil) ; 変なキーバインド禁止

;;メニューツリーを日本語化
; (install-elisp-from-emacswiki "menu-tree.el" )
; (require 'menu-tree)

;;ツールバー消去
; (tool-bar-mode -1)

;;ガベージコレクションを抑えて高速化
(setq gc-cons-threshold 5242880)

;;タイトルバーにはバッファ名
(setq frame-title-format "%b")

;;履歴を次回Emacs起動時にも保存する
(savehist-mode t)

;;ダイアログボックスを使わないようにする
(setq use-dialog-box nil)
(defalias 'message-box 'message)

;;キーストロークをメッセージエリアに早く表字する
(setq echo-keystrokes 0.1)

;;ミニバッファで入力を取り消しても履歴に残す
(defadvice abort-recursive-edit (before minibuffer-save activate)
  (when (eq (selected-window) (active-minibuffer-window))
    (add-to-history minibuffer-history-variable (minibuffer-contents))))

;; yesと入力するのが面倒なので y-nで
(defalias 'yes-or-no-p 'y-or-n-p)

;;ファイルを保存時に #! で始まっていればスクリプトとみなして実行権限を与える
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;; isearch のハイライトの反応をよくする
(setq isearch-lazy-highlight-initial-delay 0)

;; 同一名の buffer があったとき、開いているファイルのパスの一部を表示して区別する
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")

;; スクロールは一行ずつ行わない
(setq scroll-conservatively 0)

;; tab幅は2
(setq-default tab-width 2)

;; 行番号表示
; (global-linum-mode t)
