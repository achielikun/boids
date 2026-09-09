#lang r7rs

(define-library ()

  (import (scheme base))

  (export height
          width
          size
          boid-count
          )


  (begin
    (define size 12)
    (define height 800)
    (define width 800)
    (define boid-count 50)
    ))
