;; Programming Languages, Homework 5
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; definition of structures for MUPL programs - Do NOT change
(struct var  (string) #:transparent)  ;; a variable, e.g., (var "foo")
(struct int  (num)    #:transparent)  ;; a constant number, e.g., (int 17)
(struct add  (e1 e2)  #:transparent)  ;; add two expressions
(struct ifgreater (e1 e2 e3 e4)    #:transparent) ;; if e1 > e2 then e3 else e4
(struct fun  (nameopt formal body) #:transparent) ;; a recursive(?) 1-argument function
(struct call (funexp actual)       #:transparent) ;; function call
(struct mlet (var e body) #:transparent) ;; a local binding (let var = e in body) 
(struct apair (e1 e2)     #:transparent) ;; make a new pair
(struct fst  (e)    #:transparent) ;; get first part of a pair
(struct snd  (e)    #:transparent) ;; get second part of a pair
(struct aunit ()    #:transparent) ;; unit value -- good for ending a list
(struct isaunit (e) #:transparent) ;; evaluate to 1 if e is unit else 0

;; a closure is not in "source" programs; it is what functions evaluate to
(struct closure (env fun) #:transparent) 

;; Problem 1
(define (racketlist->mupllist lst)
  (if (null? lst) 
      (aunit)
      (apair (car lst) (racketlist->mupllist (cdr lst)))))

(define (mupllist->racketlist lst)
  (if (aunit? lst)
      null
      (cons (apair-e1 lst) (mupllist->racketlist (apair-e2 lst)))))

;; lookup a variable in an environment
;; Do NOT change this function
(define (envlookup env str)
  (cond [(null? env) (error "unbound variable during evaluation" str)]
        [(equal? (car (car env)) str) (cdr (car env))]
        [#t (envlookup (cdr env) str)]))

;; Do NOT change the two cases given to you.  
;; DO add more cases for other kinds of MUPL expressions.
;; We will test eval-under-env by calling it directly even though
;; "in real life" it would be a helper function of eval-exp.

; Helper function which returns #t if a MUPL value, otherwise #f
(define (is-a-mupl-value e)
  (or (int? e) (closure? e) (aunit? e)))

(define (eval-under-env e env)
  (cond [(var? e) 
         (envlookup env (var-string e))]
        
        [(add? e) 
         (let ([v1 (eval-under-env (add-e1 e) env)]
               [v2 (eval-under-env (add-e2 e) env)])
           (if (and (int? v1)
                    (int? v2))
               (int (+ (int-num v1) 
                       (int-num v2)))
               (error "MUPL addition applied to non-number")))]
        
        ; A MUPL value: int, closure or aunit
        [(is-a-mupl-value e) e]
        
        ; A MUPL value: A pair of values
        [(and (apair? e) (is-a-mupl-value (apair-e1 e)) (is-a-mupl-value (apair-e2 e))) e]
        
        ; Function evaluation
        [(fun? e) (closure env e)]
        
        ; ifgreater evaluation
        [(ifgreater? e)
         (let ([v1 (eval-under-env (ifgreater-e1 e) env)]
               [v2 (eval-under-env (ifgreater-e2 e) env)])
           (if (and (int? v1) (int? v2))
               (if (> (int-num v1) (int-num v2))
                   (eval-under-env (ifgreater-e3 e) env)
                   (eval-under-env (ifgreater-e4 e) env))
               (error "Expressions are not integers")))]
        
        [(mlet? e)
         (let ([v (eval-under-env (mlet-e e) env)])
           (eval-under-env (mlet-body e) (cons (cons (mlet-var e) v) env)))]
        
        [(apair? e)(let ([v1 (eval-under-env (apair-e1 e) env)]
                         [v2 (eval-under-env (apair-e2 e) env)])
                     (apair v1 v2))]
        
        [(fst? e)(let ([v (eval-under-env (fst-e e) env)])
                   (if (apair? v)
                       (apair-e1 v)
                       (error "Expression did not evaluate to a pair")))]
        
        [(snd? e)(let ([v (eval-under-env (snd-e e) env)])
                   (if (apair? v)
                       (apair-e2 v)
                       (error "Expression did not evaluate to a pair")))]
        
        [(isaunit? e)(let ([v (eval-under-env (isaunit-e e) env)])
                       (if (aunit? v)
                           (int 1)
                           (int 0)))]
        
        ; evaluates a function call
        [(call? e)(let ([v1 (eval-under-env (call-funexp e) env)]
                        [v2 (eval-under-env (call-actual e) env)])
                    (if (closure? v1)
                        (let* ([f-exp (closure-fun v1)]
                               [env-with-f-args (cons (cons (fun-formal f-exp) v2)(closure-env v1))])
                          (if (equal? (fun-nameopt f-exp) #f)
                              (eval-under-env (fun-body f-exp) env-with-f-args)
                              (eval-under-env (fun-body f-exp) (cons (cons (fun-nameopt f-exp) v1) env-with-f-args))))
                        (error "Function name did not evaluate to a closure")))]
        
        [#t (error "bad MUPL expression")]))

;; Do NOT change
(define (eval-exp e)
  (eval-under-env e null))


;; Problem 3 -- MUPL macros
(define (ifaunit e1 e2 e3)
  (ifgreater (isaunit e1) (int 0) e2 e3))

(define (mlet* lstlst e2)
  (if (null? lstlst)
      e2
      (let* ([var (car (car lstlst))]
             [e (cdr (car lstlst))]
             [exp (mlet var e (mlet* (cdr lstlst) e2))])
        exp)))

(define (ifeq e1 e2 e3 e4)
  (mlet "_x" e1 (mlet "_y" e2 (ifgreater (var "_x") (var "_y") e4 (ifgreater (var "_y") (var "_x") e4 e3)))))


;; Problem 4 -- Using MUPL
(define mupl-map
  (fun #f "mupl-fun"
       (fun "map" "mupl-lst"
            (ifeq (isaunit (var "mupl-lst")) (int 1)
                  (aunit)
                  (apair (call (var "mupl-fun")(fst (var "mupl-lst"))) (call (var "map") (snd (var "mupl-lst"))))))))

(define mupl-mapAddN
  (fun #f "num"
       (fun #f "lst"
            (mlet "map" mupl-map
                  (call (call mupl-map (fun #f "i" (add (var "num") (var "i")))) (var "lst"))))))

