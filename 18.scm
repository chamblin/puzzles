(use srfi-1)
; takes two rows of a triangle and reduces them into one row
(define (reduce-bottom-of-a-triangle top-row bottom-row) 
	(if (null? top-row)
		`()
		(cons (reduce-one-item (car top-row) (take bottom-row 2)) (reduce-bottom-of-a-triangle (cdr top-row) (cdr bottom-row)))
	)
)

(define (reduce-one-item item l) (+ item (max (car l) (cadr l))))

; expects an inverted list of decreasing size (that is, a triangle)
; reduces it to one row, ideally the top row
; with only one element left, the maximum.

(define (reduce-triangle triangle) (if (> (length triangle) 1)
	(reduce-triangle (cons (reduce-bottom-of-a-triangle (cadr triangle) (car triangle)) (cddr triangle)))
	triangle
)
)

(print (reduce-triangle `((04 62 98 27 23 09 70 98 73 93 38 53 60 04 23) (63 66 04 68 89 53 67 30 73 16 69 87 40 31) (91 71 52 38 17 14 91 43 58 50 27 29 48) (70 11 33 28 77 73 17 78 39 68 17 57) (53 71 44 65 25 43 91 52 97 51 14) (41 48 72 33 47 32 37 16 94 29) (41 41 26 56 83 40 80 70 33) (99 65 04 28 06 16 70 92) (88 02 77 73 07 63 67) (19 01 23 75 03 34) (20 04 82 47 65) (18 35 87 10) (17 47 82) (95 64) (75))))

