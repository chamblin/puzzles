(define (sum l) (foldr (lambda (x y) (+ x y)) 0 l))
(define (seq x y) (if (< x y) (cons x (seq (+ 1 x) y)) `()))