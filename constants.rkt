#lang r7rs

(define-library ()

  (import (scheme base))

  (export height
          width
          size
          boid-count
          seperation-radius
          alignment-radius
          cohesion-radius
          seperation-weight
          alignment-weight
          cohesion-weight
          )


  (begin
    (define size 16)
    (define height 800)
    (define width 800)
    (define boid-count 50)
    (define seperation-radius 15)
    (define alignment-radius 50)
    (define cohesion-radius 100)
    (define seperation-weight 0.001)
    (define alignment-weight  0.01)
    (define cohesion-weight 0.0001)
    
    ))
