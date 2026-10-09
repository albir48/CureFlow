SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';
START TRANSACTION;
SET time_zone = '+00:00';
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

/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,1);
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;

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
  `user_role` varchar(20) DEFAULT 'patient',
  `timestamps` timestamp NOT NULL DEFAULT current_timestamp(),
  `recommended_department` int(11) DEFAULT NULL,
  `recommended_doctor` int(11) DEFAULT NULL,
  `symptoms` text DEFAULT NULL,
  `ai_response` text DEFAULT NULL,
  PRIMARY KEY (`chat_id`),
  KEY `recommended_department` (`recommended_department`),
  KEY `recommended_doctor` (`recommended_doctor`),
  KEY `idx_chatbot_patient` (`patient_id`),
  CONSTRAINT `ai_chatbot_logs_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  CONSTRAINT `ai_chatbot_logs_ibfk_2` FOREIGN KEY (`recommended_department`) REFERENCES `departments` (`department_id`),
  CONSTRAINT `ai_chatbot_logs_ibfk_3` FOREIGN KEY (`recommended_doctor`) REFERENCES `doctors` (`doctor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ai_chatbot_logs`
--

/*!40000 ALTER TABLE `ai_chatbot_logs` DISABLE KEYS */;
INSERT INTO `ai_chatbot_logs` VALUES (2,1,1,'patient','2026-04-12 17:52:42',1,NULL,'I have sharp chest pain and difficulty breathing.',NULL),(3,1,1,'patient','2026-04-12 18:09:35',NULL,NULL,'hello',NULL),(4,1,1,'patient','2026-04-12 18:10:46',4,4,'I have a headache',NULL),(5,1,1,'patient','2026-04-12 18:11:28',NULL,NULL,'this is a uni project',NULL),(6,1,1,'patient','2026-04-12 18:11:58',NULL,NULL,'i am the one who built this website',NULL),(7,1,2,'patient','2026-04-12 18:22:01',NULL,NULL,'Mild headache and fatigue',NULL),(8,1,3,'patient','2026-04-12 18:22:01',NULL,NULL,'Persistent cough for 3 days',NULL),(9,1,4,'patient','2026-04-12 18:22:01',NULL,NULL,'Lower back pain',NULL),(10,1,5,'patient','2026-04-12 18:22:01',NULL,NULL,'Skin rash on arms',NULL),(11,1,6,'patient','2026-04-12 18:22:01',NULL,NULL,'Knee joint pain during movement',NULL),(12,1,7,'patient','2026-04-12 18:22:01',NULL,NULL,'Difficulty breathing at night',NULL),(13,1,8,'patient','2026-04-12 18:22:01',NULL,NULL,'Stomach ache after meals',NULL),(14,1,9,'patient','2026-04-12 18:22:01',NULL,NULL,'Frequent migraines',NULL),(15,1,10,'patient','2026-04-12 18:22:01',NULL,NULL,'High fever',NULL),(16,1,11,'patient','2026-04-12 18:22:01',NULL,NULL,'Sprained ankle',NULL),(17,1,12,'patient','2026-04-12 18:22:01',NULL,NULL,'Sore throat',NULL),(18,1,13,'patient','2026-04-12 18:22:01',NULL,NULL,'Allergic reaction',NULL),(19,1,14,'patient','2026-04-12 18:22:01',NULL,NULL,'Chest pain',NULL),(20,1,15,'patient','2026-04-12 18:22:01',NULL,NULL,'Blurred vision',NULL),(21,1,16,'patient','2026-04-12 18:22:01',NULL,NULL,'Dizziness',NULL),(22,1,17,'patient','2026-04-12 18:22:01',NULL,NULL,'Ear infection',NULL),(23,1,1,'patient','2026-04-12 18:32:13',NULL,NULL,'Fever and cough',NULL),(24,1,1,'patient','2026-04-12 18:33:20',NULL,NULL,'hello',NULL),(25,1,1,'patient','2026-04-13 06:04:15',NULL,NULL,'hi',NULL),(26,1,1,'patient','2026-04-13 06:04:23',NULL,NULL,'hi',NULL),(27,1,1,'patient','2026-04-13 06:04:44',NULL,NULL,'hi',NULL),(28,1,1,'patient','2026-04-13 06:05:24',NULL,NULL,'I have a headache',NULL),(29,1,1,'patient','2026-04-13 06:09:52',NULL,NULL,'hi',NULL),(30,1,1,'patient','2026-04-13 06:11:39',NULL,NULL,'thank you',NULL),(31,1,1,'patient','2026-04-13 06:12:09',5,5,'i have knee pain',NULL),(32,1,1,'admin','2026-04-16 10:09:28',NULL,NULL,'System health check','I encountered an error. Please try again.'),(33,1,1,'admin','2026-04-16 10:09:33',NULL,NULL,'k','I encountered an error. Please try again.'),(34,1,1,'admin','2026-04-16 10:20:50',NULL,NULL,'k','I encountered an error. Please try again.'),(35,1,1,'admin','2026-04-16 10:20:57',NULL,NULL,'jjjjjj','I encountered an error. Please try again.'),(36,1,1,'doctor','2026-04-16 10:22:19',NULL,NULL,'Recent medical literature','I encountered an error. Please try again.'),(37,1,1,'admin','2026-04-16 10:22:33',NULL,NULL,'mkkl','I encountered an error. Please try again.'),(38,1,1,'patient','2026-04-16 10:24:24',NULL,NULL,'hru','I encountered an error. Please try again.'),(39,1,1,'patient','2026-04-16 11:00:58',NULL,NULL,'hi','Hello! Welcome to CureFlow Hospital. How can I assist you today?'),(40,1,1,'patient','2026-04-16 11:01:23',NULL,NULL,'how many doctos?','There are 12 doctors at CureFlow Hospital.'),(41,1,1,'patient','2026-04-16 11:02:17',NULL,NULL,'what are the issues in the website?','As an AI Healthcare Assistant for CureFlow Hospital, my purpose is to provide information about our hospital services, departments, and doctors. I don\'t have access to information regarding the hospital\'s website or any technical issues it might be experiencing.\n\nIf you are looking for information about our hospital\'s services, or need help finding a doctor, please let me know!'),(42,1,1,'admin','2026-04-16 11:04:23',NULL,NULL,'huh?','It seems you\'re a bit confused or looking for clarification!\n\nAs your AI Technical Assistant for the \'CureFlow\' Hospital System, I\'m here to help you with topics related to:\n\n*   **Feature Development:** Discussing new functionalities, system design, API integrations, etc.\n*   **Database Health:** Queries about schema, performance, data integrity, backup strategies, etc.\n*   **System Architecture:** Understanding how different components of CureFlow interact.\n*   **Technical Troubleshooting:** Diagnosing system issues from a technical perspective.\n*   **General Computer Science concepts** applied to our system.\n\nCould you please elaborate on what you\'re trying to understand or what I can help you with? For example, you could ask:\n\n*   \"What\'s the status of the new patient portal feature?\"\n*   \"How can I optimize the `appointments` table?\"\n*   \"Explain the microservices architecture of CureFlow.\"\n*   \"I\'m getting an error when trying to access the `/api/doctors` endpoint.\"\n\nLet me know how I can assist!'),(43,2,1,'patient','2026-04-16 11:37:53',5,11,'I have a headache','I\'m sorry to hear you\'re experiencing a headache. For general symptoms like a headache, it\'s often best to consult with a General Medicine specialist first, as they can assess your condition comprehensively and refer you to a more specialized department if necessary.\n\nI recommend consulting with **Dr. Michael Wilson**, a General Medicine Specialist.'),(44,3,1,'patient','2026-04-16 11:38:06',NULL,NULL,'hello','Hello! Welcome to CureFlow Hospital. How can I assist you today?'),(45,4,1,'doctor','2026-04-16 11:38:35',NULL,NULL,'Schedule optimization','Optimizing a doctor\'s schedule is crucial for enhancing patient care, reducing burnout, and improving overall efficiency. As your Clinical Decision Support Assistant, I can offer several strategies for schedule optimization at \'CureFlow\' Hospital.'),(46,5,1,'admin','2026-04-16 11:39:15',NULL,NULL,'Security overview','Okay, Admin, let\'s break down the security landscape for CureFlow. Given you\'re a Computer Science student and we prioritize feature development and'),(47,6,1,'admin','2026-04-16 11:39:33',NULL,NULL,'System health check','Okay, Admin! Let\'s get a comprehensive overview of the CureFlow system\'s health. As a fellow CS enthusiast, you know that a robust'),(48,6,1,'admin','2026-04-16 11:42:54',NULL,NULL,'your message is cutoff.','My apologies! It seems my previous response was indeed cut off. That\'s certainly not helpful.\n\nPlease provide your original query again, or let me know what information you were expecting to see. I\'m ready to assist you as the AI Technical Assistant for the CureFlow Hospital System Admin.'),(49,6,1,'admin','2026-04-16 11:43:21',NULL,NULL,'you cant see older messages?','That\'s an important observation! To help me understand and address this, could you please provide a bit more context?\n\n\"Older messages\" can refer to a few different things within the CureFlow system. Could you clarify which specific system or module you\'re referring to? For example:\n\n1.  **Internal Staff Messaging/Chat:** Are you referring to conversations between staff members?\n2.  **Patient Communication Portal:** Are these messages exchanged with patients?\n3.  **System Logs/Audit Trails:** Are you looking at historical system events or user actions?\n4.  **Notifications/Alerts:** Are you referring to past system notifications?\n\nOnce I know'),(50,6,1,'admin','2026-04-16 11:44:01',NULL,NULL,'no, my earlier message to you','My apologies, but as an AI, I don\'t retain conversational history from previous interactions. Each new message is treated as a fresh request unless context is explicitly provided again within the current prompt.\n\nCould you please re-state your earlier message or the specific question/topic you\'d like to discuss?\n\nOnce you provide the context, I\'ll be happy to assist you with technical matters related to feature development or database health for the CureFlow Hospital System.'),(51,11,1,'doctor','2026-04-16 14:53:51',NULL,NULL,'Recent medical literature','Hello! As your Clinical Decision Support Assistant, I can certainly help you find recent medical literature.\n\nTo provide you with the most relevant and useful information, could you please specify what you are interested in? For example, are you looking for literature related to:\n\n*   **A specific medical condition or disease?** (e.g., \"recent advances in type 2 diabetes management,\" \"new treatments for metastatic breast cancer\")\n*   **A particular drug, treatment, or procedure?** (e.g., \"efficacy of GLP-1 agonists in weight loss,\" \"outcomes of robotic-assisted prostatectomy\")\n*   **A specific medical specialty?** (e.g., \"cardiology guidelines updates,\" \"pediatric infectious disease research\")\n*   **A type of study or research?** (e.g., \"meta-analyses on hypertension,\" \"randomized controlled trials in oncology\")\n*   **Updates on clinical guidelines or best practices?**\n*   **Specific journals or authors?**\n\nOnce you provide more details, I can search our integrated databases (like PubMed, Embase, Cochrane Library, UpToDate, etc.) to retrieve the latest articles, reviews, clinical trials, and guidelines that match your criteria.'),(52,12,1,'doctor','2026-04-19 16:38:32',NULL,NULL,'Differential diagnosis help','Hello! I can certainly help you brainstorm differential diagnoses.\n\nTo provide the most relevant and accurate assistance, please provide more clinical details about the patient. The more information you can share, the better I can help you generate a comprehensive list of possibilities.\n\nPlease consider including:\n\n*   **Patient Demographics:** Age, sex, relevant past medical history.\n*   **Chief Complaint:** What brings the patient in?\n*   **History of Present Illness (HPI):** Onset, duration, character, location, severity, associated symptoms, aggravating/alleviating factors.\n*   **Relevant Past Medical History (PMH):** Chronic conditions, surgeries.\n*   **Medications & Allergies.**\n*   **Social History:** Smoking, alcohol, drug use, occupation (if relevant).\n*   **Family History:** Relevant conditions.\n*   **Physical Exam Findings:** Vital signs, general appearance, and findings from relevant system examinations.\n*   **Initial Lab or Imaging Results (if available).**\n*   **Any specific symptoms or signs you are most concerned about.**\n\nOnce you provide this information, I can help you:\n*   Generate a list of differential diagnoses.\n*   Suggest potential investigations.\n*   Provide information on specific conditions.'),(53,6,1,'admin','2026-04-20 06:48:44',NULL,NULL,'is bangladesh over populated','While the term \"overpopulated\" can be subjective, Bangladesh is widely considered to be one of the most densely populated countries in the world.\n\nWith a large population concentrated in a relatively small land area, it faces significant challenges related to:\n*   **Resource strain:** Pressure on land, water, and food resources.\n*   **Infrastructure:** Difficulty in providing adequate housing, transportation, and utilities.\n*   **Environmental impact:** Vulnerability to climate change, pollution, and deforestation.\n*   **Socio-economic factors:** Challenges in employment, healthcare, and education for a growing populace.\n\nThese factors lead many experts and observers to describe Bangladesh as facing issues commonly associated with overpopulation.'),(54,14,1,'patient','2026-04-20 06:50:00',NULL,NULL,'what the current govt in bangladesh ?','I am an AI Healthcare Assistant for CureFlow Hospital. My purpose is to provide information related to healthcare services, departments, doctors, and appointments at our hospital. I cannot provide information about the current government in Bangladesh.\n\nPlease let me know if you have any questions about our hospital services, doctors, or any health-related inquiries!'),(55,14,1,'patient','2026-04-20 06:51:56',5,5,'if I have high diabetes what should i have for lunch','As an AI Healthcare Assistant, I cannot provide specific medical advice or dietary recommendations. Managing high diabetes requires a personalized approach based on your individual health profile, which a qualified doctor or a registered dietitian can provide.\n\nI recommend consulting with a doctor specializing in General Medicine who can assess your condition and provide appropriate dietary guidance. Would you like me to help you find an appointment with a General Medicine specialist?'),(56,14,1,'patient','2026-04-24 12:34:26',NULL,NULL,'if I have high diabetes what should i have for lunch','Hello there! It\'s very proactive of you to think about your diet, especially when managing high diabetes. What you choose to eat for lunch can significantly impact your blood sugar levels and overall health.\n\nWhen planning your lunch, the key is to focus on a balanced meal that helps stabilize blood sugar, keeps you feeling full, and provides good nutrition. HereΓÇÖs what we generally recommend:\n\n1.  **Complex Carbohydrates with High Fiber:** These are digested slowly, preventing rapid spikes in blood sugar.\n    *   **Examples:** Whole grains like brown rice, quinoa, whole-wheat bread, or whole-wheat pasta. Legumes such as lentils, chickpeas, or kidney beans are also excellent choices.\n    *   **What to avoid/limit:** Refined carbohydrates like white bread, white rice, and sugary drinks, as they can cause quick blood sugar increases.\n\n2.  **Lean Proteins:** Protein helps you feel full and has a minimal impact on blood sugar.\n    *   **Examples:** Grilled chicken breast, baked fish (like salmon or cod), tofu, tempeh, eggs, or a serving of Greek yogurt.\n    *   **Avoid:** Processed meats high in sodium and unhealthy fats.\n\n3.  **Plenty of Non-Starchy Vegetables:** These are low in calories and carbohydrates but packed with vitamins, minerals, and fiber.\n    *   **Examples:** A large colorful salad with leafy greens (spinach, lettuce), broccoli, bell peppers, cucumbers, tomatoes, and onions. Steamed or roasted vegetables like green beans, asparagus, or cauliflower are also great.\n\n4.  **Healthy Fats (in moderation):** Healthy fats can help with satiety and provide essential nutrients.\n    *   **Examples:** A small amount of avocado, a sprinkle of nuts or seeds (like almonds or chia seeds), or olive oil in your salad dressing.\n\n**Putting it all together for a lunch idea:**\n\n*   A salad with grilled chicken or chickpeas, mixed greens, bell peppers, cucumber, and a light vinaigrette dressing.\n*   A small portion of brown rice with baked fish and a generous serving of steamed broccoli.\n*   A whole-wheat wrap filled with lean turkey, lots of lettuce, tomato, and a slice of avocado.\n\nRemember, portion control is also very important. Even healthy foods can affect blood sugar if eaten in large quantities. It\'s also beneficial to monitor your blood sugar before and after meals to understand how different foods impact you personally.\n\nFor personalized dietary guidance and to develop a comprehensive diabetes management plan, we');
/*!40000 ALTER TABLE `ai_chatbot_logs` ENABLE KEYS */;

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ai_conversations`
--

/*!40000 ALTER TABLE `ai_conversations` DISABLE KEYS */;
INSERT INTO `ai_conversations` VALUES (1,0,'system','Legacy Archive','2026-04-16 11:24:23'),(2,1,'patient','I have a headache','2026-04-16 11:37:50'),(3,1,'patient','hello','2026-04-16 11:38:04'),(4,1,'doctor','Schedule optimization','2026-04-16 11:38:30'),(5,1,'admin','Security overview','2026-04-16 11:39:10'),(6,1,'admin','System health check','2026-04-16 11:39:27'),(7,1,'patient','How to book?','2026-04-16 14:32:24'),(8,1,'patient','l','2026-04-16 14:32:33'),(9,1,'patient','sad emoji','2026-04-16 14:33:49'),(10,1,'patient','sad','2026-04-16 14:34:13'),(11,1,'doctor','Recent medical literature','2026-04-16 14:53:47'),(12,1,'doctor','Differential diagnosis help','2026-04-19 16:38:27'),(13,1,'patient','I have a headache','2026-04-20 06:49:36'),(14,1,'patient','what the current govt in bangladesh ?','2026-04-20 06:49:57');
/*!40000 ALTER TABLE `ai_conversations` ENABLE KEYS */;

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

/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'Cardiology'),(2,'Neurology'),(3,'Pediatrics'),(4,'Orthopedics'),(5,'General Medicine'),(6,'Dermatology');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;

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

/*!40000 ALTER TABLE `doctor_schedules` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctor_schedules` ENABLE KEYS */;

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
  PRIMARY KEY (`doctor_id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `idx_doctors_department` (`department_id`),
  CONSTRAINT `doctors_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `doctors_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctors`
--

/*!40000 ALTER TABLE `doctors` DISABLE KEYS */;
INSERT INTO `doctors` VALUES (1,2,'Cardiology Specialist','+1 555-0101',1,1),(2,3,'Neurology Specialist','+1 555-0102',1,2),(3,4,'Pediatrics Specialist','+1 555-0103',1,3),(4,5,'Orthopedics Specialist','+1 555-0104',1,4),(5,6,'General Medicine Specialist','+1 555-0105',1,5),(6,7,'Dermatology Specialist','+1 555-0106',1,6),(7,8,'Cardiology Specialist','+1 555-0107',1,1),(8,9,'Neurology Specialist','+1 555-0108',1,2),(9,10,'Pediatrics Specialist','+1 555-0109',1,3),(10,11,'Orthopedics Specialist','+1 555-0110',1,4),(11,12,'General Medicine Specialist','+1 555-0111',1,5),(12,13,'Dermatology Specialist','+1 555-0112',1,6);
/*!40000 ALTER TABLE `doctors` ENABLE KEYS */;

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
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medical_history`
--

/*!40000 ALTER TABLE `medical_history` DISABLE KEYS */;
INSERT INTO `medical_history` VALUES (1,35,10,'Migraine','Lisinopril 10mg','2026-05-11'),(2,31,12,'Seasonal Allergies','Lisinopril 10mg','2026-03-11'),(3,39,5,'High Cholesterol','Lisinopril 10mg','2026-02-26'),(4,11,5,'Lower Back Pain','Albuterol Inhaler','2026-03-08'),(5,3,6,'High Cholesterol','Albuterol Inhaler','2026-06-15'),(6,35,7,'Seasonal Allergies','Amoxicillin 500mg','2026-05-20'),(7,10,2,'Chronic Hypertension','Lisinopril 10mg','2026-05-16'),(8,28,4,'Migraine','Albuterol Inhaler','2026-03-23'),(9,41,12,'Asthma','Atorvastatin 20mg','2026-05-27'),(10,1,8,'Migraine','Albuterol Inhaler','2026-05-07'),(11,41,8,'Chronic Hypertension','Metformin 500mg','2026-03-17'),(12,34,9,'Asthma','Lisinopril 10mg','2026-04-18'),(13,27,2,'Acid Reflux','Albuterol Inhaler','2026-04-22'),(14,28,10,'Lower Back Pain','Atorvastatin 20mg','2026-02-23'),(15,3,9,'Migraine','Amoxicillin 500mg','2026-04-24'),(16,47,8,'Asthma','Albuterol Inhaler','2026-03-31'),(17,45,9,'Lower Back Pain','Amoxicillin 500mg','2026-04-11'),(18,18,6,'Asthma','Albuterol Inhaler','2026-05-14'),(19,2,12,'Asthma','Ibuprofen 400mg','2026-05-21'),(20,32,11,'Type 2 Diabetes','Atorvastatin 20mg','2026-03-11'),(21,12,3,'High Cholesterol','Ibuprofen 400mg','2026-04-06'),(22,29,8,'Acid Reflux','Amoxicillin 500mg','2026-03-12'),(23,10,4,'Chronic Hypertension','Ibuprofen 400mg','2026-02-26'),(24,30,2,'Lower Back Pain','Lisinopril 10mg','2026-05-22'),(25,18,1,'Type 2 Diabetes','Albuterol Inhaler','2026-04-21'),(26,21,1,'Seasonal Allergies','Omeprazole 20mg','2026-04-17'),(27,9,7,'Migraine','Albuterol Inhaler','2026-05-08'),(28,48,6,'Type 2 Diabetes','Omeprazole 20mg','2026-05-07'),(29,14,8,'Seasonal Allergies','Omeprazole 20mg','2026-05-04'),(30,50,4,'High Cholesterol','Metformin 500mg','2026-05-27'),(31,4,12,'Chronic Hypertension','Metformin 500mg','2026-05-27'),(32,24,12,'Acid Reflux','Lisinopril 10mg','2026-03-12'),(33,25,7,'High Cholesterol','Atorvastatin 20mg','2026-04-16'),(34,38,10,'Lower Back Pain','Omeprazole 20mg','2026-05-13'),(35,50,9,'Chronic Hypertension','Amoxicillin 500mg','2026-03-03'),(36,22,12,'Chronic Hypertension','Lisinopril 10mg','2026-05-25'),(37,20,9,'Acid Reflux','Ibuprofen 400mg','2026-05-13'),(38,36,11,'Acid Reflux','Lisinopril 10mg','2026-03-05'),(39,19,11,'Migraine','Atorvastatin 20mg','2026-05-14'),(40,3,4,'Seasonal Allergies','Atorvastatin 20mg','2026-05-10'),(41,1,8,'Lower Back Pain','Albuterol Inhaler','2026-02-16'),(42,26,4,'Lower Back Pain','Lisinopril 10mg','2026-02-17'),(43,24,6,'Seasonal Allergies','Albuterol Inhaler','2026-04-29'),(44,37,3,'Migraine','Amoxicillin 500mg','2026-06-03'),(45,26,10,'Lower Back Pain','Atorvastatin 20mg','2026-03-13'),(46,1,3,'Lower Back Pain','Atorvastatin 20mg','2026-02-24'),(47,20,7,'Migraine','Ibuprofen 400mg','2026-03-01'),(48,3,3,'Seasonal Allergies','Ibuprofen 400mg','2026-05-06'),(49,17,9,'Chronic Hypertension','Metformin 500mg','2026-05-30'),(50,9,3,'Migraine','Albuterol Inhaler','2026-04-03'),(51,25,2,'High Cholesterol','Metformin 500mg','2026-06-12'),(52,48,3,'Chronic Hypertension','Lisinopril 10mg','2026-04-22'),(53,20,1,'Acid Reflux','Ibuprofen 400mg','2026-05-04'),(54,40,3,'Lower Back Pain','Ibuprofen 400mg','2026-06-01'),(55,26,6,'Migraine','Amoxicillin 500mg','2026-02-20'),(56,6,12,'Type 2 Diabetes','Atorvastatin 20mg','2026-04-21'),(57,44,8,'Chronic Hypertension','Ibuprofen 400mg','2026-04-05'),(58,12,7,'Lower Back Pain','Omeprazole 20mg','2026-03-14'),(59,44,9,'Type 2 Diabetes','Amoxicillin 500mg','2026-04-24'),(60,1,11,'Type 2 Diabetes','Lisinopril 10mg','2026-06-15'),(61,19,2,'High Cholesterol','Albuterol Inhaler','2026-03-05'),(62,36,10,'Acid Reflux','Amoxicillin 500mg','2026-05-02'),(63,20,5,'Seasonal Allergies','Amoxicillin 500mg','2026-03-28'),(64,17,8,'High Cholesterol','Amoxicillin 500mg','2026-06-12'),(65,8,3,'Type 2 Diabetes','Lisinopril 10mg','2026-05-19'),(66,46,7,'Acid Reflux','Metformin 500mg','2026-06-13'),(67,26,2,'Acid Reflux','Amoxicillin 500mg','2026-02-18'),(68,18,8,'Acid Reflux','Amoxicillin 500mg','2026-06-12'),(69,19,5,'Acid Reflux','Amoxicillin 500mg','2026-06-05'),(70,49,10,'Acid Reflux','Amoxicillin 500mg','2026-03-28'),(71,40,11,'Type 2 Diabetes','Amoxicillin 500mg','2026-03-07'),(72,3,11,'Seasonal Allergies','Amoxicillin 500mg','2026-05-30'),(73,45,2,'Migraine','Albuterol Inhaler','2026-04-11'),(74,38,6,'Migraine','Ibuprofen 400mg','2026-04-01');
/*!40000 ALTER TABLE `medical_history` ENABLE KEYS */;

--
-- Table structure for table `medical_reports`
--

DROP TABLE IF EXISTS `medical_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medical_reports` (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) DEFAULT NULL,
  `report_type` varchar(100) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `upload_date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`report_id`),
  KEY `patient_id` (`patient_id`),
  CONSTRAINT `medical_reports_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medical_reports`
--

/*!40000 ALTER TABLE `medical_reports` DISABLE KEYS */;
INSERT INTO `medical_reports` VALUES (1,35,'Clinical Report - Migraine','/reports/sample_1.pdf','2026-04-16 11:24:40'),(2,31,'Clinical Report - Seasonal A','/reports/sample_3.pdf','2026-04-16 11:24:40'),(3,39,'Clinical Report - High Chole','/reports/sample_4.pdf','2026-04-16 11:24:40'),(4,11,'Clinical Report - Lower Back','/reports/sample_10.pdf','2026-04-16 11:24:40'),(5,3,'Clinical Report - High Chole','/reports/sample_13.pdf','2026-04-16 11:24:40'),(6,35,'Clinical Report - Seasonal A','/reports/sample_15.pdf','2026-04-16 11:24:40'),(7,10,'Clinical Report - Chronic Hy','/reports/sample_16.pdf','2026-04-16 11:24:40'),(8,28,'Clinical Report - Migraine','/reports/sample_18.pdf','2026-04-16 11:24:40'),(9,41,'Clinical Report - Asthma','/reports/sample_20.pdf','2026-04-16 11:24:40'),(10,1,'Clinical Report - Migraine','/reports/sample_21.pdf','2026-04-16 11:24:40'),(11,41,'Clinical Report - Chronic Hy','/reports/sample_24.pdf','2026-04-16 11:24:40'),(12,34,'Clinical Report - Asthma','/reports/sample_28.pdf','2026-04-16 11:24:40'),(13,27,'Clinical Report - Acid Reflu','/reports/sample_30.pdf','2026-04-16 11:24:40'),(14,28,'Clinical Report - Lower Back','/reports/sample_31.pdf','2026-04-16 11:24:40'),(15,3,'Clinical Report - Migraine','/reports/sample_33.pdf','2026-04-16 11:24:40'),(16,47,'Clinical Report - Asthma','/reports/sample_37.pdf','2026-04-16 11:24:40'),(17,45,'Clinical Report - Lower Back','/reports/sample_38.pdf','2026-04-16 11:24:40'),(18,18,'Clinical Report - Asthma','/reports/sample_39.pdf','2026-04-16 11:24:40'),(19,2,'Clinical Report - Asthma','/reports/sample_41.pdf','2026-04-16 11:24:40'),(20,32,'Clinical Report - Type 2 Dia','/reports/sample_42.pdf','2026-04-16 11:24:40'),(21,12,'Clinical Report - High Chole','/reports/sample_45.pdf','2026-04-16 11:24:40'),(22,29,'Clinical Report - Acid Reflu','/reports/sample_46.pdf','2026-04-16 11:24:40'),(23,10,'Clinical Report - Chronic Hy','/reports/sample_47.pdf','2026-04-16 11:24:40'),(24,30,'Clinical Report - Lower Back','/reports/sample_50.pdf','2026-04-16 11:24:40'),(25,18,'Clinical Report - Type 2 Dia','/reports/sample_51.pdf','2026-04-16 11:24:40'),(26,21,'Clinical Report - Seasonal A','/reports/sample_52.pdf','2026-04-16 11:24:40'),(27,9,'Clinical Report - Migraine','/reports/sample_53.pdf','2026-04-16 11:24:40'),(28,48,'Clinical Report - Type 2 Dia','/reports/sample_54.pdf','2026-04-16 11:24:40'),(29,14,'Clinical Report - Seasonal A','/reports/sample_57.pdf','2026-04-16 11:24:40'),(30,50,'Clinical Report - High Chole','/reports/sample_58.pdf','2026-04-16 11:24:40'),(31,4,'Clinical Report - Chronic Hy','/reports/sample_59.pdf','2026-04-16 11:24:40'),(32,24,'Clinical Report - Acid Reflu','/reports/sample_62.pdf','2026-04-16 11:24:40'),(33,25,'Clinical Report - High Chole','/reports/sample_67.pdf','2026-04-16 11:24:40'),(34,38,'Clinical Report - Lower Back','/reports/sample_68.pdf','2026-04-16 11:24:40'),(35,50,'Clinical Report - Chronic Hy','/reports/sample_70.pdf','2026-04-16 11:24:40'),(36,22,'Clinical Report - Chronic Hy','/reports/sample_72.pdf','2026-04-16 11:24:40'),(37,20,'Clinical Report - Acid Reflu','/reports/sample_74.pdf','2026-04-16 11:24:40'),(38,36,'Clinical Report - Acid Reflu','/reports/sample_76.pdf','2026-04-16 11:24:40'),(39,19,'Clinical Report - Migraine','/reports/sample_77.pdf','2026-04-16 11:24:40'),(40,3,'Clinical Report - Seasonal A','/reports/sample_78.pdf','2026-04-16 11:24:40'),(41,1,'Clinical Report - Lower Back','/reports/sample_80.pdf','2026-04-16 11:24:40'),(42,26,'Clinical Report - Lower Back','/reports/sample_83.pdf','2026-04-16 11:24:40'),(43,24,'Clinical Report - Seasonal A','/reports/sample_84.pdf','2026-04-16 11:24:40'),(44,37,'Clinical Report - Migraine','/reports/sample_87.pdf','2026-04-16 11:24:40'),(45,26,'Clinical Report - Lower Back','/reports/sample_89.pdf','2026-04-16 11:24:40'),(46,1,'Clinical Report - Lower Back','/reports/sample_90.pdf','2026-04-16 11:24:40'),(47,20,'Clinical Report - Migraine','/reports/sample_92.pdf','2026-04-16 11:24:40'),(48,3,'Clinical Report - Seasonal A','/reports/sample_96.pdf','2026-04-16 11:24:40'),(49,17,'Clinical Report - Chronic Hy','/reports/sample_98.pdf','2026-04-16 11:24:40'),(50,9,'Clinical Report - Migraine','/reports/sample_99.pdf','2026-04-16 11:24:40'),(51,25,'Clinical Report - High Chole','/reports/sample_107.pdf','2026-04-16 11:24:41'),(52,48,'Clinical Report - Chronic Hy','/reports/sample_109.pdf','2026-04-16 11:24:41'),(53,20,'Clinical Report - Acid Reflu','/reports/sample_112.pdf','2026-04-16 11:24:41'),(54,40,'Clinical Report - Lower Back','/reports/sample_114.pdf','2026-04-16 11:24:41'),(55,26,'Clinical Report - Migraine','/reports/sample_120.pdf','2026-04-16 11:24:41'),(56,6,'Clinical Report - Type 2 Dia','/reports/sample_123.pdf','2026-04-16 11:24:41'),(57,44,'Clinical Report - Chronic Hy','/reports/sample_124.pdf','2026-04-16 11:24:41'),(58,12,'Clinical Report - Lower Back','/reports/sample_127.pdf','2026-04-16 11:24:41'),(59,44,'Clinical Report - Type 2 Dia','/reports/sample_131.pdf','2026-04-16 11:24:41'),(60,1,'Clinical Report - Type 2 Dia','/reports/sample_139.pdf','2026-04-16 11:24:41'),(61,19,'Clinical Report - High Chole','/reports/sample_146.pdf','2026-04-16 11:24:41'),(62,36,'Clinical Report - Acid Reflu','/reports/sample_149.pdf','2026-04-16 11:24:41'),(63,20,'Clinical Report - Seasonal A','/reports/sample_152.pdf','2026-04-16 11:24:41'),(64,17,'Clinical Report - High Chole','/reports/sample_153.pdf','2026-04-16 11:24:41'),(65,8,'Clinical Report - Type 2 Dia','/reports/sample_154.pdf','2026-04-16 11:24:41'),(66,46,'Clinical Report - Acid Reflu','/reports/sample_157.pdf','2026-04-16 11:24:41'),(67,26,'Clinical Report - Acid Reflu','/reports/sample_158.pdf','2026-04-16 11:24:41'),(68,18,'Clinical Report - Acid Reflu','/reports/sample_159.pdf','2026-04-16 11:24:41'),(69,19,'Clinical Report - Acid Reflu','/reports/sample_163.pdf','2026-04-16 11:24:41'),(70,49,'Clinical Report - Acid Reflu','/reports/sample_164.pdf','2026-04-16 11:24:41'),(71,40,'Clinical Report - Type 2 Dia','/reports/sample_167.pdf','2026-04-16 11:24:41'),(72,3,'Clinical Report - Seasonal A','/reports/sample_169.pdf','2026-04-16 11:24:41'),(73,45,'Clinical Report - Migraine','/reports/sample_175.pdf','2026-04-16 11:24:41'),(74,38,'Clinical Report - Migraine','/reports/sample_177.pdf','2026-04-16 11:24:41'),(75,9,'Clinical Diagnostic PDF','uploads/report_1776344208_69e0dc90bcc83.pdf','2026-04-16 12:56:48'),(76,9,'Clinical Diagnostic PDF','uploads/report_1776347984_69e0eb502a3e8.pdf','2026-04-16 13:59:44'),(77,9,'Clinical Diagnostic PDF','uploads/report_1776350110_69e0f39e53e56.pdf','2026-04-16 14:35:10'),(78,9,'Clinical Diagnostic PDF','uploads/report_1776351084_69e0f76c3af10.pdf','2026-04-16 14:51:24'),(79,9,'Clinical Diagnostic PDF','uploads/report_1776665461_69e5c3757e76f.pdf','2026-04-20 06:11:01');
/*!40000 ALTER TABLE `medical_reports` ENABLE KEYS */;

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
  PRIMARY KEY (`notification_id`),
  KEY `token_id` (`token_id`),
  KEY `idx_notifications_patient` (`patient_id`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  CONSTRAINT `notifications_ibfk_2` FOREIGN KEY (`token_id`) REFERENCES `tokens` (`token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;

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
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` VALUES (1,14,'+1 555-0901','1996-10-06','male','854 Jones St, CureCity'),(2,15,'+1 555-0902','1998-05-27','female','122 Brown St, CureCity'),(3,16,'+1 555-0903','1971-06-23','male','842 Lopez St, CureCity'),(4,17,'+1 555-0904','1981-10-30','female','215 Jackson St, CureCity'),(5,18,'+1 555-0905','1963-06-22','male','155 Wilson St, CureCity'),(6,19,'+1 555-0906','1958-12-27','female','655 Lopez St, CureCity'),(7,20,'+1 555-0907','1980-12-09','male','634 Jackson St, CureCity'),(8,21,'+1 555-0908','1974-05-10','male','941 Williams St, CureCity'),(9,22,'+1 555-0909','1990-05-28','male','726 Jones St, CureCity'),(10,23,'+1 555-0910','1971-11-25','female','962 Brown St, CureCity'),(11,24,'+1 555-0911','1976-05-17','male','503 Martin St, CureCity'),(12,25,'+1 555-0912','1984-09-17','male','666 Miller St, CureCity'),(13,26,'+1 555-0913','1958-08-04','female','400 Wilson St, CureCity'),(14,27,'+1 555-0914','1998-11-14','female','966 Lopez St, CureCity'),(15,28,'+1 555-0915','1958-11-24','male','734 Jones St, CureCity'),(16,29,'+1 555-0916','1956-10-16','female','837 Thomas St, CureCity'),(17,30,'+1 555-0917','1963-11-04','male','759 Jackson St, CureCity'),(18,31,'+1 555-0918','2002-07-02','female','820 Jones St, CureCity'),(19,32,'+1 555-0919','1969-11-23','female','536 Gonzalez St, CureCity'),(20,33,'+1 555-0920','1991-11-01','male','216 Rodriguez St, CureCity'),(21,34,'+1 555-0921','1991-12-24','female','893 Hernandez St, CureCity'),(22,35,'+1 555-0922','1956-12-06','female','375 Davis St, CureCity'),(23,36,'+1 555-0923','2007-12-15','male','501 Moore St, CureCity'),(24,37,'+1 555-0924','1998-05-17','female','299 Johnson St, CureCity'),(25,38,'+1 555-0925','2000-07-07','female','197 Anderson St, CureCity'),(26,39,'+1 555-0926','1997-12-29','male','375 Smith St, CureCity'),(27,40,'+1 555-0927','1972-06-07','male','795 Jackson St, CureCity'),(28,41,'+1 555-0928','1955-08-07','female','855 Smith St, CureCity'),(29,42,'+1 555-0929','1977-03-04','female','914 Lopez St, CureCity'),(30,43,'+1 555-0930','1958-04-13','male','925 Garcia St, CureCity'),(31,44,'+1 555-0931','2006-10-21','female','244 Johnson St, CureCity'),(32,45,'+1 555-0932','1985-08-14','female','487 Williams St, CureCity'),(33,46,'+1 555-0933','1977-12-29','female','326 Gonzalez St, CureCity'),(34,47,'+1 555-0934','1980-10-23','male','480 Martin St, CureCity'),(35,48,'+1 555-0935','1989-03-25','male','751 Davis St, CureCity'),(36,49,'+1 555-0936','1964-05-04','female','704 Martinez St, CureCity'),(37,50,'+1 555-0937','1981-10-17','female','863 Taylor St, CureCity'),(38,51,'+1 555-0938','2003-06-03','female','836 Wilson St, CureCity'),(39,52,'+1 555-0939','1963-08-15','female','553 Martin St, CureCity'),(40,53,'+1 555-0940','1983-05-04','male','275 Hernandez St, CureCity'),(41,54,'+1 555-0941','1998-06-19','female','730 Martin St, CureCity'),(42,55,'+1 555-0942','2006-03-04','female','878 Jackson St, CureCity'),(43,56,'+1 555-0943','1981-05-22','female','280 Wilson St, CureCity'),(44,57,'+1 555-0944','1959-01-16','female','684 Brown St, CureCity'),(45,58,'+1 555-0945','2000-04-09','male','675 Davis St, CureCity'),(46,59,'+1 555-0946','1968-10-17','male','507 Smith St, CureCity'),(47,60,'+1 555-0947','1970-09-02','female','598 Miller St, CureCity'),(48,61,'+1 555-0948','1996-03-30','female','220 Moore St, CureCity'),(49,62,'+1 555-0949','1995-09-08','female','581 Taylor St, CureCity'),(50,63,'+1 555-0950','1991-10-24','female','104 Davis St, CureCity'),(52,66,'7',NULL,NULL,NULL);
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;

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
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,1,35,'Credit Card',130.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(2,3,31,'Credit Card',54.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(3,4,39,'Credit Card',132.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(4,6,27,'Credit Card',163.00,'pending',NULL,'2026-04-16 11:24:40',NULL),(5,8,27,'Online Banking',171.00,'pending',NULL,'2026-04-16 11:24:40',NULL),(6,9,39,'Credit Card',118.00,'pending',NULL,'2026-04-16 11:24:40',NULL),(7,10,11,'Credit Card',146.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(8,13,3,'Credit Card',92.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(9,15,35,'Credit Card',106.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(10,16,10,'Online Banking',100.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(11,18,28,'Credit Card',160.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(12,19,43,'Online Banking',59.00,'pending',NULL,'2026-04-16 11:24:40',NULL),(13,20,41,'Credit Card',101.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(14,21,1,'Online Banking',164.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(15,23,40,'Online Banking',72.00,'pending',NULL,'2026-04-16 11:24:40',NULL),(16,24,41,'Online Banking',52.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(17,28,34,'Credit Card',188.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(18,30,27,'Credit Card',187.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(19,31,28,'Credit Card',105.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(20,33,3,'Online Banking',152.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(21,34,40,'Credit Card',78.00,'pending',NULL,'2026-04-16 11:24:40',NULL),(22,36,11,'Credit Card',113.00,'pending',NULL,'2026-04-16 11:24:40',NULL),(23,37,47,'Credit Card',152.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(24,38,45,'Credit Card',189.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(25,39,18,'Credit Card',147.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(26,41,2,'Credit Card',179.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(27,42,32,'Credit Card',181.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(28,43,20,'Online Banking',182.00,'pending',NULL,'2026-04-16 11:24:40',NULL),(29,45,12,'Online Banking',184.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(30,46,29,'Online Banking',97.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(31,47,10,'Online Banking',171.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(32,49,17,'Credit Card',164.00,'pending',NULL,'2026-04-16 11:24:40',NULL),(33,50,30,'Online Banking',53.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(34,51,18,'Online Banking',136.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(35,52,21,'Credit Card',155.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(36,53,9,'Online Banking',52.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(37,54,48,'Online Banking',69.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(38,57,14,'Credit Card',117.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(39,58,50,'Online Banking',88.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(40,59,4,'Online Banking',145.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(41,60,31,'Credit Card',142.00,'pending',NULL,'2026-04-16 11:24:40',NULL),(42,61,24,'Online Banking',196.00,'pending',NULL,'2026-04-16 11:24:40',NULL),(43,62,24,'Online Banking',186.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(44,64,35,'Credit Card',189.00,'pending',NULL,'2026-04-16 11:24:40',NULL),(45,66,13,'Credit Card',121.00,'pending',NULL,'2026-04-16 11:24:40',NULL),(46,67,25,'Online Banking',63.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(47,68,38,'Credit Card',123.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(48,70,50,'Credit Card',132.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(49,71,2,'Online Banking',83.00,'pending',NULL,'2026-04-16 11:24:40',NULL),(50,72,22,'Credit Card',54.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(51,73,38,'Credit Card',132.00,'pending',NULL,'2026-04-16 11:24:40',NULL),(52,74,20,'Credit Card',120.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(53,76,36,'Online Banking',113.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(54,77,19,'Online Banking',186.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(55,78,3,'Online Banking',192.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(56,80,1,'Online Banking',91.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(57,83,26,'Credit Card',67.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(58,84,24,'Credit Card',164.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(59,85,3,'Credit Card',182.00,'pending',NULL,'2026-04-16 11:24:40',NULL),(60,87,37,'Credit Card',58.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(61,88,34,'Online Banking',170.00,'pending',NULL,'2026-04-16 11:24:40',NULL),(62,89,26,'Online Banking',122.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(63,90,1,'Online Banking',64.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(64,91,10,'Online Banking',69.00,'pending',NULL,'2026-04-16 11:24:40',NULL),(65,92,20,'Online Banking',110.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(66,96,3,'Credit Card',162.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(67,97,48,'Credit Card',65.00,'pending',NULL,'2026-04-16 11:24:40',NULL),(68,98,17,'Credit Card',175.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(69,99,9,'Online Banking',75.00,'paid',NULL,'2026-04-16 11:24:40',NULL),(70,107,25,'Credit Card',192.00,'paid',NULL,'2026-04-16 11:24:41',NULL),(71,109,48,'Credit Card',79.00,'paid',NULL,'2026-04-16 11:24:41',NULL),(72,110,35,'Online Banking',175.00,'pending',NULL,'2026-04-16 11:24:41',NULL),(73,112,20,'Credit Card',52.00,'paid',NULL,'2026-04-16 11:24:41',NULL),(74,114,40,'Credit Card',190.00,'paid',NULL,'2026-04-16 11:24:41',NULL),(75,116,27,'Credit Card',125.00,'pending',NULL,'2026-04-16 11:24:41',NULL),(76,119,40,'Credit Card',194.00,'pending',NULL,'2026-04-16 11:24:41',NULL),(77,120,26,'Credit Card',192.00,'paid',NULL,'2026-04-16 11:24:41',NULL),(78,123,6,'Credit Card',90.00,'paid',NULL,'2026-04-16 11:24:41',NULL),(79,124,44,'Credit Card',145.00,'paid',NULL,'2026-04-16 11:24:41',NULL),(80,127,12,'Online Banking',98.00,'paid',NULL,'2026-04-16 11:24:41',NULL),(81,131,44,'Credit Card',179.00,'paid',NULL,'2026-04-16 11:24:41',NULL),(82,136,6,'Online Banking',128.00,'pending',NULL,'2026-04-16 11:24:41',NULL),(83,137,1,'Online Banking',106.00,'pending',NULL,'2026-04-16 11:24:41',NULL),(84,139,1,'Credit Card',200.00,'paid',NULL,'2026-04-16 11:24:41',NULL),(85,145,48,'Credit Card',91.00,'pending',NULL,'2026-04-16 11:24:41',NULL),(86,146,19,'Credit Card',120.00,'paid',NULL,'2026-04-16 11:24:41',NULL),(87,149,36,'Credit Card',91.00,'paid',NULL,'2026-04-16 11:24:41',NULL),(88,151,22,'Credit Card',87.00,'pending',NULL,'2026-04-16 11:24:41',NULL),(89,152,20,'Online Banking',94.00,'paid',NULL,'2026-04-16 11:24:41',NULL),(90,153,17,'Online Banking',89.00,'paid',NULL,'2026-04-16 11:24:41',NULL),(91,154,8,'Online Banking',161.00,'paid',NULL,'2026-04-16 11:24:41',NULL),(92,157,46,'Online Banking',169.00,'paid',NULL,'2026-04-16 11:24:41',NULL),(93,158,26,'Credit Card',85.00,'paid',NULL,'2026-04-16 11:24:41',NULL),(94,159,18,'Online Banking',186.00,'paid',NULL,'2026-04-16 11:24:41',NULL),(95,160,5,'Credit Card',65.00,'pending',NULL,'2026-04-16 11:24:41',NULL),(96,163,19,'Online Banking',105.00,'paid',NULL,'2026-04-16 11:24:41',NULL),(97,164,49,'Credit Card',191.00,'paid',NULL,'2026-04-16 11:24:41',NULL),(98,167,40,'Credit Card',173.00,'paid',NULL,'2026-04-16 11:24:41',NULL),(99,169,3,'Credit Card',181.00,'paid',NULL,'2026-04-16 11:24:41',NULL),(100,171,47,'Credit Card',159.00,'pending',NULL,'2026-04-16 11:24:41',NULL),(101,175,45,'Online Banking',134.00,'paid',NULL,'2026-04-16 11:24:41',NULL),(102,177,38,'Online Banking',190.00,'paid',NULL,'2026-04-16 11:24:41',NULL),(103,178,32,'Credit Card',104.00,'pending',NULL,'2026-04-16 11:24:41',NULL),(104,179,37,'Online Banking',96.00,'pending',NULL,'2026-04-16 11:24:41',NULL),(105,181,NULL,NULL,500.00,'paid','SIM_1777042985','2026-04-24 14:44:36','bkash');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;

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
  `STATUS` enum('pending_payment','confirmed','in_queue','completed','cancelled') DEFAULT NULL,
  `estimated_wait_time` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `queue_position` int(11) DEFAULT NULL,
  PRIMARY KEY (`token_id`),
  KEY `idx_tokens_doctor_date` (`doctor_id`,`appointment_date`),
  KEY `idx_tokens_patient` (`patient_id`),
  CONSTRAINT `tokens_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  CONSTRAINT `tokens_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=182 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
INSERT INTO `tokens` VALUES (1,35,10,218,'2026-05-11','completed',NULL,'2026-04-16 11:24:40',NULL),(2,5,10,948,'2026-04-03','in_queue',NULL,'2026-04-16 11:24:40',NULL),(3,31,12,138,'2026-03-11','completed',NULL,'2026-04-16 11:24:40',NULL),(4,39,5,307,'2026-02-26','completed',NULL,'2026-04-16 11:24:40',NULL),(5,4,6,868,'2026-03-19','pending_payment',NULL,'2026-04-16 11:24:40',NULL),(6,27,4,282,'2026-04-01','confirmed',NULL,'2026-04-16 11:24:40',NULL),(7,44,11,575,'2026-03-18','cancelled',NULL,'2026-04-16 11:24:40',NULL),(8,27,12,843,'2026-04-19','confirmed',NULL,'2026-04-16 11:24:40',NULL),(9,39,9,604,'2026-03-11','confirmed',NULL,'2026-04-16 11:24:40',NULL),(10,11,5,750,'2026-03-08','completed',NULL,'2026-04-16 11:24:40',NULL),(11,38,7,523,'2026-05-17','cancelled',NULL,'2026-04-16 11:24:40',NULL),(12,7,12,760,'2026-05-26','pending_payment',NULL,'2026-04-16 11:24:40',NULL),(13,3,6,414,'2026-06-15','completed',NULL,'2026-04-16 11:24:40',NULL),(14,32,8,877,'2026-03-16','pending_payment',NULL,'2026-04-16 11:24:40',NULL),(15,35,7,931,'2026-05-20','completed',NULL,'2026-04-16 11:24:40',NULL),(16,10,2,464,'2026-05-16','completed',NULL,'2026-04-16 11:24:40',NULL),(17,45,9,645,'2026-05-03','in_queue',NULL,'2026-04-16 11:24:40',NULL),(18,28,4,587,'2026-03-23','completed',NULL,'2026-04-16 11:24:40',NULL),(19,43,10,458,'2026-03-15','confirmed',NULL,'2026-04-16 11:24:40',NULL),(20,41,12,349,'2026-05-27','completed',NULL,'2026-04-16 11:24:40',NULL),(21,1,8,269,'2026-05-07','completed',NULL,'2026-04-16 11:24:40',NULL),(22,37,12,436,'2026-04-04','pending_payment',NULL,'2026-04-16 11:24:40',NULL),(23,40,11,509,'2026-06-05','confirmed',NULL,'2026-04-16 11:24:40',NULL),(24,41,8,184,'2026-03-17','completed',NULL,'2026-04-16 11:24:40',NULL),(25,3,1,500,'2026-05-14','in_queue',NULL,'2026-04-16 11:24:40',NULL),(26,42,10,843,'2026-05-02','cancelled',NULL,'2026-04-16 11:24:40',NULL),(27,40,8,672,'2026-03-04','cancelled',NULL,'2026-04-16 11:24:40',NULL),(28,34,9,324,'2026-04-18','completed',NULL,'2026-04-16 11:24:40',NULL),(29,30,3,199,'2026-04-25','cancelled',NULL,'2026-04-16 11:24:40',NULL),(30,27,2,784,'2026-04-22','completed',NULL,'2026-04-16 11:24:40',NULL),(31,28,10,446,'2026-02-23','completed',NULL,'2026-04-16 11:24:40',NULL),(32,9,3,332,'2026-02-21','pending_payment',NULL,'2026-04-16 11:24:40',NULL),(33,3,9,684,'2026-04-24','completed',NULL,'2026-04-16 11:24:40',NULL),(34,40,6,480,'2026-02-26','confirmed',NULL,'2026-04-16 11:24:40',NULL),(35,28,10,537,'2026-03-17','cancelled',NULL,'2026-04-16 11:24:40',NULL),(36,11,9,334,'2026-05-01','confirmed',NULL,'2026-04-16 11:24:40',NULL),(37,47,8,691,'2026-03-31','completed',NULL,'2026-04-16 11:24:40',NULL),(38,45,9,774,'2026-04-11','completed',NULL,'2026-04-16 11:24:40',NULL),(39,18,6,767,'2026-05-14','completed',NULL,'2026-04-16 11:24:40',NULL),(40,35,6,519,'2026-06-03','pending_payment',NULL,'2026-04-16 11:24:40',NULL),(41,2,12,770,'2026-05-21','completed',NULL,'2026-04-16 11:24:40',NULL),(42,32,11,542,'2026-03-11','completed',NULL,'2026-04-16 11:24:40',NULL),(43,20,3,527,'2026-05-02','confirmed',NULL,'2026-04-16 11:24:40',NULL),(44,47,6,920,'2026-05-16','pending_payment',NULL,'2026-04-16 11:24:40',NULL),(45,12,3,659,'2026-04-06','completed',NULL,'2026-04-16 11:24:40',NULL),(46,29,8,731,'2026-03-12','completed',NULL,'2026-04-16 11:24:40',NULL),(47,10,4,954,'2026-02-26','completed',NULL,'2026-04-16 11:24:40',NULL),(48,29,11,566,'2026-03-17','cancelled',NULL,'2026-04-16 11:24:40',NULL),(49,17,2,328,'2026-06-04','confirmed',NULL,'2026-04-16 11:24:40',NULL),(50,30,2,127,'2026-05-22','completed',NULL,'2026-04-16 11:24:40',NULL),(51,18,1,804,'2026-04-21','completed',NULL,'2026-04-16 11:24:40',NULL),(52,21,1,237,'2026-04-17','completed',NULL,'2026-04-16 11:24:40',NULL),(53,9,7,537,'2026-05-08','completed',NULL,'2026-04-16 11:24:40',NULL),(54,48,6,211,'2026-05-07','completed',NULL,'2026-04-16 11:24:40',NULL),(55,2,4,524,'2026-04-28','pending_payment',NULL,'2026-04-16 11:24:40',NULL),(56,18,9,420,'2026-06-02','in_queue',NULL,'2026-04-16 11:24:40',NULL),(57,14,8,666,'2026-05-04','pending_payment',NULL,'2026-04-16 11:24:40',NULL),(58,50,4,722,'2026-05-27','completed',NULL,'2026-04-16 11:24:40',NULL),(59,4,12,467,'2026-05-27','completed',NULL,'2026-04-16 11:24:40',NULL),(60,31,1,152,'2026-03-26','confirmed',NULL,'2026-04-16 11:24:40',NULL),(61,24,7,192,'2026-03-14','confirmed',NULL,'2026-04-16 11:24:40',NULL),(62,24,12,298,'2026-03-12','completed',NULL,'2026-04-16 11:24:40',NULL),(63,9,1,629,'2026-02-27','in_queue',NULL,'2026-04-16 11:24:40',NULL),(64,35,5,339,'2026-05-09','confirmed',NULL,'2026-04-16 11:24:40',NULL),(65,50,11,451,'2026-05-09','cancelled',NULL,'2026-04-16 11:24:40',NULL),(66,13,12,879,'2026-02-25','confirmed',NULL,'2026-04-16 11:24:40',NULL),(67,25,7,611,'2026-04-16','completed',NULL,'2026-04-16 11:24:40',NULL),(68,38,10,365,'2026-05-13','completed',NULL,'2026-04-16 11:24:40',NULL),(69,9,7,389,'2026-06-10','in_queue',NULL,'2026-04-16 11:24:40',NULL),(70,50,9,113,'2026-03-03','completed',NULL,'2026-04-16 11:24:40',NULL),(71,2,1,531,'2026-04-25','confirmed',NULL,'2026-04-16 11:24:40',NULL),(72,22,12,880,'2026-05-25','completed',NULL,'2026-04-16 11:24:40',NULL),(73,38,4,452,'2026-03-08','confirmed',NULL,'2026-04-16 11:24:40',NULL),(74,20,9,602,'2026-05-13','completed',NULL,'2026-04-16 11:24:40',NULL),(75,18,7,411,'2026-02-23','in_queue',NULL,'2026-04-16 11:24:40',NULL),(76,36,11,292,'2026-03-05','completed',NULL,'2026-04-16 11:24:40',NULL),(77,19,11,951,'2026-05-14','completed',NULL,'2026-04-16 11:24:40',NULL),(78,3,4,688,'2026-05-10','completed',NULL,'2026-04-16 11:24:40',NULL),(79,5,1,545,'2026-05-02','cancelled',NULL,'2026-04-16 11:24:40',NULL),(80,1,8,958,'2026-02-16','completed',NULL,'2026-04-16 11:24:40',NULL),(81,50,12,301,'2026-04-04','in_queue',NULL,'2026-04-16 11:24:40',NULL),(82,18,10,647,'2026-03-18','cancelled',NULL,'2026-04-16 11:24:40',NULL),(83,26,4,247,'2026-02-17','completed',NULL,'2026-04-16 11:24:40',NULL),(84,24,6,254,'2026-04-29','completed',NULL,'2026-04-16 11:24:40',NULL),(85,3,11,938,'2026-04-08','confirmed',NULL,'2026-04-16 11:24:40',NULL),(86,36,10,941,'2026-05-25','pending_payment',NULL,'2026-04-16 11:24:40',NULL),(87,37,3,175,'2026-06-03','completed',NULL,'2026-04-16 11:24:40',NULL),(88,34,5,660,'2026-03-29','confirmed',NULL,'2026-04-16 11:24:40',NULL),(89,26,10,502,'2026-03-13','completed',NULL,'2026-04-16 11:24:40',NULL),(90,1,3,554,'2026-02-24','completed',NULL,'2026-04-16 11:24:40',NULL),(91,10,2,721,'2026-04-16','confirmed',NULL,'2026-04-16 11:24:40',NULL),(92,20,7,704,'2026-03-01','completed',NULL,'2026-04-16 11:24:40',NULL),(93,43,7,179,'2026-04-21','in_queue',NULL,'2026-04-16 11:24:40',NULL),(94,7,3,495,'2026-03-14','in_queue',NULL,'2026-04-16 11:24:40',NULL),(95,16,3,162,'2026-05-31','cancelled',NULL,'2026-04-16 11:24:40',NULL),(96,3,3,936,'2026-05-06','completed',NULL,'2026-04-16 11:24:40',NULL),(97,48,10,713,'2026-05-21','confirmed',NULL,'2026-04-16 11:24:40',NULL),(98,17,9,212,'2026-05-30','completed',NULL,'2026-04-16 11:24:40',NULL),(99,9,3,372,'2026-04-03','completed',NULL,'2026-04-16 11:24:40',NULL),(100,23,10,685,'2026-03-18','cancelled',NULL,'2026-04-16 11:24:40',NULL),(101,44,9,281,'2026-05-02','pending_payment',NULL,'2026-04-16 11:24:40',NULL),(102,48,4,955,'2026-03-30','cancelled',NULL,'2026-04-16 11:24:40',NULL),(103,25,2,902,'2026-03-07','in_queue',NULL,'2026-04-16 11:24:40',NULL),(104,20,5,133,'2026-04-01','in_queue',NULL,'2026-04-16 11:24:41',NULL),(105,50,5,207,'2026-05-08','pending_payment',NULL,'2026-04-16 11:24:41',NULL),(106,27,4,782,'2026-03-13','cancelled',NULL,'2026-04-16 11:24:41',NULL),(107,25,2,204,'2026-06-12','completed',NULL,'2026-04-16 11:24:41',NULL),(108,28,6,563,'2026-05-17','cancelled',NULL,'2026-04-16 11:24:41',NULL),(109,48,3,858,'2026-04-22','completed',NULL,'2026-04-16 11:24:41',NULL),(110,35,9,892,'2026-04-21','confirmed',NULL,'2026-04-16 11:24:41',NULL),(111,7,6,613,'2026-05-31','pending_payment',NULL,'2026-04-16 11:24:41',NULL),(112,20,1,925,'2026-05-04','completed',NULL,'2026-04-16 11:24:41',NULL),(113,40,7,460,'2026-05-21','pending_payment',NULL,'2026-04-16 11:24:41',NULL),(114,40,3,512,'2026-06-01','completed',NULL,'2026-04-16 11:24:41',NULL),(115,31,8,127,'2026-06-10','cancelled',NULL,'2026-04-16 11:24:41',NULL),(116,27,2,537,'2026-04-25','confirmed',NULL,'2026-04-16 11:24:41',NULL),(117,26,12,394,'2026-06-05','cancelled',NULL,'2026-04-16 11:24:41',NULL),(118,10,1,827,'2026-04-23','in_queue',NULL,'2026-04-16 11:24:41',NULL),(119,40,3,907,'2026-05-02','confirmed',NULL,'2026-04-16 11:24:41',NULL),(120,26,6,975,'2026-02-20','completed',NULL,'2026-04-16 11:24:41',NULL),(121,19,7,472,'2026-05-23','in_queue',NULL,'2026-04-16 11:24:41',NULL),(122,20,6,203,'2026-04-30','pending_payment',NULL,'2026-04-16 11:24:41',NULL),(123,6,12,210,'2026-04-21','completed',NULL,'2026-04-16 11:24:41',NULL),(124,44,8,395,'2026-04-05','completed',NULL,'2026-04-16 11:24:41',NULL),(125,6,3,362,'2026-04-08','pending_payment',NULL,'2026-04-16 11:24:41',NULL),(126,34,12,864,'2026-05-12','cancelled',NULL,'2026-04-16 11:24:41',NULL),(127,12,7,345,'2026-03-14','completed',NULL,'2026-04-16 11:24:41',NULL),(128,22,12,632,'2026-03-21','cancelled',NULL,'2026-04-16 11:24:41',NULL),(129,8,8,748,'2026-05-09','in_queue',NULL,'2026-04-16 11:24:41',NULL),(130,18,6,349,'2026-05-14','cancelled',NULL,'2026-04-16 11:24:41',NULL),(131,44,9,996,'2026-04-24','completed',NULL,'2026-04-16 11:24:41',NULL),(132,9,6,442,'2026-06-04','in_queue',NULL,'2026-04-16 11:24:41',NULL),(133,29,2,429,'2026-05-19','pending_payment',NULL,'2026-04-16 11:24:41',NULL),(134,5,7,743,'2026-03-25','in_queue',NULL,'2026-04-16 11:24:41',NULL),(135,16,2,487,'2026-03-28','in_queue',NULL,'2026-04-16 11:24:41',NULL),(136,6,2,753,'2026-05-23','confirmed',NULL,'2026-04-16 11:24:41',NULL),(137,1,1,639,'2026-03-03','cancelled',NULL,'2026-04-16 11:24:41',NULL),(138,49,5,166,'2026-05-21','pending_payment',NULL,'2026-04-16 11:24:41',NULL),(139,1,11,804,'2026-06-15','cancelled',NULL,'2026-04-16 11:24:41',NULL),(140,33,8,776,'2026-04-24','cancelled',NULL,'2026-04-16 11:24:41',NULL),(141,6,1,606,'2026-03-09','pending_payment',NULL,'2026-04-16 11:24:41',NULL),(142,27,5,117,'2026-06-07','in_queue',NULL,'2026-04-16 11:24:41',NULL),(143,25,1,679,'2026-04-19','cancelled',NULL,'2026-04-16 11:24:41',NULL),(144,8,8,372,'2026-05-19','in_queue',NULL,'2026-04-16 11:24:41',NULL),(145,48,12,225,'2026-05-16','confirmed',NULL,'2026-04-16 11:24:41',NULL),(146,19,2,245,'2026-03-05','completed',NULL,'2026-04-16 11:24:41',NULL),(147,46,1,901,'2026-05-09','in_queue',NULL,'2026-04-16 11:24:41',NULL),(148,11,7,669,'2026-05-05','cancelled',NULL,'2026-04-16 11:24:41',NULL),(149,36,10,891,'2026-05-02','completed',NULL,'2026-04-16 11:24:41',NULL),(150,33,11,947,'2026-06-06','in_queue',NULL,'2026-04-16 11:24:41',NULL),(151,22,6,402,'2026-02-28','confirmed',NULL,'2026-04-16 11:24:41',NULL),(152,20,5,247,'2026-03-28','completed',NULL,'2026-04-16 11:24:41',NULL),(153,17,8,430,'2026-06-12','completed',NULL,'2026-04-16 11:24:41',NULL),(154,8,3,626,'2026-05-19','completed',NULL,'2026-04-16 11:24:41',NULL),(155,49,8,852,'2026-05-30','cancelled',NULL,'2026-04-16 11:24:41',NULL),(156,47,2,408,'2026-05-15','in_queue',NULL,'2026-04-16 11:24:41',NULL),(157,46,7,740,'2026-06-13','completed',NULL,'2026-04-16 11:24:41',NULL),(158,26,2,920,'2026-02-18','completed',NULL,'2026-04-16 11:24:41',NULL),(159,18,8,231,'2026-06-12','completed',NULL,'2026-04-16 11:24:41',NULL),(160,5,3,290,'2026-04-15','confirmed',NULL,'2026-04-16 11:24:41',NULL),(161,28,4,419,'2026-05-31','in_queue',NULL,'2026-04-16 11:24:41',NULL),(162,49,10,488,'2026-04-23','pending_payment',NULL,'2026-04-16 11:24:41',NULL),(163,19,5,137,'2026-06-05','completed',NULL,'2026-04-16 11:24:41',NULL),(164,49,10,992,'2026-03-28','completed',NULL,'2026-04-16 11:24:41',NULL),(165,49,7,872,'2026-06-08','pending_payment',NULL,'2026-04-16 11:24:41',NULL),(166,2,4,517,'2026-02-27','in_queue',NULL,'2026-04-16 11:24:41',NULL),(167,40,11,567,'2026-03-07','completed',NULL,'2026-04-16 11:24:41',NULL),(168,42,8,269,'2026-03-01','cancelled',NULL,'2026-04-16 11:24:41',NULL),(169,3,11,737,'2026-05-30','completed',NULL,'2026-04-16 11:24:41',NULL),(170,23,2,222,'2026-04-13','in_queue',NULL,'2026-04-16 11:24:41',NULL),(171,47,11,907,'2026-04-06','confirmed',NULL,'2026-04-16 11:24:41',NULL),(172,34,8,570,'2026-04-28','pending_payment',NULL,'2026-04-16 11:24:41',NULL),(173,47,4,538,'2026-05-12','cancelled',NULL,'2026-04-16 11:24:41',NULL),(174,8,3,911,'2026-03-21','cancelled',NULL,'2026-04-16 11:24:41',NULL),(175,45,2,886,'2026-04-11','completed',NULL,'2026-04-16 11:24:41',NULL),(176,9,10,536,'2026-04-16','in_queue',NULL,'2026-04-16 11:24:41',NULL),(177,38,6,432,'2026-04-01','completed',NULL,'2026-04-16 11:24:41',NULL),(178,32,3,478,'2026-04-21','confirmed',NULL,'2026-04-16 11:24:41',NULL),(179,37,6,884,'2026-02-20','confirmed',NULL,'2026-04-16 11:24:41',NULL),(180,39,12,251,'2026-05-21','in_queue',NULL,'2026-04-16 11:24:41',NULL),(181,1,1,1,'2026-04-24','confirmed',NULL,'2026-04-24 14:44:29',NULL);
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;

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
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'System Administrator','admin@cureflow.com','admin123','admin','2026-04-16 11:24:40'),(2,'Dr. James Anderson','doctor_1@cureflow.com','doctor123','doctor','2026-04-16 11:24:40'),(3,'Dr. Jennifer Moore','doctor_2@cureflow.com','doctor123','doctor','2026-04-16 11:24:40'),(4,'Dr. William Smith','doctor_3@cureflow.com','doctor123','doctor','2026-04-16 11:24:40'),(5,'Dr. Thomas Taylor','doctor_4@cureflow.com','doctor123','doctor','2026-04-16 11:24:40'),(6,'Dr. Thomas Taylor','doctor_5@cureflow.com','doctor123','doctor','2026-04-16 11:24:40'),(7,'Dr. David Davis','doctor_6@cureflow.com','doctor123','doctor','2026-04-16 11:24:40'),(8,'Dr. Sarah Hernandez','doctor_7@cureflow.com','doctor123','doctor','2026-04-16 11:24:40'),(9,'Dr. Patricia Martin','doctor_8@cureflow.com','doctor123','doctor','2026-04-16 11:24:40'),(10,'Dr. Linda Garcia','doctor_9@cureflow.com','doctor123','doctor','2026-04-16 11:24:40'),(11,'Dr. Charles Jackson','doctor_10@cureflow.com','doctor123','doctor','2026-04-16 11:24:40'),(12,'Dr. Michael Wilson','doctor_11@cureflow.com','doctor123','doctor','2026-04-16 11:24:40'),(13,'Dr. Mary Moor','doctor_12@cureflow.com','doctor123','doctor','2026-04-16 11:24:40'),(14,'Robert Jones','patient_1@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(15,'Mary Rodriguez','patient_2@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(16,'Richard Gonzalez','patient_3@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(17,'Susan Miller','patient_4@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(18,'Susan Gonzalez','patient_5@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(19,'Michael Moore','patient_6@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(20,'Linda Martin','patient_7@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(21,'Elizabeth Anderson','patient_8@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(22,'David Martinez','patient_9@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(23,'Susan Miller','patient_10@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(24,'Joseph Taylor','patient_11@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(25,'John Gonzalez','patient_12@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(26,'James Williams','patient_13@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(27,'Robert Jackson','patient_14@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(28,'Karen Brown','patient_15@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(29,'Patricia Lopez','patient_16@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(30,'Joseph Hernandez','patient_17@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(31,'James Williams','patient_18@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(32,'Thomas Davis','patient_19@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(33,'Richard Thomas','patient_20@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(34,'Elizabeth Miller','patient_21@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(35,'Linda Johnson','patient_22@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(36,'John Miller','patient_23@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(37,'Jennifer Taylor','patient_24@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(38,'Jessica Miller','patient_25@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(39,'Patricia Lopez','patient_26@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(40,'Michael Gonzalez','patient_27@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(41,'Karen Hernandez','patient_28@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(42,'Karen Martin','patient_29@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(43,'Joseph Johnson','patient_30@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(44,'Robert Davis','patient_31@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(45,'Thomas Williams','patient_32@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(46,'Joseph Anderson','patient_33@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(47,'Richard Jones','patient_34@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(48,'Michael Anderson','patient_35@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(49,'Karen Anderson','patient_36@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(50,'Charles Hernandez','patient_37@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(51,'Patricia Miller','patient_38@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(52,'Charles Martin','patient_39@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(53,'William Thomas','patient_40@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(54,'Sarah Davis','patient_41@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(55,'Richard Moore','patient_42@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(56,'Joseph Miller','patient_43@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(57,'Patricia Hernandez','patient_44@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(58,'Joseph Garcia','patient_45@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(59,'Elizabeth Williams','patient_46@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(60,'Karen Jones','patient_47@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(61,'David Jackson','patient_48@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(62,'William Martin','patient_49@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(63,'Robert Martin','patient_50@cureflow.com','patient123','patient','2026-04-16 11:24:40'),(66,'rerererererer','fffff@h.com','111111','patient','2026-04-24 12:42:07');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-24 23:07:22
SET FOREIGN_KEY_CHECKS = 1;
COMMIT;
