#lang r7rs

(define-library ()

  (import (scheme base))

  (export height
          width
          size
          )


  (begin
    (define size 20)
    (define height 800)
    (define width 800)
    ))
