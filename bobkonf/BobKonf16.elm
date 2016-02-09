module BobKonf16 where

import String
import Slides 

main = 
  mySlides
  |> String.split "\n\n\n"
  |> Slides.fromList
  |> Slides.start 


mySlides = """
# Elm im produktiven Einsatz

von Gregor Große-Bölting


# Elm (fast) im produktiven Einsatz

von Gregor Große-Bölting


# Elm im produktiven Einsatz

Was ist Elm? Und was macht man damit?

Warum denn gerade mit Elm?

Wie habt ihr das gemacht?

Wo kann ich das lernen?


# Was ist Elm?

Funktionale Sprache


# Was ist Elm?

Funktion: Nimmt Input und produziert Output. Sonst nichts.

Insbesondere keine Seiteneffekte.

Werte sind "immutable".


# Was ist Elm?

Stark und statisch typisierte Sprache mit Typinferenz.

Typdeklarationen sind optional. 

Der Kompiler ist ein Sahnestück.


# Was ist Elm?

"Functional Reactive"


# Und was macht man damit?

"The compiler happens to produce JavaScript" 


# Und was macht man damit?

2D-Spiele

Nutzer-Oberflächen für das Web

Alles, was man mit JS machen kann...


# Und was macht man damit?

Node.js wird noch nicht gut unterstützt


# Beispiel: Präsentation

* Slides mit Markdown
* Navigation mit Pfeiltasten
* 


# Präsentation: Model

    -- Data
    -- elm-community/elm-undo-redo
    type alias Slide = String

    -- past, current, future
    type alias SlideZipper = ( List Slide, Slide, List Slide )

    -- type Direction = Left | Right


# Präsentation: View

    view : SlideZipper -> Html -- optional!
    view (_, currentSlide, _) =
      Markdown.toHtml currentSlide


# Präsentation: Update

    update : {x:Int, y:Int} -> SlideZipper -> SlideZipper
    update {x, y} model =
      if x == 1 || y == 1 then
        goForward model 
      else if x == -1 || y == -1 then
        goBack model 
      else
        model


# Präsentation: Update

    goForward : SlideZipper -> SlideZipper
    goForward (past, current, future) =
      case future of
        [] ->
          (past, current, future)
        (next::rest) ->
          (current::past, next, rest)


# Präsentation: Update

    goBack : SlideZipper -> SlideZipper
    goBack (past, current, future) =
      case past of
        [] ->
          (past, current, future)
        (last::rest) ->
          (rest, last, current::future)


# Präsentation: "Glue Code"

    state : Signal SlideZipper
    state = 
      Signal.foldp update initialSlides Keyboard.arrows
  
    main : Signal Html
    main =
      Signal.map view state
"""