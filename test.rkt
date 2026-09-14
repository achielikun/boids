#lang r7rs

(import (scheme base)
        (boids logic)
        (boids constants)
        (boids boid-adt)
        (prefix (racket gui) gui:)
        (prefix (racket base) racket:))




(define logic (make-logic))
;; 1. Create the window frame
(define frame (gui:new gui:frame% 
                        (label "test")
                        (width width)
                        (height height)))


(define (make-boids)
    (do ((i 0 (+ i 1))
         (res '() (cons (make-boid) res)))
        ((= i boid-count) res)))

(define flock (make-boids))



(define previous-time (racket:current-milliseconds))
(define fps-accum-time 0)
(define fps-frames 0)
(define target-fps 400)
(define ms-per-frame (quotient 1000 target-fps))



(define (draw-callback! canvas dc)
  (gui:send dc set-background "white")
  (gui:send dc clear)
  (gui:send dc set-brush "black" 'solid)

  
  (for-each (lambda (boid)(gui:send dc draw-ellipse (boid 'x)(boid 'y) size size))flock))

(define canvas (gui:new gui:canvas% 
                          (parent frame)
                          (paint-callback draw-callback!)))




(define (game-loop)
  (let* ((current-time (racket:current-milliseconds))
         (dt( - current-time previous-time)))
    (set! previous-time current-time)
    (set! fps-accum-time (+ fps-accum-time dt))
    (set! fps-frames (+ fps-frames 1))

    (when (>= fps-accum-time 1000)
      (gui:send frame set-label
                (string-append "test - FPS: " (number->string fps-frames)))
      (set! fps-frames 0)
      (set! fps-accum-time (- fps-accum-time 1000)))
    ((logic 'update-callback!) flock dt)
    ;; (update-callback! dt)               
    (gui:send canvas refresh)

    (let* ((end-time (racket:current-milliseconds))
           (frame-duration (- end-time current-time))
           (wait-time (max 1 (- ms-per-frame frame-duration))))
      (gui:send timer start wait-time #t))))

(define timer (gui:new gui:timer%
                       (notify-callback game-loop)
                       (just-once? #t)))

    


(gui:send frame show #t)
(gui:send timer start 1 #t)



