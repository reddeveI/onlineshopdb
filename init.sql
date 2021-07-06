-- *************** SqlDBM: PostgreSQL ****************;
-- ***************************************************;


-- ************************************** "public".Customer

CREATE TABLE "public".Customer
(
 CustomerId   integer NOT NULL GENERATED ALWAYS AS IDENTITY (
 start 1
 ),
 CustomerName varchar(50) NOT NULL,
 Phone        varchar(20) NULL,
 CONSTRAINT PK_Customer PRIMARY KEY ( CustomerId ),
 CONSTRAINT AK1_Customer_CustomerName UNIQUE ( CustomerName )
);

COMMENT ON TABLE "public".Customer IS 'Basic information 
about Customer';


-- ************************************** "public".PaymentType

CREATE TABLE "public".PaymentType
(
 PaymentTypeId integer NOT NULL,
 Name          varchar(50) NOT NULL,
 Description   varchar(50) NULL,
 CONSTRAINT PK_paymenttype PRIMARY KEY ( PaymentTypeId )
);


-- ************************************** "public"."Order"

CREATE TABLE "public"."Order"
(
 OrderId       integer NOT NULL GENERATED ALWAYS AS IDENTITY (
 start 1
 ),
 OrderNumber   varchar(10) NULL,
 CustomerId    integer NOT NULL,
 OrderDate     timestamp NOT NULL,
 TotalAmount   decimal(12,2) NOT NULL,
 PaymentTypeId integer NOT NULL,
 CONSTRAINT PK_Order PRIMARY KEY ( OrderId ),
 CONSTRAINT AK1_Order_OrderNumber UNIQUE ( OrderNumber ),
 CONSTRAINT FK_Order_CustomerId_Customer FOREIGN KEY ( CustomerId ) REFERENCES "public".Customer ( CustomerId ),
 CONSTRAINT FK_139 FOREIGN KEY ( PaymentTypeId ) REFERENCES "public".PaymentType ( PaymentTypeId )
);

CREATE INDEX FK_Order_CustomerId_Customer ON "public"."Order"
(
 CustomerId
);

CREATE INDEX fkIdx_140 ON "public"."Order"
(
 PaymentTypeId
);

COMMENT ON TABLE "public"."Order" IS 'Order information
like Date, Amount';

-- ************************************** "public".Supplier

CREATE TABLE "public".Supplier
(
 SupplierId  integer NOT NULL GENERATED ALWAYS AS IDENTITY (
 start 1
 ),
 CompanyName varchar(40) NOT NULL,
 Phone       varchar(20) NULL,
 CONSTRAINT PK_Supplier PRIMARY KEY ( SupplierId ),
 CONSTRAINT AK1_Supplier_CompanyName UNIQUE ( CompanyName )
);

COMMENT ON TABLE "public".Supplier IS 'Basic information 
about Supplier';


-- ************************************** "public".Product

CREATE TABLE "public".Product
(
 ProductId      integer NOT NULL GENERATED ALWAYS AS IDENTITY (
 start 1
 ),
 ProductName    varchar(50) NOT NULL,
 SupplierId     integer NOT NULL,
 UnitPrice      decimal(12,2) NULL,
 CONSTRAINT PK_Product PRIMARY KEY ( ProductId ),
 CONSTRAINT AK1_Product_SupplierId_ProductName UNIQUE ( SupplierId, ProductName ),
 CONSTRAINT FK_Product_SupplierId_Supplier FOREIGN KEY ( SupplierId ) REFERENCES "public".Supplier ( SupplierId )
);

CREATE INDEX FK_Product_SupplierId_Supplier ON "public".Product
(
 SupplierId
);

COMMENT ON TABLE "public".Product IS 'Basic information 
about Product';

-- ************************************** "public".OrderProduct

CREATE TABLE "public".OrderProduct
(
 OrderId   integer NOT NULL,
 ProductId integer NOT NULL,
 UnitPrice decimal(12,2) NOT NULL,
 Quantity  integer NOT NULL,
 CONSTRAINT PK_OrderItem PRIMARY KEY ( OrderId, ProductId ),
 CONSTRAINT FK_OrderItem_OrderId_Order FOREIGN KEY ( OrderId ) REFERENCES "public"."Order" ( OrderId ),
 CONSTRAINT FK_OrderItem_ProductId_Product FOREIGN KEY ( ProductId ) REFERENCES "public".Product ( ProductId )
);

CREATE INDEX FK_OrderItem_OrderId_Order ON "public".OrderProduct
(
 OrderId
);

CREATE INDEX FK_OrderItem_ProductId_Product ON "public".OrderProduct
(
 ProductId
);

COMMENT ON TABLE "public".OrderProduct IS 'Information about
like Price, Quantity';











