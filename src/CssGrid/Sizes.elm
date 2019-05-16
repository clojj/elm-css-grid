module CssGrid.Sizes exposing (Fraction, Gap, fr, gapPx, gapToString, fractionToString)

-- TODO types: "42px" "8ch" "auto", etc.
-- see https://developer.mozilla.org/en-US/docs/Web/CSS/grid-template-rows
-- see https://developer.mozilla.org/en-US/docs/Web/CSS/grid-template-columns


type Fraction
    = Fraction String


fr : Int -> Fraction
fr value =
    Fraction <| String.fromInt value ++ "fr"


fractionToString : Fraction -> String
fractionToString (Fraction value) =
    value



-- TODO types <length> and <percentage>


type Gap
    = Gap String


gapToString : Gap -> String
gapToString (Gap value) =
    value


gapPx : Int -> Gap
gapPx px =
    Gap <| String.fromInt px ++ "px"
