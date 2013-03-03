#lang racket
(require "hw5.rkt")
(require rackunit)

; a test case that uses problems 1, 2, and 4
; should produce (list (int 10) (int 11) (int 16))
;(define test1
;  (mupllist->racketlist
;   (eval-exp (call (call mupl-mapAddN (int 7))
;                   (racketlist->mupllist 
;                    (list (int 3) (int 4) (int 9)))))))

; Q1
(define test1_1 (racketlist->mupllist (list (int 1) (int 2) (int 3) (int 4))))
(check-equal? test1_1
              (apair (int 1) (apair (int 2) (apair (int 3) (apair (int 4) (aunit)))))
              "Testing racketlist->mupllist")

(check-equal? (mupllist->racketlist test1_1)
              (list (int 1) (int 2) (int 3) (int 4))
              "Testing mupllist->racketlist")

(define f2_sumall (eval-exp (fun "sumall" "nb" (ifgreater (var "nb")
                                                          (int 0)
                                                          (add (var "nb") (call (var "sumall") (add (int -1) (var "nb"))))
                                                          (int 0)))))
(check-equal? (eval-exp (call f2_sumall (int 10)))
              (int 55)
              "Testing recursive function")
