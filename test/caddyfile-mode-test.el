;;; caddyfile-mode-test.el --- Tests for caddyfile-mode

(require 'ert)
(require 'faceup)

(defvar caddyfile-test-dir (faceup-this-file-directory))

(defun caddyfile-font-lock-test-file (file)
  "Test that the mylang FILE is fontifies as the .faceup file describes."
  (faceup-test-font-lock-file 'caddyfile-mode
                              (concat caddyfile-test-dir file)))
(faceup-defexplainer caddyfile-font-lock-test-file)

(ert-deftest caddyfile-font-lock-test ()
  (should (caddyfile-font-lock-test-file "Caddyfile1")))

(defun caddyfile-indent-test-file (file)
  (with-temp-buffer
    (insert-file-contents-literally (concat caddyfile-test-dir file))
    (let ((orig-content (buffer-substring-no-properties (point-min) (point-max))))
      ;; Remove all indentation
      (goto-char (point-min))
      (while (< (point) (point-max))
	(delete-horizontal-space)
	(forward-line 1))

      ;; Re-indent!
      (caddyfile-mode)
      (indent-region (point-min) (point-max))

      (should (equal (buffer-substring-no-properties (point-min) (point-max))
		     orig-content)))))

(ert-deftest caddyfile-indent-test ()
  (caddyfile-indent-test-file "Caddyfile1"))

;;; caddyfile-mode-test.el ends here
