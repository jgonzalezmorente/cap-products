namespace com.logali;

type Address {
    Street     : String;
    City       : String;
    State      : String(2);
    PostalCode : String(5);
    Country    : String(3);
}

// type EmailsAddresses_01 : many {
//     kind  : String;
//     email : String;
// }

// type EmailsAddresses_02 {
//     kind  : String;
//     email : String;
// }

// entity Emails {
//     email_01 :      EmailsAddresses_01;
//     email_02 : many EmailsAddresses_02;
//     email_03 : many {
//         kind  : String;
//         email : String;
//     }
// }

// type Gender : String enum {
//     male;
//     female;
// };

// entity Order {
//     clientGender : Gender;
//     status       : Integer enum {
//         submitted = 1;
//         fulfiller = 2;
//         shipped   = 3;
//         cancel    = -1;
//     };
//     priority     : String @assert.range enum {
//         high;
//         medium;
//         low;
//     }
// };

// entity Car {
//     key ID                 : UUID;
//         name               : String;
//         virtual discount_1 : Decimal;
//         @Core.Computed: false
//         virtual discount_2 : Decimal;
// }

// Elementos Virtuales en SAP CAP y OData
// --------------------------------------
// 1. Definición de Elementos Virtuales:
//    Los elementos virtuales son definiciones en el modelo de datos que no corresponden a columnas físicas en la base de datos.
//    Estos elementos están presentes en los metadatos del servicio OData y son utilizados para representar datos calculados o derivados.

// 2. Comportamiento por Defecto de Elementos Virtuales:
//    Por defecto, los elementos virtuales están anotados con @Core.Computed: true.
//    Esto indica que los valores de estos campos son calculados dinámicamente por la aplicación en tiempo de ejecución.
//    La lógica específica para estos cálculos puede variar y depende de la implementación del servicio o aplicación.

// 3. Restricciones en la Modificación:
//    Dado que los elementos virtuales son por defecto computados, son de solo lectura.
//    Esto significa que no se pueden modificar directamente mediante operaciones de entrada del cliente como POST o PUT,
//    ya que el sistema no espera que estos campos sean proporcionados o alterados por el cliente.

// 4. Hacer Elementos Virtuales Escribibles:
//    Si se requiere que un elemento virtual acepte valores a través de operaciones de cliente, como una petición POST,
//    se debe anotar explícitamente con @Core.Computed: false.
//    Aunque esta anotación permite que el elemento sea escribible, es importante recordar que sigue siendo no persistente.
//    Esto significa que cualquier valor proporcionado por el cliente para este campo no se almacenará en la base de datos y
//    deberá ser gestionado adecuadamente por la lógica del backend durante el ciclo de vida de la operación o sesión.

// 5. Consideraciones de Diseño:
//    Al cambiar la anotación de un elemento virtual de @Core.Computed: true a @Core.Computed: false,
//    se debe planificar cómo se manejarán estos valores en la aplicación.
//    Puede ser necesario implementar mecanismos adicionales para procesar, validar o almacenar estos valores de manera temporal o en otras estructuras de datos.


type Dec : Decimal(16, 2);

entity Products {
    key ID               : UUID;
        Name             : String not null;
        Description      : String;
        ImageUrl         : String;
        ReleaseDate      : DateTime default $now;
        DiscontinuedDate : DateTime;
        Price            : Dec;
        Height           : type of Price;
        Width            : Decimal(16, 2);
        Depth            : Decimal(16, 2);
        Quantity         : Decimal(16, 2);
        Supplier         : Association to Suppliers;
        UnitOfMeasure    : Association to UnitOfMeasures;
        Currency         : Association to Currencies;
        DimensionUnit    : Association to DimensionUnits;
        Category         : Association to Categories;
        SalesData        : Association to many SalesData
                               on SalesData.Product = $self;
        Reviews          : Association to many ProductReview
                               on Reviews.Product = $self;
};

entity Suppliers {
    key ID      : UUID;
        Name    : type of Products : Name;
        Address : Address;
        Email   : String;
        Phone   : String;
        Fax     : String;
        Product : Association to many Products
                      on Product.Supplier = $self;
};

entity Orders {
    key ID       : UUID;
        Date     : Date;
        Customer : String;
        // Item     : Composition of many OrderItems
        //                on Item.Order = $self;
        Item     : Composition of many {
                       key Position : Integer;
                           Order    : Association to Orders;
                           Product  : Association to Products;
                           Quantity : Integer;

                   }
};

entity OrderItems {
    key ID       : UUID;
        Order    : Association to Orders;
        Product  : Association to Products;
        Quantity : Integer;
}


entity Categories {
    key ID   : String(1);
        Name : String;
};

entity StockAvailability {
    key ID          : Integer;
        Description : String;
};

entity Currencies {
    key ID          : String(3);
        Description : String;
};

entity UnitOfMeasures {
    key ID          : String(2);
        Description : String;
};

entity DimensionUnits {
    key ID          : String(2);
        Description : String;
};

entity Months {
    key ID               : String(2);
        Description      : String;
        ShortDescription : String(3);
};

entity ProductReview {
    key ID      : UUID;
        Name    : String;
        Rating  : Integer;
        Comment : String;
        Product : Association to Products;
};

entity SalesData {
    key ID            : UUID;
        DeliveryDate  : DateTime;
        Revenue       : Decimal(16, 2);
        Product       : Association to Products;
        Currency      : Association to Currencies;
        DeliveryMonth : Association to Months;
};

entity SelProducts   as select from Products;

entity SelProducts1  as
    select from Products {
        *
    };

entity SelProducts2  as
    select from Products {
        Name,
        Price,
        Quantity
    };

entity SelProducts3  as
    select from Products
    left join ProductReview
        on Products.Name = ProductReview.Name
    {
        Rating,
        Products.Name,
        sum(Price) as TotalPrice
    }
    group by
        Rating,
        Products.Name
    order by
        Rating;

entity ProjProducts  as projection on Products;

entity ProjProducts2 as
    projection on Products {
        *
    };

entity ProjProducts3 as
    projection on Products {
        ReleaseDate,
        Name
    };

// entity ParamProducts(pName : String) as
//     select from Products {
//         Name,
//         Price,
//         Quantity
//     }
//     where
//         Name = :pName;

// entity ProjParamProducts(pName: String) as projection on Products where Name = :pName;

extend Products with {
    PriceConditions    : String(2);
    PriceDetermination : String(3);
};

entity Course {
    key ID      : UUID;
        Student : Association to many StudentCourse
                      on Student.Course = $self;
}

entity Student {
    key ID     : UUID;
        Course : Association to many StudentCourse
                     on Course.Student = $self;
}

entity StudentCourse {
    key ID      : UUID;
        Student : Association to Student;
        Course  : Association to Course;
}
