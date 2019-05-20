module Main exposing (Model, bigScreenTemplate, bootstrapPanel, initialModel, main, smallScreenTemplate, testPanel, update, view)

import Areas exposing (cont1, contFix, contLeft1, contRight1, foot1, footFix, head1, headFix, navi1)
import Bootstrap.CDN as CDN
import Bootstrap.Card as Card
import Bootstrap.ListGroup as ListGroup
import Browser
import Css as Css
import Css.Media as Media exposing (MediaQuery, only, screen)
import CssGrid.Areas exposing (gridAreaElement)
import CssGrid.Sizes exposing (..)
import Html
import Html.Styled exposing (Attribute, Html, br, div, fromUnstyled, text, toUnstyled)
import Html.Styled.Attributes exposing (css)
import InnerView exposing (viewInner)
import SimpleGrid exposing (ResponsiveTemplate, SimpleTemplate, gridContainer, mediaGridContainer, simpleTemplate)


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
    div []
        [ mediaGridContainer [ bigScreenTemplate, smallScreenTemplate ]
            []
            [ gridAreaElement head1 (testPanel "header ")
            , gridAreaElement navi1 (testPanel "nav ")
            , gridAreaElement contLeft1 (testPanel "contLeft ")
            , gridAreaElement cont1 [ fromUnstyled CDN.stylesheet, bootstrapPanel, viewInner model ]
            , gridAreaElement contRight1 (testPanel "contRight ")
            , gridAreaElement foot1 (testPanel "footer ")
            ]
        , br [] []
        , gridContainer simpleTemplateFix
            []
            [ gridAreaElement headFix (testPanel "headFix ")
            , gridAreaElement contFix (testPanel "contFix ")
            , gridAreaElement footFix (testPanel "footFix ")
            ]
        ]


simpleTemplateFix : SimpleTemplate
simpleTemplateFix =
    simpleTemplate
        [ [ headFix ]
        , [ contFix ]
        , [ footFix ]
        ]
        (gap (px 3))
        [ minmax (px 400) (px 600) ]


simpleTemplateBig : SimpleTemplate
simpleTemplateBig =
    simpleTemplate
        [ [ head1, navi1, contRight1 ]
        , [ contLeft1, cont1, contRight1 ]
        , [ foot1, foot1, foot1 ]
        ]
        (gap (px 10))
        [ auto, units (fr 1), auto ]


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
