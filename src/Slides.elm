module Slides where

import Signal
import Keyboard
import Markdown
import Html exposing (Html)


-- Data
-- elm-community/elm-undo-redo
type alias Slide = String

-- past, current, future
type alias SlideZipper = ( List Slide, Slide, List Slide )


slide1 : Slide
slide1 = """
# First Slide
Text text text
"""


slide2 : Slide
slide2 = """
# Second Slide
More text
![Eichhoernchen](http://tinyurl.com/oahq83h)
"""


slide3 : Slide
slide3 = """
# Third Slide
Etc. etc. 
"""


slides : SlideZipper
slides = ([], slide1, [slide2, slide3])


view : SlideZipper -> Html
view (_, currentSlide, _) =
  Markdown.toHtml currentSlide


goForward : SlideZipper -> SlideZipper
goForward (past, current, future) =
  case future of
    [] ->
      (past, current, future)
    (next::rest) ->
      (current::past, next, rest)


goBack : SlideZipper -> SlideZipper
goBack (past, current, future) =
  case past of
    [] ->
      (past, current, future)
    (last::rest) ->
      (rest, last, current::future)


update : {x:Int, y:Int} -> SlideZipper -> SlideZipper
update {x, y} model =
  if x == 1 || y == 1 then
    goForward model 
  else if x == -1 || y == -1 then
    goBack model 
  else
    model
      

state : Signal SlideZipper
state = 
  Signal.foldp update slides Keyboard.arrows


main : Signal Html
main =
  Signal.map view state