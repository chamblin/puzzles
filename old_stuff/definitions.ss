;; The first three lines of this file were inserted by DrScheme. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname definitions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ())))
; specific to more than one problem

(define (seq x y) (seq-step x y 1))
(define (seq-step x y s) (if (<= x y) (cons x (seq (+ s x) y)) `()))
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

;problem 1

(define (is-divisible-by-3-or-5 x) (or (= 0 (remainder x 3)) (= 0 (remainder x 5))))

;problem 2

(define (fib-list limit l)
	(let ([next-fib	(+ (car l) (cadr l))])
		(if (< next-fib limit) (fib-list limit (cons next-fib l)) l)
	)
)

;problem 3

(define (largest-prime-factor x y)
	(if (> y x)
		y
		(if (= 0 (remainder x y))
			(largest (list y (largest-prime-factor (/ x y) 2)))
			(largest-prime-factor x (+ 1 y))
		)
	)
)

;problem 4

(define (factors-of x l) (filter (lambda (j) (= 0 (remainder x j))) l))

(define (list-equal? l1 l2)
  (if (= (length l1) (length l2))
    (if (and (empty? l1) (empty? l2))
      #t
      (if (= (car l1) (car l2)) (list-equal? (cdr l1) (cdr l2)) #f)
    )
    #f
  )
)

(define (number-to-list x)
  (if (= 0 x)
      `()
      (cons (remainder x 10) (number-to-list (floor (/ x 10))))
  )
)

(define (list-to-number l) (foldl (lambda (itm acc) (+ (* acc 10) itm)) 0 l))

(define (is-palindrome? x)
  (list-equal? (number-to-list x) (reverse (number-to-list x)))
)

(define (all-multiples l1 l2)
  (uniq (flatten (map (lambda (x) (map (lambda (y) (* y x)) l2)) l1)))
)

(define (odd-palindromes x)
  (map (lambda (i) (list-to-number (append (reverse (number-to-list x)) (list i) (number-to-list x)))) (seq 0 9))
)

(define (even-palindromes x)
  (list (list-to-number (append (reverse (number-to-list x)) (number-to-list x))))
)

(define (potential-palindromes)
  (append (flatten (map (lambda (x) (odd-palindromes x)) (seq 10 99))) (flatten (map (lambda (x) (even-palindromes x)) (seq 100 999))))
)

(define (is-divisible-by-two-three-digit-numbers x) (any? (lambda (i) (and (= 0 (remainder x i)) (= 3 (length (number-to-list (/ x i)))))) (seq 100 999)))
; l must be sorted from greatest to least
(define (largest-divisible-by-a-three-digit-number l)
  (if (empty? l)
      null
      (if (is-divisible-by-two-three-digit-numbers (car l))
          (car l)
          (largest-divisible-by-a-three-digit-number (cdr l)))
  )
)

;problem 5
;relative-primes assumes it gets a sorted, descending list of numbers
(define (relative-primes l) (if (empty? l) `() (cons (car l) (relative-primes (filter (lambda (x) (not (= 0 (remainder (car l) x)))) (cdr l))))))
(define (least-common-multiple-acc l acc) (if (all? (lambda (x) (= 0 (remainder acc x))) l) acc (least-common-multiple-acc l (+ acc (largest l)))))
(define (least-common-multiple l) (least-common-multiple-acc l (largest l)))

  
;problem 6
(define (sum-of-squares l) (sum (map square l)))
(define (square-of-sums l) (square (sum l)))

;problem 7
(define (one-more-prime l)
	(if (empty? l)
		`(2)
		(cons (next-prime l (+ 1 (car l))) l)
	)
)

(define (next-prime l x)
	(if (any? (lambda (i) (= 0 (remainder x i))) l)
		(next-prime l (+ 1 x))
		x
	)
)

(define (nth-prime n l)
  (if (= 0 n)
      (car l)
      (nth-prime (- n 1) (one-more-prime l))
  )
)

;problem 8
(define (product l)
  (foldl * 1 l)
)

(define (first-n l n)
  (if (or (= 0 n) (empty? l))
      `()
      (append (list (car l)) (first-n (cdr l) (- n 1)))
  )
)
(define (largest-product-number l current-winner)
  (if (empty? l)
      current-winner
      (if (> (product current-winner) (product (first-n l 5)))
          (largest-product-number (cdr l) current-winner)
          (largest-product-number (cdr l) (first-n l 5))
      )
  )
)

;problem 9
(define (leg-pairs x)
  (map (lambda (i) (list i (- x i))) (seq 1 (/ x 2)))
)

(define (is-pythagorean-triplet? l) (= (+ (* (car l) (car l)) (* (cadr l) (cadr l))) (* (caddr l) (caddr l))))

(define (find-pythagorean-triplet-with-sum n c)
  (if (= 0 c)
    `()
    (if (any? (lambda (triple) (is-pythagorean-triplet? triple)) (map (lambda (pair) (append pair (list c))) (leg-pairs (- n c))))
      (filter (lambda (triple) (is-pythagorean-triplet? triple)) (map (lambda (pair) (append pair (list c))) (leg-pairs (- n c))))
      (find-pythagorean-triplet-with-sum n (- c 1))
    )
  )
)

;problem 10

(define (sieve primes l)
 (if (empty? l)
     primes
     (sieve (append primes (list (car l))) (filter (lambda (x) (not (= 0 (remainder x (car l))))) l))
 )
)

;problem 14
(define (collatz-sequence n)
  (if (= n 1)
      `(1)
      (if (is-even n)
          (append (list n) (collatz-sequence (/ n 2)))
          (append (list n) (collatz-sequence (+ (* n 3) 1)))
       )
  )
)

(define (longest-collatz-sequence-start-number l) (foldr (lambda (itm acc) (if (> (length (collatz-sequence itm)) (length (collatz-sequence acc))) itm acc)) (car l) l))