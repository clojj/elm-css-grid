module Main exposing (main)

import Browser
import Css exposing (backgroundColor, height, px, rgb, width)
import Grid exposing (gridContainer, gridElement)
import Html.Styled exposing (button, div, text, toUnstyled)
import Html.Styled.Attributes exposing (css)


type alias Model =
    ()


initialModel : Model
initialModel =
    ()


main : Program () Model msg
main =
    Browser.sandbox
        { view = view >> toUnstyled
        , update = update
        , init = initialModel
        }


update : msg -> Model -> Model
update msg model =
    model


view : Model -> Html.Styled.Html msg
view model =
    gridContainer
        []
        [ gridElement "button" [ button [] [ text "Button" ] ]
        , gridElement "url" [ text "Url" ]
        , gridElement "main" [ div [ css [ width (px 490), height (px 200), backgroundColor (rgb 150 150 150) ] ] [ text "Main" ] ]
        ]
