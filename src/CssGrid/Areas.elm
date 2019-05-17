module CssGrid.Areas exposing (Areas, GridArea, GridAreaElement, gridArea, gridAreaElement, gridAreaElementArea, gridAreaElementChildren, toString)

{-| Represents a [grid-area](https://developer.mozilla.org/en-US/docs/Web/CSS/grid-area), uniquely identified by a name.
-}

import Html.Styled exposing (Html)


type GridArea
    = GridArea String


type alias Areas =
    List (List GridArea)


toString : GridArea -> String
toString (GridArea value) =
    value


{-| Constructs a `GridArea` which is uniquely identified by name.
The name of the grid-area must be unique for the entire view.

    gridArea "header"

The resulting GridArea will be appear in the resulting CSS in two places:

1.  As a substring in the list-of-strings-value of the `grid-template-areas` property (aka CSS Grid container definition)
2.  As the value of a `grid-area` property

-}
gridArea : String -> GridArea
gridArea name =
    GridArea name


{-| Opaque type representing a grid-area element
-}
type GridAreaElement msg
    = GridAreaElement
        { area : GridArea
        , children : List (Html msg)
        }


{-| Creates a grid-area element that gets its grid-position by the area's name
-}
gridAreaElement : GridArea -> List (Html msg) -> GridAreaElement msg
gridAreaElement area children =
    GridAreaElement
        { area = area
        , children = children
        }


gridAreaElementArea : GridAreaElement msg -> GridArea
gridAreaElementArea (GridAreaElement { area }) =
    area


gridAreaElementChildren : GridAreaElement msg -> List (Html msg)
gridAreaElementChildren (GridAreaElement { children }) =
    children
