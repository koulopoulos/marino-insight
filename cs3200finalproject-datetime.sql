CREATE DATABASE  IF NOT EXISTS `marinoinsights` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `marinoinsights`;
-- MySQL dump 10.13  Distrib 8.0.33, for macos13 (x86_64)
--
-- Host: localhost    Database: marinoinsights
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `basketball_court`
--

DROP TABLE IF EXISTS `basketball_court`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `basketball_court` (
  `hoop_height` int DEFAULT NULL,
  `room_no` int NOT NULL,
  PRIMARY KEY (`room_no`),
  KEY `fk_basketball_room_no` (`room_no`),
  CONSTRAINT `fk_basketball_room_no` FOREIGN KEY (`room_no`) REFERENCES `room` (`room_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `basketball_court`
--

LOCK TABLES `basketball_court` WRITE;
/*!40000 ALTER TABLE `basketball_court` DISABLE KEYS */;
INSERT INTO `basketball_court` VALUES (10,101),(10,303);
/*!40000 ALTER TABLE `basketball_court` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment` (
  `equipment_id` int NOT NULL,
  `type` varchar(45) DEFAULT NULL,
  `status` varchar(64) DEFAULT NULL,
  `level` int NOT NULL,
  PRIMARY KEY (`equipment_id`,`level`),
  KEY `fk_equip_level` (`level`),
  CONSTRAINT `fk_equip_level` FOREIGN KEY (`level`) REFERENCES `floor` (`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment`
--

LOCK TABLES `equipment` WRITE;
/*!40000 ALTER TABLE `equipment` DISABLE KEYS */;
INSERT INTO `equipment` VALUES (1,'Treadmill','Active',1),(2,'Elliptical Trainer','Active',2),(3,'Rowing Machine','Inactive',1),(4,'Stationary Bike','Active',3),(5,'Weight Bench','Active',2),(6,'Dumbbells','Inactive',3),(7,'Smith Machine','Active',1);
/*!40000 ALTER TABLE `equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `floor`
--

DROP TABLE IF EXISTS `floor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `floor` (
  `level` int NOT NULL,
  PRIMARY KEY (`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `floor`
--

LOCK TABLES `floor` WRITE;
/*!40000 ALTER TABLE `floor` DISABLE KEYS */;
INSERT INTO `floor` VALUES (1),(2),(3);
/*!40000 ALTER TABLE `floor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lock`
--

DROP TABLE IF EXISTS `lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lock` (
  `lock_no` int NOT NULL,
  `student_id` int DEFAULT NULL,
  PRIMARY KEY (`lock_no`),
  KEY `fk_lock_student_id` (`student_id`),
  CONSTRAINT `fk_lock_student_id` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lock`
--

LOCK TABLES `lock` WRITE;
/*!40000 ALTER TABLE `lock` DISABLE KEYS */;
INSERT INTO `lock` VALUES (1,1001),(2,1002),(3,1003),(4,1004),(5,1005),(6,1006),(7,1007),(8,1008),(9,1009),(10,1010);
/*!40000 ALTER TABLE `lock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `queue` (
  `student_id` int NOT NULL,
  `equipment_id` int NOT NULL,
  `entry_datetime` datetime NOT NULL,
  `exit_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`student_id`,`equipment_id`),
  KEY `fk_queue_student_id` (`student_id`),
  KEY `fk_queue_equipment_id` (`equipment_id`),
  CONSTRAINT `fk_queue_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`equipment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queue`
--

LOCK TABLES `queue` WRITE;
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
INSERT INTO `queue` VALUES (1001,1,'2023-06-20 09:00:00','2023-06-20 09:30:00'),(1002,2,'2023-06-20 10:15:00','2023-06-20 11:00:00'),(1003,3,'2023-06-28 13:45:00','2023-06-28 14:30:00'),(1004,4,'2023-06-28 15:30:00','2023-06-28 16:00:00'),(1005,5,'2023-07-03 17:00:00','2023-07-03 18:00:00'),(1006,1,'2023-07-03 10:30:00','2023-07-03 11:00:00'),(1007,2,'2023-07-03 11:45:00',NULL),(1008,3,'2023-07-10 14:15:00','2023-07-10 15:00:00'),(1009,4,'2023-07-10 16:30:00',NULL),(1010,5,'2023-07-10 18:30:00','2023-07-10 19:00:00');
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation` (
  `reservation_no` int NOT NULL AUTO_INCREMENT,
  `status` varchar(45) DEFAULT NULL,
  `type` varchar(64) DEFAULT NULL,
  `start_datetime` datetime DEFAULT NULL,
  `end_datetime` datetime DEFAULT NULL,
  `room_no` int NOT NULL,
  `student_id` int NOT NULL,
  PRIMARY KEY (`reservation_no`,`room_no`),
  KEY `fk_reservation_room_no` (`room_no`),
  KEY `fk_reservation_student_id` (`student_id`),
  CONSTRAINT `fk_reservation_room_no` FOREIGN KEY (`room_no`) REFERENCES `room` (`room_no`),
  CONSTRAINT `fk_reservation_student_id` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES 
(1,'Confirmed','Yoga Class','2023-06-20 09:00:00','2023-06-20 11:00:00',202,1001),(2,'Pending','Basketball','2023-06-22 14:00:00','2023-06-22 16:00:00',101,1001),(3,'Confirmed','Basketball','2023-06-25 10:00:00','2023-06-25 12:00:00',101,1002),(4,'Cancelled','Personal Training','2023-06-28 13:00:00','2023-06-28 15:00:00',207,1003),(5,'Confirmed','Basketball','2023-06-30 09:00:00','2023-06-30 17:00:00',303,1003),(6,'Confirmed','Yoga Class','2023-07-01 16:00:00','2023-07-01 18:00:00',202,1004),(7,'Pending','Personal Training','2023-07-03 11:00:00','2023-07-03 13:00:00',302,1005),(8,'Confirmed','Boxing','2023-07-05 14:00:00','2023-07-05 16:00:00',307,1005),(9,'Confirmed','Weightlifting Session','2023-07-08 09:00:00','2023-07-08 12:00:00',212,1006),(10,'Cancelled','CrossFit Workout','2023-07-10 13:00:00','2023-07-10 15:00:00',102,1008);
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room` (
  `room_no` int NOT NULL,
  `max_occupancy` int DEFAULT NULL,
  `level` int NOT NULL,
  PRIMARY KEY (`room_no`,`level`),
  KEY `fk_room_level` (`level`),
  CONSTRAINT `fk_room_level` FOREIGN KEY (`level`) REFERENCES `floor` (`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (101,4,1),(102,42,1),(106,3,1),(202,2,2),(205,NULL,2),(207,5,2),(212,10,2),(303,6,3),(304,8,3),(307,16,3);
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `student_fname` varchar(45) DEFAULT NULL,
  `student_lname` varchar(45) DEFAULT NULL,
  `student_id` int NOT NULL,
  `student_login_datetime` datetime NOT NULL,
  `student_logout_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES ('Julian','Getsey',1001,'2023-06-20 08:00:00','2023-06-20 12:00:00'),('Adam','Koulopoulos',1002,'2023-06-20 09:30:00','2023-06-20 15:00:00'),('Alex','McMillan',1003,'2023-06-28 10:45:00','2023-06-28 14:30:00'),('Emily','Williams',1004,'2023-06-28 11:15:00','2023-06-28 16:00:00'),('David','Brown',1005,'2023-07-03 13:00:00','2023-07-03 18:00:00'),('Sarah','Taylor',1006,'2023-07-03 14:30:00','2023-07-03 17:00:00'),('Robert','Anderson',1007,'2023-07-03 15:45:00','2023-07-03 19:00:00'),('Olivia','Martinez',1008,'2023-07-10 16:30:00','2023-07-10 20:00:00'),('William','Garcia',1009,'2023-07-10 17:45:00',NULL),('Sophia','Davis',1010,'2023-07-10 18:15:00',NULL);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `yoga_studio`
--

DROP TABLE IF EXISTS `yoga_studio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `yoga_studio` (
  `temperature` int DEFAULT NULL,
  `room_no` int NOT NULL,
  PRIMARY KEY (`room_no`),
  KEY `fk_yoga_room_no` (`room_no`),
  CONSTRAINT `fk_yoga_room_no` FOREIGN KEY (`room_no`) REFERENCES `room` (`room_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yoga_studio`
--

LOCK TABLES `yoga_studio` WRITE;
/*!40000 ALTER TABLE `yoga_studio` DISABLE KEYS */;
INSERT INTO `yoga_studio` VALUES (100,106),(70,202),(90,205),(80,304);
/*!40000 ALTER TABLE `yoga_studio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'marinoinsights'
--
/*!50003 DROP PROCEDURE IF EXISTS `create_reservation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_reservation`(IN res_status varchar(45), IN res_type varchar(64), IN res_sdatetime DATETIME, IN res_edatetime DATETIME, IN res_rno int, IN res_sid int)
BEGIN
    DECLARE count_room INT;
    DECLARE count_reservation INT;
    SELECT count(*) INTO count_room FROM room WHERE room_no = res_rno;
    SELECT count(*) INTO count_reservation FROM reservation WHERE (start_datetime BETWEEN res_sdatetime AND res_edatetime) OR (end_datetime BETWEEN res_sdatetime AND res_edatetime) OR (res_sdatetime BETWEEN start_datetime AND end_datetime) OR (res_edatetime BETWEEN start_datetime AND end_datetime);
    IF count_room = 0 THEN 
        SELECT 'Room does not exist.' AS result;
    ELSEIF count_reservation = 0 THEN 
        INSERT INTO reservation(status, type, start_datetime, end_datetime, room_no, student_id) VALUES 
        (res_status, res_type, res_sdatetime, res_edatetime, res_rno, res_sid);
        SELECT 'Reservation created.' AS result;
    ELSE
      SELECT 'Unable to make reservation.' AS result;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_student` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_student`(IN s_fname varchar(45), IN s_lname varchar(45), IN s_id int)
BEGIN
	DECLARE s_id_temp INT DEFAULT NULL;
    DECLARE count_student INT;
    SELECT count(*) INTO count_student FROM student WHERE student_id = s_id;
    IF count_student = 0 THEN 
        INSERT INTO student(student_fname, student_lname, student_id) VALUES (s_fname, s_lname, s_id);
    END IF;
    SELECT student_id INTO s_id_temp FROM student WHERE student_id= s_id;    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_reservations` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_reservations`()
BEGIN
SELECT * FROM reservation;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `reservation_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `reservation_status`(IN reservation_id INT)
BEGIN
SELECT status FROM reservation WHERE reservation.reservation_no=reservation_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `students_on_floor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `students_on_floor`(IN floor_level int)
BEGIN
SELECT student.* FROM student LEFT OUTER JOIN queue ON student.student_id=queue.student_id 
LEFT OUTER JOIN equipment ON equipment.equipment_id=queue.equipment_id WHERE equipment.level=floor_level;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `student_login` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `student_login`(
	IN student_fname VARCHAR(45),
    IN student_lname VARCHAR(45),
    IN student_id INT
)
BEGIN
	DECLARE existing_login_datetime DATETIME;
    
    SELECT student_login_datetime INTO existing_login_datetime
		FROM student
        WHERE student_id = student_id;
	
    IF existing_login_datetime IS NULL THEN
		INSERT INTO student (student_fname, student_lname, student_id, student_login_datetime)
		VALUES (student_fname, student_lname, student_id, NOW());
    SELECT 'Student created and logged in.' AS result;
    
	ELSEIF existing_login_datetime IS NOT NULL AND student_logout_datetime IS NOT NULL THEN
		UPDATE student
		SET student_login_datetime = NOW(), student_logout_datetime = NULL
		WHERE student_id = student_id;
    SELECT 'Student logged in.' AS result;
    
	ELSE
		SELECT 'Student is already logged in. Log out before logging in again.' AS result;
  END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `student_logout` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `student_logout`(
	IN student_id INT
)
BEGIN
	DECLARE student_exists INT;
    
    SELECT COUNT(*) INTO student_exists
		FROM student
		WHERE student_id = student_id;
  
	IF student_exists > 0 THEN
		UPDATE student
		SET student_logout_datetime = NOW()
		WHERE student_id = student_id;
    SELECT 'Student logged out.' AS result;
    
	ELSE
		SELECT 'Student does not exist.' AS result;
  END IF;  
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-19 11:44:21
