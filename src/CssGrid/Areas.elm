module CssGrid.Areas exposing
    ( Areas
    , GridArea
    , GridAreaElement
    , gridArea
    , gridAreaElement
    , gridAreaElementArea
    , gridAreaElementChildren
    , toString
    )

import Html.Styled exposing (Html)


type GridArea
    = GridArea String


type alias Areas =
    List (List GridArea)


toString : GridArea -> String
toString (GridArea value) =
    value


{-| Represents a [grid-area](https://developer.mozilla.org/en-US/docs/Web/CSS/grid-area), uniquely identified by a name.
The name of the grid-area must be unique for the entire view.

    gridArea "header"

The resulting GridArea will be appear in the resulting CSS in two places:

1.  As an element of the template-definition.
2.  As the value of the `grid-area` property in a Html element, which gets its layout from the template-definition.

-}
gridArea : String -> GridArea
gridArea name =
    GridArea name


type GridAreaElement msg
    = GridAreaElement
        { area : GridArea
        , children : List (Html msg)
        }


{-| Creates a Html element with the CSS property `grid-area`. The Html child elements will be layouted according to the area names defined in the template.
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
