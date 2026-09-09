#lang r7rs

(import (scheme base)
        (boids constants))

(export make-logic)


(define-library ()
  (begin
    (define (make-logic)
      
      (define (update-callback! flock dt)
        (for-each
         (lambda (boid)
           ((boid 'set-x!) (+ (boid 'x) (* (boid 'vx) dt)))
           ((boid 'set-y!)  (+ (boid 'y) (* (boid 'vy) dt)))
           
           (when (or (> (boid 'x) (- height size)) (< (boid 'x) 0))
             ((boid 'set-vx!) (- (boid 'vx))))
           (when (or (> (boid 'y) (- width size)) (< (boid 'y) 0))
             ((boid 'set-vy!) (- (boid 'vy)))))
         flock))
      
      
      (lambda (msg)
        (cond ((eq? msg 'update-callback!) update-callback!)
              (else (error "Logic-ADT -- Unknown message: " msg)))))))
