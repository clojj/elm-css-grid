module Main exposing (Model, bigScreenTemplate, bootstrapPanel, initialModel, main, smallScreenTemplate, testPanel, update, view)

import Areas exposing (cont1, contLeft1, contRight1, foot1, head1, navi1)
import Bootstrap.CDN as CDN
import Bootstrap.Card as Card
import Bootstrap.ListGroup as ListGroup
import Browser
import Css as Css
import Css.Media as Media exposing (MediaQuery, only, screen)
import CssGrid.Areas exposing (gridAreaElement)
import CssGrid.Simple exposing (ResponsiveTemplate, SimpleTemplate, simpleContainer, simpleTemplate)
import CssGrid.Sizes exposing (..)
import Html
import Html.Styled exposing (Attribute, Html, div, fromUnstyled, text, toUnstyled)
import Html.Styled.Attributes exposing (css)
import Simple exposing (viewSimple)


type alias Model =
    ()



initialModel : Model
initialModel =
    ()


update : msg -> Model -> Model
update _ model =
    model


view : Model -> Html.Styled.Html msg
view model =
    simpleContainer [ bigScreenTemplate, smallScreenTemplate ]
        []
        [ gridAreaElement head1 (testPanel "header ")
        , gridAreaElement navi1 (testPanel "nav ")
        , gridAreaElement cont1 [ fromUnstyled CDN.stylesheet, bootstrapPanel, viewSimple model ]
        , gridAreaElement foot1 (testPanel "footer ")
        ]

simpleTemplateBig : SimpleTemplate
simpleTemplateBig =
    simpleTemplate
        [ [ head1, navi1, navi1 ]
        , [ contLeft1, cont1, contRight1 ]
        , [ foot1, foot1, foot1 ]
        ]
        (gap (px 3))
        [ fr 1, fr 1, fr 1 ]


simpleTemplateSmall : SimpleTemplate
simpleTemplateSmall =
    simpleTemplate
        [ [ head1 ]
        , [ navi1 ]
        , [ contLeft1 ]
        , [ contRight1 ]
        , [ cont1 ]
        , [ foot1 ]
        ]
        (gap (px 5))
        []


bigScreenTemplate : ResponsiveTemplate
bigScreenTemplate =
    ( [ only screen [ Media.minWidth (Css.px 401) ] ], simpleTemplateBig )


smallScreenTemplate : ResponsiveTemplate
smallScreenTemplate =
    ( [ only screen [ Media.maxWidth (Css.px 400) ] ], simpleTemplateSmall )


bootstrapPanel =
    Card.config []
        |> Card.listGroup
            [ ListGroup.li [ ListGroup.success ] [ Html.text "Cras justo odio" ]
            , ListGroup.li [ ListGroup.info ] [ Html.text "Dapibus ac facilisis in" ]
            , ListGroup.li [ ListGroup.warning ] [ Html.text "Vestibulum at eros" ]
            ]
        |> Card.view
        |> fromUnstyled


testPanel : String -> List (Html msg)
testPanel name =
    [ div [ css [ Css.border3 (Css.px 3) Css.solid (Css.rgb 50 50 50) ] ] (List.repeat 2 (text name)) ]


main : Program () Model msg
main =
    Browser.sandbox
        { view = view >> toUnstyled
        , update = update
        , init = initialModel
        }
