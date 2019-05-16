
parameterize by fixed responsive 'profile' ("best-practices" media-queries) ?
-

test invalid templates.. add some validations ?
-

```
gridTemplateBad : GridTemplate
gridTemplateBad =
    template
        [ [ headerGridArea ], [], [ navGridArea ], [ footerGridArea ] ]
        []
        []
```

```
gridTemplateBad_ : GridTemplate
gridTemplateBad_ =
    template
        [ [ headerGridArea ]
        , [ contentGridArea, contentGridArea ]
        , [ navGridArea ]
        , [ footerGridArea ]
        ]
        []
        []
```