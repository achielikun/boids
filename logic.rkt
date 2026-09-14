#lang r7rs

(import (scheme base)
        (scheme inexact)
        (boids constants))

(export make-logic)


(define-library ()
  (begin
    (define (make-logic)

      (define (euclid-distance b1 b2)
        (let ((dx (- (b1 'x) (b2 'x)))
              (dy (- (b1 'y) (b2 'y))))
          (sqrt (+ (* dx dx) (* dy dy)))))


      
      (define (seperation boid flock)
        (let loop ((rest flock)
                    (sep-x 0.0)
                    (sep-y 0.0))
          (let* ((other (if (null? rest) #f (car rest)))
                 (dist  (if other (euclid-distance boid other) 0.0)))
            (cond ((null? rest) (cons sep-x sep-y))
                  ((and (not (eq? boid other)) (< dist seperation-radius)) (loop (cdr rest) (+ sep-x (- (boid 'x) (other 'x))) (+ sep-y (- (boid 'y) (other 'y)))))
                  (else (loop (cdr rest) sep-x sep-y))))))
      
      
      (define (alignment boid flock)
        (let loop ((rest flock)
                   (align-x 0.0)
                   (align-y 0.0)
                   (count 0))
          (let* ((other (if (null? rest) #f (car rest)))
                 (dist  (if other (euclid-distance boid other) 0.0)))
            (cond ((and (null? rest) (> count 0)) (cons (- (/ align-x count) (boid 'vx)) (- (/ align-y count) (boid 'vy))))
                  ((null? rest) (cons 0.0 0.0))
                  ((and (not (eq? boid other)) (< dist alighnment-radius)) (loop (cdr rest) (+ align-x (other 'vx)) (+ align-y (other 'vy)) (+ count 1)))
                  (else (loop (cdr rest) align-x align-y count))))))


      (define (cohesion boid flock)
        (let loop ((rest flock)
                   (coh-x 0.0)
                   (coh-y 0.0)
                   (count 0))
          (let* ((other (if (null? rest) #f (car rest)))
                 (dist  (if other (euclid-distance boid other) 0.0)))
            (cond ((and (null? rest) (> count 0)) (cons (- (/ coh-x count) (boid 'x)) (- (/ coh-y count) (boid 'y))))
                  ((null? rest) (cons 0.0 0.0))
                  ((and (not (eq? boid other)) (< dist cohesion-radius)) (loop (cdr rest) (+ coh-x (other 'x)) (+ coh-y (other 'y)) (+ count 1)))
                  (else (loop (cdr rest) coh-x coh-y count))))))
                                                  
                   
        
        



        
                   
                   
      
      
      
      
      (define (update-callback! flock dt)

        ;;boid properties
        (for-each
         (lambda (boid)
           (let* ((sep (seperation boid flock))
                  (ali (alignment boid flock))
                  (coh (cohesion boid flock))
                  (new-vx (+ (boid 'vx) (* (car sep) 0.001) (* (car ali) 0.01) (* (car coh) 0.0001)))
                  (new-vy (+ (boid 'vy) (* (car sep) 0.001) (* (car ali) 0.01) (* (car coh) 0.0001))))
             ((boid 'set-vx!) new-vx)
             ((boid 'set-vx!) new-vx)))
           flock)
                    
        ;;move and handle borders
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
