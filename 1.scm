(define (sum l) (foldr (lambda (x y) (+ x y)) 0 l))
(define (is-divisible-by-3-or-5 x) (or (= 0 (remainder x 3)) (= 0 (remainder x 5))))
(define (seq x y) (if (< x y) (cons x (seq (+ 1 x) y)) `()))
(define (numbers-divisible-by-3-or-5-less-than x) (filter is-divisible-by-3-or-5 (seq 1 x)))
(display (sum (numbers-divisible-by-3-or-5-less-than 1000)))
(display "\n")