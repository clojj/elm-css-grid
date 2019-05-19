module CssGrid.Sizes exposing
    ( Gap
    , Length
    , LengthTemplate
    , auto
    , fr
    , gap
    , gapToString
    , lengthTemplateToString
    , lengthToString
    , minmax
    , px
    , units
    )


type Length
    = Fr Float
    | Px Int


{-| A 'fractional' length
-}
fr : Float -> Length
fr length =
    Fr length


{-| A length in absolute pixels.
-}
px : Int -> Length
px length =
    Px length


lengthToString : Length -> String
lengthToString length =
    case length of
        Fr float ->
            String.fromFloat float ++ "fr"

        Px int ->
            String.fromInt int ++ "px"


type LengthTemplate
    = Units Length
    | Auto
    | MinMax Length Length


{-| Constructs a length, which can be used in a template-definition (like `grid-template-columns`)
-}
units : Length -> LengthTemplate
units =
    Units


{-| The `auto` value from CSS Grid.
-}
auto : LengthTemplate
auto =
    Auto


{-| The `minmax` function from CSS Grid.
-}
minmax : Length -> Length -> LengthTemplate
minmax min max =
    MinMax min max


lengthTemplateToString : LengthTemplate -> String
lengthTemplateToString length =
    case length of
        Units lengthUnits ->
            lengthToString lengthUnits

        Auto ->
            "auto"

        MinMax min max ->
            "minmax(" ++ lengthToString min ++ ", " ++ lengthToString max ++ ")"


type Gap
    = Gap Length


gapToString : Gap -> String
gapToString (Gap length) =
    lengthToString length


gap : Length -> Gap
gap length =
    Gap length
