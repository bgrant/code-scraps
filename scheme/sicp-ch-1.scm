;; fahrenheit to celsius converter
(define (f2c t) 
  (* 5/9 (- t 32)))

;; squares a number
(define (square n) 
  (* n n ))

;; sum of squares of a and b
(define (sum-of-squares a b)
  (+ (square a) (square b)))

;; sum return the min of three numbers
(define (min a b c)
  (cond ((and (<= a b) (<= a c)) a)
        ((and (<= b a) (<= b c)) b)
        ((and (<= c a) (<= c b)) c)
        (else #f)))

;; Exercise 1.3
;; returns the sum-of-square of the maximum of two numbers
(define (2-max-ss a b c)
  (cond ((= a (min a b c)) (sum-of-squares b c))
        ((= b (min a b c)) (sum-of-squares a c))
        ((= c (min a b c)) (sum-of-squares a b))))

;; Exercise 1.4
;; clever way to do a plus the absolute value of b
;; if statement returns the + or - function depending on the sign of b
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

;; Exercise 1.5
;; (test 0 (p))
;; applicative order iterpreters run forever by running the infinitely recursive procedure
;; normal order interpreters stop on realizing x = 0 and don't eval (p)
(define (p) (p))
(define (test x y)
  (if (= x 0)
      0
      y))

;; Newton's Method
(define (my-sqrt x)
  (define (average a b)
    (/ (+ a b) 2))
  (define (good-enough? guess)
    (< (abs (- x (square guess))) 0.0001))
  (define (improve-guess guess)
    (average guess (/ x guess)))
  (define (sqrt-iter guess)
    (if (good-enough? guess);; new-if won't work here
        guess
        (sqrt-iter (improve-guess guess))))
  (sqrt-iter 1.0))

;; Exercise 1.6
;; this new-if procedure is wrong---because of applicative order interpretation,
;; if used in Newton's method above sqrt-iter (else-clause) is forever expanded, preventing substitution
;; with the then-clause (it does work with simple cases that need no expansion of the else-clause)
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

;; Exercise 1.8
;; Newton's Method for Cube Roots
(define (cube x)
  (* x x x ))

(define (my-cbrt x)
  (define (good-enough? guess)
    (< (abs (- x (cube guess))) 0.0001))
  (define (improve-guess guess)
    (/ (+ (/ x (square guess)) (* 2 guess)) 3))
  (define (cbrt-iter guess)
    (if (good-enough? guess);; new-if won't work here
        guess
        (cbrt-iter (improve-guess guess))))
  (cbrt-iter 1.0))

;; Section 1.2.1
(define (fact x)
  (define (rec-fact x)
    (if (= x 0)
        1
        (* x (rec-fact (- x 1)))))  
  (define (iter-fact product counter)
    (if (= counter x) 
        (* product counter)
        (iter-fact (* product counter) (+ counter 1))))
  (if (= x 0)
      1
      (iter-fact 1 1)))
;;  (rec-fact x))

;; Exercise 1.9
;;
;;(define (+ a b)
;;  (if (= a 0)
;;      b
;;      (inc (+ (dec a) b))))
;;
;;(+ 4 5)
;;(inc (+ 3 5)) 
;;(inc (inc (+ 2 5)))
;;(inc (inc (inc (+ 1 5))))
;;(inc (inc (inc (inc (+ 0 5)))))
;;(inc (inc (inc (inc 5))))
;;(inc (inc (inc 6)))
;;(inc (inc 7))
;;(inc 8)
;;9
;;
;;-> Recursive Process
;;
;;(define (+ a b)
;;  (if (= a 0)
;;      b
;;      (+ (dec a) (inc b))))
;;
;;(+ 4 5)
;;(+ (dec 4) (inc 5)) -> (+ 3 6)
;;(+ (dec 3) (inc 6)) -> (+ 2 7)
;;(+ (dec 2) (inc 7)) -> (+ 1 8)
;;(+ (dec 1) (inc 8)) -> (+ 0 9)
;;9
;;
;;-> Iterative Process
  
;; Exercise 1.10
  
(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A x (- y 1)))))

;; (A 1 10)
;; (A 1 (- 10 1)) -> (A 1 9)
;; ...
;; 2
;; 
;; (A 2 4)
;; ...
;; 2
;;
;; (A 3 3)
;; ...
;; 2

;; equivalent to 2y
(define (af n) (A 0 n))

;; equivalent to 2
(define (ag n) (A 1 n))

;; equivalent to 2
(define (ah n) (A 2 n))

;; equivalent to 5n^2
(define (ak n) (* 5 n n))
  

;; Section 1.2.2 (Tree Recusion)

;; fibonacci numbers
(define (rfib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (rfib (- n 1))
                 (rfib (- n 2))))))

(define (ifib n)
  (define (fib-iter sum2 sum1 count)
    (if (= n count) 
        (+ sum2 sum1)
        (fib-iter sum1 (+ sum2 sum1) (+ count 1))))
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (fib-iter 0 1 2))))

;; ways to count change
(define (count-change amount)
  (define (cc amount kinds-of-coins)
    (cond ((= amount 0) 1)
          ((or (< amount 0) (= kinds-of-coins 0)) 0)
          (else (+ (cc amount
                       (- kinds-of-coins 1))
                   (cc (- amount
                          (first-denomination kinds-of-coins))
                       kinds-of-coins)))))
  (define (first-denomination kinds-of-coins)
    (cond ((= kinds-of-coins 1) 1)
          ((= kinds-of-coins 2) 5)
          ((= kinds-of-coins 3) 10)
          ((= kinds-of-coins 4) 25)
          ((= kinds-of-coins 5) 50)))
  (cc amount 5))

;; increment function
(define (1+ n)
  (+ n 1))

;; decrement function
(define (1- n)
  (- n 1))

;; Exercise 1.11
(define (rfun n)
  (if (< n 3)
      3
      (+ (rfun (- n 1))
         (* 2 (rfun (- n 2)))
         (* 3 (rfun (- n 3))))))

(define (ifun n)
  (define (calc f3 f2 f1)
    (+ (* 1 f1) 
       (* 2 f2) 
       (* 3 f3)))
  (define (ifun-iter f3 f2 f1 count)
    (if (> count n)
        f1
        (ifun-iter f2 f1 (calc f3 f2 f1) (1+ count))))
  (if (< n 3)
      3
      (ifun-iter 3 3 3 3)))

;; Exercise 1.12
;; use the binomial theorem
(define (ncr n i)
  (/ (fact n) 
     (* (fact i) 
        (fact (- n i)))))

(define (pascal level elem)
  (ncr n i))

;; exponentiation
(define (rexpt n x)
  (if (= x 0)
      1
      (* n (rexpt n (1- x)))))

(define (iexpt n x)
  (define (iter-expt product count)
    (if (> count x)
        product
        (iter-expt (* product n) (1+ count))))
  (iter-expt 1 1))

;; Exercise 1.29
;; Simpson's Rule
(define (h a b n)
  (/ (- b a) n))
