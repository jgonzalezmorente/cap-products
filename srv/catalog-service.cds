using com.logali as logali from '../db/schema';
// using com.training as training from '../db/training';

// service CatalogService {
//     entity Products       as projection on logali.materials.Products;
//     entity Supplier       as projection on logali.sales.Supplier;
//     entity UnitOfMeasure  as projection on logali.materials.UnitOfMeasure;
//     entity Currency       as projection on logali.materials.Currencies;
//     entity Months         as projection on logali.sales.Months;
//     entity DimensionUnit  as projection on logali.materials.DimensionsUnits;
//     entity Category       as projection on logali.materials.Category;
//     entity SalesData      as projection on logali.sales.SalesData;
//     entity ProductsReview as projection on logali.materials.ProductsReview;
//     entity Order          as projection on logali.sales.Orders;
//     entity OrderItem      as projection on logali.sales.OrderItems;
// }

define service CatalogService {
    entity Products          as
        select from logali.materials.Products {
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
            Quantity,
            UnitOfMeasure as ToUnitOfMeasure @mandatory,
            Currency      as ToCurrency      @mandatory,
            Category      as ToCategory      @mandatory,
            Category.Name as Category        @readonly,
            DimensionUnit as ToDimensionUnit,
            SalesData,
            Supplier,
            Reviews
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
    entity StockAvailabilit  as
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
        select from logali.materials.DimensionsUnits {
            ID          as Code,
            Description as Text
        };
}
