# elm-slides

Everyone needs to write his own presentation tool in Elm...

Just import the Slides-module and do something like this:

```elm
main : Signal Html
main = 
  mySlides
  |> String.split "\n\n\n"
  |> Slides.fromList
  |> Slides.start
  
mySlides = """
# First Slide

Lots of Content


# Second Slide

cont'd


... 
"""
```

## BOB 2016-Slides

Take a look at [http://www.graphomate.com/bobkonf16](graphomate.com/bobkon16) to see this tiny module in 
action. If you would like to learn more about Elm and see this tiny module even more in action 
[here](https://youtu.be/hG6Q8RZKg28) is my BOB 2016-Talk on Elm.