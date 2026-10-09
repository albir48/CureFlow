-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: cureflow
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

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
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admins` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `admins_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,1);
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ai_chatbot_logs`
--

DROP TABLE IF EXISTS `ai_chatbot_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ai_chatbot_logs` (
  `chat_id` int(11) NOT NULL AUTO_INCREMENT,
  `conversation_id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `timestamps` timestamp NOT NULL DEFAULT current_timestamp(),
  `recommended_department` int(11) DEFAULT NULL,
  `recommended_doctor` int(11) DEFAULT NULL,
  `symptoms` text DEFAULT NULL,
  `ai_response` text DEFAULT NULL,
  `user_role` varchar(20) DEFAULT 'patient',
  PRIMARY KEY (`chat_id`),
  KEY `recommended_department` (`recommended_department`),
  KEY `recommended_doctor` (`recommended_doctor`),
  KEY `idx_chatbot_patient` (`patient_id`),
  CONSTRAINT `ai_chatbot_logs_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  CONSTRAINT `ai_chatbot_logs_ibfk_2` FOREIGN KEY (`recommended_department`) REFERENCES `departments` (`department_id`),
  CONSTRAINT `ai_chatbot_logs_ibfk_3` FOREIGN KEY (`recommended_doctor`) REFERENCES `doctors` (`doctor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ai_chatbot_logs`
--

LOCK TABLES `ai_chatbot_logs` WRITE;
/*!40000 ALTER TABLE `ai_chatbot_logs` DISABLE KEYS */;
INSERT INTO `ai_chatbot_logs` VALUES (1,1,1,'2026-04-29 10:44:05',NULL,NULL,'I have a headache','','patient'),(2,2,1,'2026-04-29 10:44:16',NULL,NULL,'l','Hello there! It seems like your message might be incomplete. Could you please tell me more about what you\'re looking for or how I can help you today? I\'m here to assist you with any health-related questions or concerns you might have.','patient');
/*!40000 ALTER TABLE `ai_chatbot_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ai_conversations`
--

DROP TABLE IF EXISTS `ai_conversations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ai_conversations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_id` int(11) NOT NULL,
  `user_role` varchar(20) NOT NULL,
  `title` varchar(255) DEFAULT 'New Conversation',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ai_conversations`
--

LOCK TABLES `ai_conversations` WRITE;
/*!40000 ALTER TABLE `ai_conversations` DISABLE KEYS */;
INSERT INTO `ai_conversations` VALUES (1,1,'patient','I have a headache','2026-04-29 10:44:02'),(2,1,'patient','l','2026-04-29 10:44:13');
/*!40000 ALTER TABLE `ai_conversations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departments` (
  `department_id` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'Cardiology'),(2,'Neurology'),(3,'Pediatrics'),(4,'Orthopedics'),(5,'General Medicine'),(6,'Dermatology');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_schedules`
--

DROP TABLE IF EXISTS `doctor_schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctor_schedules` (
  `schedule_id` int(11) NOT NULL AUTO_INCREMENT,
  `doctor_id` int(11) DEFAULT NULL,
  `day_of_week` enum('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday') DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `fee` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`schedule_id`),
  KEY `doctor_id` (`doctor_id`),
  CONSTRAINT `doctor_schedules_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_schedules`
--

LOCK TABLES `doctor_schedules` WRITE;
/*!40000 ALTER TABLE `doctor_schedules` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctor_schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctors`
--

DROP TABLE IF EXISTS `doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctors` (
  `doctor_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `specialization` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `availability_status` tinyint(1) DEFAULT 1,
  `department_id` int(11) DEFAULT NULL,
  `current_tau` decimal(10,2) DEFAULT 5.00,
  PRIMARY KEY (`doctor_id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `idx_doctors_department` (`department_id`),
  CONSTRAINT `doctors_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `doctors_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctors`
--

LOCK TABLES `doctors` WRITE;
/*!40000 ALTER TABLE `doctors` DISABLE KEYS */;
INSERT INTO `doctors` VALUES (1,2,'Cardiology Specialist','01761393623',1,1,3.86),(2,3,'Neurology Specialist','01798456291',1,2,5.00),(3,4,'Pediatrics Specialist','01727773051',1,3,5.00),(4,5,'Orthopedics Specialist','01748622909',1,4,5.00),(5,6,'General Medicine Specialist','01719582543',1,5,5.00),(6,7,'Dermatology Specialist','01785800157',1,6,5.00),(7,8,'Cardiology Specialist','01732430065',1,1,5.00),(8,9,'Neurology Specialist','01742989655',1,2,5.00),(9,10,'Pediatrics Specialist','01737853658',1,3,5.00),(10,11,'Orthopedics Specialist','01730625458',1,4,5.00),(11,12,'General Medicine Specialist','01787456617',1,5,5.00),(12,13,'Dermatology Specialist','01760474418',1,6,5.00);
/*!40000 ALTER TABLE `doctors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medical_history`
--

DROP TABLE IF EXISTS `medical_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medical_history` (
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) DEFAULT NULL,
  `doctor_id` int(11) DEFAULT NULL,
  `diagnosis` text DEFAULT NULL,
  `prescription` text DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `patient_id` (`patient_id`),
  KEY `doctor_id` (`doctor_id`),
  CONSTRAINT `medical_history_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  CONSTRAINT `medical_history_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medical_history`
--

LOCK TABLES `medical_history` WRITE;
/*!40000 ALTER TABLE `medical_history` DISABLE KEYS */;
INSERT INTO `medical_history` VALUES (1,33,11,'Type 2 Diabetes','Atorvastatin 20mg','2026-05-22'),(2,3,7,'High Cholesterol','Ibuprofen 400mg','2026-06-22'),(3,39,10,'Seasonal Allergies','Omeprazole 20mg','2026-06-24'),(4,30,5,'Seasonal Allergies','Atorvastatin 20mg','2026-06-27'),(5,2,11,'Migraine','Amoxicillin 500mg','2026-05-28'),(6,36,2,'Migraine','Ibuprofen 400mg','2026-04-05'),(7,49,8,'High Cholesterol','Ibuprofen 400mg','2026-05-03'),(8,3,1,'Lower Back Pain','Metformin 500mg','2026-04-30'),(9,1,4,'Chronic Hypertension','Amoxicillin 500mg','2026-05-17'),(10,22,3,'Acid Reflux','Albuterol Inhaler','2026-02-28'),(11,50,3,'Migraine','Atorvastatin 20mg','2026-06-26'),(12,46,9,'Type 2 Diabetes','Ibuprofen 400mg','2026-04-23'),(13,19,2,'High Cholesterol','Amoxicillin 500mg','2026-03-06'),(14,36,5,'Chronic Hypertension','Atorvastatin 20mg','2026-05-07'),(15,31,7,'Lower Back Pain','Amoxicillin 500mg','2026-06-27'),(16,22,12,'High Cholesterol','Albuterol Inhaler','2026-04-15'),(17,32,1,'Seasonal Allergies','Atorvastatin 20mg','2026-06-28'),(18,24,7,'High Cholesterol','Ibuprofen 400mg','2026-05-06'),(19,26,9,'Type 2 Diabetes','Metformin 500mg','2026-03-14'),(20,49,10,'Lower Back Pain','Atorvastatin 20mg','2026-06-09'),(21,40,8,'Migraine','Albuterol Inhaler','2026-05-09'),(22,22,12,'Chronic Hypertension','Atorvastatin 20mg','2026-05-04'),(23,20,6,'Acid Reflux','Lisinopril 10mg','2026-03-30'),(24,45,2,'Lower Back Pain','Metformin 500mg','2026-04-09'),(25,40,6,'Asthma','Lisinopril 10mg','2026-05-10'),(26,17,8,'High Cholesterol','Ibuprofen 400mg','2026-04-23'),(27,2,5,'Chronic Hypertension','Albuterol Inhaler','2026-04-22'),(28,40,4,'Seasonal Allergies','Atorvastatin 20mg','2026-04-20'),(29,37,1,'Asthma','Albuterol Inhaler','2026-05-01'),(30,38,10,'Migraine','Ibuprofen 400mg','2026-03-06'),(31,15,4,'High Cholesterol','Ibuprofen 400mg','2026-05-06'),(32,6,6,'Type 2 Diabetes','Albuterol Inhaler','2026-06-04'),(33,23,1,'Chronic Hypertension','Lisinopril 10mg','2026-03-27'),(34,43,3,'Seasonal Allergies','Omeprazole 20mg','2026-03-11'),(35,27,2,'Seasonal Allergies','Omeprazole 20mg','2026-04-05'),(36,45,4,'Type 2 Diabetes','Omeprazole 20mg','2026-05-27'),(37,29,5,'Seasonal Allergies','Amoxicillin 500mg','2026-06-08'),(38,7,3,'Acid Reflux','Ibuprofen 400mg','2026-05-24'),(39,16,12,'Type 2 Diabetes','Atorvastatin 20mg','2026-06-13'),(40,45,2,'Lower Back Pain','Ibuprofen 400mg','2026-04-25'),(41,11,2,'Lower Back Pain','Atorvastatin 20mg','2026-05-09'),(42,34,12,'Seasonal Allergies','Atorvastatin 20mg','2026-03-21'),(43,7,1,'High Cholesterol','Lisinopril 10mg','2026-03-30'),(44,24,4,'Lower Back Pain','Metformin 500mg','2026-03-14'),(45,21,8,'Acid Reflux','Atorvastatin 20mg','2026-06-02'),(46,27,6,'Type 2 Diabetes','Omeprazole 20mg','2026-04-29'),(47,37,2,'Acid Reflux','Albuterol Inhaler','2026-06-03'),(48,36,6,'Chronic Hypertension','Ibuprofen 400mg','2026-05-06'),(49,17,1,'Asthma','Lisinopril 10mg','2026-06-17'),(50,8,11,'Lower Back Pain','Omeprazole 20mg','2026-06-23'),(51,14,10,'Acid Reflux','Lisinopril 10mg','2026-04-24'),(52,37,8,'Acid Reflux','Amoxicillin 500mg','2026-03-16'),(53,29,4,'Type 2 Diabetes','Metformin 500mg','2026-05-24'),(54,36,8,'Asthma','Albuterol Inhaler','2026-06-22'),(55,43,11,'Asthma','Omeprazole 20mg','2026-03-22'),(56,49,12,'Asthma','Metformin 500mg','2026-05-09'),(57,17,10,'Lower Back Pain','Metformin 500mg','2026-03-30'),(58,39,11,'Asthma','Ibuprofen 400mg','2026-02-28'),(59,1,11,'High Cholesterol','Omeprazole 20mg','2026-06-01'),(60,11,10,'Lower Back Pain','Atorvastatin 20mg','2026-04-08'),(61,5,3,'Chronic Hypertension','Albuterol Inhaler','2026-05-05'),(62,1,1,'Acid Reflux','Lisinopril 10mg','2026-06-25'),(63,18,7,'High Cholesterol','Ibuprofen 400mg','2026-04-29'),(64,3,8,'Migraine','Ibuprofen 400mg','2026-03-19'),(65,39,3,'Seasonal Allergies','Lisinopril 10mg','2026-04-09'),(66,12,5,'Asthma','Albuterol Inhaler','2026-03-16'),(67,8,4,'High Cholesterol','Albuterol Inhaler','2026-03-16'),(68,12,1,'Acid Reflux','Lisinopril 10mg','2026-06-12'),(69,6,12,'Migraine','Lisinopril 10mg','2026-03-03'),(70,25,8,'Seasonal Allergies','Amoxicillin 500mg','2026-05-09'),(71,48,7,'Seasonal Allergies','Amoxicillin 500mg','2026-05-16'),(72,6,8,'Seasonal Allergies','Ibuprofen 400mg','2026-06-09'),(73,50,10,'Chronic Hypertension','Atorvastatin 20mg','2026-03-18'),(74,3,7,'Seasonal Allergies','Albuterol Inhaler','2026-04-07'),(75,23,12,'Asthma','Lisinopril 10mg','2026-06-21'),(76,45,1,'Type 2 Diabetes','Metformin 500mg','2026-05-30'),(77,4,9,'Type 2 Diabetes','Amoxicillin 500mg','2026-05-18'),(78,34,6,'Acid Reflux','Albuterol Inhaler','2026-04-23'),(79,22,1,'Lower Back Pain','Ibuprofen 400mg','2026-04-22'),(80,11,7,'High Cholesterol','Omeprazole 20mg','2026-03-27'),(81,43,11,'Seasonal Allergies','Ibuprofen 400mg','2026-06-05'),(82,43,12,'High Cholesterol','Metformin 500mg','2026-06-11'),(83,2,7,'Chronic Hypertension','Omeprazole 20mg','2026-03-01'),(84,30,10,'Acid Reflux','Lisinopril 10mg','2026-04-11'),(85,50,3,'Seasonal Allergies','Amoxicillin 500mg','2026-05-17'),(86,13,1,'Type 2 Diabetes','Amoxicillin 500mg','2026-04-05'),(87,32,9,'High Cholesterol','Lisinopril 10mg','2026-03-20'),(88,25,5,'Asthma','Albuterol Inhaler','2026-05-23'),(89,44,12,'Asthma','Amoxicillin 500mg','2026-03-12'),(90,8,6,'Migraine','Atorvastatin 20mg','2026-03-24'),(91,43,8,'Type 2 Diabetes','Atorvastatin 20mg','2026-03-05'),(92,9,4,'Lower Back Pain','Albuterol Inhaler','2026-03-08'),(93,6,7,'Acid Reflux','Metformin 500mg','2026-04-20');
/*!40000 ALTER TABLE `medical_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medical_reports`
--

DROP TABLE IF EXISTS `medical_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medical_reports` (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) DEFAULT NULL,
  `doctor_id` int(11) DEFAULT NULL,
  `report_type` varchar(100) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `upload_date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`report_id`),
  KEY `patient_id` (`patient_id`),
  CONSTRAINT `medical_reports_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medical_reports`
--

LOCK TABLES `medical_reports` WRITE;
/*!40000 ALTER TABLE `medical_reports` DISABLE KEYS */;
INSERT INTO `medical_reports` VALUES (1,33,NULL,'Clinical Report - Type 2 Dia','/reports/sample_1.pdf','2026-04-29 10:40:20'),(2,3,NULL,'Clinical Report - High Chole','/reports/sample_2.pdf','2026-04-29 10:40:20'),(3,39,NULL,'Clinical Report - Seasonal A','/reports/sample_3.pdf','2026-04-29 10:40:20'),(4,30,NULL,'Clinical Report - Seasonal A','/reports/sample_4.pdf','2026-04-29 10:40:20'),(5,2,NULL,'Clinical Report - Migraine','/reports/sample_7.pdf','2026-04-29 10:40:20'),(6,36,NULL,'Clinical Report - Migraine','/reports/sample_8.pdf','2026-04-29 10:40:20'),(7,49,NULL,'Clinical Report - High Chole','/reports/sample_9.pdf','2026-04-29 10:40:20'),(8,3,NULL,'Clinical Report - Lower Back','/reports/sample_10.pdf','2026-04-29 10:40:20'),(9,1,NULL,'Clinical Report - Chronic Hy','/reports/sample_12.pdf','2026-04-29 10:40:20'),(10,22,NULL,'Clinical Report - Acid Reflu','/reports/sample_13.pdf','2026-04-29 10:40:20'),(11,50,NULL,'Clinical Report - Migraine','/reports/sample_14.pdf','2026-04-29 10:40:20'),(12,46,NULL,'Clinical Report - Type 2 Dia','/reports/sample_15.pdf','2026-04-29 10:40:20'),(13,19,NULL,'Clinical Report - High Chole','/reports/sample_16.pdf','2026-04-29 10:40:20'),(14,36,NULL,'Clinical Report - Chronic Hy','/reports/sample_18.pdf','2026-04-29 10:40:20'),(15,31,NULL,'Clinical Report - Lower Back','/reports/sample_19.pdf','2026-04-29 10:40:20'),(16,22,NULL,'Clinical Report - High Chole','/reports/sample_20.pdf','2026-04-29 10:40:20'),(17,32,NULL,'Clinical Report - Seasonal A','/reports/sample_21.pdf','2026-04-29 10:40:20'),(18,24,NULL,'Clinical Report - High Chole','/reports/sample_25.pdf','2026-04-29 10:40:20'),(19,26,NULL,'Clinical Report - Type 2 Dia','/reports/sample_29.pdf','2026-04-29 10:40:20'),(20,49,NULL,'Clinical Report - Lower Back','/reports/sample_30.pdf','2026-04-29 10:40:20'),(21,40,NULL,'Clinical Report - Migraine','/reports/sample_31.pdf','2026-04-29 10:40:20'),(22,22,NULL,'Clinical Report - Chronic Hy','/reports/sample_34.pdf','2026-04-29 10:40:20'),(23,20,NULL,'Clinical Report - Acid Reflu','/reports/sample_35.pdf','2026-04-29 10:40:20'),(24,45,NULL,'Clinical Report - Lower Back','/reports/sample_36.pdf','2026-04-29 10:40:20'),(25,40,NULL,'Clinical Report - Asthma','/reports/sample_40.pdf','2026-04-29 10:40:20'),(26,17,NULL,'Clinical Report - High Chole','/reports/sample_42.pdf','2026-04-29 10:40:20'),(27,2,NULL,'Clinical Report - Chronic Hy','/reports/sample_43.pdf','2026-04-29 10:40:20'),(28,40,NULL,'Clinical Report - Seasonal A','/reports/sample_47.pdf','2026-04-29 10:40:20'),(29,37,NULL,'Clinical Report - Asthma','/reports/sample_48.pdf','2026-04-29 10:40:20'),(30,38,NULL,'Clinical Report - Migraine','/reports/sample_51.pdf','2026-04-29 10:40:20'),(31,15,NULL,'Clinical Report - High Chole','/reports/sample_52.pdf','2026-04-29 10:40:20'),(32,6,NULL,'Clinical Report - Type 2 Dia','/reports/sample_53.pdf','2026-04-29 10:40:20'),(33,23,NULL,'Clinical Report - Chronic Hy','/reports/sample_54.pdf','2026-04-29 10:40:20'),(34,43,NULL,'Clinical Report - Seasonal A','/reports/sample_56.pdf','2026-04-29 10:40:20'),(35,27,NULL,'Clinical Report - Seasonal A','/reports/sample_59.pdf','2026-04-29 10:40:20'),(36,45,NULL,'Clinical Report - Type 2 Dia','/reports/sample_60.pdf','2026-04-29 10:40:20'),(37,29,NULL,'Clinical Report - Seasonal A','/reports/sample_62.pdf','2026-04-29 10:40:20'),(38,7,NULL,'Clinical Report - Acid Reflu','/reports/sample_63.pdf','2026-04-29 10:40:20'),(39,16,NULL,'Clinical Report - Type 2 Dia','/reports/sample_65.pdf','2026-04-29 10:40:20'),(40,45,NULL,'Clinical Report - Lower Back','/reports/sample_67.pdf','2026-04-29 10:40:20'),(41,11,NULL,'Clinical Report - Lower Back','/reports/sample_70.pdf','2026-04-29 10:40:20'),(42,34,NULL,'Clinical Report - Seasonal A','/reports/sample_77.pdf','2026-04-29 10:40:20'),(43,7,NULL,'Clinical Report - High Chole','/reports/sample_78.pdf','2026-04-29 10:40:20'),(44,24,NULL,'Clinical Report - Lower Back','/reports/sample_79.pdf','2026-04-29 10:40:20'),(45,21,NULL,'Clinical Report - Acid Reflu','/reports/sample_81.pdf','2026-04-29 10:40:20'),(46,27,NULL,'Clinical Report - Type 2 Dia','/reports/sample_83.pdf','2026-04-29 10:40:20'),(47,37,NULL,'Clinical Report - Acid Reflu','/reports/sample_84.pdf','2026-04-29 10:40:20'),(48,36,NULL,'Clinical Report - Chronic Hy','/reports/sample_86.pdf','2026-04-29 10:40:20'),(49,17,NULL,'Clinical Report - Asthma','/reports/sample_87.pdf','2026-04-29 10:40:20'),(50,8,NULL,'Clinical Report - Lower Back','/reports/sample_88.pdf','2026-04-29 10:40:20'),(51,14,NULL,'Clinical Report - Acid Reflu','/reports/sample_91.pdf','2026-04-29 10:40:20'),(52,37,NULL,'Clinical Report - Acid Reflu','/reports/sample_93.pdf','2026-04-29 10:40:20'),(53,29,NULL,'Clinical Report - Type 2 Dia','/reports/sample_94.pdf','2026-04-29 10:40:20'),(54,36,NULL,'Clinical Report - Asthma','/reports/sample_95.pdf','2026-04-29 10:40:20'),(55,43,NULL,'Clinical Report - Asthma','/reports/sample_96.pdf','2026-04-29 10:40:20'),(56,49,NULL,'Clinical Report - Asthma','/reports/sample_97.pdf','2026-04-29 10:40:20'),(57,17,NULL,'Clinical Report - Lower Back','/reports/sample_102.pdf','2026-04-29 10:40:20'),(58,39,NULL,'Clinical Report - Asthma','/reports/sample_104.pdf','2026-04-29 10:40:20'),(59,1,NULL,'Clinical Report - High Chole','/reports/sample_108.pdf','2026-04-29 10:40:20'),(60,11,NULL,'Clinical Report - Lower Back','/reports/sample_114.pdf','2026-04-29 10:40:20'),(61,5,NULL,'Clinical Report - Chronic Hy','/reports/sample_116.pdf','2026-04-29 10:40:20'),(62,1,NULL,'Clinical Report - Acid Reflu','/reports/sample_117.pdf','2026-04-29 10:40:20'),(63,18,NULL,'Clinical Report - High Chole','/reports/sample_118.pdf','2026-04-29 10:40:20'),(64,3,NULL,'Clinical Report - Migraine','/reports/sample_119.pdf','2026-04-29 10:40:20'),(65,39,NULL,'Clinical Report - Seasonal A','/reports/sample_121.pdf','2026-04-29 10:40:20'),(66,12,NULL,'Clinical Report - Asthma','/reports/sample_122.pdf','2026-04-29 10:40:20'),(67,8,NULL,'Clinical Report - High Chole','/reports/sample_123.pdf','2026-04-29 10:40:20'),(68,12,NULL,'Clinical Report - Acid Reflu','/reports/sample_124.pdf','2026-04-29 10:40:20'),(69,6,NULL,'Clinical Report - Migraine','/reports/sample_126.pdf','2026-04-29 10:40:20'),(70,25,NULL,'Clinical Report - Seasonal A','/reports/sample_127.pdf','2026-04-29 10:40:20'),(71,48,NULL,'Clinical Report - Seasonal A','/reports/sample_128.pdf','2026-04-29 10:40:20'),(72,6,NULL,'Clinical Report - Seasonal A','/reports/sample_129.pdf','2026-04-29 10:40:20'),(73,50,NULL,'Clinical Report - Chronic Hy','/reports/sample_130.pdf','2026-04-29 10:40:20'),(74,3,NULL,'Clinical Report - Seasonal A','/reports/sample_132.pdf','2026-04-29 10:40:20'),(75,23,NULL,'Clinical Report - Asthma','/reports/sample_135.pdf','2026-04-29 10:40:20'),(76,45,NULL,'Clinical Report - Type 2 Dia','/reports/sample_136.pdf','2026-04-29 10:40:20'),(77,4,NULL,'Clinical Report - Type 2 Dia','/reports/sample_139.pdf','2026-04-29 10:40:20'),(78,34,NULL,'Clinical Report - Acid Reflu','/reports/sample_142.pdf','2026-04-29 10:40:20'),(79,22,NULL,'Clinical Report - Lower Back','/reports/sample_143.pdf','2026-04-29 10:40:20'),(80,11,NULL,'Clinical Report - High Chole','/reports/sample_144.pdf','2026-04-29 10:40:20'),(81,43,NULL,'Clinical Report - Seasonal A','/reports/sample_145.pdf','2026-04-29 10:40:20'),(82,43,NULL,'Clinical Report - High Chole','/reports/sample_147.pdf','2026-04-29 10:40:20'),(83,2,NULL,'Clinical Report - Chronic Hy','/reports/sample_149.pdf','2026-04-29 10:40:20'),(84,30,NULL,'Clinical Report - Acid Reflu','/reports/sample_152.pdf','2026-04-29 10:40:20'),(85,50,NULL,'Clinical Report - Seasonal A','/reports/sample_155.pdf','2026-04-29 10:40:20'),(86,13,NULL,'Clinical Report - Type 2 Dia','/reports/sample_157.pdf','2026-04-29 10:40:20'),(87,32,NULL,'Clinical Report - High Chole','/reports/sample_159.pdf','2026-04-29 10:40:20'),(88,25,NULL,'Clinical Report - Asthma','/reports/sample_160.pdf','2026-04-29 10:40:20'),(89,44,NULL,'Clinical Report - Asthma','/reports/sample_168.pdf','2026-04-29 10:40:20'),(90,8,NULL,'Clinical Report - Migraine','/reports/sample_175.pdf','2026-04-29 10:40:20'),(91,43,NULL,'Clinical Report - Type 2 Dia','/reports/sample_176.pdf','2026-04-29 10:40:20'),(92,9,NULL,'Clinical Report - Lower Back','/reports/sample_178.pdf','2026-04-29 10:40:20'),(93,6,NULL,'Clinical Report - Acid Reflu','/reports/sample_180.pdf','2026-04-29 10:40:20');
/*!40000 ALTER TABLE `medical_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) DEFAULT NULL,
  `token_id` int(11) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `notification_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `STATUS` enum('sent','pending','failed') DEFAULT NULL,
  `TYPE` varchar(50) DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`notification_id`),
  KEY `token_id` (`token_id`),
  KEY `idx_notifications_patient` (`patient_id`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  CONSTRAINT `notifications_ibfk_2` FOREIGN KEY (`token_id`) REFERENCES `tokens` (`token_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patients` (
  `patient_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `gender` enum('male','female','other') DEFAULT NULL,
  `address` text DEFAULT NULL,
  PRIMARY KEY (`patient_id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` VALUES (1,14,'01830740150','1973-12-25','male','91 Rahman Road, Dhaka'),(2,15,'01875476131','1997-11-07','male','32 Begum Road, Dhaka'),(3,16,'01844654339','1998-10-31','male','37 Sarkar Road, Dhaka'),(4,17,'01816738673','1959-08-16','female','78 Miah Road, Dhaka'),(5,18,'01832542488','2004-12-13','male','55 Munshi Road, Dhaka'),(6,19,'01854470997','2005-01-28','female','35 Begum Road, Dhaka'),(7,20,'01884190479','1991-03-20','male','16 Shakur Road, Dhaka'),(8,21,'01874683805','1972-01-10','female','20 Chowdhury Road, Dhaka'),(9,22,'01831927653','1958-02-07','female','74 Sultana Road, Dhaka'),(10,23,'01875663662','1964-05-28','male','49 Sarkar Road, Dhaka'),(11,24,'01894501480','1986-12-09','male','82 Sarkar Road, Dhaka'),(12,25,'01859740106','1980-04-04','female','22 Islam Road, Dhaka'),(13,26,'01885130923','1982-05-06','female','51 Munshi Road, Dhaka'),(14,27,'01842214218','1993-06-04','female','10 Begum Road, Dhaka'),(15,28,'01862422568','1960-07-18','male','22 Ahmed Road, Dhaka'),(16,29,'01889524868','1961-03-15','female','37 Ahmed Road, Dhaka'),(17,30,'01860706283','1978-09-16','female','30 Akter Road, Dhaka'),(18,31,'01860974097','1988-07-28','female','73 Shakur Road, Dhaka'),(19,32,'01812130244','1972-11-28','female','99 Sultana Road, Dhaka'),(20,33,'01878129091','1998-10-15','male','60 Shakur Road, Dhaka'),(21,34,'01899103154','1980-08-01','female','74 Majumder Road, Dhaka'),(22,35,'01855192410','1992-06-19','male','13 Islam Road, Dhaka'),(23,36,'01886260000','1986-07-04','female','59 Hossain Road, Dhaka'),(24,37,'01826948155','1989-09-05','female','47 Jahan Road, Dhaka'),(25,38,'01877335061','1988-07-27','female','92 Bhuiyan Road, Dhaka'),(26,39,'01827971338','1974-02-22','male','54 Shakur Road, Dhaka'),(27,40,'01826008874','1972-03-16','female','32 Ahmed Road, Dhaka'),(28,41,'01823311225','1959-10-13','male','17 Haque Road, Dhaka'),(29,42,'01851373921','1973-04-30','female','88 Islam Road, Dhaka'),(30,43,'01823202674','1985-09-27','female','45 Uddin Road, Dhaka'),(31,44,'01870303771','1996-02-29','male','68 Chowdhury Road, Dhaka'),(32,45,'01856728331','1963-03-30','female','64 Hossain Road, Dhaka'),(33,46,'01810285715','1980-01-09','male','30 Sultana Road, Dhaka'),(34,47,'01823365972','1982-08-03','female','41 Rahman Road, Dhaka'),(35,48,'01817959721','1977-12-21','female','91 Munshi Road, Dhaka'),(36,49,'01832141677','1955-12-19','male','78 Khan Road, Dhaka'),(37,50,'01816168902','2006-12-23','male','92 Munshi Road, Dhaka'),(38,51,'01885870059','1981-01-06','male','77 Begum Road, Dhaka'),(39,52,'01819000189','1970-11-20','male','13 Islam Road, Dhaka'),(40,53,'01879013464','1964-06-25','male','34 Jahan Road, Dhaka'),(41,54,'01853790285','1992-05-22','female','85 Ahmed Road, Dhaka'),(42,55,'01833279880','1984-07-17','female','54 Islam Road, Dhaka'),(43,56,'01856966331','1993-11-19','male','98 Munshi Road, Dhaka'),(44,57,'01891293643','2005-11-22','male','64 Majumder Road, Dhaka'),(45,58,'01858679388','1982-03-15','male','76 Begum Road, Dhaka'),(46,59,'01852771296','2002-08-27','male','48 Sultana Road, Dhaka'),(47,60,'01896276183','1962-07-07','female','20 Sarkar Road, Dhaka'),(48,61,'01891923595','1989-05-26','female','23 Uddin Road, Dhaka'),(49,62,'01868538038','2005-10-21','male','27 Rahman Road, Dhaka'),(50,63,'01863087134','1968-11-20','male','49 Hossain Road, Dhaka');
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `token_id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `method` varchar(50) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `payment_status` enum('pending','paid','failed') DEFAULT NULL,
  `transaction_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `payment_gateway` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  UNIQUE KEY `token_id` (`token_id`),
  KEY `patient_id` (`patient_id`),
  KEY `idx_payments_token` (`token_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`token_id`) REFERENCES `tokens` (`token_id`),
  CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,1,33,'Nagad',954.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(2,2,3,'Nagad',580.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(3,3,39,'bKash',1375.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(4,4,30,'Nagad',1163.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(5,5,4,'Nagad',873.00,'pending',NULL,'2026-04-29 10:40:20',NULL),(6,7,2,'Nagad',967.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(7,8,36,'Nagad',529.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(8,9,49,'Nagad',750.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(9,10,3,'bKash',880.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(10,12,1,'bKash',1257.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(11,13,22,'Nagad',652.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(12,14,50,'Nagad',697.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(13,15,46,'bKash',756.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(14,16,19,'Nagad',1205.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(15,18,36,'Nagad',1114.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(16,19,31,'bKash',992.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(17,20,22,'bKash',1307.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(18,21,32,'Nagad',1286.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(19,22,42,'Nagad',802.00,'pending',NULL,'2026-04-29 10:40:20',NULL),(20,25,24,'Nagad',1382.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(21,29,26,'bKash',611.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(22,30,49,'Nagad',917.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(23,31,40,'Nagad',1231.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(24,34,22,'bKash',1046.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(25,35,20,'Nagad',1465.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(26,36,45,'Nagad',1039.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(27,37,50,'Nagad',575.00,'pending',NULL,'2026-04-29 10:40:20',NULL),(28,38,34,'bKash',1145.00,'pending',NULL,'2026-04-29 10:40:20',NULL),(29,40,40,'bKash',711.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(30,42,17,'Nagad',1480.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(31,43,2,'Nagad',517.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(32,47,40,'bKash',736.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(33,48,37,'bKash',1406.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(34,50,46,'Nagad',509.00,'pending',NULL,'2026-04-29 10:40:20',NULL),(35,51,38,'Nagad',1403.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(36,52,15,'Nagad',813.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(37,53,6,'Nagad',1055.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(38,54,23,'bKash',1000.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(39,55,7,'bKash',892.00,'pending',NULL,'2026-04-29 10:40:20',NULL),(40,56,43,'bKash',731.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(41,58,37,'Nagad',662.00,'pending',NULL,'2026-04-29 10:40:20',NULL),(42,59,27,'Nagad',953.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(43,60,45,'Nagad',816.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(44,62,29,'Nagad',1294.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(45,63,7,'bKash',1300.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(46,65,16,'bKash',1462.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(47,67,45,'bKash',815.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(48,70,11,'bKash',1120.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(49,71,34,'Nagad',883.00,'pending',NULL,'2026-04-29 10:40:20',NULL),(50,77,34,'bKash',534.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(51,78,7,'bKash',939.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(52,79,24,'bKash',587.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(53,81,21,'bKash',1228.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(54,82,46,'bKash',784.00,'pending',NULL,'2026-04-29 10:40:20',NULL),(55,83,27,'bKash',1195.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(56,84,37,'Nagad',803.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(57,85,47,'Nagad',1418.00,'pending',NULL,'2026-04-29 10:40:20',NULL),(58,86,36,'Nagad',1181.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(59,87,17,'Nagad',868.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(60,88,8,'Nagad',1195.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(61,89,46,'bKash',1408.00,'pending',NULL,'2026-04-29 10:40:20',NULL),(62,91,14,'bKash',728.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(63,93,37,'Nagad',1072.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(64,94,29,'Nagad',869.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(65,95,36,'bKash',529.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(66,96,43,'bKash',920.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(67,97,49,'Nagad',1451.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(68,100,50,'bKash',1089.00,'pending',NULL,'2026-04-29 10:40:20',NULL),(69,102,17,'bKash',1168.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(70,103,12,'Nagad',613.00,'pending',NULL,'2026-04-29 10:40:20',NULL),(71,104,39,'bKash',1226.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(72,108,1,'bKash',1422.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(73,114,11,'bKash',865.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(74,116,5,'bKash',828.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(75,117,1,'bKash',973.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(76,118,18,'Nagad',762.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(77,119,3,'bKash',1117.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(78,121,39,'Nagad',956.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(79,122,12,'bKash',511.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(80,123,8,'bKash',1452.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(81,124,12,'bKash',797.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(82,125,19,'Nagad',742.00,'pending',NULL,'2026-04-29 10:40:20',NULL),(83,126,6,'bKash',1403.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(84,127,25,'bKash',958.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(85,128,48,'Nagad',998.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(86,129,6,'Nagad',1201.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(87,130,50,'bKash',953.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(88,131,23,'Nagad',541.00,'pending',NULL,'2026-04-29 10:40:20',NULL),(89,132,3,'bKash',1071.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(90,135,23,'Nagad',1036.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(91,136,45,'Nagad',965.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(92,137,13,'bKash',1034.00,'pending',NULL,'2026-04-29 10:40:20',NULL),(93,139,4,'bKash',1151.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(94,142,34,'Nagad',764.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(95,143,22,'bKash',1314.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(96,144,11,'bKash',762.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(97,145,43,'bKash',1313.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(98,147,43,'bKash',923.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(99,148,27,'Nagad',1050.00,'pending',NULL,'2026-04-29 10:40:20',NULL),(100,149,2,'bKash',664.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(101,151,28,'Nagad',672.00,'pending',NULL,'2026-04-29 10:40:20',NULL),(102,152,30,'Nagad',1030.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(103,155,50,'bKash',1060.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(104,157,13,'bKash',963.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(105,159,32,'bKash',1362.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(106,160,25,'Nagad',1136.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(107,167,5,'Nagad',765.00,'pending',NULL,'2026-04-29 10:40:20',NULL),(108,168,44,'bKash',981.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(109,171,34,'Nagad',1378.00,'pending',NULL,'2026-04-29 10:40:20',NULL),(110,175,8,'Nagad',987.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(111,176,43,'bKash',771.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(112,178,9,'bKash',1351.00,'paid',NULL,'2026-04-29 10:40:20',NULL),(113,180,6,'Nagad',1170.00,'paid',NULL,'2026-04-29 10:40:20',NULL);
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tokens` (
  `token_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) DEFAULT NULL,
  `doctor_id` int(11) DEFAULT NULL,
  `token_number` int(11) DEFAULT NULL,
  `appointment_date` date DEFAULT NULL,
  `STATUS` enum('pending_payment','confirmed','in_queue','in_progress','completed','cancelled') DEFAULT 'pending_payment',
  `estimated_wait_time` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `queue_position` int(11) DEFAULT NULL,
  `started_at` timestamp NULL DEFAULT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  `actual_duration` decimal(10,2) DEFAULT NULL,
  `predicted_duration` decimal(10,2) DEFAULT NULL,
  `hidden_by_patient` tinyint(1) DEFAULT 0,
  `hidden_by_doctor` tinyint(1) DEFAULT 0,
  `appointment_time` time DEFAULT NULL,
  PRIMARY KEY (`token_id`),
  KEY `idx_tokens_doctor_date` (`doctor_id`,`appointment_date`),
  KEY `idx_tokens_patient` (`patient_id`),
  CONSTRAINT `tokens_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  CONSTRAINT `tokens_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
INSERT INTO `tokens` VALUES (1,33,11,893,'2026-05-22','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(2,3,7,322,'2026-06-22','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(3,39,10,444,'2026-06-24','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(4,30,5,421,'2026-06-27','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(5,4,4,746,'2026-04-27','confirmed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(6,29,10,238,'2026-05-30','in_queue',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(7,2,11,361,'2026-05-28','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(8,36,2,330,'2026-04-05','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(9,49,8,935,'2026-05-03','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(10,3,1,124,'2026-04-30','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(11,13,1,195,'2026-04-06','in_queue',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(12,1,4,733,'2026-05-17','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(13,22,3,366,'2026-02-28','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(14,50,3,284,'2026-06-26','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(15,46,9,341,'2026-04-23','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(16,19,2,457,'2026-03-06','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(17,13,10,140,'2026-04-16','cancelled',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(18,36,5,199,'2026-05-07','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(19,31,7,837,'2026-06-27','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(20,22,12,660,'2026-04-15','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(21,32,1,339,'2026-06-28','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(22,42,2,600,'2026-05-27','confirmed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(23,45,4,627,'2026-04-29','in_queue',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(24,19,11,933,'2026-06-08','in_queue',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(25,24,7,718,'2026-05-06','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(26,13,3,844,'2026-05-10','in_queue',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(27,42,10,687,'2026-04-29','cancelled',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(28,16,5,398,'2026-04-14','pending_payment',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(29,26,9,591,'2026-03-14','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(30,49,10,397,'2026-06-09','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(31,40,8,572,'2026-05-09','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(32,44,7,421,'2026-03-20','in_queue',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(33,9,3,847,'2026-03-20','in_queue',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(34,22,12,690,'2026-05-04','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(35,20,6,803,'2026-03-30','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(36,45,2,142,'2026-04-09','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(37,50,8,918,'2026-03-27','confirmed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(38,34,7,917,'2026-02-28','confirmed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(39,49,7,677,'2026-03-11','in_queue',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(40,40,6,236,'2026-05-10','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(41,35,1,527,'2026-05-18','in_queue',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(42,17,8,133,'2026-04-23','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(43,2,5,581,'2026-04-22','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(44,37,4,230,'2026-05-24','cancelled',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(45,49,2,602,'2026-04-20','pending_payment',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(46,28,2,933,'2026-03-07','pending_payment',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(47,40,4,370,'2026-04-20','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(48,37,1,619,'2026-05-01','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(49,14,5,310,'2026-05-25','pending_payment',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(50,46,6,878,'2026-03-16','confirmed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(51,38,10,220,'2026-03-06','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(52,15,4,709,'2026-05-06','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(53,6,6,383,'2026-06-04','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(54,23,1,294,'2026-03-27','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(55,7,11,539,'2026-05-02','confirmed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(56,43,3,854,'2026-03-11','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(57,3,12,152,'2026-05-22','cancelled',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(58,37,9,236,'2026-04-19','confirmed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(59,27,2,515,'2026-04-05','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(60,45,4,923,'2026-05-27','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(61,20,6,245,'2026-06-26','cancelled',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(62,29,5,523,'2026-06-08','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(63,7,3,692,'2026-05-24','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(64,7,5,105,'2026-06-14','pending_payment',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(65,16,12,203,'2026-06-13','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(66,18,10,862,'2026-05-17','pending_payment',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(67,45,2,242,'2026-04-25','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(68,5,8,385,'2026-06-14','pending_payment',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(69,17,1,986,'2026-05-25','pending_payment',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(70,11,2,342,'2026-05-09','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(71,34,3,986,'2026-06-09','confirmed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(72,43,5,191,'2026-05-27','cancelled',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(73,41,8,868,'2026-06-26','cancelled',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(74,12,9,404,'2026-04-19','in_queue',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(75,43,10,232,'2026-06-09','pending_payment',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(76,50,10,589,'2026-03-25','pending_payment',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(77,34,12,293,'2026-03-21','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(78,7,1,535,'2026-03-30','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(79,24,4,870,'2026-03-14','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(80,19,11,932,'2026-03-03','in_queue',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(81,21,8,767,'2026-06-02','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(82,46,5,525,'2026-04-27','confirmed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(83,27,6,910,'2026-04-29','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(84,37,2,834,'2026-06-03','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(85,47,11,166,'2026-03-02','confirmed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(86,36,6,784,'2026-05-06','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(87,17,1,818,'2026-06-17','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(88,8,11,959,'2026-06-23','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(89,46,11,204,'2026-03-30','confirmed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(90,9,6,757,'2026-06-14','cancelled',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(91,14,10,584,'2026-04-24','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(92,33,9,107,'2026-03-05','cancelled',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(93,37,8,370,'2026-03-16','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(94,29,4,240,'2026-05-24','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(95,36,8,157,'2026-06-22','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(96,43,11,860,'2026-03-22','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(97,49,12,480,'2026-05-09','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(98,37,9,289,'2026-06-21','cancelled',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(99,37,1,177,'2026-03-15','pending_payment',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(100,50,6,165,'2026-04-15','confirmed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(101,45,1,820,'2026-04-30','in_queue',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(102,17,10,446,'2026-03-30','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(103,12,11,841,'2026-03-17','confirmed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(104,39,11,194,'2026-02-28','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(105,37,6,291,'2026-05-07','in_queue',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(106,40,9,683,'2026-04-11','in_queue',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(107,30,3,316,'2026-04-12','in_queue',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(108,1,11,671,'2026-06-01','cancelled',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,1,0,NULL),(109,23,10,805,'2026-04-28','pending_payment',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(110,9,5,486,'2026-03-16','cancelled',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(111,11,3,301,'2026-06-08','cancelled',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(112,7,1,263,'2026-04-23','cancelled',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(113,48,4,404,'2026-04-12','in_queue',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(114,11,10,628,'2026-04-08','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(115,48,1,697,'2026-03-19','in_queue',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(116,5,3,177,'2026-05-05','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(117,1,1,103,'2026-06-25','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(118,18,7,360,'2026-04-29','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(119,3,8,640,'2026-03-19','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(120,15,4,635,'2026-04-11','pending_payment',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(121,39,3,338,'2026-04-09','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(122,12,5,331,'2026-03-16','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(123,8,4,325,'2026-03-16','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(124,12,1,603,'2026-06-12','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(125,19,8,683,'2026-05-25','confirmed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(126,6,12,148,'2026-03-03','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(127,25,8,625,'2026-05-09','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(128,48,7,675,'2026-05-16','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(129,6,8,782,'2026-06-09','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(130,50,10,854,'2026-03-18','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(131,23,12,945,'2026-04-29','confirmed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(132,3,7,265,'2026-04-07','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(133,28,1,986,'2026-06-10','in_queue',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(134,9,11,404,'2026-04-29','in_queue',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(135,23,12,121,'2026-06-21','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(136,45,1,493,'2026-05-30','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(137,13,8,737,'2026-05-15','confirmed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(138,10,7,898,'2026-03-14','cancelled',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(139,4,9,101,'2026-05-18','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(140,22,6,704,'2026-05-26','pending_payment',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(141,43,7,713,'2026-04-08','in_queue',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(142,34,6,730,'2026-04-23','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(143,22,1,780,'2026-04-22','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(144,11,7,712,'2026-03-27','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(145,43,11,241,'2026-06-05','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(146,25,10,857,'2026-03-01','cancelled',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(147,43,12,353,'2026-06-11','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(148,27,11,582,'2026-06-16','confirmed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(149,2,7,526,'2026-03-01','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(150,5,11,964,'2026-03-16','cancelled',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(151,28,7,291,'2026-05-22','confirmed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(152,30,10,679,'2026-04-11','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(153,46,5,498,'2026-05-25','cancelled',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(154,34,5,571,'2026-05-07','cancelled',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(155,50,3,608,'2026-05-17','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(156,36,9,185,'2026-03-26','pending_payment',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(157,13,1,300,'2026-04-05','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(158,22,6,736,'2026-06-15','pending_payment',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(159,32,9,937,'2026-03-20','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(160,25,5,858,'2026-05-23','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(161,2,7,817,'2026-05-11','in_queue',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(162,35,12,969,'2026-04-26','cancelled',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(163,30,2,678,'2026-04-23','pending_payment',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(164,37,2,894,'2026-05-04','in_queue',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(165,40,9,958,'2026-06-17','cancelled',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(166,16,3,530,'2026-06-13','in_queue',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(167,5,10,716,'2026-03-06','confirmed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(168,44,12,542,'2026-03-12','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(169,22,5,699,'2026-05-07','in_queue',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(170,29,12,770,'2026-05-19','in_queue',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(171,34,7,341,'2026-04-14','confirmed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(172,37,6,155,'2026-06-08','in_queue',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(173,5,3,204,'2026-04-13','pending_payment',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(174,15,12,507,'2026-04-13','in_queue',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(175,8,6,936,'2026-03-24','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(176,43,8,331,'2026-03-05','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(177,18,8,281,'2026-03-06','in_queue',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(178,9,4,204,'2026-03-08','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(179,16,11,542,'2026-04-02','pending_payment',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(180,6,7,274,'2026-04-20','completed',NULL,'2026-04-29 10:40:20',NULL,NULL,NULL,NULL,NULL,0,0,NULL),(182,1,1,1,'2026-04-29','completed',0,'2026-04-29 10:46:21',NULL,'2026-04-29 03:00:00','2026-04-29 03:03:12',3.20,5.00,0,0,'09:00:00'),(183,2,1,2,'2026-04-29','completed',5,'2026-04-29 10:46:21',NULL,'2026-04-29 03:05:00','2026-04-29 03:12:48',7.80,5.00,0,0,'09:05:00'),(184,3,1,3,'2026-04-29','in_progress',10,'2026-04-29 10:46:21',NULL,'2026-04-29 06:46:21',NULL,NULL,5.00,0,0,'09:10:00'),(185,4,1,4,'2026-04-29','confirmed',15,'2026-04-29 10:46:21',NULL,NULL,NULL,NULL,5.00,0,0,'09:15:00'),(186,5,1,5,'2026-04-29','confirmed',20,'2026-04-29 10:46:21',NULL,NULL,NULL,NULL,5.00,0,0,'09:20:00'),(187,6,1,6,'2026-04-29','confirmed',25,'2026-04-29 10:46:21',NULL,NULL,NULL,NULL,5.00,0,0,'09:25:00'),(188,1,1,7,'2026-04-29','completed',0,'2026-04-29 10:46:21',NULL,'2026-04-29 07:00:00','2026-04-29 07:03:12',3.20,5.00,0,0,'13:00:00'),(189,2,1,8,'2026-04-29','completed',5,'2026-04-29 10:46:21',NULL,'2026-04-29 07:05:00','2026-04-29 07:12:48',7.80,5.00,0,0,'13:05:00'),(190,3,1,9,'2026-04-29','in_progress',10,'2026-04-29 10:46:21',NULL,'2026-04-29 06:46:21',NULL,NULL,5.00,0,0,'13:10:00'),(191,4,1,10,'2026-04-29','confirmed',15,'2026-04-29 10:46:21',NULL,NULL,NULL,NULL,5.00,0,0,'13:15:00'),(192,5,1,11,'2026-04-29','confirmed',20,'2026-04-29 10:46:21',NULL,NULL,NULL,NULL,5.00,0,0,'13:20:00'),(193,6,1,12,'2026-04-29','confirmed',25,'2026-04-29 10:46:21',NULL,NULL,NULL,NULL,5.00,0,0,'13:25:00'),(194,1,1,13,'2026-04-29','completed',0,'2026-04-29 10:46:21',NULL,'2026-04-29 11:00:00','2026-04-29 11:03:12',3.20,5.00,0,0,'17:00:00'),(195,2,1,14,'2026-04-29','completed',5,'2026-04-29 10:46:21',NULL,'2026-04-29 11:05:00','2026-04-29 11:12:48',7.80,5.00,0,0,'17:05:00'),(196,3,1,15,'2026-04-29','completed',10,'2026-04-29 10:46:21',NULL,'2026-04-29 06:46:21','2026-04-29 10:49:04',2.72,5.00,0,0,'17:10:00'),(197,4,1,16,'2026-04-29','confirmed',15,'2026-04-29 10:46:21',NULL,NULL,NULL,NULL,5.00,0,0,'17:15:00'),(198,5,1,17,'2026-04-29','confirmed',20,'2026-04-29 10:46:21',NULL,NULL,NULL,NULL,5.00,0,0,'17:20:00'),(199,6,1,18,'2026-04-29','confirmed',25,'2026-04-29 10:46:21',NULL,NULL,NULL,NULL,5.00,0,0,'17:25:00');
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `PASSWORD` varchar(255) DEFAULT NULL,
  `role` enum('patient','doctor','admin') DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_users_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'System Administrator','admin@cureflow.com','admin123','admin','2026-04-29 10:40:20'),(2,'Dr. Tanvir Khan','doctor_1@cureflow.com','doctor123','doctor','2026-04-29 10:40:20'),(3,'Dr. Nusrat Rahman','doctor_2@cureflow.com','doctor123','doctor','2026-04-29 10:40:20'),(4,'Dr. Lamia Shakur','doctor_3@cureflow.com','doctor123','doctor','2026-04-29 10:40:20'),(5,'Dr. Asif Munshi','doctor_4@cureflow.com','doctor123','doctor','2026-04-29 10:40:20'),(6,'Dr. Meher Rahman','doctor_5@cureflow.com','doctor123','doctor','2026-04-29 10:40:20'),(7,'Dr. Sabbir Miah','doctor_6@cureflow.com','doctor123','doctor','2026-04-29 10:40:20'),(8,'Dr. Sadia Khan','doctor_7@cureflow.com','doctor123','doctor','2026-04-29 10:40:20'),(9,'Dr. Asif Sultana','doctor_8@cureflow.com','doctor123','doctor','2026-04-29 10:40:20'),(10,'Dr. Anika Chowdhury','doctor_9@cureflow.com','doctor123','doctor','2026-04-29 10:40:20'),(11,'Dr. Sadia Sultana','doctor_10@cureflow.com','doctor123','doctor','2026-04-29 10:40:20'),(12,'Dr. Ishrat Ahmed','doctor_11@cureflow.com','doctor123','doctor','2026-04-29 10:40:20'),(13,'Dr. Lamia Majumder','doctor_12@cureflow.com','doctor123','doctor','2026-04-29 10:40:20'),(14,'Zubair Akter','patient_1@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(15,'Mahmud Ahmed','patient_2@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(16,'Zubair Majumder','patient_3@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(17,'Shafik Miah','patient_4@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(18,'Nusrat Miah','patient_5@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(19,'Fahim Sarkar','patient_6@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(20,'Lamia Islam','patient_7@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(21,'Ariful Ahmed','patient_8@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(22,'Asif Talukder','patient_9@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(23,'Ariful Chowdhury','patient_10@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(24,'Asif Akter','patient_11@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(25,'Sadia Sarkar','patient_12@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(26,'Tanvir Ali','patient_13@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(27,'Mahmud Munshi','patient_14@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(28,'Nabila Shakur','patient_15@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(29,'Shafik Munshi','patient_16@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(30,'Mahmud Sarkar','patient_17@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(31,'Anika Ali','patient_18@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(32,'Zubair Hossain','patient_19@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(33,'Ishrat Jahan','patient_20@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(34,'Shafik Ahmed','patient_21@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(35,'Ariful Talukder','patient_22@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(36,'Shafik Jahan','patient_23@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(37,'Sumaiya Shakur','patient_24@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(38,'Sabbir Jahan','patient_25@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(39,'Tanvir Talukder','patient_26@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(40,'Mahmud Rahman','patient_27@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(41,'Mahmud Uddin','patient_28@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(42,'Shafik Uddin','patient_29@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(43,'Riyad Talukder','patient_30@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(44,'Fahim Uddin','patient_31@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(45,'Sadia Sultana','patient_32@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(46,'Ariful Rahman','patient_33@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(47,'Fahim Ahmed','patient_34@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(48,'Kamrul Sultana','patient_35@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(49,'Sumaiya Ahmed','patient_36@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(50,'Anika Munshi','patient_37@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(51,'Meher Jahan','patient_38@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(52,'Sadia Chowdhury','patient_39@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(53,'Asif Miah','patient_40@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(54,'Fahim Miah','patient_41@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(55,'Riyad Bhuiyan','patient_42@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(56,'Asif Rahman','patient_43@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(57,'Shafik Begum','patient_44@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(58,'Sabbir Jahan','patient_45@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(59,'Sabbir Sarkar','patient_46@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(60,'Shafik Majumder','patient_47@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(61,'Tasnim Talukder','patient_48@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(62,'Farhana Rahman','patient_49@cureflow.com','patient123','patient','2026-04-29 10:40:20'),(63,'Zubair Islam','patient_50@cureflow.com','patient123','patient','2026-04-29 10:40:20');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-29 17:10:32
