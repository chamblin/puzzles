(load "divisors.scm")

(define (amicable-value n)
	(sum (proper-divisors n))
)

(define (is-amicable? n)
	(and (= n (amicable-value (amicable-value n))) (not (= n (amicable-value n))))
)

(define (amicable-pairs-less-than n)
	(filter
		(lambda (x) (< (amicable-value x) n))
		(amicable-pairs-in-list (seq 1 n))
	)
)

(define (amicable-pairs-in-list xs)
	(filter (lambda (x) (is-amicable? x)) xs)
)

(print (sum (amicable-pairs-less-than 10000)))