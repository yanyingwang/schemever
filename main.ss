;; cd ~ && git clone https://github.com/ovenpasta/thunderchez.git
(library-directories "~/thunderchez")
(import (matchable))

;; cd ~ && git clone https://github.com/ashinn/irregex
;;(load "~/irregex/irregex.scm")

(define (string-split s c)
  (letrec* ([len (string-length s)]
            [walk (lambda (str begin end rst)
                    (cond ((>= begin len) rst)
                          ((or (= end len) (char=? (string-ref str end) c))
                           (walk
                            str
                            (+ end 1)
                            (+ end 1)
                            (if (= begin end)
                                rst
                                (cons (substring str begin end) rst))))
                          (else
                           (walk str begin (+ end 1) rst))))])
    (reverse (walk s 0 0 '()))))

(define cron-raw (get-string-all (car (process "crontab -l"))))
(define cron-content (string-split cron-raw #\newline))

(remp (lambda (x) (memq "# Begin Whenever generated tasks for"(string-split x #\:)) )
      )

;;(define cron-header (car cron-content))
;;(define cron-footer (list-ref cron-content (- (length cron-content) 1)))
