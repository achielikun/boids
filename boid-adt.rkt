#lang r7rs

(define-library ()


  (import (scheme base))
  (export make-boid)
  
  (begin
    
    (define (make-boid)
      (let ((x 150)
            (y 150))
        (define (set-x! new-x)
          (set! x new-x))

        (define (set-y! new-y)
          (set! y new-y))
        
        (lambda (msg)
          (cond ((eq? msg 'x) x)
                ((eq? msg 'y) y)
                ((eq? msg 'set-x!) set-x!)
                ((eq? msg 'set-y!) set-y!)
                (else (error "Boid-adt -- Unknown message: " msg))
                ))))))



