module Main exposing (..)

import Browser
import Css exposing (backgroundColor, height, px, rgb, width)
import Grid
import Html.Styled exposing (button, div, text, toUnstyled)
import Html.Styled.Attributes exposing (css)


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


gridTemplateBig : Grid.GridTemplate
gridTemplateBig =
    Grid.template [ [ headerGridItem, headerGridItem ], [ navGridItem, navGridItem ], [ contentGridItem, contentGridItem ], [ footerGridItem, footerGridItem ] ]


gridTemplateSmall : Grid.GridTemplate
gridTemplateSmall =
    Grid.template [ [ headerGridItem ], [ contentGridItem ], [ navGridItem ], [ footerGridItem ] ]

gridTemplateInvalid : Grid.GridTemplate
gridTemplateInvalid =
    Grid.template [ [ headerGridItem ], [ contentGridItem, contentGridItem ], [ navGridItem ], [ footerGridItem ] ]


initialModel : Model
initialModel =
    ()


update : msg -> Model -> Model
update msg model =
    model


view : Model -> Html.Styled.Html msg
view model =
    Grid.gridContainer
        []
        [ Grid.gridElement "button" [ button [] [ text "Button" ] ]
        , Grid.gridElement "url" [ text "Url" ]
        , Grid.gridElement "main" [ div [ css [ width (px 490), height (px 200), backgroundColor (rgb 150 150 150) ] ] [ text "Main" ] ]
        ]


main : Program () Model msg
main =
    Browser.sandbox
        { view = view >> toUnstyled
        , update = update
        , init = initialModel
        }
