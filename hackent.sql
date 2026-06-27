CREATE DATABASE  IF NOT EXISTS `privacy_compliance` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `privacy_compliance`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: privacy_compliance
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `assessment_answers`
--

DROP TABLE IF EXISTS `assessment_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assessment_answers` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `assessment_id` bigint NOT NULL,
  `question_id` bigint NOT NULL,
  `option_id` bigint DEFAULT NULL,
  `answer_text` text COLLATE utf8mb4_unicode_ci,
  `score` decimal(5,2) DEFAULT '0.00',
  `observations` text COLLATE utf8mb4_unicode_ci,
  `answered_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_answer_assessment` (`assessment_id`),
  KEY `fk_answer_question` (`question_id`),
  KEY `fk_answer_option` (`option_id`),
  CONSTRAINT `fk_answer_assessment` FOREIGN KEY (`assessment_id`) REFERENCES `assessments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_answer_option` FOREIGN KEY (`option_id`) REFERENCES `question_options` (`id`),
  CONSTRAINT `fk_answer_question` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assessment_results`
--

DROP TABLE IF EXISTS `assessment_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assessment_results` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `assessment_id` bigint NOT NULL,
  `total_score` decimal(6,2) DEFAULT NULL,
  `compliance_percentage` decimal(5,2) DEFAULT NULL,
  `compliance_level` enum('CRITICAL','LOW','MEDIUM','HIGH','EXCELLENT') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `risk_level` enum('LOW','MEDIUM','HIGH') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `summary` text COLLATE utf8mb4_unicode_ci,
  `generated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `assessment_id` (`assessment_id`),
  CONSTRAINT `fk_result_assessment` FOREIGN KEY (`assessment_id`) REFERENCES `assessments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assessments`
--

DROP TABLE IF EXISTS `assessments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assessments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint NOT NULL,
  `questionnaire_version_id` int NOT NULL,
  `evaluator_id` bigint NOT NULL,
  `started_at` datetime NOT NULL,
  `finished_at` datetime DEFAULT NULL,
  `status` enum('IN_PROGRESS','COMPLETED','CANCELLED') COLLATE utf8mb4_unicode_ci DEFAULT 'IN_PROGRESS',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_assessment_company` (`company_id`),
  KEY `fk_assessment_version` (`questionnaire_version_id`),
  KEY `fk_assessment_user` (`evaluator_id`),
  CONSTRAINT `fk_assessment_company` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`),
  CONSTRAINT `fk_assessment_user` FOREIGN KEY (`evaluator_id`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_assessment_version` FOREIGN KEY (`questionnaire_version_id`) REFERENCES `questionnaire_versions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category_results`
--

DROP TABLE IF EXISTS `category_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category_results` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `assessment_id` bigint NOT NULL,
  `category_id` int NOT NULL,
  `score` decimal(5,2) NOT NULL,
  `max_score` decimal(5,2) NOT NULL,
  `percentage` decimal(5,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_category_result_assessment` (`assessment_id`),
  KEY `fk_category_result_category` (`category_id`),
  CONSTRAINT `fk_category_result_assessment` FOREIGN KEY (`assessment_id`) REFERENCES `assessments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_category_result_category` FOREIGN KEY (`category_id`) REFERENCES `question_categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `companies`
--

DROP TABLE IF EXISTS `companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `companies` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `business_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trade_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nit` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sector` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_size` enum('MICRO','SMALL','MEDIUM','LARGE') COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `department` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nit` (`nit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `question_categories`
--

DROP TABLE IF EXISTS `question_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `version_id` int NOT NULL,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `weight` decimal(5,2) NOT NULL,
  `display_order` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_category_version` (`version_id`),
  CONSTRAINT `fk_category_version` FOREIGN KEY (`version_id`) REFERENCES `questionnaire_versions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `question_options`
--

DROP TABLE IF EXISTS `question_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question_options` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `question_id` bigint NOT NULL,
  `option_text` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option_value` decimal(5,2) NOT NULL,
  `display_order` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_option_question` (`question_id`),
  CONSTRAINT `fk_option_question` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `questionnaire_versions`
--

DROP TABLE IF EXISTS `questionnaire_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questionnaire_versions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `questionnaire_id` int NOT NULL,
  `version_number` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_current` tinyint(1) DEFAULT '0',
  `published_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_version_questionnaire` (`questionnaire_id`),
  CONSTRAINT `fk_version_questionnaire` FOREIGN KEY (`questionnaire_id`) REFERENCES `questionnaires` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `questionnaires`
--

DROP TABLE IF EXISTS `questionnaires`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questionnaires` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL,
  `question_text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `help_text` text COLLATE utf8mb4_unicode_ci,
  `explanation` text COLLATE utf8mb4_unicode_ci,
  `weight` decimal(5,2) NOT NULL,
  `display_order` int NOT NULL,
  `is_required` tinyint(1) DEFAULT '1',
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_question_category` (`category_id`),
  CONSTRAINT `fk_question_category` FOREIGN KEY (`category_id`) REFERENCES `question_categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_permissions`
--

DROP TABLE IF EXISTS `role_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_permissions` (
  `role_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`role_id`,`permission_id`),
  KEY `fk_rp_permission` (`permission_id`),
  CONSTRAINT `fk_rp_permission` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rp_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint NOT NULL,
  `role_id` int NOT NULL,
  `first_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `oauth_provider` enum('LOCAL','GOOGLE','MICROSOFT') COLLATE utf8mb4_unicode_ci DEFAULT 'LOCAL',
  `oauth_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `last_login` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_user_company` (`company_id`),
  KEY `fk_user_role` (`role_id`),
  CONSTRAINT `fk_user_company` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`),
  CONSTRAINT `fk_user_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-26 15:15:41
