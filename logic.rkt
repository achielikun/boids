#lang r7rs

(import (scheme base)
        (boids constants))

(export make-logic)


(define-library ()
  (begin
    (define (make-logic)
      (let ((vx 0.2)
            (vy 0.2))


        (define (update-callback! boid dt)
          ((boid 'set-x!) (+(boid 'x) (* vx dt)))
          ((boid 'set-y!)  (+ (boid 'y) (* vy dt)))
          
          (when (or (> (boid 'x) (- height size)) (< (boid 'x) 0)) ((boid 'set-x!) (- (boid 'x) vx)))
          (when (or (> (boid 'y) (- width size)) (< (boid 'y) 0)) ((boid 'set-y!) (- (boid 'y) vy))))


        (lambda (msg)
          (cond ((eq? msg 'update-callback!) update-callback!)
                 (else (error "Logic-ADT -- Unknown message: " msg))))))))
