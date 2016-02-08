module BobKonf16 where

import String
import Slides 

main = 
  mySlides
  |> String.split "\n\n\n"
  |> Slides.fromList
  |> Slides.start 


mySlides = """
# First Slide

Text, Text, Text


# Seconde Slide

even more Text...


# Third Slide

on and on

"""