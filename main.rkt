#lang racket
(define sums (list))
(define highest 0)
(for
  ((i (string-split (file->string "input.txt") "\n\n")))
  (define current_list
    (map (lambda (s) (string->number s)) (string-split i "\n")))
  (define current_sum (foldr + 0 current_list))
  (set! sums (append sums (list current_sum)))
  (when (> current_sum highest) (set! highest current_sum)))
(set! sums (sort sums >))
(display "Part 1: ")
(display highest)
(display "\nPart 2: ")
(display (foldr + 0 (take sums 3)))
(display "\n")