(use srfi-1)
(load "number-lists.scm")

(define (sieve l)
	(let ((max-value (sqrt (car (take-right l 1)))))
		(if (> (car l) max-value)
			l
			(cons
				(car l)
				(let ((divisor (car l)))
					(let ((square-of-the-divisor (* divisor divisor)))
						(let ((bisected-lists (bisect-list-at square-of-the-divisor (cdr l))))
							(sieve
								(append
									(car bisected-lists)
									(remove-divisible-by divisor (cadr bisected-lists))
								)
							)
						)
					)
				)
			)
		)
	)
)

(define (remove-divisible-by divisor list)
	(filter
		(lambda (x)
			(not (= 0 (remainder x divisor)))
		)
		list
	)
)

(define (primes-to n) (cons 2 (sieve (seq-step 3 n 2))))