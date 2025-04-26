using {com.logali as logali} from '../db/schema';

service CatalogService {
    entity Products       as projection on logali.Products;
    entity Supplier       as projection on logali.Supplier;
    entity UnitOfMeasure  as projection on logali.UnitOfMeasure;
    entity Currency       as projection on logali.Currencies;
    entity Months         as projection on logali.Months;
    entity DimensionUnit  as projection on logali.DimensionsUnits;
    entity Category       as projection on logali.Category;
    entity SalesData      as projection on logali.SalesData;
    entity ProductsReview as projection on logali.ProductsReview;
    entity Order          as projection on logali.Orders;
    entity OrderItem      as projection on logali.OrderItems;
}
