namespace com.training;

using {cuid} from '@sap/cds/common';

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

// entity ParamProducts(pName : String) as
//     select
//         Name,
//         Price,
//         Quantity
//     from Products
//     where
//         Name = :pName;

// entity ProjParamProducts(pName: String) as projection on Products where Name = :pName;

entity Course : cuid {
    Students : Association to many StudentCourse
                   on Students.Course = $self;
}

entity Student : cuid {
    Courses : Association to many StudentCourse
                  on Courses.Student = $self;
}

entity StudentCourse : cuid {
    Student : Association to Student;
    Course  : Association to Course;
}

entity Orders {
    key ClientEmail : String(65);
        FirstName   : String(30);
        LastName    : String(30);
        CreatedOn   : Date;
        Reviewed    : Boolean;
        Approved    : Boolean;
}
