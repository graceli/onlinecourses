
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

; Q1
(define (sequence low high stride)
  (if (<= low high)
      (cons low (sequence (+ low stride) high stride))
      null))

; Q2
(define (string-append-map xs suffix)
  (map (lambda (s) (string-append s suffix)) xs))

; Q3
; Assume that count from zero here means the list is indexed from 0. i.e. 0 maps to the first element of the 
; List and so on.  Check this in the forums
(define (list-nth-mod xs n)
  (cond [(< n 0) (error "list-nth-mod: negative number")]
        [(null? xs) (error "list-nth-mod: empty list")]
        [#t (let ([i (remainder n (length xs))])
            (if (= i 0)
                (car xs)
                (car (list-tail xs i))))]))

; Q4
(define (stream-for-n-steps s n)
  (if (= n 0)
      null
      (let ([pr (s)])
        (cons (car pr) (stream-for-n-steps (cdr pr) (- n 1))))))

; Q5
(define funny-number-stream
  (letrec ([f (lambda (x) (if (= (remainder x 5) 0) 
                              (cons (* -1 x) (lambda () (f (+ x 1)))) 
                              (cons x (lambda () (f (+ x 1))))))])
  (lambda ()(f 1))))


; Q6
(define dan-then-dog
  (letrec ([f (lambda (x) (if (= x 0)
                               (cons "dan.jpg" (lambda () (f 1)))
                               (cons "dog.jpg" (lambda () (f 0)))))])
  (lambda () (f 0))))


; Q7
; The sample solution is around 4 lines ... 
; which means they probably used a couple of let expressions
(define (stream-add-zero s)
  (lambda () (cons (cons 0 (car (s))) (stream-add-zero (cdr (s))))))

; Q8
(define (cycle-lists xs ys)
  (letrec ([run-cycle-lists 
            (lambda (n) 
                (lambda ()(cons (cons (list-nth-mod xs n) (list-nth-mod ys n)) (run-cycle-lists (+ n 1)))))])
  (run-cycle-lists 0)))

; Q9
(define (vector-assoc v vec)
  (letrec ([f (lambda (v vec pos)
                (cond [(and (< pos (vector-length vec)) (pair? (vector-ref vec pos)))
                                                                               (if (equal? v (car (vector-ref vec pos)))
                                                                                   (vector-ref vec pos)
                                                                                   (f v vec (+ pos 1)))]
                      [(< pos (vector-length vec)) (f v vec (+ pos 1))]
                      [#t #f]))])
    (f v vec 0)))

; Q10
