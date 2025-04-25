using {com.logali as logali} from '../db/schema';

service CatalogService {
    entity Products as projection on logali.Products;
    entity Supplier as projection on logali.Supplier;
    // entity Car      as projection on logali.Car;
}
