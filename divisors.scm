(use srfi-1)
(load "number-lists.scm")

(define (divisors n)
	(flatten (map (lambda (x) (list x (/ n x))) (filter (lambda (x) (= 0 (remainder n x))) (seq 1 (sqrt n)))))
)