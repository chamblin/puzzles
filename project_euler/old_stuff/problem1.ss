(require "common.ss")
;problem 1

(define (is-divisible-by-3-or-5 x) (or (= 0 (remainder x 3)) (= 0 (remainder x 5))))