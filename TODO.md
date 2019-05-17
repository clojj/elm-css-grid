unify Length and Fractional types
-

Each parameter can be a <length>, a <percentage>, a <flex> value, or one of the keyword values max-content, min-content, or auto.

Sizes: "42px" "8ch" "auto", etc.
-
see https://developer.mozilla.org/en-US/docs/Web/CSS/grid-template-rows

see https://developer.mozilla.org/en-US/docs/Web/CSS/grid-template-columns

Some properties allow negative <length>s, while others do not.

rename or remove module `CssGrid`
-

parameterize by fixed responsive 'profile' ("best-practices" media-queries) ?
-

test invalid templates.. add some validations ?
-

- 'bad' templates can be defined, if the areas column- or row-length differs from any grid-template-rows/columns 

- 'bad' templates can be defined, if the areas are do not shape a rectangle
