; specific to more than one problem
(module common mzscheme
(define (seq x y) (if (<= x y) (cons x (seq (+ 1 x) y)) `()))
(define (is-even x) (= 0 (remainder x 2)))
(define (sum l) (foldr (lambda (x y) (+ x y)) 0 l))
(define (fib x) (if (< x 3) 1 (+ (fib (- x 1)) (fib (- x 2)))))
(define (largest l) (foldr (lambda (x y) (if (> x y) x y)) (car l) l))
(define (flatten list)
  (cond ((null? list) '())
	((list? (car list)) (append (flatten (car list)) (flatten (cdr list))))
	(else
	 (cons (car list) (flatten (cdr list))))))
(define (square x) (* x x))
(define (all? f l) (foldr (lambda (itm acc) (and acc (f itm))) #t l))
(define (any? f l) (foldr (lambda (itm acc) (or acc (f itm))) #f l))
(define (uniq l) (if (empty? l) `() (cons (car l) (uniq (filter (lambda (x) (not (= (car l) x))) (cdr l))))))
(define (primes-in l) (if (empty? l) `() (cons (car l) (filter (lambda (x) (not (= 0 (remainder x (car l))))) (cdr l)))))
(provide seq is-even sum fib largest flatten square all? any? uniq primes-in))