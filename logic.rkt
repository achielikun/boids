#lang r7rs

(import (scheme base))

(export make-logic)


(define-library ()
  (begin
    (define (make-logic)
      (let ((x 100)
            (y 100)
            (vx 0.2)
            (vy 0.2))


        (define (update-callback! dt)
          (set! x (+ x (* vx dt)))
          (set! y (+ y (* vy dt)))
          
          (when (or (> x (- height size)) (< x 0)) (set! x (- x vx)))
          (when (or (> y (- width size)) (< y 0)) (set! y (- y vy))))


        (lambda (msg)
          ((cond ((eq? msg 'update-callback!) (update-callback!))
                 (else (error "Logic-ADT -- Unknown message: " msg)))))))))
