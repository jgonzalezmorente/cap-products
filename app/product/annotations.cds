using CatalogService as service from '../../srv/catalog-service';

annotate service.Products with @(
    Capabilities: {
        DeleteRestrictions : {
            $Type : 'Capabilities.DeleteRestrictionsType',
            Deletable: false
        },
    },    
    UI.HeaderInfo                : {
        TypeName      : '{i18n>Product}',
        TypeNamePlural: '{i18n>Products}',
        ImageUrl      : ImageUrl,
        Title         : {Value: ProductName},
        Description   : {Value: Description}
    },
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            // {
            //     $Type : 'UI.DataField',
            //     Label:'{i18n>ProductName}',
            //     Value : ProductName,
            // },
            // {
            //     $Type : 'UI.DataField',
            //     Label:'{i18n>Description}',
            //     Value : Description,
            // },
            // {
            //     $Type : 'UI.DataField',
            //     Label:'{i18n>ImageUrl}',
            //     Value : ImageUrl,
            // },
            {
                $Type: 'UI.DataField',
                Label:'{i18n>ReleaseDate}',
                Value: ReleaseDate,
            },
            {
                $Type: 'UI.DataField',
                Label:'{i18n>DiscontinuedDate}',
                Value: DiscontinuedDate,
            },
            {
                $Type: 'UI.DataField',
                Label:'{i18n>Price}',
                Value: Price,
            },
            {
                $Type: 'UI.DataField',
                Label:'{i18n>Height}',
                Value: Height,
            },
            {
                $Type: 'UI.DataField',
                Label:'{i18n>Width}',
                Value: Width,
            },
            {
                $Type: 'UI.DataField',
                Label:'{i18n>Depth}',
                Value: Depth,
            },
            {
                $Type: 'UI.DataField',
                Label:'{i18n>Quantity}',
                Value: Quantity,
            },
            {
                $Type: 'UI.DataField',
                Label:'{i18n>ToUnitOfMeasure_ID}',
                Value: ToUnitOfMeasure_ID,
            },
            {
                $Type: 'UI.DataField',
                Label:'{i18n>ToCurrency_ID}',
                Value: ToCurrency_ID,
            },
            {
                $Type: 'UI.DataField',
                Label:'{i18n>ToCategory_ID}',
                Value: ToCategory_ID,
            },
            {
                $Type: 'UI.DataField',
                Label:'{i18n>Category}',
                Value: Category,
            },
            {
                $Type: 'UI.DataField',
                Label:'{i18n>ToDimensionUnit_ID}',
                Value: ToDimensionUnit_ID,
            },
            {
                // $Type: 'UI.DataField',
                Label:'{i18n>Rating}',
                // Value: Rating,
                $Type: 'UI.DataFieldForAnnotation',
                Target: '@UI.DataPoint#AverageRating'

            },
            {
                $Type: 'UI.DataField',
                Label:'{i18n>StockAvailability}',
                Value: StockAvailability,
            },
        ],
    },
    UI.FieldGroup #GeneratedGroup2: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label:'{i18n>ProductName}',
                Value : ProductName,
            },
            {
                $Type : 'UI.DataField',
                Label:'{i18n>Description}',
                Value : Description,
            },
            {
                $Type : 'UI.DataField',
                Label:'{i18n>ImageUrl}',
                Value : ImageUrl,
            },
        ],
    },    
    UI.Facets                    : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label:'{i18n>General Information}',
            Target: '@UI.FieldGroup#GeneratedGroup'
        }, 
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet2',
            Label:'{i18n>General Information 2}',
            Target: '@UI.FieldGroup#GeneratedGroup2'
        }, 
    ],
    UI.SelectionFields           : [
        CategoryId,
        CurrencyId,
        StockAvailability
    ],
    UI.LineItem                  : [
        {
            $Type: 'UI.DataField',
            Label:'{i18n>ImageUrl}',
            Value: ImageUrl,
        },
        {
            $Type: 'UI.DataField',
            Label:'{i18n>ProductName}',
            Value: ProductName,
        },
        {
            $Type: 'UI.DataField',
            Label:'{i18n>Description}',
            Value: Description,
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Label:'{i18n>Supplier}',
            Target: 'Supplier/@Communication.Contact'
        },
        {
            $Type: 'UI.DataField',
            Label:'{i18n>ReleaseDate}',
            Value: ReleaseDate,
        },
        {
            $Type: 'UI.DataField',
            Label:'{i18n>DiscontinuedDate}',
            Value: DiscontinuedDate,
        },
        {
            Label:'{i18n>Stock Availability}',
            Value      : StockAvailability,
            Criticality: StockAvailability,
        },
        {
            // $Type: 'UI.DataField',
            $Type: 'UI.DataFieldForAnnotation',
            Label:'{i18n>Rating}',
            Target: '@UI.DataPoint#AverageRating'
            // Value: Rating,

        },
        {
            $Type: 'UI.DataField',
            Label:'{i18n>Price}',
            Value: Price,
        },
    ],
);

annotate service.Products with {
    CategoryId @title: '{i18n>CategoryId}';
    CurrencyId @title: '{i18n>CurrencyId}';
    StockAvailability @title: 'Stock Availability';
};

annotate service.Products with {
    Supplier @Common.ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'Supplier',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: Supplier_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Name',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Email',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Phone',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Fax',
            },
        ],
    }
};

annotate service.Products with {
    ImageUrl @(UI.IsImageURL: true);
};

/**
 * Annotations for SH
 */
annotate service.Products with {
    // Category
    Category          @(UI.Hidden: true);

    ToCategory        @(Common: {
        Label:'{i18n>Category}',
        Text     : {
            $value                : Category,
            ![@UI.TextArrangement]: #TextOnly,
        },
        ValueList: {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'VH_Categories',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: ToCategory_ID,
                    ValueListProperty: 'Code'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'Text'
                }
            ],
        },
    });

    // Currency
    ToCurrency        @(Common: {
        ValueListWithFixedValues: false,
        ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'VH_Currencies',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: ToCurrency_ID,
                    ValueListProperty: 'Code'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'Text'
                }
            ]
        },
    });

    StockAvailability @(Common: {
        ValueListWithFixedValues: true,
        ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'StockAvailability',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: StockAvailability,
                ValueListProperty: 'ID'
            }]
        },
    });

};

/**
 * Annotations for VH_Categories Entity
 */
annotate service.VH_Categories with {
    Code @(
        UI.HiddenFilter: true,
        Common         : {
            Label:'{i18n>Category}',
            Text : {
                $value                : Text,
                ![@UI.TextArrangement]: #TextLast,
            }
        }
    );
    Text @(UI.Hidden: true);
};

/**
 * Annotations for VH_Currencies Entity
 */
annotate service.VH_Currencies with {
    Code @(UI: {HiddenFilter: true});
    Text @(UI: {HiddenFilter: true});
};

/**
 * Annotations for StockAvailability Entity
 */
annotate service.StockAvailability with {
    ID @(Common: {Text: {
        $value                : Description,
        ![@UI.TextArrangement]: #TextLast,
    }, });
};

/**
 * Annotations for VH_UnitOfMeasure Entity
 */
annotate service.VH_UnitOfMeasure with {
    Code @(UI: {HiddenFilter: true});
    Text @(UI: {HiddenFilter: true});
};

/**
 * Annotations for VH_DimensionUnits Entity
 */
annotate service.VH_DimensionUnits with {
    Code @(UI: {HiddenFilter: true});
    Text @(UI: {HiddenFilter: true});
};

/**
 * Annotations for Supplier Entity
 */
annotate service.Supplier with @(Communication: {Contact: {
    $Type: 'Communication.ContactType',
    fn   : Name,
    role : 'Supplier',
    photo: 'sap-icon://supplier',
    email: [{
        type   : #work,
        address: Email
    }],
    tel  : [
        {
            type: #work,
            uri : Phone
        },
        {
            type: #fax,
            uri : Fax
        }
    ]
}, });

annotate service.Products with @(
UI.DataPoint #AverageRating: {
    Value: Rating,
    Title: 'Rating',
    TargetValue: 5,
    Visualization: #Rating
}
);
 