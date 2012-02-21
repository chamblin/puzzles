(use srfi-1)
(load "number-lists.scm")

(define (divisors n)
	(flatten (map (lambda (x) (list x (/ n x))) (filter (lambda (x) (= 0 (remainder n x))) (seq 1 (sqrt n)))))
)

; xs expects a non-empty list, try `(1)
(define (first-triangle-number-with-n-divisors n xs)
	(if (>= (length (divisors (car xs))) n)
		(car xs)
		(first-triangle-number-with-n-divisors n (cons-triangle-number xs))
	)
)

(define (cons-triangle-number xs)
	(if (null? xs)
		`()
		(cons (+ 1 (car xs) (length xs)) xs)
	)
)

(print (first-triangle-number-with-n-divisors 500 `(1)))