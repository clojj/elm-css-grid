module CssGrid.Sizes exposing (Auto, Gap, Length, MinMax, fr, gap, gapToString, lengthToString, minmax, minmaxToString, px)

-- minmax(min, max)


type MinMax
    = MinMax Length Length


minmax : Length -> Length -> MinMax
minmax min max =
    MinMax min max


minmaxToString : MinMax -> String
minmaxToString (MinMax min max) =
    "minmax(" ++ lengthToString min ++ ", " ++ lengthToString max ++ ")"


{-| auto
-}
type Auto
    = Auto



-- TODO type <percentage>


type Length
    = Fr Float
    | Px Int


px : Int -> Length
px length =
    Px length


fr : Float -> Length
fr length =
    Fr length


lengthToString : Length -> String
lengthToString length =
    case length of
        Fr float ->
            String.fromFloat float ++ "fr"

        Px int ->
            String.fromInt int ++ "px"


type Gap
    = Gap Length


gapToString : Gap -> String
gapToString (Gap value) =
    lengthToString value


gap : Length -> Gap
gap length =
    Gap length
