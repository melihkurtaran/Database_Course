
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

/*inserting without the foreign keys*/

INSERT INTO producer values(1,"A company");
INSERT INTO producer values(2,"B company");
INSERT INTO producer values(3,"C company");
INSERT INTO producer values(4,"D company"),(5,"E company");

INSERT INTO physician values(1,"Andrew","Toz");
INSERT INTO physician values(2,"Melih","Kurtaran");
INSERT INTO physician values(3,"Jack","Black");
INSERT INTO physician values(4,"Michael","Ronchester");
INSERT INTO physician values(5,"Rubi","Can");

INSERT INTO customer values(1,"Ali","Zvala",19981013,"Company X insurance");
INSERT INTO customer values(2,"Memed","Kar",19951123,NULL);
INSERT INTO customer values(3,"Panna","Tak",19980214,NULL);
INSERT INTO customer values(4,"Andris","Piter",19900123,"Company Y insurance");
INSERT INTO customer values(5,"Melih","Kurt",19850503,NULL);
INSERT INTO customer values(6,"Anie","Swolka",19941009,"Company Z insurance");
INSERT INTO customer values(7,"Ramazan","Deniz",19820213,NULL);
INSERT INTO customer values(8,"John","Smith",19870918,NULL);

INSERT INTO price values(1,30.15);
INSERT INTO price values(2,4.16);
INSERT INTO price values(3,3);
INSERT INTO price values(4,4.6);
INSERT INTO price values(5,7.5);
INSERT INTO price values(6,10.25);

INSERT INTO type values(1,"drug"),(2,"ancessor"),(3,"parfume");
INSERT INTO type values(4,"syprey"),(5,"medicine");

INSERT INTO postcode values(1,"post A",405);
INSERT INTO postcode values(2,"post B",675);
INSERT INTO postcode values(3,"post C",2000),(4,"post D",759),(5,"post E",930);
INSERT INTO postcode values(6,"post F",2045);
INSERT INTO postcode values(7,"post G",978);
INSERT INTO postcode values(8,"post H",2950),(9,"post I",79),(10,"post J",999);

INSERT INTO insurance values(1,"full insurance");
INSERT INTO insurance values(2,"75% insurance"),(3,"half insurance");
INSERT INTO insurance values(4,"private insurance"),(5,"government insurance");

/*inserting with the foreign keys*/

INSERT INTO product values(1,"Alovera","description bla bla",475,"hypertension",1),(2,"Tovera","description bla bla",1,NULL,5);
INSERT INTO product values(3,"bolovera","description bla bla",25,"flue",1),(4,"Kovera","description bla bla",235,"hypertension",1);
INSERT INTO product values(5,"jolovera","description bla bla",100,"hypertension",5);
INSERT INTO product values(6,"Zyrtex","description bla bla",475,"hypertension",5),(7,"Soloan","description bla bla",1,"heart disease",3);
INSERT INTO product values(8,"Juxamib","description bla bla",25,"hypertension",5),(9,"Votamin","description bla bla",235,NULL,1);
INSERT INTO product values(10,"HIV-Killer","it stops HIV",100,"HIV",5);
INSERT INTO product values(11,"Extra strong patches of Partex","description bla bla",10,NULL,3);
INSERT INTO product values(12,"Coldinex","it is good for cold",10,"cold",5);

INSERT INTO adress values(1,"steet Zeo",35,1),(2,"steet Kzo",315,1),(3,"steet Zeo",2465,1);
INSERT INTO adress values(4,"steet Hao",432,2),(5,"steet Upo",435,1),(6,"steet Zeo",8545,7);
INSERT INTO adress values(7,"steet Bao",3500,3),(8,"steet Rmo",15,1),(9,"steet tot",2,6),(10,"steet ocav",9,1);

INSERT INTO pharmacy values(1,"pharmacy A",10),(2,"pharmacy B",6),(3,"pharmacy C",1);
INSERT INTO pharmacy values(4,"pharmacy D",1),(5,"pharmacy E",4),(6,"pharmacy F",1);
INSERT INTO pharmacy values(7,"pharmacy G",5),(8,"pharmacy H",1),(9,"pharmacy I",2);
INSERT INTO pharmacy values(10,"pharmacy J",1);

INSERT INTO pharmacy_has_product values(1,10,3),(2,4,1),(3,10,3),(4,10,3),(5,8,2);
INSERT INTO pharmacy_has_product values(6,7,2),(7,10,4),(8,10,3),(9,3,1),(10,9,4);

INSERT INTO product_has_price values(1,19990124,20090413,2,2),(2,19990124,NULL,1,5);
INSERT INTO product_has_price values(3,19990124,20110816,5,4),(4,19890113,NULL,1,1);
INSERT INTO product_has_price values(5,20040120,20050722,3,2),(6,20010101,20130101,3,2);
INSERT INTO product_has_price values(7,20110728,20120101,1,5),(8,20090128,NULL,1,6);
INSERT INTO product_has_price values(9,19970512,20090613,5,2),(10,19990104,NULL,5,4);

INSERT INTO product_has_insurance values(1,19990124,20040413,2,1),(2,19991124,NULL,1,3);
INSERT INTO product_has_insurance values(3,19990124,NULL,5,4),(4,19890113,NULL,7,1);
INSERT INTO product_has_insurance values(5,20040120,20050722,8,1),(6,20010101,NULL,11,2);
INSERT INTO product_has_insurance values(7,20110728,NULL,9,5),(8,20040528,NULL,12,2);
INSERT INTO product_has_insurance values(9,19970512,20090613,10,2),(10,19990104,NULL,3,2);

INSERT INTO prescription values(1,20190102,3,7),(2,20190202,5,5),(3,20190122,2,8);
INSERT INTO prescription values(4,20190122,4,2),(5,20190202,4,8),(6,20190314,3,1);
INSERT INTO prescription values(7,20190111,4,7),(8,20190202,2,5),(9,20190402,5,7);
INSERT INTO prescription values(10,20190222,1,1);
INSERT INTO prescription values(11,20150118,2,6),(12,20130213,1,3),(13,20100122,4,7);

INSERT INTO invoice values(1,3.5,20190102,NULL,7),(2,13,20190202,NULL,5),(3,5.6,20190122,2.5,1);
INSERT INTO invoice values(4,15.7,20190122,4,2),(5,18.22,20190202,6.7,1),(6,45.45,20190314,NULL,1);
INSERT INTO invoice values(7,24.5,20190111,NULL,7),(8,45.3,20190202,0.4,5),(9,13,20190402,5.5,7);
INSERT INTO invoice values(10,100,20190222,1.9,1);

INSERT INTO invoice_has_product values(1,4,8),(2,4,12),(3,3,3),(4,5,10),(5,2,7);
INSERT INTO invoice_has_product values(6,1,11),(7,1,6),(8,1,11),(9,3,1),(10,1,12);

INSERT INTO prescription_has_product values(1,10,5,3),(2,1,1,1),(3,5,3,5),(4,2,5,1),(5,1,3,1);
INSERT INTO prescription_has_product values(6,4,1,3),(7,36,5,2),(8,6,4,4),(9,1,3,4),(10,17,5,4);
INSERT INTO prescription_has_product values(11,36,5,1),(12,0,8,3),(13,15,8,3),(14,6,5,2),(15,7,5,1);

INSERT INTO producer_has_product values(1,20110101,2,3),(2,20051212,5,1),(3,20171221,5,3),(4,19990105,2,3),(5,20050709,1,1);
INSERT INTO producer_has_product values(6,20090903,1,4),(7,20060613,1,2),(8,20110107,1,5),(9,20190127,2,1),(10,20101224,5,2);

