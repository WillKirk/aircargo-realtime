/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.15-MariaDB, for Linux (x86_64)
--
-- Host: cn7028-coursework-database.cteewm6uylwo.eu-west-2.rds.amazonaws.com    Database: airfreight
-- ------------------------------------------------------
-- Server version	8.4.7

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `airports`
--

DROP TABLE IF EXISTS `airports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `airports` (
  `airport_code` varchar(3) NOT NULL,
  `airport_name` varchar(100) NOT NULL,
  `city` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `timezone` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`airport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airports`
--

LOCK TABLES `airports` WRITE;
/*!40000 ALTER TABLE `airports` DISABLE KEYS */;
INSERT INTO `airports` VALUES
('AMS','Amsterdam Schiphol Airport','Amsterdam','Netherlands','Europe/Amsterdam'),
('BHX','Birmingham Airport','Birmingham','United Kingdom','Europe/London'),
('CDG','Charles de Gaulle Airport','Paris','France','Europe/Paris'),
('DOH','Hamad International Airport','Doha','Qatar','Asia/Qatar'),
('DUB','Dublin Airport','Dublin','Ireland','Europe/Dublin'),
('DXB','Dubai International Airport','Dubai','United Arab Emirates','Asia/Dubai'),
('FRA','Frankfurt Airport','Frankfurt','Germany','Europe/Berlin'),
('HKG','Hong Kong International Airport','Hong Kong','China','Asia/Hong_Kong'),
('JFK','John F. Kennedy International Airport','New York','United States','America/New_York'),
('LHR','Heathrow Airport','London','United Kingdom','Europe/London'),
('MAN','Manchester Airport','Manchester','United Kingdom','Europe/London'),
('ORD','O\'Hare International Airport','Chicago','United States','America/Chicago'),
('SIN','Singapore Changi Airport','Singapore','Singapore','Asia/Singapore'),
('SYD','Sydney Kingsford Smith Airport','Sydney','Australia','Australia/Sydney');
/*!40000 ALTER TABLE `airports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(100) NOT NULL,
  `customer_type` varchar(50) DEFAULT NULL,
  `customer_email` varchar(100) DEFAULT NULL,
  `customer_phone` varchar(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES
(9,'Acme Ltd','shipper','ops@acmeltd.co.uk','+44 161 555 0101','10 Industrial Park, Manchester','United Kingdom'),
(10,'MedPharm Ltd','shipper','logistics@medpharm.co.uk','+44 121 555 0102','5 Science Park, Birmingham','United Kingdom'),
(11,'TextileCo','shipper','shipping@textileco.co.uk','+44 20 7946 0103','22 Fashion Street, London','United Kingdom'),
(12,'PharmaGlobal','shipper','cargo@pharmaglobal.com','+1 212 555 0104','88 Pharma Drive, New York','United States'),
(13,'ComponentsCo','shipper','exports@componentsco.com','+49 69 555 0105','15 Engineering Strasse, Frankfurt','Germany'),
(14,'RetailCo','consignee','receiving@retailco.com','+1 312 555 0106','200 Retail Blvd, Chicago','United States'),
(15,'MediStore','consignee','imports@medistore.com','+971 4 555 0107','Dubai Healthcare City','United Arab Emirates'),
(16,'TechWorks','consignee','warehouse@techworks.com.sg','+65 6555 0108','30 Tech Park, Singapore','Singapore'),
(17,'Global Freight Partners','freight_forwarder','ops@gfp.com','+44 161 555 0109','3 Forwarding Way, Manchester','United Kingdom'),
(18,'SkyBridge Logistics','freight_forwarder','cargo@skybridgelogistics.com','+44 121 555 0110','7 Cargo Road, Birmingham','United Kingdom'),
(19,'Meridian Exports Ltd','shipper','ops@meridianexports.com','+44 20 7946 0111','22 Export House, London','United Kingdom'),
(20,'Atlas Forwarding Co','freight_forwarder','info@atlasforwarding.com','+1 212 555 0112','88 Logistics Park, New York','United States');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight_shipment`
--

DROP TABLE IF EXISTS `flight_shipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight_shipment` (
  `flight_shipment_id` int NOT NULL AUTO_INCREMENT,
  `flight_id` int NOT NULL,
  `shipment_id` int NOT NULL,
  PRIMARY KEY (`flight_shipment_id`),
  KEY `flight_id` (`flight_id`),
  KEY `shipment_id` (`shipment_id`),
  CONSTRAINT `flight_shipment_ibfk_1` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`flight_id`),
  CONSTRAINT `flight_shipment_ibfk_2` FOREIGN KEY (`shipment_id`) REFERENCES `shipments` (`shipment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight_shipment`
--

LOCK TABLES `flight_shipment` WRITE;
/*!40000 ALTER TABLE `flight_shipment` DISABLE KEYS */;
INSERT INTO `flight_shipment` VALUES
(25,1,11),
(26,2,12),
(27,3,13),
(28,8,14),
(29,12,14),
(30,2,15),
(31,11,15),
(32,10,16),
(33,13,16),
(34,7,17),
(35,8,18),
(36,9,19),
(37,10,20),
(38,2,21),
(39,12,21),
(40,3,22),
(41,14,22),
(42,2,23),
(43,8,23),
(44,3,24),
(45,14,24),
(46,11,24),
(47,10,25),
(48,9,26);
/*!40000 ALTER TABLE `flight_shipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight_staff`
--

DROP TABLE IF EXISTS `flight_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight_staff` (
  `flight_staff_id` int NOT NULL AUTO_INCREMENT,
  `flight_id` int NOT NULL,
  `staff_id` int NOT NULL,
  PRIMARY KEY (`flight_staff_id`),
  KEY `flight_id` (`flight_id`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `flight_staff_ibfk_1` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`flight_id`),
  CONSTRAINT `flight_staff_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight_staff`
--

LOCK TABLES `flight_staff` WRITE;
/*!40000 ALTER TABLE `flight_staff` DISABLE KEYS */;
INSERT INTO `flight_staff` VALUES
(1,1,1),
(2,1,2),
(3,2,1),
(4,2,3),
(5,3,4),
(6,3,5),
(7,4,4),
(8,4,6),
(9,5,2),
(10,5,3),
(11,6,5),
(12,6,6),
(13,7,1),
(14,7,2),
(15,8,4),
(16,8,5),
(17,9,3),
(18,9,6),
(19,10,4),
(20,10,6);
/*!40000 ALTER TABLE `flight_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight_uld`
--

DROP TABLE IF EXISTS `flight_uld`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight_uld` (
  `flight_uld_id` int NOT NULL AUTO_INCREMENT,
  `flight_id` int NOT NULL,
  `uld_id` int NOT NULL,
  PRIMARY KEY (`flight_uld_id`),
  KEY `flight_id` (`flight_id`),
  KEY `uld_id` (`uld_id`),
  CONSTRAINT `flight_uld_ibfk_1` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`flight_id`),
  CONSTRAINT `flight_uld_ibfk_2` FOREIGN KEY (`uld_id`) REFERENCES `ulds` (`uld_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight_uld`
--

LOCK TABLES `flight_uld` WRITE;
/*!40000 ALTER TABLE `flight_uld` DISABLE KEYS */;
INSERT INTO `flight_uld` VALUES
(1,1,1),
(2,1,2),
(3,2,3),
(4,2,6),
(5,3,4),
(6,4,7),
(7,4,8),
(8,5,1),
(9,5,2),
(10,6,3),
(11,6,4),
(12,7,6),
(13,8,7),
(14,8,8),
(15,9,2),
(16,10,4);
/*!40000 ALTER TABLE `flight_uld` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flights`
--

DROP TABLE IF EXISTS `flights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `flights` (
  `flight_id` int NOT NULL AUTO_INCREMENT,
  `airline` varchar(100) DEFAULT NULL,
  `flight_no` varchar(10) DEFAULT NULL,
  `departure_airport_code` varchar(3) DEFAULT NULL,
  `arrival_airport_code` varchar(3) DEFAULT NULL,
  `dep_time` datetime DEFAULT NULL,
  `arr_time` datetime DEFAULT NULL,
  `aircraft_type` varchar(50) DEFAULT NULL,
  `flight_status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`flight_id`),
  KEY `departure_airport_code` (`departure_airport_code`),
  KEY `arrival_airport_code` (`arrival_airport_code`),
  CONSTRAINT `flights_ibfk_1` FOREIGN KEY (`departure_airport_code`) REFERENCES `airports` (`airport_code`),
  CONSTRAINT `flights_ibfk_2` FOREIGN KEY (`arrival_airport_code`) REFERENCES `airports` (`airport_code`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flights`
--

LOCK TABLES `flights` WRITE;
/*!40000 ALTER TABLE `flights` DISABLE KEYS */;
INSERT INTO `flights` VALUES
(1,'Delta Air Lines','DL123','MAN','JFK','2025-03-03 10:30:00','2025-03-03 13:00:00','B777F','Departed'),
(2,'Emirates','EK654','MAN','DXB','2025-03-03 14:00:00','2025-03-03 23:00:00','B777F','Departed'),
(3,'Lufthansa','LH789','BHX','FRA','2025-03-04 09:00:00','2025-03-04 12:00:00','A321F','Departed'),
(4,'DHL Aviation','D05678','BHX','SIN','2025-03-04 22:00:00','2025-03-05 16:00:00','B767F','Departed'),
(5,'FedEx','FX5432','MAN','HKG','2025-03-05 23:30:00','2025-03-06 16:30:00','B777F','Departed'),
(6,'American Airlines','AA432','BHX','JFK','2025-03-06 11:00:00','2025-03-06 14:00:00','B787F','Departed'),
(7,'Air France','AF987','MAN','CDG','2025-03-07 07:30:00','2025-03-07 09:30:00','A320F','Departed'),
(8,'Cargolux','CV7821','BHX','DOH','2025-03-07 20:00:00','2025-03-08 05:30:00','B747F','Departed'),
(9,'United Airlines','UA555','MAN','ORD','2025-03-08 11:00:00','2025-03-08 14:00:00','B787F','Scheduled'),
(10,'KLM','KL888','BHX','AMS','2025-03-08 09:00:00','2025-03-08 11:00:00','A321F','Scheduled'),
(11,'Emirates','EK415','DXB','HKG','2025-03-06 08:00:00','2025-03-06 16:00:00','B777F','Departed'),
(12,'Qatar Airways','QR942','DOH','SIN','2025-03-08 06:00:00','2025-03-08 18:00:00','A350F','Departed'),
(13,'KLM','KL809','AMS','JFK','2025-03-09 10:00:00','2025-03-09 13:00:00','B787F','Scheduled'),
(14,'Lufthansa','LH400','FRA','DXB','2025-03-05 13:00:00','2025-03-05 21:00:00','A340F','Departed');
/*!40000 ALTER TABLE `flights` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `check_flight_times` BEFORE INSERT ON `flights` FOR EACH ROW BEGIN
    IF NEW.arr_time <= NEW.dep_time THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Arrival time must be after departure time';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `service_rates`
--

DROP TABLE IF EXISTS `service_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_rates` (
  `rate_id` int NOT NULL AUTO_INCREMENT,
  `route` varchar(100) DEFAULT NULL,
  `origin_airport` varchar(3) DEFAULT NULL,
  `destination_airport` varchar(3) DEFAULT NULL,
  `service_type` varchar(50) DEFAULT NULL,
  `rate_per_kg` decimal(10,2) DEFAULT NULL,
  `min_charge` decimal(10,2) DEFAULT NULL,
  `effective_from` date DEFAULT NULL,
  `effective_to` date DEFAULT NULL,
  PRIMARY KEY (`rate_id`),
  KEY `origin_airport` (`origin_airport`),
  KEY `destination_airport` (`destination_airport`),
  CONSTRAINT `service_rates_ibfk_1` FOREIGN KEY (`origin_airport`) REFERENCES `airports` (`airport_code`),
  CONSTRAINT `service_rates_ibfk_2` FOREIGN KEY (`destination_airport`) REFERENCES `airports` (`airport_code`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_rates`
--

LOCK TABLES `service_rates` WRITE;
/*!40000 ALTER TABLE `service_rates` DISABLE KEYS */;
INSERT INTO `service_rates` VALUES
(1,'MAN-JFK','MAN','JFK','Priority',2.50,150.00,'2025-01-01','2025-12-31'),
(2,'MAN-DXB','MAN','DXB','Standard',1.80,100.00,'2025-01-01','2025-12-31'),
(3,'BHX-FRA','BHX','FRA','Standard',1.05,90.00,'2025-01-01','2025-12-31'),
(4,'BHX-FRA','BHX','FRA','TempControlled',2.80,160.00,'2025-01-01','2025-12-31'),
(5,'BHX-SIN','BHX','SIN','Priority',2.20,140.00,'2025-01-01','2025-12-31'),
(6,'MAN-HKG','MAN','HKG','Standard',1.90,130.00,'2025-01-01','2025-12-31'),
(7,'BHX-JFK','BHX','JFK','TempControlled',2.80,160.00,'2025-01-01','2025-12-31'),
(8,'MAN-CDG','MAN','CDG','Priority',1.50,80.00,'2025-01-01','2025-12-31'),
(9,'BHX-DOH','BHX','DOH','TempControlled',2.60,150.00,'2025-01-01','2025-12-31'),
(10,'MAN-ORD','MAN','ORD','Standard',2.00,120.00,'2025-01-01','2025-12-31'),
(11,'BHX-AMS','BHX','AMS','Priority',1.20,80.00,'2025-01-01','2025-12-31'),
(12,'BHX-ORD','BHX','ORD','Priority',2.40,150.00,'2025-01-01','2025-12-31');
/*!40000 ALTER TABLE `service_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipment_uld`
--

DROP TABLE IF EXISTS `shipment_uld`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipment_uld` (
  `shipment_uld_id` int NOT NULL AUTO_INCREMENT,
  `uld_id` int NOT NULL,
  `shipment_id` int NOT NULL,
  PRIMARY KEY (`shipment_uld_id`),
  KEY `uld_id` (`uld_id`),
  KEY `shipment_id` (`shipment_id`),
  CONSTRAINT `shipment_uld_ibfk_1` FOREIGN KEY (`uld_id`) REFERENCES `ulds` (`uld_id`),
  CONSTRAINT `shipment_uld_ibfk_2` FOREIGN KEY (`shipment_id`) REFERENCES `shipments` (`shipment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipment_uld`
--

LOCK TABLES `shipment_uld` WRITE;
/*!40000 ALTER TABLE `shipment_uld` DISABLE KEYS */;
INSERT INTO `shipment_uld` VALUES
(1,1,11),
(2,1,15),
(3,2,12),
(4,2,19),
(5,3,13),
(6,3,21),
(7,4,14),
(8,4,24),
(9,6,17),
(10,6,25),
(11,7,18),
(12,7,23),
(13,8,16),
(14,8,20),
(15,2,26);
/*!40000 ALTER TABLE `shipment_uld` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipments`
--

DROP TABLE IF EXISTS `shipments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipments` (
  `shipment_id` int NOT NULL AUTO_INCREMENT,
  `awb_number` varchar(20) DEFAULT NULL,
  `shipper_id` int DEFAULT NULL,
  `consignee_id` int DEFAULT NULL,
  `origin_airport` varchar(3) DEFAULT NULL,
  `destination_airport` varchar(3) DEFAULT NULL,
  `weight_kg` decimal(10,2) DEFAULT NULL,
  `booking_date` datetime DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `service_type` varchar(50) DEFAULT NULL,
  `expected_flight_id` int DEFAULT NULL,
  `commodity_description` varchar(255) DEFAULT NULL,
  `handling_instructions` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`shipment_id`),
  KEY `shipper_id` (`shipper_id`),
  KEY `consignee_id` (`consignee_id`),
  KEY `origin_airport` (`origin_airport`),
  KEY `destination_airport` (`destination_airport`),
  KEY `expected_flight_id` (`expected_flight_id`),
  CONSTRAINT `shipments_ibfk_1` FOREIGN KEY (`shipper_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `shipments_ibfk_2` FOREIGN KEY (`consignee_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `shipments_ibfk_3` FOREIGN KEY (`origin_airport`) REFERENCES `airports` (`airport_code`),
  CONSTRAINT `shipments_ibfk_4` FOREIGN KEY (`destination_airport`) REFERENCES `airports` (`airport_code`),
  CONSTRAINT `shipments_ibfk_5` FOREIGN KEY (`expected_flight_id`) REFERENCES `flights` (`flight_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipments`
--

LOCK TABLES `shipments` WRITE;
/*!40000 ALTER TABLE `shipments` DISABLE KEYS */;
INSERT INTO `shipments` VALUES
(11,'125-12345671',9,14,'MAN','JFK',1200.00,'2025-03-01 09:00:00','Delivered','Priority',1,'Industrial Components','Handle with care'),
(12,'125-12345742',17,15,'MAN','DXB',450.00,'2025-03-02 10:00:00','Delivered','Standard',2,'Consumer Electronics','Keep upright'),
(13,'220-00034563',10,14,'BHX','FRA',320.00,'2025-03-02 11:00:00','Delivered','TempControlled',3,'Pharmaceutical Products','Keep between 2-8C'),
(14,'330-98765434',11,16,'BHX','SIN',980.00,'2025-03-03 09:00:00','Delivered','Priority',4,'Textile Goods','No compression'),
(15,'410-11122235',12,15,'MAN','HKG',2100.00,'2025-03-04 08:00:00','In Transit','Standard',5,'Auto Parts','Heavy lift required'),
(16,'125-22233346',13,14,'BHX','JFK',600.00,'2025-03-04 09:00:00','Cancelled','TempControlled',6,'Fresh Produce','Keep refrigerated'),
(17,'125-33344457',9,16,'MAN','CDG',680.00,'2025-03-05 10:00:00','In Transit','Priority',7,'Electronic Equipment','Fragile'),
(18,'220-44455568',10,14,'BHX','DOH',150.00,'2025-03-05 11:00:00','Delivered','TempControlled',8,'Medical Supplies','Keep between 2-8C'),
(19,'330-55566679',11,16,'MAN','ORD',420.00,'2025-01-10 09:00:00','Booked','Standard',9,'Printed Materials','Keep dry'),
(20,'410-66677780',12,15,'BHX','AMS',990.00,'2025-01-15 10:00:00','Booked','Priority',10,'Machine Parts','Heavy lift required'),
(21,'125-77788891',9,16,'MAN','SIN',750.00,'2025-03-05 09:00:00','Delivered','Priority',2,'Luxury Goods','Handle with care'),
(22,'220-88899902',10,15,'BHX','DXB',560.00,'2025-03-06 10:00:00','Delivered','TempControlled',3,'Vaccines','Keep between 2-8C'),
(23,'330-99900013',11,14,'MAN','DOH',890.00,'2025-03-07 08:00:00','In Transit','Standard',4,'Clothing','No compression'),
(24,'410-11100124',12,16,'BHX','HKG',1100.00,'2025-03-07 09:00:00','At Warehouse','Priority',5,'Medical Devices','Fragile'),
(25,'125-22211235',13,15,'MAN','AMS',300.00,'2025-01-05 10:00:00','Booked','Standard',10,'Machine Components','Keep dry'),
(26,'220-33322346',17,14,'BHX','ORD',670.00,'2025-03-08 11:00:00','Cancelled','Priority',9,'Auto Parts','Heavy lift required');
/*!40000 ALTER TABLE `shipments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `staff_id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) NOT NULL,
  `role` varchar(50) DEFAULT NULL,
  `hub_location` varchar(3) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  KEY `hub_location` (`hub_location`),
  CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`hub_location`) REFERENCES `airports` (`airport_code`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES
(1,'James Wilson','Operations Manager','MAN','j.wilson@aircargo.com'),
(2,'Sarah Ahmed','Cargo Handler','MAN','s.ahmed@aircargo.com'),
(3,'Mohammed Al-Rashid','Ramp Agent','MAN','m.alrashid@aircargo.com'),
(4,'Emily Clarke','Cargo Handler','BHX','e.clarke@aircargo.com'),
(5,'David Patel','Ramp Agent','BHX','d.patel@aircargo.com'),
(6,'Rachel Thompson','Hub Supervisor','BHX','r.thompson@aircargo.com'),
(7,'Oliver Bennett','CEO','LHR','o.bennett@aircargo.com'),
(8,'Sophie Harrison','Finance Manager','LHR','s.harrison@aircargo.com'),
(9,'Daniel Kowalski','Operations Director','LHR','d.kowalski@aircargo.com'),
(10,'Priya Sharma','Customer Relations','LHR','p.sharma@aircargo.com');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tracking_events`
--

DROP TABLE IF EXISTS `tracking_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tracking_events` (
  `event_id` int NOT NULL AUTO_INCREMENT,
  `shipment_id` int DEFAULT NULL,
  `uld_id` int DEFAULT NULL,
  `flight_id` int DEFAULT NULL,
  `event_type` varchar(50) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `latitude` decimal(9,6) DEFAULT NULL,
  `longitude` decimal(9,6) DEFAULT NULL,
  `temp_c` decimal(5,2) DEFAULT NULL,
  `shock_detected` tinyint(1) DEFAULT NULL,
  `scan_method` varchar(50) DEFAULT NULL,
  `staff_id` int DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `shipment_id` (`shipment_id`),
  KEY `uld_id` (`uld_id`),
  KEY `flight_id` (`flight_id`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `tracking_events_ibfk_1` FOREIGN KEY (`shipment_id`) REFERENCES `shipments` (`shipment_id`),
  CONSTRAINT `tracking_events_ibfk_2` FOREIGN KEY (`uld_id`) REFERENCES `ulds` (`uld_id`),
  CONSTRAINT `tracking_events_ibfk_3` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`flight_id`),
  CONSTRAINT `tracking_events_ibfk_4` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tracking_events`
--

LOCK TABLES `tracking_events` WRITE;
/*!40000 ALTER TABLE `tracking_events` DISABLE KEYS */;
INSERT INTO `tracking_events` VALUES
(1,11,1,1,'WarehouseScan','MAN-WH1','2025-03-01 08:00:00',53.353700,-2.274900,12.00,0,'RFID',1,'Pre-flight check completed'),
(2,11,1,1,'LoadedToULD','MAN-RAMP1','2025-03-03 09:00:00',53.353700,-2.274900,11.50,0,'Handheld',2,'ULD sealed and tagged'),
(3,11,1,1,'FlightDeparted','MAN','2025-03-03 10:35:00',53.353700,-2.274900,11.00,0,'Automated',1,'Departed on schedule'),
(4,11,1,1,'FlightArrived','JFK','2025-03-03 13:10:00',40.641300,-73.778100,18.00,0,'Automated',1,'Arrived on schedule'),
(5,11,1,1,'Delivered','JFK Terminal','2025-03-03 15:00:00',40.641300,-73.778100,18.50,0,'Handheld',1,'Delivered to consignee'),
(6,12,3,2,'WarehouseScan','MAN-WH2','2025-03-02 09:00:00',53.353700,-2.274900,10.00,0,'RFID',3,'Weight verified'),
(7,12,3,2,'FlightDeparted','MAN','2025-03-03 14:10:00',53.353700,-2.274900,10.50,0,'Automated',3,'Departed on schedule'),
(8,12,3,2,'Delivered','DXB Terminal','2025-03-03 23:10:00',25.253200,55.365700,22.00,0,'Handheld',3,'Delivered to consignee'),
(9,13,4,3,'WarehouseScan','BHX-WH1','2025-03-02 10:00:00',52.453300,-1.748000,5.00,0,'RFID',4,'Pre-cool verified'),
(10,13,4,3,'TempAlert','BHX-WH1','2025-03-02 12:00:00',52.453300,-1.748000,10.50,0,'Automated',4,'Temperature excursion detected'),
(11,13,4,3,'TempCorrected','BHX-WH1','2025-03-02 12:30:00',52.453300,-1.748000,5.20,0,'Automated',4,'Cooling restored'),
(12,13,4,3,'FlightDeparted','BHX','2025-03-04 09:10:00',52.453300,-1.748000,5.50,0,'Automated',4,'Departed on schedule'),
(13,13,4,3,'Delivered','FRA Terminal','2025-03-04 12:10:00',50.037900,8.562200,6.00,0,'Handheld',4,'Delivered to consignee'),
(14,14,7,4,'WarehouseScan','BHX-WH2','2025-03-03 08:00:00',52.453300,-1.748000,15.00,0,'RFID',5,'Pallet staged'),
(15,14,7,4,'LoadedToULD','BHX-RAMP2','2025-03-04 20:00:00',52.453300,-1.748000,15.50,0,'Handheld',5,'ULD sealed'),
(16,14,7,4,'FlightDeparted','BHX','2025-03-04 22:10:00',52.453300,-1.748000,15.00,0,'Automated',5,'Departed on schedule'),
(17,14,7,12,'FlightArrived','DOH','2025-03-05 05:40:00',25.273100,51.608000,28.00,0,'Automated',5,'Connecting flight boarding'),
(18,14,7,12,'FlightDeparted','DOH','2025-03-08 06:10:00',25.273100,51.608000,28.50,0,'Automated',5,'Departed on connecting flight'),
(19,14,7,12,'Delivered','SIN Terminal','2025-03-08 18:10:00',1.364400,103.991500,26.00,0,'Handheld',5,'Delivered to consignee'),
(20,15,1,5,'WarehouseScan','MAN-WH1','2025-03-04 07:00:00',53.353700,-2.274900,11.00,0,'RFID',2,'Heavy lift confirmed'),
(21,15,1,5,'LoadedToULD','MAN-RAMP1','2025-03-05 22:00:00',53.353700,-2.274900,11.50,0,'Handheld',2,'ULD loaded'),
(22,15,1,5,'FlightDeparted','MAN','2025-03-05 23:40:00',53.353700,-2.274900,11.00,0,'Automated',2,'Departed on schedule'),
(23,15,1,11,'FlightArrived','DXB','2025-03-06 08:10:00',25.253200,55.365700,24.00,0,'Automated',2,'Connecting via DXB'),
(24,15,1,11,'FlightDeparted','DXB','2025-03-06 08:30:00',25.253200,55.365700,24.50,0,'Automated',2,'Departed on connecting flight'),
(25,15,1,11,'Delivered','HKG Terminal','2025-03-06 16:40:00',22.308000,113.918500,21.00,0,'Handheld',2,'Delivered to consignee'),
(26,16,8,6,'WarehouseScan','BHX-WH1','2025-03-04 08:00:00',52.453300,-1.748000,4.00,0,'RFID',6,'Pre-cool verified'),
(27,16,NULL,NULL,'BookingCancelled','BHX System','2025-03-04 09:00:00',52.453300,-1.748000,NULL,0,'Automated',6,'Customer cancelled booking'),
(28,17,6,7,'WarehouseScan','MAN-WH2','2025-03-05 09:00:00',53.353700,-2.274900,13.00,0,'RFID',1,'Awaiting loading'),
(29,18,7,8,'WarehouseScan','BHX-WH1','2025-03-05 10:00:00',52.453300,-1.748000,4.50,0,'RFID',4,'Pre-cool verified'),
(30,18,7,8,'LoadedToULD','BHX-RAMP1','2025-03-07 19:00:00',52.453300,-1.748000,4.80,0,'Handheld',4,'ULD sealed'),
(31,18,7,8,'FlightDeparted','BHX','2025-03-07 20:10:00',52.453300,-1.748000,5.00,0,'Automated',4,'Departed on schedule'),
(32,18,7,8,'Delivered','DOH Terminal','2025-03-08 05:40:00',25.273100,51.608000,27.00,0,'Handheld',4,'Delivered to consignee'),
(34,17,6,7,'FlightDeparted','MAN','2025-03-07 07:35:00',53.353700,-2.274900,13.00,0,'Automated',1,'Departed on schedule');
/*!40000 ALTER TABLE `tracking_events` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `update_shipment_status` AFTER INSERT ON `tracking_events` FOR EACH ROW BEGIN
    IF NEW.event_type = 'FlightDeparted' THEN
        UPDATE shipments
        SET status = 'In Transit'
        WHERE shipment_id = NEW.shipment_id
        AND status != 'Cancelled';
    ELSEIF NEW.event_type = 'ProofOfDelivery' THEN
        UPDATE shipments
        SET status = 'Delivered'
        WHERE shipment_id = NEW.shipment_id
        AND status != 'Cancelled';
    ELSEIF NEW.event_type = 'FlightArrived' THEN
        UPDATE shipments
        SET status = 'Arrived'
        WHERE shipment_id = NEW.shipment_id
        AND status != 'Cancelled';
    ELSEIF NEW.event_type = 'CustomsCleared' THEN
        UPDATE shipments
        SET status = 'Customs Cleared'
        WHERE shipment_id = NEW.shipment_id
        AND status != 'Cancelled';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ulds`
--

DROP TABLE IF EXISTS `ulds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ulds` (
  `uld_id` int NOT NULL AUTO_INCREMENT,
  `uld_code` varchar(20) DEFAULT NULL,
  `type_code` varchar(10) DEFAULT NULL,
  `owner_code` varchar(10) DEFAULT NULL,
  `serial_number` varchar(50) DEFAULT NULL,
  `max_weight_kg` decimal(10,2) DEFAULT NULL,
  `dimensions_lwh` varchar(50) DEFAULT NULL,
  `uld_condition` varchar(50) DEFAULT NULL,
  `current_location` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`uld_id`),
  KEY `current_location` (`current_location`),
  CONSTRAINT `ulds_ibfk_1` FOREIGN KEY (`current_location`) REFERENCES `airports` (`airport_code`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ulds`
--

LOCK TABLES `ulds` WRITE;
/*!40000 ALTER TABLE `ulds` DISABLE KEYS */;
INSERT INTO `ulds` VALUES
(1,'AKE12345DL','AKE','DAL','12345',1588.00,'1.53x1.56x1.60','Good','MAN'),
(2,'PMC54321BA','PMC','BAW','54321',6033.00,'2.44x1.22x0.86','Good','MAN'),
(3,'AKN67890AA','AKN','AAL','67890',2000.00,'2.44x1.56x1.60','Good','BHX'),
(4,'RKN11223DL','RKN','DAL','11223',1750.00,'1.82x1.22x1.60','Good','BHX'),
(5,'AKE33344CX','AKE','CXL','33344',1588.00,'1.53x1.56x1.60','Damaged','MAN'),
(6,'PCA99900BA','PCA','BAW','99900',900.00,'1.20x0.80x1.00','Good','MAN'),
(7,'AKE55566DL','AKE','DAL','55566',1588.00,'1.53x1.56x1.60','Good','BHX'),
(8,'PMC77788CX','PMC','CXL','77788',1200.00,'2.44x1.22x0.86','Good','BHX'),
(9,'AKE99911KL','AKE','KLM','99911',1588.00,'1.53x1.56x1.60','Good','BHX'),
(10,'RKN44556FX','RKN','FDX','44556',1750.00,'1.82x1.22x1.60','Good','MAN');
/*!40000 ALTER TABLE `ulds` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-04 18:49:22
