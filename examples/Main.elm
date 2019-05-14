module Main exposing (Model, contentGridItem, footerGridItem, gridTemplateBad, gridTemplateBad_, gridTemplateBig, gridTemplateSmall, headerGridItem, initialModel, main, myContainer, navGridItem, update, view)

import Array2D
import Browser
import Css exposing (backgroundColor, border, border3, dashed, height, pct, px, rgb, solid)
import Css.Media as Media exposing (MediaQuery, only, screen, withMedia)
import Grid
import Html.Styled exposing (button, div, text, toUnstyled)
import Html.Styled.Attributes exposing (css, style)


type alias Model =
    ()


headerGridItem : Grid.Area
headerGridItem =
    Grid.gridArea "header"


navGridItem : Grid.Area
navGridItem =
    Grid.gridArea "nav"


contentGridItem : Grid.Area
contentGridItem =
    Grid.gridArea "content"


footerGridItem : Grid.Area
footerGridItem =
    Grid.gridArea "footer"


{-| all rows will be []
-}
gridTemplateBad : Grid.GridTemplate
gridTemplateBad =
    Grid.template
        (Array2D.fromList [ [ headerGridItem ], [], [ navGridItem ], [ footerGridItem ] ])
        []
        []


{-| second contentGridItem is ignored
-}
gridTemplateBad_ : Grid.GridTemplate
gridTemplateBad_ =
    Grid.template
        (Array2D.fromList [ [ headerGridItem ], [ contentGridItem, contentGridItem ], [ navGridItem ], [ footerGridItem ] ])
        []
        []


gridTemplateBig : Grid.GridTemplate
gridTemplateBig =
    Grid.template
        (Array2D.fromList
            [ [ headerGridItem, navGridItem, navGridItem ]
            , [ contentGridItem, contentGridItem, contentGridItem ]
            , [ footerGridItem, footerGridItem, footerGridItem ]
            ]
        )
        [ "1fr", "4fr", "1fr" ]
        [ "1fr", "1fr", "1fr" ]


gridTemplateSmall : Grid.GridTemplate
gridTemplateSmall =
    Grid.template
        (Array2D.fromList
            [ [ headerGridItem ]
            , [ contentGridItem ]
            , [ navGridItem ]
            , [ footerGridItem ]
            ]
        )
        [ "1fr", "4fr", "1fr", "1fr" ]
        [ "1fr" ]


myContainer : Grid.GridContainer
myContainer =
    Grid.container [ ( [ only screen [ Media.minWidth (px 501) ] ], gridTemplateBig ) ]



-- TODO construct grid-container for example view


initialModel : Model
initialModel =
    ()


update : msg -> Model -> Model
update msg model =
    model


view : Model -> Html.Styled.Html msg
view model =
    Grid.gridContainer
        [ style "width" "100%", style "height" "100%" ]
        [ Grid.gridElement "button" [ button [] [ text "Button" ] ]
        , Grid.gridElement "url" [ text "Url" ]
        , Grid.gridElement "main" [ div [ css [ border3 (px 5) solid (rgb 50 50 50) ] ] [ text "Main" ] ]
        ]


main : Program () Model msg
main =
    Browser.sandbox
        { view = view >> toUnstyled
        , update = update
        , init = initialModel
        }
