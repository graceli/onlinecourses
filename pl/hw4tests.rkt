#lang racket

(require "hw4.rkt") 

;; A simple library for displaying a 2x3 grid of pictures: used
;; for fun in the tests below (look for "Tests Start Here").

(require (lib "graphics.rkt" "graphics"))

(open-graphics)

(define window-name "Programming Languages, Homework 4")
(define window-width 700)
(define window-height 500)
(define border-size 100)

(define approx-pic-width 200)
(define approx-pic-height 200)
(define pic-grid-width 3)
(define pic-grid-height 2)

(define (open-window)
  (open-viewport window-name window-width window-height))

(define (grid-posn-to-posn grid-posn)
  (when (>= grid-posn (* pic-grid-height pic-grid-width))
    (error "picture grid does not have that many positions"))
  (let ([row (quotient grid-posn pic-grid-width)]
        [col (remainder grid-posn pic-grid-width)])
    (make-posn (+ border-size (* approx-pic-width col))
               (+ border-size (* approx-pic-height row)))))

(define (place-picture window filename grid-posn)
  (let ([posn (grid-posn-to-posn grid-posn)])
    ((clear-solid-rectangle window) posn approx-pic-width approx-pic-height)
    ((draw-pixmap window) filename posn)))

(define (place-repeatedly window pause stream n)
  (when (> n 0)
    (let* ([next (stream)]
           [filename (cdar next)]
           [grid-posn (caar next)]
           [stream (cdr next)])
      (place-picture window filename grid-posn)
      (sleep pause)
      (place-repeatedly window pause stream (- n 1)))))

;; Tests Start Here

; These definitions will work only after you do some of the problems
; so you need to comment them out until you are ready.
; Add more tests as appropriate, of course.

(define nums (sequence 0 5 1))

(define files (string-append-map 
               (list "dan" "dog" "curry" "dog2") 
               ".jpg"))

(define funny-test (stream-for-n-steps funny-number-stream 5))

; a zero-argument function: call (one-visual-test) to open the graphics window, etc.
(define (one-visual-test)
  (place-repeatedly (open-window) 0.5 (cycle-lists nums files) 8))

; similar to previous but uses only two files and one position on the grid
(define (visual-zero-only)
  (place-repeatedly (open-window) 0.5 (stream-add-zero dan-then-dog) 27))

; Q1
(equal? (sequence 3 11 2) (list 3 5 7 9 11))
(equal? (sequence 3 8 3) (list 3 6))
(equal? (sequence 3 2 1) null)

; Q2
(equal? (string-append-map (list "grace " "abby " "june ") "smith") (list "grace smith" "abby smith" "june smith"))
(equal? (string-append-map (list "a" "b") "c") (list "ac" "bc"))

; Q3
; (equal? (list-nth-mod (list 1 2 3) -1) (error "list-nth-mod: negative number"))
; (equal? (list-nth-mod null 2) (error "list-nth-mod: empty list"))
(equal? (list-nth-mod (list 1 2 3) 2) 3)

; Q5
(equal? funny-test (list 1 2 3 4 -5))

; Q6
(equal? (stream-for-n-steps dan-then-dog 2) (list "dan.jpg" "dog.jpg"))
(equal? (stream-for-n-steps dan-then-dog 1) "dan.jpg")
(equal? (stream-for-n-steps dan-then-dog 0) null)

; Q7
(equal? (stream-for-n-steps (stream-add-zero dan-then-dog) 2) (list (cons 0 "dan.jpg") (cons 0 "dog.jpg")))

; Test cases for Q8
(equal? (stream-for-n-steps (cycle-lists '(1 2 3) '("a" "b")) 2) (list (cons 1  "a") (cons 2 "b")))

; Test case for Q9
(equal? (vector-assoc 1 (build-vector 2 (lambda (x) (cons 1 x)))) (cons 1 0))
; should be equal to the output of (assoc 1 (list (cons 1 0) (cons 1 1)))
; expected output '(1 . 0)

; Test cases for Q10
(equal? (let ([f (cached-assoc (list (cons 1 2) (cons 2 2) (cons 3 3)) 2)]) (begin (f 1) (f 2) (f 3) (f 3))) (cons 3 3))

; Very long list
(equal? (let ([f (cached-assoc (build-list 100000 (lambda (x) (cons x x))) 5)]) (begin (f 99999) (f 99999))) (cons 99999 99999))