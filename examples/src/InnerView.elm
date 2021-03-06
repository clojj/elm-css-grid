module InnerView exposing (simpleTemplateBig, viewInner)

import Areas exposing (cont, contLeft, contRight, foot, head, navi)
import Css as Css
import Css.Media as Media exposing (only, screen)
import CssGrid.Areas exposing (GridArea, gridAreaElement)
import CssGrid.Sizes exposing (fr, gap, px, units)
import Html.Styled exposing (Html, div, p, text)
import Html.Styled.Attributes exposing (css)
import SimpleGrid exposing (ResponsiveTemplate, SimpleTemplate, mediaGridContainer, simpleTemplate)


simpleTemplateBig : SimpleTemplate
simpleTemplateBig =
    simpleTemplate
        [ [ head, navi, navi ]
        , [ contLeft, cont, contRight ]
        , [ foot, foot, foot ]
        ]
        (gap (px 3))
        [ units (fr 1), units (fr 1), units (fr 1) ]


simpleTemplateSmall : SimpleTemplate
simpleTemplateSmall =
    simpleTemplate
        [ [ head ]
        , [ contLeft ]
        , [ cont ]
        , [ contRight ]
        , [ navi ]
        , [ foot ]
        ]
        (gap (px 5))
        []


bigScreenTemplate : ResponsiveTemplate
bigScreenTemplate =
    ( [ only screen [ Media.minWidth (Css.px 401) ] ], simpleTemplateBig )


smallScreenTemplate : ResponsiveTemplate
smallScreenTemplate =
    ( [ only screen [ Media.maxWidth (Css.px 400) ] ], simpleTemplateSmall )


viewInner : () -> Html.Styled.Html msg
viewInner _ =
    mediaGridContainer [ bigScreenTemplate, smallScreenTemplate ]
        []
        [ gridAreaElement head (panel <| text "head")
        , gridAreaElement navi (panel <| text "navi")
        , gridAreaElement contLeft (panel <| p [] [ text "left" ])
        , gridAreaElement cont (panel <| p [] [ text "cont" ])
        , gridAreaElement contRight (panel <| p [] [ text "right" ])
        , gridAreaElement foot (panel <| text "foot")
        ]


panel : Html msg -> List (Html msg)
panel html =
    [ div [ css [ Css.border3 (Css.px 1) Css.solid (Css.rgb 20 20 20) ] ] [ html ] ]
