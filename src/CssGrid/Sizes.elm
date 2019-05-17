module CssGrid.Sizes exposing (Auto, Fraction, Gap, Length, MinMax, cm, fr, fractionToString, gapPx, gapToString, lengthToString, minmax, px)

-- minmax(min, max)


type MinMax
    = MinMax String


minmax : Length a String -> Length b String -> MinMax
minmax min max =
    MinMax <| "minmax(" ++ lengthToString min ++ ", " ++ lengthToString max ++ ")"


minmaxToString : MinMax -> String
minmaxToString (MinMax value) =
    value



-- TODO type <percentage>


{-| auto
-}
type Auto
    = Auto



-- TODO types <length>


type Px
    = Px


type Cm
    = Cm


type Length unit value
    = Length value


px : Int -> Length Px String
px length =
    Length <| String.fromInt length ++ "px"


cm : Float -> Length Cm String
cm length =
    Length <| String.fromFloat length ++ "cm"


lengthToString : Length unit String -> String
lengthToString (Length value) =
    value



-- type <flex> TODO as Length ?


type Fraction
    = Fraction String


fr : Int -> Fraction
fr value =
    Fraction <| String.fromInt value ++ "fr"


fractionToString : Fraction -> String
fractionToString (Fraction value) =
    value


type Gap
    = Gap String


gapToString : Gap -> String
gapToString (Gap value) =
    value

-- TODO Length parameter

gapPx : Int -> Gap
gapPx length =
    Gap <| String.fromInt length ++ "px"
