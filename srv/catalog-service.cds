using com.logali as logali from '../db/schema';

@protocol: ['graphql', 'odata']
define service CatalogService {
    entity Products          as
        select from logali.reports.Products {
            ID,
            Name          as ProductName     @mandatory,
            Description                      @mandatory,
            ImageUrl,
            ReleaseDate,
            DiscontinuedDate,
            Price                            @mandatory,
            Height,
            Width,
            Depth,
            Quantity                         @(
                mandatory,
                assert.range: [
                    0.00,
                    20
                ]
            ),
            UnitOfMeasure as ToUnitOfMeasure @mandatory,
            Currency      as ToCurrency      @mandatory,
            Currency.ID   as CurrencyId,
            Category      as ToCategory      @mandatory,            
            Category.ID   as CategoryId,
            Category.Name as Category        @readonly,
            DimensionUnit as ToDimensionUnit,
            SalesData,
            Supplier,
            Reviews,
            Rating,
            StockAvailability,
            ToAverageRating
        };

    @readonly
    entity Supplier          as
        select from logali.sales.Supplier {
            ID,
            Name,
            Email,
            Phone,
            Fax,
            Product as ToProduct
        };

    entity Review            as
        select from logali.materials.ProductsReview {
            ID,
            Name,
            Rating,
            Comment,
            createdAt,
            Product as ToProducts
        };

    @readonly
    entity SalesData         as
        select from logali.sales.SalesData {
            ID,
            DeliveryDate,
            Revenue,
            Currency.ID               as CurrencyKey,
            DeliveryMonth             as DeliveryMonthId,
            DeliveryMonth.Description as DeliveryMonth,
            Product                   as ToProduct
        };

    @readonly
    entity StockAvailability  as
        select from logali.materials.StockAvailability {
            ID,
            Description,
            Product as ToProduct
        };

    @readonly
    entity VH_Categories     as
        select from logali.materials.Category {
            ID   as Code,
            Name as Text
        };

    @readonly
    entity VH_Currencies     as
        select from logali.materials.Currencies {
            ID          as Code,
            Description as Text
        };

    @readonly
    entity VH_UnitOfMeasure  as
        select from logali.materials.UnitOfMeasure {
            ID          as Code,
            Description as Text
        };

    @readonly
    entity VH_DimensionUnits as
        select
            ID          as Code,
            Description as Text
        from logali.materials.DimensionsUnits;
};

define service MyService {
    entity SupplierProduct  as
        select from logali.materials.Products[Name = 'Producto 7']{
            *,
            Name,
            Description,
            Supplier.Address
        }
        where
            Supplier.Address.PostalCode = 83889;

    entity SuppliersToSales as
        select
            Supplier.Email,
            Category.Name,
            SalesData.Currency.ID as Currency
        from logali.materials.Products;

    entity EntityInfix      as
        select Supplier[Name = 'Proveedor 3'].Phone from logali.materials.Products
        where
            Products.Name = 'Producto 7';

    entity EntityJoin       as
        select Phone from logali.materials.Products
        left join logali.sales.Supplier as supp
            on  supp.ID   = Products.Supplier.ID
            and supp.Name = 'Proveedor 3'
        where
            Products.Name = 'Producto 7';
};

define service Reports {
    entity AverageRating as projection on logali.reports.AverageRating;
    entity EntityCasting as
        select 
            cast (Price as Integer) as Price,
            Price as Price2 : Integer
        from logali.materials.Products;
    entity EntityExists as 
        select from logali.materials.Products {
            Name
        } where exists Supplier[Name = 'Proveedor 10'];
}
