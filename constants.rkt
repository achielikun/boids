#lang r7rs

(define-library ()

  (import (scheme base))

  (export height
          width
          size
          boid-count
          seperation-radius
          alighnment-radius
          cohesion-radius
          )


  (begin
    (define size 16)
    (define height 800)
    (define width 800)
    (define boid-count 50)
    (define seperation-radius 15)
    (define alighnment-radius 50)
    (define cohesion-radius 100)
    
    ))
