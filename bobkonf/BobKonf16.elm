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


### Reden wir über Indiana Jones!

![Der einzige Kinoheld, ever...](img/crusade.jpg)


# Der Name Gottes...

![Jehova oder Iehova?](img/indylc_3949.jpg)


## JS-Entwickler kennen das!

![Total logisch](img/js_madness.PNG)


![Grals Tagebuch](img/grals_tagebuch.jpg)


![Stackoverflow](img/stackoverflow_pixel.PNG)


![Stackoverflow zum Zweiten](img/stackoverflow_js.PNG)


# "reserved words" in JavaScript

abstract, arguments, boolean, break, byte, case, catch, char, class, const, continue, debugger, default, delete, do, double, else, enum, eval, export, extends, false, final, finally, float, for, function, goto, if, implements, import, in, instanceof, int, interface, let, long, native, new, null, package, private, protected, public, return, short, static, super, switch, synchronized, this, throw, throws, transient, true, try, typeof, var, void, volatile, while, with, yield


## Und in Elm: 63 vs. 14

alias, as, case, else, if, import, in, let, module, of, port, then, type, where


# JavaScript Projektstruktur

17 Verzeichnisse

54 Dateien


## Elm Projektstruktur

1 Verzeichnis

8 Dateien 

(LOC im Schnitt gleich)


# Was ist Elm?

Elm ist eine funktionale, reaktive Sprache


# Was ist Elm?

Funktion: Nimmt Input und produziert Output. Sonst nichts.

Insbesondere keine Seiteneffekte.

Werte sind "immutable".


# Was ist Elm?

Stark und statisch typisierte Sprache mit Typinferenz.

Typdeklarationen sind optional. 

Der Kompiler ist ein Sahnestück.


# Und was macht man damit?

"The compiler happens to produce JavaScript" 


# Und was macht man damit?

2D-Spiele

Nutzer-Oberflächen für das Web

Alles, was man mit JS machen kann...


# Und was macht man damit?

Node.js wird noch nicht gut unterstützt


# Beispiel: Präsentation

Slides mit Markdown

Navigation mit Pfeiltasten 


# Präsentation: Model

    -- Data
    type alias Slide = String

    -- past, current, future
    -- elm-community/elm-undo-redo
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