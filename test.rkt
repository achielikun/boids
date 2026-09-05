#lang r7rs

(import (scheme base)
        (boids logic)
        (boids constants)
        (boids boid-adt)
        (prefix (racket gui) gui:)
        (prefix (racket base) base:))




(define logic (make-logic))
;; 1. Create the window frame
(define frame (gui:new gui:frame% 
                        (label "test")
                        (width width)
                        (height height)))
;; (define x 150)
;; (define y 150)
;; (define vx 0.2)
;; (define vy 0.2)
(define boid (make-boid))


(define previous-time (base:current-milliseconds))
(define fps-accum-time 0)
(define fps-frames 0)
(define target-fps 400)
(define ms-per-frame (quotient 1000 target-fps))






  

(define (draw-callback! canvas dc)
  (gui:send dc set-background "white")
  (gui:send dc clear)
  
  
  (gui:send dc set-brush "black" 'solid)
  (gui:send dc draw-ellipse (boid 'x)(boid 'y) 20 20))

(define canvas (gui:new gui:canvas% 
                          (parent frame)
                          (paint-callback draw-callback!)))




(define (game-loop)
  (let* ((current-time (base:current-milliseconds))
         (dt( - current-time previous-time)))
    (set! previous-time current-time)
    (set! fps-accum-time (+ fps-accum-time dt))
    (set! fps-frames (+ fps-frames 1))

    (when (>= fps-accum-time 1000)
      (gui:send frame set-label
                (string-append "test - FPS: " (number->string fps-frames)))
      (set! fps-frames 0)
      (set! fps-accum-time (- fps-accum-time 1000)))
    ((logic 'update-callback!) boid dt)
    ;; (update-callback! dt)               
    (gui:send canvas refresh)

    (let* ((end-time (base:current-milliseconds))
           (frame-duration (- end-time current-time))
           (wait-time (max 1 (- ms-per-frame frame-duration))))
      (gui:send timer start wait-time #t))))

(define timer (gui:new gui:timer%
                       (notify-callback game-loop)
                       (just-once? #t)))

    


(gui:send frame show #t)
(gui:send timer start 1 #t)



