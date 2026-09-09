#lang r7rs

(define-library ()


  (import (scheme base)
          (only (racket base) random)
          (boids constants))
  (export make-boid)
  
  (begin
    
    (define (make-boid)
      (let ((x (random width))
            (y (random height))
            (vx (- (* (random)0.4)0.2))
            (vy (- (* (random) 0.4) 0.2)))
        (define (set-x! new-x)
          (set! x new-x))

        (define (set-y! new-y)
          (set! y new-y))

        (define (set-vx! new-vx)
          (set! vx new-vx))

        (define (set-vy! new-vy)
          (set! vy new-vy))
        
        (lambda (msg)
          (cond ((eq? msg 'x) x)
                ((eq? msg 'y) y)
                ((eq? msg 'vx) vx)
                ((eq? msg 'vy) vy)
                ((eq? msg 'set-x!) set-x!)
                ((eq? msg 'set-y!) set-y!)
                ((eq? msg 'set-vx!) set-vx!)
                ((eq? msg 'set-vy!) set-vy!)
                (else (error "Boid-adt -- Unknown message: " msg))
                ))))))



