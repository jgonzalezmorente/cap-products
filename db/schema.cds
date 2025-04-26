namespace com.logali;

type Name : String(50);

type Address {
    Street     : String;
    City       : String;
    State      : String(2);
    PostalCode : String(5);
    Country    : String(3);
};

// type EamilsAddresses_01 : many {
//     kind  : String;
//     email : String;
// };

// type EamilsAddresses_02 {
//     kind  : String;
//     email : String;
// };

// entity Emails {
//     email_01 :      EamilsAddresses_01;
//     email_02 : many EamilsAddresses_02;
//     email_03 : many {
//         kind  : String;
//         email : String;
//     }
// };

// type Gender : String enum {
//     male;
//     female;
// };

// entity Order {
//     clientgender : Gender;
//     status       : Integer enum {
//         submitted = 1;
//         fulfiller = 2;
//         shipped   = 3;
//         cancel    = -1;
//     };
//     priority     : String @assert.range enum {
//         hight;
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

type Dec  : Decimal(16, 2);

entity Products {
    key ID               : UUID;
        Name             : String not null;
        Description      : String;
        ImageUrl         : String;
        ReleaseDate      : DateTime default $now;
        DiscontinuedDate : DateTime;
        Price            : Dec;
        Height           : type of Price; // Decimal(16, 2);
        Width            : Decimal(16, 2);
        Depth            : Decimal(16, 2);
        Quantity         : Decimal(16, 2);
        Supplier         : Association to one Supplier;
        UnitOfMeasure    : Association to UnitOfMeasure;
        Currency         : Association to Currencies;
        DimensionUnit    : Association to DimensionsUnits;
        Category         : Association to Category;
        SalesData        : Association to many SalesData
                               on SalesData.Product = $self;
        Reviews          : Association to many ProductsReview
                               on Reviews.Product = $self;
}

entity Orders {
    key ID       : UUID;
        Date     : Date;
        Customer : String;
        Items     : Composition of many OrderItems
                       on Items.Order = $self;
};

entity OrderItems {
    key ID       : UUID;
        Order    : Association to Orders;
        Product  : Association to Products;
        Quantity : Integer;
}

entity Supplier {
    key ID       : UUID;
        Name     : Products:Name; // String;
        Address  : Address;
        Email    : String;
        Phone    : String;
        Fax      : String;
        Products : Association to many Products
                       on Products.Supplier = $self;
};

entity Category {
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

entity UnitOfMeasure {
    key ID          : String(2);
        Description : String;
};

entity DimensionsUnits {
    key ID          : String(2);
        Description : String;
};

entity Months {
    key ID               : String(2);
        Description      : String;
        ShortDescription : String(3);
};

entity ProductsReview {
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
    left join ProductsReview
        on Products.Name = ProductsReview.Name
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
//     select
//         Name,
//         Price,
//         Quantity
//     from Products
//     where
//         Name = :pName;

// entity ProjParamProducts(pName: String) as projection on Products where Name = :pName;

extend Products with {
    PriceCondition     : String(2);
    PriceDetermination : String(3);
};

entity Course {
    key ID       : UUID;
        Students : Association to many StudentCourse
                       on Students.Course = $self;
}

entity Student {
    key ID      : UUID;
        Courses : Association to many StudentCourse
                      on Courses.Student = $self;
}

entity StudentCourse {
    key ID      : UUID;
        Student : Association to Student;
        Course  : Association to Course;
}
