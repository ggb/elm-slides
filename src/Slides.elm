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

-- type Direction = Left | Right

options =
  { githubFlavored = Just { tables = False, breaks = False }
  , defaultHighlighting = Just "elm"
  , sanitize = False
  , smartypants = False
  }


fromList : List String -> SlideZipper
fromList list =
  case list of
    (head::rest) -> 
      ([], head, rest)
    [] ->
      ([], "", [])


--view : SlideZipper -> Html
view (_, currentSlide, _) =
  Markdown.toHtmlWith options currentSlide


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
      

state : SlideZipper -> Signal SlideZipper
state initialSlides = 
  Signal.foldp update initialSlides Keyboard.arrows


start : SlideZipper -> Signal Html
start initialSlides =
  Signal.map view (state initialSlides)