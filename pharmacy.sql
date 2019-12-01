
SET foreign_key_checks = 0;
DROP TRIGGER checkSurcharge;
DROP TABLE product_has_insurance;
DROP TABLE product_has_price;
DROP TABLE pharmacy_has_product;
DROP TABLE producer_has_product;
DROP TABLE invoice_has_product;
DROP TABLE prescription_has_product;
DROP TABLE producer;
DROP TABLE type;
DROP TABLE product;
DROP TABLE price;
DROP TABLE postcode;
DROP TABLE adress;
DROP TABLE pharmacy;
DROP TABLE insurance;
DROP TABLE customer;
DROP TABLE invoice;
DROP TABLE physician;
DROP TABLE prescription;

CREATE TABLE Producer(
	idProducer INT UNSIGNED NOT NULL auto_increment,
    producerName VARCHAR(45) NOT NULL,
    PRIMARY KEY(idProducer)
    );

CREATE TABLE Type(
	idType INT UNSIGNED NOT NULL auto_increment,
    typeName VARCHAR(45) NOT NULL,
    PRIMARY KEY(idType)
    );

CREATE TABLE Product(
	idProduct INT UNSIGNED NOT NULL auto_increment,
	productName VARCHAR(45) NOT NULL,
    Brief_Description VARCHAR(200) NOT NULL,
    Amount INT UNSIGNED NOT NULL,
    disease VARCHAR(45),
    PRIMARY KEY(idProduct)
    );

ALTER TABLE Product ADD Type_idType INT UNSIGNED NOT NULL;
ALTER TABLE Product ADD FOREIGN KEY(Type_idType) REFERENCES Type(idType);

CREATE TABLE Price(
	idPrice INT UNSIGNED NOT NULL auto_increment,
    Amount float NOT NULL,
    PRIMARY KEY(idPrice)
    );

CREATE TABLE postcode(
	idpostCode INT UNSIGNED NOT NULL auto_increment,
    PostName VARCHAR(45) NOT NULL,
    code INT,
    PRIMARY KEY(idpostcode)
    );

CREATE TABLE Adress(
	idAdress INT UNSIGNED NOT NULL auto_increment,
    StreetName VARCHAR(45) NOT NULL,
    StreetNumber INT,
    PRIMARY KEY(idAdress)
    );

ALTER TABLE Adress ADD postcode_idpostcode INT UNSIGNED NOT NULL;
ALTER TABLE Adress ADD FOREIGN KEY(postcode_idpostcode) REFERENCES postCode(idpostCode);
    
CREATE TABLE Pharmacy(
	idPharmacy INT UNSIGNED NOT NULL auto_increment,
    PharmacyName VARCHAR(45) NOT NULL,
    PRIMARY KEY(idPharmacy)
    );
    
ALTER TABLE Pharmacy ADD Adress_idAdress INT UNSIGNED NOT NULL;
ALTER TABLE Pharmacy ADD FOREIGN KEY(Adress_idAdress) REFERENCES Adress(idAdress);
    
CREATE TABLE Insurance(
	idInsurance INT UNSIGNED NOT NULL auto_increment,
    type VARCHAR(45) NOT NULL,
    PRIMARY KEY(idInsurance)
    );
 
 CREATE TABLE customer(
	idcustomer INT UNSIGNED NOT NULL auto_increment,
    Name VARCHAR(30) NOT NULL,
    Surname VARCHAR(30) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Insurance VARCHAR(45),
    PRIMARY KEY(idcustomer)
    );
    
CREATE TABLE Invoice(
	idInvoice INT UNSIGNED NOT NULL auto_increment,
    TotalPrice FLOAT NOT NULL,
    date DATE NOT NULL,
    surcharge FLOAT,
    PRIMARY KEY(idInvoice)
    );
    
ALTER TABLE Invoice ADD customer_idcustomer INT UNSIGNED NOT NULL;
ALTER TABLE Invoice ADD FOREIGN KEY(customer_idcustomer) REFERENCES customer(idcustomer);

CREATE TABLE Physician(
	idPhysician INT UNSIGNED NOT NULL auto_increment,
    Name VARCHAR(30) NOT NULL,
    Surname VARCHAR(30) NOT NULL,
    PRIMARY KEY(idPhysician)
    );
    
CREATE TABLE Prescription(
	idPrescription INT UNSIGNED NOT NULL auto_increment,
	date DATE NOT NULL,
    PRIMARY KEY(idPrescription),
    Physician_idPhysician INT UNSIGNED NOT NULL,
    FOREIGN KEY(Physician_idPhysician) REFERENCES Physician(idPhysician)
    );

ALTER TABLE Prescription ADD customer_idcustomer INT UNSIGNED NOT NULL;
ALTER TABLE Prescription ADD FOREIGN KEY(customer_idcustomer) REFERENCES customer(idcustomer);
    
    
/*intermediate entities*/
    
CREATE TABLE Pharmacy_has_Product(
	idPharmacy_has_Product INT UNSIGNED NOT NULL auto_increment,
    PRIMARY KEY(idPharmacy_has_Product),
    Pharmacy_idPharmacy INT UNSIGNED NOT NULL,
    Product_idProduct INT UNSIGNED NOT NULL
    );
    
ALTER TABLE Pharmacy_has_Product ADD FOREIGN KEY(Pharmacy_idPharmacy) REFERENCES Pharmacy(idPharmacy);
ALTER TABLE Pharmacy_has_Product ADD FOREIGN KEY(Product_idProduct) REFERENCES Product(idProduct);


CREATE TABLE Product_has_Insurance(
	idProduct_has_Insurance INT UNSIGNED NOT NULL auto_increment,
    valid_from DATE NOT NULL,
    valid_to DATE,
    Product_idProduct INT UNSIGNED NOT NULL,
    PRIMARY KEY(idProduct_has_Insurance),
    FOREIGN KEY(Product_idProduct) REFERENCES Product(idProduct)
    );
   
ALTER TABLE Product_has_Insurance ADD Insurance_idInsurance INT UNSIGNED NOT NULL;
ALTER TABLE Product_has_Insurance ADD FOREIGN KEY(Insurance_idInsurance) REFERENCES Insurance(idInsurance);

CREATE TABLE Product_has_Price(
	idPharmacy_has_Product INT UNSIGNED NOT NULL auto_increment,
	valid_from DATE NOT NULL,
    valid_to DATE,
    Product_idProduct INT UNSIGNED NOT NULL,
    PRIMARY KEY(idPharmacy_has_Product),
	FOREIGN KEY(Product_idProduct) REFERENCES Product(idProduct)
);

ALTER TABLE Product_has_Price ADD Price_idPrice INT UNSIGNED NOT NULL;
ALTER TABLE Product_has_Price ADD FOREIGN KEY(Price_idPrice) REFERENCES Price(idPrice);

CREATE TABLE Producer_has_Product(
	idProducer_has_Product INT UNSIGNED NOT NULL auto_increment,
    produceDate DATE NOT NULL,
	PRIMARY KEY(idProducer_has_Product),
    Producer_idProducer INT UNSIGNED NOT NULL,
    Product_idProduct INT UNSIGNED NOT NULL,
	FOREIGN KEY(Product_idProduct) REFERENCES Product(idProduct)
	);

ALTER TABLE Producer_has_Product ADD FOREIGN KEY(Producer_idProducer) REFERENCES Producer(idProducer);

CREATE TABLE Invoice_has_Product(
	idInvoice_has_Product INT UNSIGNED NOT NULL auto_increment,
    Invoice_idInvoice INT UNSIGNED NOT NULL,
    Product_idProduct INT UNSIGNED NOT NULL,
    PRIMARY KEY(idInvoice_has_Product)
    );

ALTER TABLE Invoice_has_Product ADD FOREIGN KEY(Invoice_idInvoice) REFERENCES Invoice(idInvoice);
ALTER TABLE Invoice_has_Product ADD FOREIGN KEY(Product_idProduct) REFERENCES Product(idProduct);

CREATE TABLE Prescription_has_Product(
	idPrescription_has_Product INT UNSIGNED NOT NULL auto_increment,
    Amount INT UNSIGNED NOT NULL,
    Product_idProduct INT UNSIGNED NOT NULL,
	PRIMARY KEY(idPrescription_has_Product),
    FOREIGN KEY(Product_idProduct) REFERENCES Product(idProduct)
    );

ALTER TABLE Prescription_has_Product ADD Prescription_idPrescription INT UNSIGNED NOT NULL;
ALTER TABLE Prescription_has_Product ADD FOREIGN KEY(Prescription_idPrescription) REFERENCES Prescription(idPrescription);

