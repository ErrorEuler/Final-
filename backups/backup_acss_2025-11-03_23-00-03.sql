-- Database Backup
-- Generated: 2025-11-03 23:00:03
-- Database: acss
-- PHP Version: 8.2.12
-- Tables: 46

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT;
SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS;
SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION;
SET NAMES utf8mb4;

--
-- Table structure for table `academic_calendar`
--

DROP TABLE IF EXISTS `academic_calendar`;
CREATE TABLE `academic_calendar` (
  `event_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `semester_id` int(10) unsigned NOT NULL,
  `event_name` varchar(100) NOT NULL,
  `event_type` enum('Holiday','Exam Period','Registration','Special Event') NOT NULL,
  `recurring_event` enum('None','Weekly','Monthly','Yearly') DEFAULT 'None',
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `affects_scheduling` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`event_id`),
  KEY `idx_semester_id` (`semester_id`),
  KEY `idx_event_type` (`event_type`),
  KEY `idx_date_range` (`start_date`,`end_date`),
  KEY `idx_affects_scheduling` (`affects_scheduling`),
  CONSTRAINT `fk_calendar_semester` FOREIGN KEY (`semester_id`) REFERENCES `semesters` (`semester_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Academic calendar events and holidays';

--
-- Dumping data for table `academic_calendar`
--

--
-- Table structure for table `activity_logs`
--

DROP TABLE IF EXISTS `activity_logs`;
CREATE TABLE `activity_logs` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `department_id` smallint(5) unsigned NOT NULL,
  `action_type` varchar(50) NOT NULL,
  `action_description` varchar(255) DEFAULT NULL,
  `entity_type` varchar(50) DEFAULT NULL COMMENT 'Table affected',
  `entity_id` int(10) unsigned DEFAULT NULL COMMENT 'Record ID affected',
  `metadata_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`log_id`),
  KEY `fk_log_metadata` (`metadata_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_action_type` (`action_type`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_entity` (`entity_type`,`entity_id`),
  CONSTRAINT `fk_log_metadata` FOREIGN KEY (`metadata_id`) REFERENCES `user_metadata` (`metadata_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_log_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=480 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='System activity audit logs';

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`log_id`, `user_id`, `department_id`, `action_type`, `action_description`, `entity_type`, `entity_id`, `metadata_id`, `created_at`) VALUES 
('1', '1', '14', 'Update Course', 'Updated course ID 95', 'courses', '95', NULL, '2025-08-24 22:50:22'),
('2', '1', '14', 'Update Course', 'Updated course ID 95', 'courses', '95', NULL, '2025-08-24 23:19:51'),
('3', '1', '14', 'View Faculty Details', 'Viewed details for user_id=59', 'users', '59', NULL, '2025-08-25 12:44:01'),
('4', '1', '14', 'Search Faculty', 'Searched for name: hs', 'users', NULL, NULL, '2025-08-25 12:44:53'),
('5', '1', '14', 'Search Faculty', 'Searched for name: ha', 'users', NULL, NULL, '2025-08-25 12:45:01'),
('7', '1', '14', 'View Faculty Details', 'Viewed details for user_id=59', 'users', '59', NULL, '2025-08-27 10:59:05'),
('37', '1', '14', 'Toggle Curriculum Status', 'Toggled curriculum ID 6 to Draft', 'curricula', '6', NULL, '2025-08-28 09:39:53'),
('38', '1', '14', 'Toggle Curriculum Status', 'Toggled curriculum ID 6 to Active', 'curricula', '6', NULL, '2025-08-28 09:39:55'),
('39', '2', '14', 'Deactivate User', 'Deactivated user ID 1', 'users', '1', NULL, '2025-08-28 13:32:07'),
('40', '2', '14', 'Activate User', 'Activated user ID 1', 'users', '1', NULL, '2025-08-28 13:32:17'),
('41', '2', '17', 'Activate User', 'Activated user ID 66', 'users', '66', NULL, '2025-08-28 13:33:12'),
('42', '2', '17', 'Deactivate User', 'Deactivated user ID 66', 'users', '66', NULL, '2025-08-28 13:34:07'),
('43', '2', '14', 'Deactivate User', 'Deactivated user ID 18', 'users', '18', NULL, '2025-08-28 13:35:56'),
('44', '2', '14', 'Activate User', 'Activated user ID 18', 'users', '18', NULL, '2025-08-28 13:36:49'),
('45', '1', '14', 'View Faculty Details', 'Viewed details for user_id=49', 'users', '49', NULL, '2025-08-28 20:24:01'),
('46', '1', '14', 'Update Course', 'Updated course ID 95', 'courses', '95', NULL, '2025-08-31 12:57:56'),
('47', '1', '14', 'View Faculty Details', 'Viewed details for user_id=27', 'users', '27', NULL, '2025-08-31 14:41:32'),
('48', '1', '14', 'View Faculty Details', 'Viewed details for user_id=59', 'users', '59', NULL, '2025-08-31 14:42:09'),
('49', '1', '14', 'View Faculty Details', 'Viewed details for user_id=54', 'users', '54', NULL, '2025-08-31 22:50:06'),
('50', '1', '14', 'View Faculty Details', 'Viewed details for user_id=59', 'users', '59', NULL, '2025-08-31 22:50:48'),
('51', '1', '14', 'Update Course', 'Updated course ID 105', 'courses', '105', NULL, '2025-09-01 11:12:25'),
('52', '1', '14', 'Update Course', 'Updated course ID 95', 'courses', '95', NULL, '2025-09-01 11:12:39'),
('53', '1', '14', 'Update Course', 'Updated course ID 81', 'courses', '81', NULL, '2025-09-01 11:12:53'),
('54', '1', '14', 'Update Course', 'Updated course ID 83', 'courses', '83', NULL, '2025-09-01 11:13:11'),
('55', '1', '14', 'Update Course', 'Updated course ID 96', 'courses', '96', NULL, '2025-09-01 11:13:23'),
('56', '1', '14', 'Update Course', 'Updated course ID 109', 'courses', '109', NULL, '2025-09-01 11:13:36'),
('57', '1', '14', 'Update Course', 'Updated course ID 88', 'courses', '88', NULL, '2025-09-01 11:13:59'),
('58', '1', '14', 'View Faculty Details', 'Viewed details for user_id=21', 'users', '21', NULL, '2025-09-01 18:43:47'),
('59', '1', '14', 'View Faculty Details', 'Viewed details for user_id=49', 'users', '49', NULL, '2025-09-01 19:17:17'),
('60', '1', '14', 'View Faculty Details', 'Viewed details for user_id=59', 'users', '59', NULL, '2025-09-01 19:17:22'),
('61', '1', '14', 'View Faculty Details', 'Viewed details for user_id=24', 'users', '24', NULL, '2025-09-01 19:17:46'),
('62', '1', '14', 'View Faculty Details', 'Viewed details for user_id=54', 'users', '54', NULL, '2025-09-02 07:58:54'),
('63', '1', '14', 'View Faculty Details', 'Viewed details for user_id=54', 'users', '54', NULL, '2025-09-02 07:59:01'),
('64', '1', '14', 'View Faculty Details', 'Viewed details for user_id=54', 'users', '54', NULL, '2025-09-02 07:59:06'),
('65', '1', '14', 'View Faculty Details', 'Viewed details for user_id=54', 'users', '54', NULL, '2025-09-02 07:59:17'),
('66', '1', '14', 'View Faculty Details', 'Viewed details for user_id=54', 'users', '54', NULL, '2025-09-02 07:59:22'),
('67', '1', '14', 'Remove Faculty', 'Removed faculty user_id=54 from department_id=14', 'faculty_departments', '24', NULL, '2025-09-02 08:08:18'),
('68', '1', '14', 'Search Faculty', 'Searched for name: ew', 'users', NULL, NULL, '2025-09-02 08:08:59'),
('69', '1', '14', 'Search Faculty', 'Searched for name: eww', 'users', NULL, NULL, '2025-09-02 08:09:00'),
('70', '1', '14', 'Search Faculty', 'Searched for name: eww', 'users', NULL, NULL, '2025-09-02 08:09:02'),
('71', '1', '14', 'Search Faculty', 'Searched for name: ewwdjsd', 'users', NULL, NULL, '2025-09-02 08:09:02'),
('72', '1', '14', 'Search Faculty', 'Searched for name: ewwdjs', 'users', NULL, NULL, '2025-09-02 08:09:03'),
('73', '1', '14', 'Remove Faculty', 'Removed faculty user_id=18 from department_id=14', 'faculty_departments', '1', NULL, '2025-09-02 08:13:08'),
('74', '1', '14', 'Search Faculty', 'Searched for name: fac', 'users', NULL, NULL, '2025-09-02 08:13:17'),
('75', '1', '14', 'Search Faculty', 'Searched for name: facul', 'users', NULL, NULL, '2025-09-02 08:13:18'),
('76', '1', '14', 'Search Faculty', 'Searched for name: faculty', 'users', NULL, NULL, '2025-09-02 08:13:18'),
('77', '1', '14', 'Search Faculty', 'Searched for name: fac', 'users', NULL, NULL, '2025-09-02 08:18:22'),
('78', '1', '14', 'Search Faculty', 'Searched for name: facul', 'users', NULL, NULL, '2025-09-02 08:18:23'),
('79', '1', '14', 'Search Faculty', 'Searched for name: faculty', 'users', NULL, NULL, '2025-09-02 08:18:24'),
('80', '1', '14', 'Add Faculty', 'Added faculty username=Batman to department_id=14', 'faculty_departments', '0', NULL, '2025-09-02 08:19:02'),
('81', '1', '14', 'Remove Faculty', 'Removed faculty user_id=49 from department_id=14', 'faculty_departments', '23', NULL, '2025-09-02 08:19:54'),
('82', '1', '14', 'Search Faculty', 'Searched for name: he', 'users', NULL, NULL, '2025-09-02 08:20:03'),
('83', '1', '14', 'Search Faculty', 'Searched for name: hel', 'users', NULL, NULL, '2025-09-02 08:20:04'),
('84', '1', '14', 'Search Faculty', 'Searched for name: helo', 'users', NULL, NULL, '2025-09-02 08:20:06'),
('85', '1', '14', 'Search Faculty', 'Searched for name: hel', 'users', NULL, NULL, '2025-09-02 08:20:08'),
('86', '1', '14', 'Search Faculty', 'Searched for name: hello', 'users', NULL, NULL, '2025-09-02 08:20:08'),
('87', '1', '14', 'Add Faculty', 'Added faculty username=Batman to department_id=14', 'faculty_departments', '0', NULL, '2025-09-02 08:20:23'),
('88', '1', '14', 'View Faculty Details', 'Viewed details for user_id=49', 'users', '49', NULL, '2025-09-02 08:35:46'),
('89', '1', '14', 'Remove Faculty', 'Removed faculty user_id=18 from department_id=14', 'faculty_departments', '32', NULL, '2025-09-02 08:35:55'),
('90', '1', '14', 'Search Faculty', 'Searched for name: fac', 'users', NULL, NULL, '2025-09-02 08:36:19'),
('91', '1', '14', 'Search Faculty', 'Searched for name: facu', 'users', NULL, NULL, '2025-09-02 08:36:20'),
('92', '1', '14', 'Add Faculty', 'Added faculty username=Batman to department_id=14', 'faculty_departments', '0', NULL, '2025-09-02 08:36:36'),
('93', '1', '14', 'Search Faculty', 'Searched for name: fa', 'users', NULL, NULL, '2025-09-02 08:37:27'),
('94', '1', '14', 'Search Faculty', 'Searched for name: fac', 'users', NULL, NULL, '2025-09-02 08:37:29'),
('95', '1', '14', 'Remove Faculty', 'Removed faculty user_id=18 from department_id=14', 'faculty_departments', '34', NULL, '2025-09-02 08:37:37'),
('96', '1', '14', 'Search Faculty', 'Searched for name: fa', 'users', NULL, NULL, '2025-09-02 08:39:48'),
('97', '1', '14', 'Search Faculty', 'Searched for name: fa', 'users', NULL, NULL, '2025-09-02 08:39:56'),
('98', '1', '14', 'Add Faculty', 'Added faculty username=Batman to department_id=14', 'faculty_departments', '0', NULL, '2025-09-02 08:40:05'),
('99', '1', '14', 'Remove Faculty', 'Removed faculty user_id=18 from department_id=14', 'faculty_departments', '35', NULL, '2025-09-02 08:41:08'),
('100', '1', '14', 'Search Faculty', 'Searched for name: fac', 'users', NULL, NULL, '2025-09-02 08:41:13'),
('101', '1', '14', 'Search Faculty', 'Searched for name: facu', 'users', NULL, NULL, '2025-09-02 08:41:13'),
('102', '1', '14', 'Add Faculty', 'Added faculty username=Batman to department_id=14', 'faculty_departments', '0', NULL, '2025-09-02 08:41:19'),
('103', '1', '14', 'View Faculty Details', 'Viewed details for user_id=25', 'users', '25', NULL, '2025-09-02 08:41:37'),
('104', '1', '14', 'View Faculty Details', 'Viewed details for user_id=24', 'users', '24', NULL, '2025-09-02 08:42:00'),
('105', '1', '14', 'View Faculty Details', 'Viewed details for user_id=18', 'users', '18', NULL, '2025-09-02 08:42:04'),
('106', '1', '14', 'View Faculty Details', 'Viewed details for user_id=18', 'users', '18', NULL, '2025-09-02 08:42:29'),
('107', '1', '14', 'View Faculty Details', 'Viewed details for user_id=18', 'users', '18', NULL, '2025-09-02 08:42:55'),
('108', '1', '14', 'View Faculty Details', 'Viewed details for user_id=18', 'users', '18', NULL, '2025-09-02 08:43:31'),
('109', '1', '14', 'View Faculty Details', 'Viewed details for user_id=18', 'users', '18', NULL, '2025-09-02 08:43:41'),
('110', '1', '14', 'Search Faculty', 'Searched for name: Geo', 'users', NULL, NULL, '2025-09-02 08:44:17'),
('111', '1', '14', 'Search Faculty', 'Searched for name: Geof', 'users', NULL, NULL, '2025-09-02 08:44:17'),
('112', '1', '14', 'Search Faculty', 'Searched for name: Geo', 'users', NULL, NULL, '2025-09-02 08:44:40'),
('113', '1', '14', 'Search Faculty', 'Searched for name: fac', 'users', NULL, NULL, '2025-09-02 08:44:41'),
('114', '1', '14', 'Search Faculty', 'Searched for name: facu', 'users', NULL, NULL, '2025-09-02 08:44:42'),
('115', '1', '14', 'Search Faculty', 'Searched for name: facul', 'users', NULL, NULL, '2025-09-02 08:44:43'),
('116', '1', '14', 'Search Faculty', 'Searched for name: faculty', 'users', NULL, NULL, '2025-09-02 08:44:43'),
('117', '1', '14', 'View Faculty Details', 'Viewed details for user_id=18', 'users', '18', NULL, '2025-09-02 08:44:54'),
('118', '1', '14', 'Search Faculty', 'Searched for name: facult', 'users', NULL, NULL, '2025-09-02 08:45:08'),
('119', '1', '14', 'Search Faculty', 'Searched for name: de', 'users', NULL, NULL, '2025-09-02 08:49:19'),
('120', '1', '14', 'Search Faculty', 'Searched for name: dean', 'users', NULL, NULL, '2025-09-02 08:58:44'),
('121', '1', '14', 'Search Faculty', 'Searched for name: fac', 'users', NULL, NULL, '2025-09-02 08:58:49'),
('122', '1', '14', 'Search Faculty', 'Searched for name: dea', 'users', NULL, NULL, '2025-09-02 08:59:05'),
('123', '1', '14', 'Search Faculty', 'Searched for name: dean', 'users', NULL, NULL, '2025-09-02 08:59:05'),
('124', '1', '14', 'Search Faculty', 'Searched for name: dge', 'users', NULL, NULL, '2025-09-02 08:59:11'),
('125', '1', '14', 'Search Faculty', 'Searched for name: dgeo', 'users', NULL, NULL, '2025-09-02 08:59:17'),
('126', '1', '14', 'Search Faculty', 'Searched for name: dge', 'users', NULL, NULL, '2025-09-02 08:59:18'),
('127', '1', '14', 'Search Faculty', 'Searched for name: geo', 'users', NULL, NULL, '2025-09-02 08:59:20'),
('128', '1', '14', 'Search Faculty', 'Searched for name: geof', 'users', NULL, NULL, '2025-09-02 08:59:22'),
('129', '1', '14', 'Search Faculty', 'Searched for name: geo', 'users', NULL, NULL, '2025-09-02 09:00:27'),
('130', '1', '14', 'Search Faculty', 'Searched for name: Geo', 'users', NULL, NULL, '2025-09-02 09:00:29'),
('131', '1', '14', 'Search Faculty', 'Searched for name: Ge', 'users', NULL, NULL, '2025-09-02 09:00:32'),
('132', '1', '14', 'Search Faculty', 'Searched for name: Geo', 'users', NULL, NULL, '2025-09-02 09:00:36'),
('133', '1', '14', 'Search Faculty', 'Searched for name: Ge', 'users', NULL, NULL, '2025-09-02 09:00:38'),
('134', '1', '14', 'Remove Faculty', 'Removed faculty user_id=18 from department_id=14', 'faculty_departments', '36', NULL, '2025-09-02 09:00:46'),
('135', '1', '14', 'Search Faculty', 'Searched for name: fac', 'users', NULL, NULL, '2025-09-02 09:00:51'),
('136', '1', '14', 'View Faculty Details', 'Viewed details for user_id=1', 'users', '1', NULL, '2025-09-02 09:04:49'),
('137', '57', '4', 'Search Faculty', 'Searched for name: Geo', 'users', NULL, NULL, '2025-09-02 09:09:55'),
('138', '57', '4', 'Search Faculty', 'Searched for name: Ge', 'users', NULL, NULL, '2025-09-02 09:10:00'),
('139', '57', '4', 'Search Faculty', 'Searched for name: geo', 'users', NULL, NULL, '2025-09-02 09:10:02'),
('140', '57', '4', 'Search Faculty', 'Searched for name: ge', 'users', NULL, NULL, '2025-09-02 09:10:04'),
('141', '57', '4', 'Search Faculty', 'Searched for name: fac', 'users', NULL, NULL, '2025-09-02 09:10:13'),
('142', '57', '4', 'Search Faculty', 'Searched for name: fa', 'users', NULL, NULL, '2025-09-02 09:10:15'),
('143', '57', '4', 'Search Faculty', 'Searched for name: fac', 'users', NULL, NULL, '2025-09-02 09:11:15'),
('144', '57', '4', 'Search Faculty', 'Searched for name: fa', 'users', NULL, NULL, '2025-09-02 09:11:24'),
('145', '57', '4', 'Search Faculty', 'Searched for name: Geo', 'users', NULL, NULL, '2025-09-02 09:11:27'),
('146', '57', '4', 'Search Faculty', 'Searched for name: Geof', 'users', NULL, NULL, '2025-09-02 09:11:28'),
('147', '57', '4', 'Search Faculty', 'Searched for name: Ge', 'users', NULL, NULL, '2025-09-02 09:11:30'),
('148', '57', '4', 'Search Faculty', 'Searched for name: Ge', 'users', NULL, NULL, '2025-09-02 09:11:33'),
('149', '57', '4', 'Search Faculty', 'Searched for name: fac', 'users', NULL, NULL, '2025-09-02 09:12:31'),
('150', '57', '4', 'Search Faculty', 'Searched for name: Geof', 'users', NULL, NULL, '2025-09-02 09:12:42'),
('151', '57', '4', 'Search Faculty', 'Searched for name: Geo', 'users', NULL, NULL, '2025-09-02 09:12:44'),
('152', '57', '4', 'Search Faculty', 'Searched for name: Ge', 'users', NULL, NULL, '2025-09-02 09:12:45'),
('153', '57', '4', 'Search Faculty', 'Searched for name: Geoff', 'users', NULL, NULL, '2025-09-02 09:12:50'),
('154', '57', '4', 'Search Faculty', 'Searched for name: Geoffre', 'users', NULL, NULL, '2025-09-02 09:12:51'),
('155', '57', '4', 'Search Faculty', 'Searched for name: Geoffr', 'users', NULL, NULL, '2025-09-02 09:12:54'),
('156', '57', '4', 'Search Faculty', 'Searched for name: dean', 'users', NULL, NULL, '2025-09-02 09:12:58'),
('157', '57', '4', 'Search Faculty', 'Searched for name: dea', 'users', NULL, NULL, '2025-09-02 09:12:59'),
('158', '57', '4', 'Search Faculty', 'Searched for name: fa', 'users', NULL, NULL, '2025-09-02 09:32:51'),
('159', '57', '4', 'Search Faculty', 'Searched for name: fac', 'users', NULL, NULL, '2025-09-02 09:33:01'),
('160', '57', '4', 'Search Faculty', 'Searched for name: de', 'users', NULL, NULL, '2025-09-02 09:38:16'),
('161', '57', '4', 'Search Faculty', 'Searched for name: fa', 'users', NULL, NULL, '2025-09-02 09:41:54'),
('162', '57', '4', 'Add Faculty', 'Added faculty username=sdvsdv to department_id=4', 'faculty_departments', '0', NULL, '2025-09-02 09:42:09'),
('163', '57', '4', 'Search Faculty', 'Searched for name: ge', 'users', NULL, NULL, '2025-09-02 09:46:35'),
('164', '57', '4', 'Search Faculty', 'Searched for name: de', 'users', NULL, NULL, '2025-09-02 09:46:41'),
('165', '57', '4', 'Search Faculty', 'Searched for name: dean', 'users', NULL, NULL, '2025-09-02 09:46:43'),
('166', '57', '4', 'Search Faculty', 'Searched for name: dea', 'users', NULL, NULL, '2025-09-02 09:46:46'),
('167', '57', '4', 'Remove Faculty', 'Removed faculty user_id=18 from department_id=4', 'faculty_departments', '38', NULL, '2025-09-02 09:47:14'),
('168', '57', '4', 'Search Faculty', 'Searched for name: fac', 'users', NULL, NULL, '2025-09-02 09:47:17'),
('169', '57', '4', 'Add Faculty', 'Added faculty username=sdvsdv to department_id=4', 'faculty_departments', '0', NULL, '2025-09-02 09:47:24'),
('170', '57', '4', 'Search Faculty', 'Searched for name: Geoffrey', 'users', NULL, NULL, '2025-09-02 09:48:22'),
('171', '57', '4', 'Search Faculty', 'Searched for name: GE', 'users', NULL, NULL, '2025-09-02 09:52:22'),
('172', '57', '4', 'Search Faculty', 'Searched for name: Ge', 'users', NULL, NULL, '2025-09-02 09:52:25'),
('173', '57', '4', 'Search Faculty', 'Searched for name: fac', 'users', NULL, NULL, '2025-09-02 09:52:35'),
('174', '57', '4', 'Search Faculty', 'Searched for name: facu', 'users', NULL, NULL, '2025-09-02 09:52:36'),
('175', '57', '4', 'Search Faculty', 'Searched for name: fac', 'users', NULL, NULL, '2025-09-02 09:52:37'),
('176', '57', '4', 'Search Faculty', 'Searched for name: geo', 'users', NULL, NULL, '2025-09-02 09:54:18'),
('177', '57', '4', 'Search Faculty', 'Searched for name: ge', 'users', NULL, NULL, '2025-09-02 09:54:26'),
('178', '57', '4', 'Search Faculty', 'Searched for name: de', 'users', NULL, NULL, '2025-09-02 09:54:28'),
('179', '57', '4', 'Search Faculty', 'Searched for name: dean', 'users', NULL, NULL, '2025-09-02 09:54:29'),
('180', '57', '4', 'Search Faculty', 'Searched for name: dea', 'users', NULL, NULL, '2025-09-02 09:55:44'),
('181', '57', '4', 'Search Faculty', 'Searched for name: ad', 'users', NULL, NULL, '2025-09-02 09:55:45'),
('182', '57', '4', 'Search Faculty', 'Searched for name: admi', 'users', NULL, NULL, '2025-09-02 09:55:49'),
('183', '1', '14', 'Search Faculty', 'Searched for name: admi', 'users', NULL, NULL, '2025-09-02 11:08:27'),
('184', '1', '14', 'Search Faculty', 'Searched for name: adm', 'users', NULL, NULL, '2025-09-02 11:08:32'),
('185', '1', '14', 'Search Faculty', 'Searched for name: fac', 'users', NULL, NULL, '2025-09-02 20:38:28'),
('186', '1', '14', 'Add Faculty', 'Added faculty username=Batman to department_id=14', 'faculty_departments', '0', NULL, '2025-09-02 20:38:35'),
('187', '1', '14', 'View Faculty Details', 'Viewed details for user_id=18', 'users', '18', NULL, '2025-09-02 21:53:33'),
('188', '1', '14', 'View Faculty Details', 'Viewed details for user_id=49', 'users', '49', NULL, '2025-09-02 21:53:39'),
('189', '1', '14', 'View Faculty Details', 'Viewed details for user_id=21', 'users', '21', NULL, '2025-09-02 21:53:47'),
('190', '1', '14', 'Search Faculty', 'Searched for name: de', 'users', NULL, NULL, '2025-09-02 21:55:24'),
('191', '1', '14', 'View Faculty Details', 'Viewed details for user_id=1', 'users', '1', NULL, '2025-09-04 13:42:04'),
('192', '1', '14', 'View Faculty Details', 'Viewed details for user_id=18', 'users', '18', NULL, '2025-09-04 19:20:41'),
('193', '1', '14', 'View Faculty Details', 'Viewed details for user_id=18', 'users', '18', NULL, '2025-09-05 10:54:01'),
('194', '1', '14', 'View Faculty Details', 'Viewed details for user_id=25', 'users', '25', NULL, '2025-09-05 10:54:04'),
('195', '1', '14', 'View Faculty Details', 'Viewed details for user_id=24', 'users', '24', NULL, '2025-09-05 10:54:48'),
('196', '1', '14', 'View Faculty Details', 'Viewed details for user_id=23', 'users', '23', NULL, '2025-09-05 13:59:54'),
('197', '1', '14', 'View Faculty Details', 'Viewed details for user_id=1', 'users', '1', NULL, '2025-09-05 13:59:58'),
('198', '1', '14', 'View Faculty Details', 'Viewed details for user_id=18', 'users', '18', NULL, '2025-09-05 15:58:52'),
('199', '1', '14', 'View Faculty Details', 'Viewed details for user_id=18', 'users', '18', NULL, '2025-09-11 14:46:19'),
('200', '1', '14', 'View Faculty Details', 'Viewed details for user_id=18', 'users', '18', NULL, '2025-09-11 14:48:02'),
('201', '1', '14', 'View Faculty Details', 'Viewed details for user_id=59', 'users', '59', NULL, '2025-09-11 14:48:07'),
('202', '1', '14', 'View Faculty Details', 'Viewed details for user_id=24', 'users', '24', NULL, '2025-09-13 22:09:05'),
('203', '1', '14', 'View Faculty Details', 'Viewed details for user_id=1', 'users', '1', NULL, '2025-09-16 14:28:35'),
('204', '1', '14', 'View Faculty Details', 'Viewed details for user_id=1', 'users', '1', NULL, '2025-09-16 14:33:03'),
('205', '1', '14', 'View Faculty Details', 'Viewed details for user_id=33', 'users', '33', NULL, '2025-09-16 14:35:26'),
('206', '1', '14', 'View Faculty Details', 'Viewed details for user_id=19', 'users', '19', NULL, '2025-09-16 14:35:31'),
('207', '1', '14', 'View Faculty Details', 'Viewed details for user_id=1', 'users', '1', NULL, '2025-09-16 14:35:50'),
('208', '1', '14', 'View Faculty Details', 'Viewed details for user_id=1', 'users', '1', NULL, '2025-09-16 14:37:55'),
('209', '1', '14', 'View Faculty Details', 'Viewed details for user_id=1', 'users', '1', NULL, '2025-09-16 14:37:56'),
('210', '1', '14', 'View Faculty Details', 'Viewed details for user_id=1', 'users', '1', NULL, '2025-09-16 14:37:56'),
('211', '1', '14', 'View Faculty Details', 'Viewed details for user_id=1', 'users', '1', NULL, '2025-09-16 14:38:28'),
('212', '1', '14', 'View Faculty Details', 'Viewed details for user_id=1', 'users', '1', NULL, '2025-09-16 14:38:29'),
('213', '1', '14', 'View Faculty Details', 'Viewed details for user_id=1', 'users', '1', NULL, '2025-09-16 14:38:30'),
('214', '1', '14', 'View Faculty Details', 'Viewed details for user_id=59', 'users', '59', NULL, '2025-09-16 14:38:31'),
('215', '1', '14', 'View Faculty Details', 'Viewed details for user_id=21', 'users', '21', NULL, '2025-09-16 14:38:32'),
('216', '1', '14', 'View Faculty Details', 'Viewed details for user_id=49', 'users', '49', NULL, '2025-09-16 14:38:33'),
('217', '1', '14', 'View Faculty Details', 'Viewed details for user_id=33', 'users', '33', NULL, '2025-09-16 14:38:33'),
('218', '1', '14', 'View Faculty Details', 'Viewed details for user_id=33', 'users', '33', NULL, '2025-09-16 14:38:51'),
('219', '1', '14', 'View Faculty Details', 'Viewed details for user_id=1', 'users', '1', NULL, '2025-09-16 14:38:56'),
('220', '1', '14', 'View Faculty Details', 'Viewed details for user_id=23', 'users', '23', NULL, '2025-09-16 22:15:47'),
('221', '1', '14', 'View Faculty Details', 'Viewed details for user_id=24', 'users', '24', NULL, '2025-09-16 22:15:51'),
('222', '1', '14', 'Add Course', 'Added course ID 110', 'courses', '110', NULL, '2025-09-17 09:52:54'),
('223', '1', '14', 'View Faculty Details', 'Viewed details for user_id=18', 'users', '18', NULL, '2025-09-17 23:04:01'),
('224', '1', '14', 'View Faculty Details', 'Viewed details for user_id=49', 'users', '49', NULL, '2025-09-18 09:17:45'),
('225', '1', '14', 'View Faculty Details', 'Viewed details for user_id=33', 'users', '33', NULL, '2025-09-18 09:20:16'),
('226', '1', '14', 'View Faculty Details', 'Viewed details for user_id=1', 'users', '1', NULL, '2025-09-18 09:20:21'),
('227', '1', '14', 'Update Course', 'Updated course ID 95', 'courses', '95', NULL, '2025-09-18 09:50:45'),
('228', '1', '14', 'Update Course', 'Updated course ID 105', 'courses', '105', NULL, '2025-09-18 09:50:55'),
('229', '1', '14', 'Update Course', 'Updated course ID 60', 'courses', '60', NULL, '2025-09-18 09:51:18'),
('230', '1', '14', 'Update Course', 'Updated course ID 67', 'courses', '67', NULL, '2025-09-18 09:51:34'),
('231', '1', '14', 'Update Course', 'Updated course ID 67', 'courses', '67', NULL, '2025-09-18 09:51:41'),
('232', '1', '14', 'Update Course', 'Updated course ID 74', 'courses', '74', NULL, '2025-09-18 09:51:59'),
('233', '1', '14', 'Update Course', 'Updated course ID 74', 'courses', '74', NULL, '2025-09-18 09:53:55'),
('234', '1', '14', 'Update Course', 'Updated course ID 74', 'courses', '74', NULL, '2025-09-18 09:54:41'),
('235', '1', '14', 'Update Course', 'Updated course ID 74', 'courses', '74', NULL, '2025-09-18 09:55:14'),
('236', '1', '14', 'Update Course', 'Updated course ID 74', 'courses', '74', NULL, '2025-09-18 09:55:18'),
('237', '1', '14', 'Update Course', 'Updated course ID 83', 'courses', '83', NULL, '2025-09-18 09:57:36'),
('238', '1', '14', 'Update Course', 'Updated course ID 81', 'courses', '81', NULL, '2025-09-18 09:58:01'),
('239', '1', '14', 'Update Course', 'Updated course ID 96', 'courses', '96', NULL, '2025-09-18 09:58:23'),
('240', '1', '14', 'Update Course', 'Updated course ID 101', 'courses', '101', NULL, '2025-09-18 09:58:51'),
('241', '1', '14', 'Update Course', 'Updated course ID 80', 'courses', '80', NULL, '2025-09-18 09:59:03'),
('242', '1', '14', 'Update Course', 'Updated course ID 80', 'courses', '80', NULL, '2025-09-18 10:00:32'),
('243', '1', '14', 'Update Course', 'Updated course ID 61', 'courses', '61', NULL, '2025-09-18 10:06:32'),
('244', '1', '14', 'Add Course', 'Added course ID 111', 'courses', '111', NULL, '2025-09-18 10:16:55'),
('245', '1', '14', 'View Faculty Details', 'Viewed details for user_id=27', 'users', '27', NULL, '2025-09-18 10:17:19'),
('246', '1', '14', 'View Faculty Details', 'Viewed details for user_id=59', 'users', '59', NULL, '2025-09-18 10:17:25'),
('247', '1', '14', 'View Faculty Details', 'Viewed details for user_id=1', 'users', '1', NULL, '2025-09-18 10:17:31'),
('248', '1', '14', 'Update Course', 'Updated course ID 95', 'courses', '95', NULL, '2025-09-18 20:59:00'),
('249', '1', '14', 'Update Course', 'Updated course ID 71', 'courses', '71', NULL, '2025-09-18 20:59:11'),
('250', '1', '14', 'Remove Faculty', 'Removed faculty user_id=59 from department_id=14', 'faculty_departments', '29', NULL, '2025-09-18 20:59:56'),
('251', '1', '14', 'Update Curriculum', 'Updated curriculum ID 6', 'curricula', '6', NULL, '2025-09-20 20:33:52'),
('252', '1', '14', 'Update Course', 'Updated course ID 106', 'courses', '106', NULL, '2025-09-20 20:57:41'),
('253', '1', '14', 'Update Course', 'Updated course ID 109', 'courses', '109', NULL, '2025-09-20 20:58:00'),
('254', '1', '14', 'Update Course', 'Updated course ID 90', 'courses', '90', NULL, '2025-09-20 20:58:14'),
('255', '1', '14', 'Update Course', 'Updated course ID 89', 'courses', '89', NULL, '2025-09-20 20:58:38'),
('256', '1', '14', 'Update Course', 'Updated course ID 100', 'courses', '100', NULL, '2025-09-20 20:58:49'),
('257', '1', '14', 'Update Course', 'Updated course ID 85', 'courses', '85', NULL, '2025-09-20 20:59:00'),
('258', '1', '14', 'Update Course', 'Updated course ID 69', 'courses', '69', NULL, '2025-09-20 21:07:59'),
('259', '1', '14', 'Update Course', 'Updated course ID 94', 'courses', '94', NULL, '2025-09-20 21:08:23'),
('260', '1', '14', 'Update Course', 'Updated course ID 104', 'courses', '104', NULL, '2025-09-20 21:08:53'),
('261', '1', '14', 'Update Course', 'Updated course ID 92', 'courses', '92', NULL, '2025-09-20 21:09:15'),
('262', '1', '14', 'Update Course', 'Updated course ID 98', 'courses', '98', NULL, '2025-09-20 21:09:30'),
('263', '1', '14', 'View Faculty Details', 'Viewed details for user_id=21', 'users', '21', NULL, '2025-09-22 14:57:31'),
('264', '1', '14', 'Update Course', 'Updated course ID 84', 'courses', '84', NULL, '2025-09-23 18:05:35'),
('265', '1', '14', 'View Faculty Details', 'Viewed details for user_id=18', 'users', '18', NULL, '2025-09-23 18:07:08'),
('266', '1', '14', 'View Faculty Details', 'Viewed details for user_id=19', 'users', '19', NULL, '2025-09-23 18:07:18'),
('267', '1', '14', 'View Faculty Details', 'Viewed details for user_id=21', 'users', '21', NULL, '2025-09-23 18:07:23'),
('268', '1', '14', 'View Faculty Details', 'Viewed details for user_id=49', 'users', '49', NULL, '2025-09-23 18:07:26'),
('269', '1', '14', 'View Faculty Details', 'Viewed details for user_id=21', 'users', '21', NULL, '2025-09-23 18:07:34'),
('270', '1', '14', 'View Faculty Details', 'Viewed details for user_id=1', 'users', '1', NULL, '2025-09-23 18:07:36'),
('271', '1', '14', 'Search Faculty', 'Searched for name: wf', 'users', NULL, NULL, '2025-09-23 18:08:01'),
('272', '1', '14', 'View Faculty Details', 'Viewed details for user_id=20', 'users', '20', NULL, '2025-09-25 23:00:21'),
('273', '1', '14', 'Update Course', 'Updated course ID 87', 'courses', '87', NULL, '2025-09-25 23:00:56'),
('274', '2', '14', 'Demote User', 'Demoted user ID 26 to Faculty', 'users', '26', NULL, '2025-09-26 14:57:07'),
('275', '2', '14', 'Demote User', 'Demoted user ID 1 to Faculty', 'users', '1', NULL, '2025-09-26 14:59:52'),
('276', '2', '14', 'Demote User', 'Demoted user ID 1 to Faculty', 'users', '1', NULL, '2025-09-26 15:29:18'),
('277', '1', '14', 'Remove Faculty', 'Removed faculty user_id=27 from department_id=14', 'faculty_departments', '8', NULL, '2025-09-27 16:56:20'),
('278', '1', '14', 'View Faculty Details', 'Viewed details for user_id=1', 'users', '1', NULL, '2025-09-27 17:47:16'),
('279', '1', '14', 'Search Faculty', 'Searched for name: rowe', 'users', NULL, NULL, '2025-09-27 22:39:57'),
('280', '1', '14', 'Add Faculty', 'Added faculty user_id=20 to department_id=14, is_active=0', 'faculty_departments', '0', NULL, '2025-09-27 22:40:11'),
('281', '1', '14', 'Search Faculty', 'Searched for name: fa', 'users', NULL, NULL, '2025-09-27 22:40:29'),
('282', '1', '14', 'Search Faculty', 'Searched for name: ro', 'users', NULL, NULL, '2025-09-27 22:40:34'),
('283', '1', '14', 'Search Faculty', 'Searched for name: rowe', 'users', NULL, NULL, '2025-09-27 22:46:29'),
('284', '1', '14', 'Search Faculty', 'Searched for name: rowel', 'users', NULL, NULL, '2025-09-27 22:46:29'),
('285', '1', '14', 'Search Faculty', 'Searched for name: ba', 'users', NULL, NULL, '2025-09-27 22:46:54'),
('286', '1', '14', 'Add Faculty', 'Added faculty user_id=32 to department_id=14, is_active=1', 'faculty_departments', '0', NULL, '2025-09-27 22:47:03'),
('287', '1', '14', 'View Faculty Details', 'Viewed details for user_id=20', 'users', '20', NULL, '2025-09-27 22:47:31'),
('288', '1', '14', 'Remove Faculty', 'Deactivated faculty user_id=20 in department_id=14, is_active=0', 'faculty_departments', '1', NULL, '2025-09-27 22:49:10'),
('289', '1', '14', 'Search Faculty', 'Searched for name: rowel', 'users', NULL, NULL, '2025-09-27 22:49:48'),
('290', '1', '14', 'Remove Faculty', 'Removed faculty user_id=20 from department_id=14', 'faculty_departments', '1', NULL, '2025-09-27 23:09:35'),
('291', '1', '14', 'Search Faculty', 'Searched for name: ro', 'users', NULL, NULL, '2025-09-27 23:09:41'),
('292', '1', '14', 'Search Faculty', 'Searched for name: rowel', 'users', NULL, NULL, '2025-09-27 23:09:42'),
('293', '1', '14', 'Add Faculty', 'Added faculty username=Batman to department_id=14', 'faculty_departments', '0', NULL, '2025-09-27 23:09:48'),
('294', '1', '14', 'Search Faculty', 'Searched for name: dar', 'users', NULL, NULL, '2025-09-27 23:09:51'),
('295', '1', '14', 'Add Faculty', 'Added faculty username=Batman to department_id=14', 'faculty_departments', '0', NULL, '2025-09-27 23:09:56'),
('296', '1', '14', 'Search Faculty', 'Searched for name: da', 'users', NULL, NULL, '2025-09-27 23:10:01'),
('297', '1', '14', 'Add Faculty', 'Added faculty username=Batman to department_id=14', 'faculty_departments', '0', NULL, '2025-09-27 23:10:17'),
('298', '1', '14', 'Search Faculty', 'Searched for name: da', 'users', NULL, NULL, '2025-09-27 23:10:20'),
('299', '1', '14', 'Add Faculty', 'Added faculty username=Batman to department_id=14', 'faculty_departments', '0', NULL, '2025-09-27 23:10:25'),
('300', '1', '14', 'Search Faculty', 'Searched for name: jos', 'users', NULL, NULL, '2025-09-27 23:10:34'),
('301', '1', '14', 'Add Faculty', 'Added faculty username=Batman to department_id=14', 'faculty_departments', '0', NULL, '2025-09-27 23:10:41'),
('302', '1', '14', 'Search Faculty', 'Searched for name: ju', 'users', NULL, NULL, '2025-09-27 23:10:46'),
('303', '1', '14', 'Add Faculty', 'Added faculty username=Batman to department_id=14', 'faculty_departments', '0', NULL, '2025-09-27 23:10:50'),
('304', '1', '14', 'Search Faculty', 'Searched for name: geo', 'users', NULL, NULL, '2025-09-27 23:11:04'),
('305', '1', '14', 'Search Faculty', 'Searched for name: geof', 'users', NULL, NULL, '2025-09-27 23:11:04'),
('306', '1', '14', 'Search Faculty', 'Searched for name: geo', 'users', NULL, NULL, '2025-09-27 23:12:50'),
('307', '1', '14', 'Search Faculty', 'Searched for name: geo', 'users', NULL, NULL, '2025-09-27 23:15:12'),
('308', '1', '14', 'Search Faculty', 'Searched for name: geof', 'users', NULL, NULL, '2025-09-27 23:15:12'),
('309', '1', '14', 'Add Faculty', 'Added faculty username=Batman to department_id=14', 'faculty_departments', '0', NULL, '2025-09-27 23:15:17'),
('310', '1', '14', 'Search Faculty', 'Searched for name: me', 'users', NULL, NULL, '2025-09-27 23:15:33'),
('311', '1', '14', 'Add Faculty', 'Added faculty username=Batman to department_id=14', 'faculty_departments', '0', NULL, '2025-09-27 23:15:42'),
('312', '1', '14', 'Search Faculty', 'Searched for name: ro', 'users', NULL, NULL, '2025-09-27 23:15:51'),
('313', '1', '14', 'Search Faculty', 'Searched for name: ron', 'users', NULL, NULL, '2025-09-27 23:15:51'),
('314', '1', '14', 'Search Faculty', 'Searched for name: ca', 'users', NULL, NULL, '2025-09-27 23:15:59'),
('315', '1', '14', 'Search Faculty', 'Searched for name: cab', 'users', NULL, NULL, '2025-09-27 23:15:59'),
('316', '1', '14', 'Search Faculty', 'Searched for name: ca', 'users', NULL, NULL, '2025-09-27 23:16:01'),
('317', '1', '14', 'View Faculty Details', 'Viewed details for user_id=24', 'users', '24', NULL, '2025-09-27 23:36:37'),
('318', '1', '14', 'View Faculty Details', 'Viewed details for user_id=24', 'users', '24', NULL, '2025-09-27 23:52:20'),
('319', '1', '14', 'View Faculty Details', 'Viewed details for user_id=33', 'users', '33', NULL, '2025-09-27 23:52:30'),
('320', '1', '14', 'View Faculty Details', 'Viewed details for user_id=24', 'users', '24', NULL, '2025-09-27 23:54:49'),
('321', '1', '14', 'Add Classroom', 'Added classroom sssdg', 'classrooms', '19', NULL, '2025-09-29 15:54:47'),
('322', '1', '14', 'Edit Classroom', 'Edited classroom CCIT Lec 15', 'classrooms', '15', NULL, '2025-09-29 18:16:47'),
('323', '1', '14', 'Edit Classroom', 'Edited classroom IT Lab 1', 'classrooms', '5', NULL, '2025-09-29 18:51:55'),
('324', '1', '14', 'Edit Classroom', 'Edited classroom IT Lab 2', 'classrooms', '6', NULL, '2025-09-29 18:52:06'),
('325', '1', '14', 'Edit Classroom', 'Edited classroom IT Lab 3', 'classrooms', '7', NULL, '2025-09-29 18:52:16'),
('326', '1', '14', 'Edit Classroom', 'Edited classroom IT101', 'classrooms', '1', NULL, '2025-09-29 18:59:45'),
('327', '1', '14', 'Edit Classroom', 'Edited classroom Room 3', 'classrooms', '18', NULL, '2025-09-29 19:04:01'),
('328', '1', '14', 'Edit Classroom', 'Edited classroom Room 2', 'classrooms', '16', NULL, '2025-09-29 19:04:09'),
('329', '1', '14', 'Edit Classroom', 'Edited classroom Room 10', 'classrooms', '14', NULL, '2025-09-29 19:04:21'),
('330', '1', '14', 'Edit Classroom', 'Edited classroom Room 1', 'classrooms', '17', NULL, '2025-09-29 19:04:29'),
('331', '1', '14', 'Edit Classroom', 'Edited classroom IT102', 'classrooms', '2', NULL, '2025-09-29 19:04:45'),
('332', '1', '14', 'Edit Classroom', 'Edited classroom IT202', 'classrooms', '4', NULL, '2025-09-29 19:04:53'),
('333', '1', '14', 'Edit Classroom', 'Edited classroom Laboratory 1', 'classrooms', '3', NULL, '2025-09-29 19:04:59'),
('334', '1', '14', 'View Faculty Details', 'Viewed details for user_id=24', 'users', '24', NULL, '2025-09-29 19:05:29'),
('335', '1', '14', 'Edit Classroom', 'Edited classroom CCIT Lec 15', 'classrooms', '15', NULL, '2025-09-29 21:04:25'),
('336', '1', '14', 'Edit Classroom', 'Edited classroom CCIT Lec 15', 'classrooms', '15', NULL, '2025-09-29 21:21:24'),
('337', '1', '14', 'Edit Classroom', 'Edited classroom CCIT Lec 15', 'classrooms', '15', NULL, '2025-09-29 21:21:29'),
('338', '1', '14', 'Edit Classroom', 'Edited classroom CCIT Lec 15', 'classrooms', '15', NULL, '2025-09-29 21:21:33'),
('339', '1', '14', 'Include Room', 'Included room_id=8', 'classroom_departments', '1', NULL, '2025-09-29 21:53:10'),
('340', '1', '14', 'Remove Room', 'Removed room_id=8', 'classroom_departments', '1', NULL, '2025-09-29 21:54:33'),
('341', '1', '14', 'View Faculty Details', 'Viewed details for user_id=24', 'users', '24', NULL, '2025-10-01 19:47:38'),
('342', '1', '14', 'View Faculty Details', 'Viewed details for user_id=1', 'users', '1', NULL, '2025-10-01 19:47:42'),
('343', '1', '14', 'View Faculty Details', 'Viewed details for user_id=22', 'users', '22', NULL, '2025-10-01 19:47:44'),
('344', '1', '14', 'View Faculty Details', 'Viewed details for user_id=24', 'users', '24', NULL, '2025-10-02 15:21:47'),
('345', '1', '14', 'View Faculty Details', 'Viewed details for user_id=33', 'users', '33', NULL, '2025-10-02 16:46:16'),
('346', '1', '14', 'View Faculty Details', 'Viewed details for user_id=1', 'users', '1', NULL, '2025-10-02 16:46:20'),
('347', '2', '14', 'Deactivate User', 'Deactivated user ID 49', 'users', '49', NULL, '2025-10-05 00:00:04'),
('348', '2', '14', 'Deactivate User', 'Deactivated user ID 49', 'users', '49', NULL, '2025-10-05 00:00:04'),
('349', '2', '17', 'Deactivate User', 'Deactivated user ID 26', 'users', '26', NULL, '2025-10-05 00:09:43'),
('350', '2', '17', 'Deactivate User', 'Deactivated user ID 26', 'users', '26', NULL, '2025-10-05 00:09:43'),
('351', '2', '17', 'Activate User', 'Activated user ID 26', 'users', '26', NULL, '2025-10-05 00:10:35'),
('352', '2', '17', 'Activate User', 'Activated user ID 26', 'users', '26', NULL, '2025-10-05 00:10:39'),
('353', '2', '17', 'Demote User', 'Demoted user ID 26 to Faculty', 'users', '26', NULL, '2025-10-05 00:10:42'),
('354', '2', '17', 'Promote User', 'Promoted user ID 26 to Program Chair for program ID 2', 'users', '26', NULL, '2025-10-05 00:11:05'),
('355', '2', '14', 'Demote User', 'Demoted user ID 1 to Faculty', 'users', '1', NULL, '2025-10-05 00:42:23'),
('356', '1', '14', 'View Faculty Details', 'Viewed details for user_id=1', 'users', '1', NULL, '2025-10-05 10:49:53'),
('357', '1', '14', 'Edit Classroom', 'Edited classroom Laboratory 1', 'classrooms', '3', NULL, '2025-10-07 20:22:41'),
('358', '26', '17', 'View Faculty Details', 'Viewed details for user_id=26', 'users', '26', NULL, '2025-10-07 21:24:50'),
('359', '26', '17', 'Toggle Curriculum Status', 'Toggled curriculum ID 7 to Active', 'curricula', '7', NULL, '2025-10-07 22:17:00'),
('360', '26', '17', 'View Faculty Details', 'Viewed details for user_id=26', 'users', '26', NULL, '2025-10-07 22:20:56'),
('361', '1', '14', 'View Faculty Details', 'Viewed details for user_id=32', 'users', '32', NULL, '2025-10-08 09:51:57'),
('362', '1', '14', 'View Faculty Details', 'Viewed details for user_id=23', 'users', '23', NULL, '2025-10-08 09:52:01'),
('363', '1', '14', 'Add Classroom', 'Added classroom Room 1', 'classrooms', '1', NULL, '2025-10-12 18:46:12'),
('364', '1', '14', 'Add Classroom', 'Added classroom Room 2', 'classrooms', '4', NULL, '2025-10-12 18:47:42'),
('365', '1', '14', 'Add Classroom', 'Added classroom Room 3', 'classrooms', '5', NULL, '2025-10-12 18:48:03'),
('366', '1', '14', 'Add Classroom', 'Added classroom Room 4', 'classrooms', '6', NULL, '2025-10-12 18:48:55'),
('367', '1', '14', 'Add Classroom', 'Added classroom Room 8', 'classrooms', '7', NULL, '2025-10-12 18:49:22'),
('368', '1', '14', 'Add Classroom', 'Added classroom Laboratory 1', 'classrooms', '8', NULL, '2025-10-12 18:50:40'),
('369', '1', '14', 'Add Classroom', 'Added classroom Laboratory 2', 'classrooms', '9', NULL, '2025-10-12 18:51:25'),
('370', '1', '14', 'Add Classroom', 'Added classroom Laboratory 3', 'classrooms', '10', NULL, '2025-10-12 18:51:58'),
('371', '1', '14', 'Search Faculty', 'Searched for name: fei', 'users', NULL, NULL, '2025-10-13 23:18:55'),
('372', '1', '14', 'Search Faculty', 'Searched for name: Sir', 'users', NULL, NULL, '2025-10-13 23:19:05'),
('373', '1', '14', 'Search Faculty', 'Searched for name: Sir', 'users', NULL, NULL, '2025-10-13 23:19:06'),
('374', '1', '14', 'Search Faculty', 'Searched for name: Si', 'users', NULL, NULL, '2025-10-13 23:19:08'),
('375', '1', '14', 'Search Faculty', 'Searched for name: Feil', 'users', NULL, NULL, '2025-10-13 23:19:13'),
('376', '1', '14', 'Search Faculty', 'Searched for name: Fi', 'users', NULL, NULL, '2025-10-13 23:19:34'),
('377', '1', '14', 'Add Faculty', 'Added faculty username=Batman to department_id=14', 'faculty_departments', '0', NULL, '2025-10-13 23:19:54'),
('378', '1', '14', 'View Faculty Details', 'Viewed details for user_id=38', 'users', '38', NULL, '2025-10-13 23:20:02'),
('379', '26', '17', 'Add Classroom', 'Added classroom Room 5', 'classrooms', '11', NULL, '2025-10-14 10:25:31'),
('380', '26', '17', 'Add Classroom', 'Added classroom Lab 4', 'classrooms', '12', NULL, '2025-10-14 10:26:29'),
('381', '26', '17', 'Add Classroom', 'Added classroom Room 6', 'classrooms', '13', NULL, '2025-10-14 10:26:57'),
('382', '1', '14', 'Edit Classroom', 'Edited classroom Room 1', 'classrooms', '1', NULL, '2025-10-14 10:28:04'),
('383', '26', '17', 'Include Room', 'Included room_id=1', 'classroom_departments', '2', NULL, '2025-10-14 10:28:28'),
('384', '2', '14', 'Activate User', 'Activated user ID 49', 'users', '49', NULL, '2025-10-15 07:43:23'),
('385', '2', '14', 'Activate User', 'Activated user ID 49', 'users', '49', NULL, '2025-10-15 07:43:27'),
('386', '2', '14', 'Activate User', 'Activated user ID 49', 'users', '49', NULL, '2025-10-15 07:43:29'),
('387', '1', '14', 'Search Faculty', 'Searched for name: hello', 'users', NULL, NULL, '2025-10-18 17:54:06'),
('388', '1', '14', 'Add Faculty', 'Added faculty username=Batman to department_id=14', 'faculty_departments', '0', NULL, '2025-10-18 17:54:20'),
('389', '1', '14', 'View Faculty Details', 'Viewed details for user_id=24', 'users', '24', NULL, '2025-10-18 18:22:19'),
('390', '1', '14', 'View Faculty Details', 'Viewed details for user_id=1', 'users', '1', NULL, '2025-10-18 18:22:24'),
('391', '1', '14', 'View Faculty Details', 'Viewed details for user_id=49', 'users', '49', NULL, '2025-10-22 21:59:28'),
('392', '1', '14', 'Remove Faculty', 'Removed faculty user_id=49 from department_id=14', 'faculty_departments', '13', NULL, '2025-10-22 21:59:39'),
('393', '69', '7', 'Search Faculty', 'Searched for name: ge', 'users', NULL, NULL, '2025-10-22 22:45:20'),
('394', '69', '7', 'Search Faculty', 'Searched for name: geof', 'users', NULL, NULL, '2025-10-22 22:45:20'),
('395', '1', '14', 'Search Faculty', 'Searched for name: ma', 'users', NULL, NULL, '2025-10-23 13:36:53'),
('396', '1', '14', 'Search Faculty', 'Searched for name: maa', 'users', NULL, NULL, '2025-10-23 13:36:57'),
('397', '1', '14', 'Add Faculty', 'Added faculty username=Batman to department_id=14', 'faculty_departments', '0', NULL, '2025-10-23 13:37:22'),
('398', '1', '14', 'Remove Faculty', 'Removed faculty user_id=68 from department_id=14', 'faculty_departments', '14', NULL, '2025-10-23 20:20:49'),
('399', '2', '17', 'Activate User', 'Activated user ID 67', 'users', '67', NULL, '2025-10-24 23:13:12'),
('400', '69', '7', 'Search Faculty', 'Searched for name: ge', 'users', NULL, NULL, '2025-10-25 19:10:05'),
('401', '69', '7', 'Search Faculty', 'Searched for name: geo', 'users', NULL, NULL, '2025-10-25 19:10:05'),
('402', '69', '7', 'Search Faculty', 'Searched for name: geof', 'users', NULL, NULL, '2025-10-25 19:10:06'),
('403', '69', '7', 'Add Faculty', 'Added faculty username=Teacher to department_id=7', 'faculty_departments', '0', NULL, '2025-10-25 19:10:13'),
('404', '69', '7', 'Remove Faculty', 'Removed faculty user_id=1 from department_id=7', 'faculty_departments', '15', NULL, '2025-10-25 19:10:42'),
('405', '69', '7', 'Search Faculty', 'Searched for name: ge', 'users', NULL, NULL, '2025-10-25 21:16:11'),
('406', '69', '7', 'Add Faculty', 'Added faculty username=Teacher to department_id=7', 'faculty_departments', '0', NULL, '2025-10-25 21:16:17'),
('407', '69', '7', 'View Faculty Details', 'Viewed details for user_id=1', 'users', '1', NULL, '2025-10-25 21:16:36'),
('408', '69', '7', 'Remove Faculty', 'Removed faculty user_id=1 from department_id=7', 'faculty_departments', '16', NULL, '2025-10-25 21:16:42'),
('409', '69', '7', 'Add Curriculum', 'Added curriculum ID 12', 'curricula', '12', NULL, '2025-10-25 21:19:20'),
('410', '69', '7', 'Search Faculty', 'Searched for name: ge', 'users', NULL, NULL, '2025-10-25 21:22:19'),
('411', '69', '7', 'Search Faculty', 'Searched for name: geo', 'users', NULL, NULL, '2025-10-25 21:22:20'),
('412', '69', '8', 'Add Faculty', 'Added faculty username=Teacher to department_id=8', 'faculty_departments', '0', NULL, '2025-10-25 21:22:28'),
('413', '69', '8', 'View Faculty Details', 'Viewed details for user_id=1', 'users', '1', NULL, '2025-10-25 21:22:30'),
('414', '69', '7', 'Search Faculty', 'Searched for name: te', 'users', NULL, NULL, '2025-10-25 21:22:39'),
('415', '69', '7', 'Search Faculty', 'Searched for name: tes', 'users', NULL, NULL, '2025-10-25 21:22:40'),
('416', '69', '7', 'Search Faculty', 'Searched for name: test', 'users', NULL, NULL, '2025-10-25 21:22:43'),
('417', '69', '7', 'Search Faculty', 'Searched for name: te', 'users', NULL, NULL, '2025-10-25 21:22:45'),
('418', '69', '8', 'Remove Faculty', 'Removed faculty user_id=1 from department_id=8', 'faculty_departments', '17', NULL, '2025-10-25 21:22:59'),
('419', '69', '7', 'Search Faculty', 'Searched for name: gh', 'users', NULL, NULL, '2025-10-27 11:43:29'),
('420', '69', '7', 'Search Faculty', 'Searched for name: geof', 'users', NULL, NULL, '2025-10-27 11:43:31'),
('421', '69', '8', 'Add Faculty', 'Added faculty username=Teacher to department_id=8', 'faculty_departments', '0', NULL, '2025-10-27 11:43:42'),
('422', '69', '8', 'Remove Faculty', 'Removed faculty user_id=1 from department_id=8', 'faculty_departments', '18', NULL, '2025-10-27 17:30:43'),
('423', '70', '12', 'Search Faculty', 'Searched for name: go', 'users', NULL, NULL, '2025-10-27 23:46:41'),
('424', '70', '12', 'Add Faculty', 'Added faculty username=67 to department_id=12', 'faculty_departments', '0', NULL, '2025-10-27 23:46:47'),
('425', '70', '12', 'Remove Faculty', 'Removed faculty user_id=20 from department_id=12', 'faculty_departments', '19', NULL, '2025-10-27 23:47:24'),
('426', '1', '14', 'Search Faculty', 'Searched for name: con', 'users', NULL, NULL, '2025-10-28 22:46:16'),
('427', '1', '14', 'Add Faculty', 'Added faculty username=Batman to department_id=14', 'faculty_departments', '0', NULL, '2025-10-28 22:46:23'),
('428', '1', '14', 'Remove Faculty', 'Removed faculty user: Dr. Geoffrey Sepillo from department_id=14', 'faculty_departments', '20', NULL, '2025-10-28 22:48:11'),
('429', '70', '12', 'Search Faculty', 'Searched for name: ge', 'users', NULL, NULL, '2025-10-28 22:49:10'),
('430', '70', '12', 'Add Faculty', 'Added faculty username=67 to department_id=12', 'faculty_departments', '0', NULL, '2025-10-28 22:55:23'),
('431', '70', '12', 'Remove Faculty', 'Removed faculty user: maam con qwfew from department_id=12', 'faculty_departments', '21', NULL, '2025-10-28 22:56:11'),
('432', '1', '14', 'View Faculty Details', 'Viewed details for user: Dr. Geoffrey Sepillo', 'users', '24', NULL, '2025-11-02 22:34:54'),
('433', '1', '14', 'View Faculty Details', 'Viewed details for user: Dr. Geoffrey Sepillo', 'users', '32', NULL, '2025-11-02 22:35:00'),
('434', '1', '14', 'View Faculty Details', 'Viewed details for user: Dr. Geoffrey Sepillo', 'users', '38', NULL, '2025-11-02 22:35:19'),
('435', '1', '14', 'View Faculty Details', 'Viewed details for user: Dr. Geoffrey Sepillo', 'users', '28', NULL, '2025-11-02 22:35:30'),
('436', '1', '14', 'View Faculty Details', 'Viewed details for user: Dr. Geoffrey Sepillo', 'users', '33', NULL, '2025-11-02 22:35:40'),
('437', '1', '14', 'View Faculty Details', 'Viewed details for user: Dr. Geoffrey Sepillo', 'users', '1', NULL, '2025-11-02 22:35:45'),
('438', '1', '14', 'View Faculty Details', 'Viewed details for user: Dr. Geoffrey Sepillo', 'users', '24', NULL, '2025-11-02 23:07:14'),
('439', '1', '14', 'View Faculty Details', 'Viewed details for user: Dr. Geoffrey Sepillo', 'users', '32', NULL, '2025-11-02 23:08:12'),
('440', '1', '14', 'View Faculty Details', 'Viewed details for user: Dr. Geoffrey Sepillo', 'users', '32', NULL, '2025-11-02 23:08:50'),
('441', '1', '14', 'View Faculty Details', 'Viewed details for user: Dr. Geoffrey Sepillo', 'users', '22', NULL, '2025-11-02 23:13:38'),
('442', '1', '14', 'View Faculty Details', 'Viewed details for user: Dr. Geoffrey Sepillo', 'users', '24', NULL, '2025-11-02 23:29:38'),
('443', '1', '14', 'View Faculty Details', 'Viewed details for user: Dr. Geoffrey Sepillo', 'users', '24', NULL, '2025-11-02 23:29:45'),
('444', '1', '14', 'View Faculty Details', 'Viewed details for user: Dr. Geoffrey Sepillo', 'users', '24', NULL, '2025-11-02 23:29:48'),
('445', '1', '14', 'View Faculty Details', 'Viewed details for user: Dr. Geoffrey Sepillo', 'users', '33', NULL, '2025-11-03 00:34:24'),
('446', '1', '14', 'View Faculty Details', 'Viewed details for user: Dr. Geoffrey Sepillo', 'users', '22', NULL, '2025-11-03 00:34:30'),
('447', '1', '14', 'View Faculty Details', 'Viewed details for user: Dr. Geoffrey Sepillo', 'users', '24', NULL, '2025-11-03 00:39:17'),
('448', '1', '14', 'View Faculty Details', 'Viewed details for user: Dr. Geoffrey Sepillo', 'users', '24', NULL, '2025-11-03 00:39:20'),
('449', '1', '14', 'View Faculty Details', 'Viewed details for user: Dr. Geoffrey Sepillo', 'users', '24', NULL, '2025-11-03 01:00:38'),
('450', '1', '14', 'Toggle Curriculum Status', 'Toggled curriculum ID 8 to Active', 'curricula', '8', NULL, '2025-11-03 23:24:17'),
('451', '1', '14', 'Toggle Curriculum Status', 'Toggled curriculum ID 8 to Draft', 'curricula', '8', NULL, '2025-11-03 23:24:20'),
('452', '1', '14', 'Add Curriculum', 'Added curriculum ID 13', 'curricula', '13', NULL, '2025-11-04 01:41:50'),
('453', '1', '14', 'Add Course', 'Added course ID 112', 'courses', '112', NULL, '2025-11-04 01:51:35'),
('454', '1', '14', 'Add Course', 'Added course ID 113', 'courses', '113', NULL, '2025-11-04 02:01:54'),
('455', '1', '14', 'Add Course', 'Added course ID 114', 'courses', '114', NULL, '2025-11-04 02:05:35'),
('456', '1', '14', 'Add Course', 'Added course ID 115', 'courses', '115', NULL, '2025-11-04 02:16:36'),
('457', '1', '14', 'Add Course', 'Added course ID 116', 'courses', '116', NULL, '2025-11-04 02:18:17'),
('458', '1', '14', 'Add Course', 'Added course ID 117', 'courses', '117', NULL, '2025-11-04 02:23:17'),
('459', '1', '14', 'Add Course', 'Added course ID 118', 'courses', '118', NULL, '2025-11-04 02:25:09'),
('460', '1', '14', 'Add Course', 'Added course ID 119', 'courses', '119', NULL, '2025-11-04 02:34:01'),
('461', '1', '14', 'Update Course', 'Updated course ID 117', 'courses', '117', NULL, '2025-11-04 02:34:55'),
('462', '1', '14', 'Add Course', 'Added course ID 120', 'courses', '120', NULL, '2025-11-04 02:37:52'),
('463', '1', '14', 'Add Course', 'Added course ID 121', 'courses', '121', NULL, '2025-11-04 02:39:38'),
('464', '1', '14', 'Update Course', 'Updated course ID 117', 'courses', '117', NULL, '2025-11-04 02:39:43'),
('465', '1', '14', 'Add Course', 'Added course ID 122', 'courses', '122', NULL, '2025-11-04 02:42:45'),
('466', '1', '14', 'Add Course', 'Added course ID 123', 'courses', '123', NULL, '2025-11-04 02:46:02'),
('467', '1', '14', 'Add Course', 'Added course ID 124', 'courses', '124', NULL, '2025-11-04 02:47:44'),
('468', '1', '14', 'Update Course', 'Updated course ID 113', 'courses', '113', NULL, '2025-11-04 03:04:16'),
('469', '1', '14', 'Add Course', 'Added course ID 125', 'courses', '125', NULL, '2025-11-04 03:14:46'),
('470', '1', '14', 'Toggle Curriculum Status', 'Toggled curriculum ID 13 to Active', 'curricula', '13', NULL, '2025-11-04 03:22:11'),
('471', '1', '14', 'Toggle Curriculum Status', 'Toggled curriculum ID 8 to Active', 'curricula', '8', NULL, '2025-11-04 03:45:31'),
('472', '1', '14', 'Toggle Curriculum Status', 'Toggled curriculum ID 8 to Draft', 'curricula', '8', NULL, '2025-11-04 03:45:33'),
('473', '1', '14', 'Toggle Curriculum Status', 'Toggled curriculum ID 8 to Active', 'curricula', '8', NULL, '2025-11-04 04:01:23'),
('474', '1', '14', 'Toggle Curriculum Status', 'Toggled curriculum ID 8 to Draft', 'curricula', '8', NULL, '2025-11-04 04:01:27'),
('475', '1', '14', 'Toggle Curriculum Status', 'Toggled curriculum ID 13 to Draft', 'curricula', '13', NULL, '2025-11-04 05:41:35'),
('476', '1', '14', 'Toggle Curriculum Status', 'Toggled curriculum ID 13 to Active', 'curricula', '13', NULL, '2025-11-04 05:43:18'),
('477', '1', '14', 'Toggle Curriculum Status', 'Toggled curriculum ID 13 to Draft', 'curricula', '13', NULL, '2025-11-04 05:46:32'),
('478', '1', '14', 'Toggle Curriculum Status', 'Toggled curriculum ID 13 to Active', 'curricula', '13', NULL, '2025-11-04 05:59:03'),
('479', '1', '14', 'Toggle Curriculum Status', 'Toggled curriculum ID 13 to Draft', 'curricula', '13', NULL, '2025-11-04 06:00:02');

--
-- Table structure for table `admission_departments`
--

DROP TABLE IF EXISTS `admission_departments`;
CREATE TABLE `admission_departments` (
  `admission_dept_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `admission_id` int(10) unsigned NOT NULL,
  `department_id` smallint(5) unsigned NOT NULL,
  `is_primary` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`admission_dept_id`),
  UNIQUE KEY `unique_admission_department` (`admission_id`,`department_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `admission_departments_ibfk_1` FOREIGN KEY (`admission_id`) REFERENCES `admissions` (`admission_id`) ON DELETE CASCADE,
  CONSTRAINT `admission_departments_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admission_departments`
--

INSERT INTO `admission_departments` (`admission_dept_id`, `admission_id`, `department_id`, `is_primary`) VALUES 
('1', '1', '12', '1');

--
-- Table structure for table `admission_roles`
--

DROP TABLE IF EXISTS `admission_roles`;
CREATE TABLE `admission_roles` (
  `admission_role_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `admission_id` int(10) unsigned NOT NULL,
  `role_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`admission_role_id`),
  UNIQUE KEY `unique_admission_role` (`admission_id`,`role_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `admission_roles_ibfk_1` FOREIGN KEY (`admission_id`) REFERENCES `admissions` (`admission_id`) ON DELETE CASCADE,
  CONSTRAINT `admission_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admission_roles`
--

INSERT INTO `admission_roles` (`admission_role_id`, `admission_id`, `role_id`) VALUES 
('1', '1', '4'),
('2', '1', '5');

--
-- Table structure for table `admissions`
--

DROP TABLE IF EXISTS `admissions`;
CREATE TABLE `admissions` (
  `admission_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(20) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(60) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `title` enum('Mr.','Mrs.','Ms.','Miss','Mx.','Dr.','Prof.') DEFAULT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) NOT NULL,
  `suffix` varchar(10) DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `role_id` tinyint(3) unsigned NOT NULL,
  `department_id` smallint(5) unsigned DEFAULT NULL,
  `college_id` smallint(5) unsigned NOT NULL,
  `academic_rank` varchar(100) DEFAULT NULL,
  `employment_type` varchar(50) DEFAULT NULL,
  `classification` varchar(10) DEFAULT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `rejection_reason` text DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `reviewed_by` int(10) unsigned DEFAULT NULL,
  `terms_accepted` tinyint(1) DEFAULT 0,
  `terms_accepted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`admission_id`),
  UNIQUE KEY `unique_employee_id` (`employee_id`),
  UNIQUE KEY `unique_username` (`username`),
  UNIQUE KEY `unique_email` (`email`),
  KEY `role_id` (`role_id`),
  KEY `department_id` (`department_id`),
  KEY `college_id` (`college_id`),
  KEY `reviewed_by` (`reviewed_by`),
  CONSTRAINT `admissions_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`),
  CONSTRAINT `admissions_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`),
  CONSTRAINT `admissions_ibfk_3` FOREIGN KEY (`college_id`) REFERENCES `colleges` (`college_id`),
  CONSTRAINT `admissions_ibfk_4` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admissions`
--

INSERT INTO `admissions` (`admission_id`, `employee_id`, `username`, `password_hash`, `email`, `phone`, `title`, `first_name`, `middle_name`, `last_name`, `suffix`, `profile_picture`, `role_id`, `department_id`, `college_id`, `academic_rank`, `employment_type`, `classification`, `status`, `rejection_reason`, `submitted_at`, `reviewed_at`, `reviewed_by`, `terms_accepted`, `terms_accepted_at`) VALUES 
('1', '0026', 'penek', '$2y$10$bEbuDML2BV7oJFQNvZKzfeu5HOWXIWRXP3Wfhe49R4FimMvxGzZdG', 'penek@hotmilk.com', '', NULL, 'penek', 'penek', 'penek', '', NULL, '4', '12', '5', 'Professor I', 'Regular', 'TL', 'approved', NULL, '2025-11-02 22:04:17', '2025-11-02 22:08:03', '45', '0', NULL);

--
-- Table structure for table `auth_logs`
--

DROP TABLE IF EXISTS `auth_logs`;
CREATE TABLE `auth_logs` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `action` varchar(50) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  `identifier` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`log_id`),
  KEY `fk_auth_logs_user` (`user_id`),
  CONSTRAINT `fk_auth_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=387 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_logs`
--

INSERT INTO `auth_logs` (`log_id`, `user_id`, `action`, `ip_address`, `user_agent`, `identifier`, `created_at`) VALUES 
('1', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-09 20:36:59'),
('2', '65', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-10 20:42:50'),
('3', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', NULL, '2025-10-10 21:30:47'),
('4', '2', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-11 11:41:12'),
('5', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '76s5p2b0241ev9uqht2boion54', '2025-10-11 11:41:12'),
('6', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-11 16:07:43'),
('7', '2', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', NULL, '2025-10-11 16:08:11'),
('8', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'pr1vffjugkdi7qm1ebhbsajf5h', '2025-10-11 16:08:11'),
('9', '65', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0', NULL, '2025-10-11 16:09:55'),
('10', '65', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-11 16:41:37'),
('11', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-11 16:44:41'),
('12', '65', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-11 16:45:53'),
('13', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-11 17:59:21'),
('14', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-11 21:14:38'),
('15', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-12 17:25:15'),
('16', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-12 21:01:50'),
('17', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-13 20:45:57'),
('18', '18', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-13 23:20:57'),
('19', '26', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-13 23:25:29'),
('20', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-14 09:51:29'),
('21', '26', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-14 10:23:49'),
('22', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-14 10:27:53'),
('23', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-14 17:09:49'),
('24', '65', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-14 17:10:00'),
('25', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-14 17:10:27'),
('26', '59', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-14 23:03:33'),
('27', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-14 23:34:50'),
('28', '2', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-15 07:34:33'),
('29', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '7ouu3i0uvf4bu7m69s823l4jum', '2025-10-15 07:34:34'),
('30', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '7ouu3i0uvf4bu7m69s823l4jum', '2025-10-15 07:46:08'),
('31', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '7ouu3i0uvf4bu7m69s823l4jum', '2025-10-15 07:55:30'),
('32', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '7ouu3i0uvf4bu7m69s823l4jum', '2025-10-15 07:55:36'),
('33', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '7ouu3i0uvf4bu7m69s823l4jum', '2025-10-15 08:00:42'),
('34', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '7ouu3i0uvf4bu7m69s823l4jum', '2025-10-15 08:00:44'),
('35', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '7ouu3i0uvf4bu7m69s823l4jum', '2025-10-15 08:00:59'),
('36', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '7ouu3i0uvf4bu7m69s823l4jum', '2025-10-15 08:01:22'),
('37', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '7ouu3i0uvf4bu7m69s823l4jum', '2025-10-15 08:01:26'),
('38', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '7ouu3i0uvf4bu7m69s823l4jum', '2025-10-15 10:14:27'),
('39', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '7ouu3i0uvf4bu7m69s823l4jum', '2025-10-15 10:14:53'),
('40', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-15 10:15:25'),
('41', '59', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-15 23:31:02'),
('42', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-15 23:34:09'),
('43', '2', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-15 23:34:24'),
('44', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2va47avmu0prvcrcvtkaghv6qb', '2025-10-15 23:34:24'),
('45', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2va47avmu0prvcrcvtkaghv6qb', '2025-10-15 23:34:59'),
('46', '65', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-15 23:35:30'),
('47', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-15 23:38:14'),
('48', '65', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-16 09:37:05'),
('49', '2', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-16 09:40:15'),
('50', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'pq5c43o1kk8stdfohlist696an', '2025-10-16 09:40:15'),
('51', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'pq5c43o1kk8stdfohlist696an', '2025-10-16 09:49:00'),
('52', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'pq5c43o1kk8stdfohlist696an', '2025-10-16 12:01:37'),
('53', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-16 12:01:48'),
('54', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-18 17:03:58'),
('55', '49', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-18 17:47:36'),
('56', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-18 17:54:00'),
('57', '65', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-18 17:59:12'),
('58', '2', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-18 18:13:16'),
('59', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'h6f0rso93ki5qfukpmkeacm4oj', '2025-10-18 18:13:16'),
('60', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'h6f0rso93ki5qfukpmkeacm4oj', '2025-10-18 18:16:24'),
('61', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'h6f0rso93ki5qfukpmkeacm4oj', '2025-10-18 18:19:09'),
('62', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'h6f0rso93ki5qfukpmkeacm4oj', '2025-10-18 18:19:23'),
('63', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-18 21:19:29'),
('64', '59', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-18 21:19:39'),
('65', '18', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-18 21:19:49'),
('66', '49', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-18 21:20:00'),
('67', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-18 21:29:49'),
('68', '2', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-18 21:38:38'),
('69', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'qpk3k3poeh6ma2ompsc0j5c16b', '2025-10-18 21:38:39'),
('70', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'qpk3k3poeh6ma2ompsc0j5c16b', '2025-10-18 21:52:09'),
('71', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'qpk3k3poeh6ma2ompsc0j5c16b', '2025-10-18 21:52:22'),
('72', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'qpk3k3poeh6ma2ompsc0j5c16b', '2025-10-18 21:52:57'),
('73', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-20 11:36:10'),
('74', '59', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-20 11:46:16'),
('75', '49', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-20 11:46:26'),
('76', '2', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-20 11:48:30'),
('77', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'q72m1pu080pql8nvjjv51f5vdf', '2025-10-20 11:48:30'),
('78', '65', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-20 11:49:15'),
('79', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-20 11:50:11'),
('80', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-21 20:58:25'),
('81', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-21 20:59:09'),
('82', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-21 21:04:00'),
('83', NULL, 'request_submitted', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '67', '2025-10-21 21:09:55'),
('84', NULL, 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-21 21:10:37'),
('85', NULL, 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'ccbp6r2id1of55as4n2h6cg9i5', '2025-10-21 21:10:38'),
('86', NULL, 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'ccbp6r2id1of55as4n2h6cg9i5', '2025-10-21 21:10:56'),
('87', NULL, 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'ccbp6r2id1of55as4n2h6cg9i5', '2025-10-21 21:11:28'),
('88', NULL, 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'ccbp6r2id1of55as4n2h6cg9i5', '2025-10-21 21:11:43'),
('89', NULL, 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'ccbp6r2id1of55as4n2h6cg9i5', '2025-10-21 21:19:10'),
('90', NULL, 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'ccbp6r2id1of55as4n2h6cg9i5', '2025-10-21 21:23:49'),
('91', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-21 22:28:49'),
('92', '2', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-21 22:32:12'),
('93', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'o2nq4rp1ue0ns9ifkcsn9pbqrn', '2025-10-21 22:32:13'),
('94', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-21 22:39:19'),
('95', '65', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-21 22:39:27'),
('96', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-21 22:41:18'),
('97', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-22 19:57:59'),
('98', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-22 20:00:44'),
('99', NULL, 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-22 20:01:05'),
('100', NULL, 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2f8mcpukpd2pov3fhs6okionfq', '2025-10-22 20:01:05'),
('101', '49', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-22 20:45:04'),
('102', '18', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-22 20:45:54'),
('103', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-22 20:46:06'),
('104', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-22 21:16:59'),
('105', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-22 21:23:41'),
('106', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-22 21:38:25'),
('107', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-22 21:58:17'),
('108', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-22 22:31:55'),
('109', '69', 'request_submitted', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '35', '2025-10-22 22:39:02'),
('110', '69', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-22 22:39:59'),
('111', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-22 22:43:04'),
('112', '69', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-22 22:43:37'),
('113', NULL, 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-22 23:12:02'),
('114', NULL, 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'vju70j2gl963uvtpealmftrmps', '2025-10-22 23:12:02'),
('115', NULL, 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'vju70j2gl963uvtpealmftrmps', '2025-10-22 23:12:10'),
('116', NULL, 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'vju70j2gl963uvtpealmftrmps', '2025-10-22 23:21:47'),
('117', NULL, 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'vju70j2gl963uvtpealmftrmps', '2025-10-23 10:09:23'),
('118', '69', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-23 10:09:48'),
('119', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-23 10:12:11'),
('120', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-23 10:15:26'),
('121', '26', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-23 10:16:06'),
('122', '2', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-23 10:17:09'),
('123', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'h7sm792fl4s5gv3o8rja7mdqmk', '2025-10-23 10:17:09'),
('124', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-23 12:03:58'),
('125', '59', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-23 13:29:39'),
('126', '49', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-23 13:30:00'),
('127', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-23 13:30:14'),
('128', '69', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-23 13:40:34'),
('129', '2', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-23 13:50:40'),
('130', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'j0u2su7p5t50dmb3f7bs3l4o61', '2025-10-23 13:50:40'),
('131', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'j0u2su7p5t50dmb3f7bs3l4o61', '2025-10-23 19:51:36'),
('132', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-23 19:53:00'),
('133', NULL, 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-23 20:11:48'),
('134', NULL, 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'i4fs6u7i5678q29bp2cd7hjje1', '2025-10-23 20:11:48'),
('135', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-23 20:12:08'),
('136', NULL, 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-23 20:17:06'),
('137', NULL, 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'm8g5k9jaoh2vtgr3cnvriis05k', '2025-10-23 20:17:06'),
('138', '69', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-23 20:20:27'),
('139', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-23 20:20:40'),
('140', '70', 'request_submitted', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '67', '2025-10-23 20:25:02'),
('141', NULL, 'login_failed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '67', '2025-10-23 20:27:14'),
('142', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-23 20:27:22'),
('143', '70', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-23 20:28:40'),
('144', '70', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '6di2hp8li36esd1v2q40tcuk3f', '2025-10-23 20:28:40'),
('145', '70', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '6di2hp8li36esd1v2q40tcuk3f', '2025-10-23 20:29:08'),
('146', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-23 20:29:18'),
('147', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-23 20:47:59'),
('148', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-23 20:49:43'),
('149', '65', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-23 21:21:59'),
('150', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-23 21:22:43'),
('151', '69', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-23 21:38:35'),
('152', '70', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-23 22:01:58'),
('153', '70', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'vedeoueea97qvl4c20a9sqjb7g', '2025-10-23 22:01:59'),
('154', '69', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-24 18:04:18'),
('155', '70', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-24 18:14:32'),
('156', '70', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '65f49toj7g5hdt7e1pdss56upa', '2025-10-24 18:14:32'),
('157', '69', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-24 18:14:56'),
('158', '69', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-24 18:23:18'),
('159', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-24 18:32:50'),
('160', '69', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-24 18:45:38'),
('161', '18', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-24 21:43:50'),
('162', '70', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-24 21:44:54'),
('163', '70', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'ajv7nng2q3556acbh2l6tj1euk', '2025-10-24 21:44:54'),
('164', '70', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'ajv7nng2q3556acbh2l6tj1euk', '2025-10-24 21:49:08'),
('165', '70', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'ajv7nng2q3556acbh2l6tj1euk', '2025-10-24 22:21:59'),
('166', '2', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-24 22:23:25'),
('167', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'lak9baaa5iv68fqrq7hesho134', '2025-10-24 22:23:25'),
('168', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'lak9baaa5iv68fqrq7hesho134', '2025-10-24 22:23:42'),
('169', '70', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-24 22:59:47'),
('170', '70', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '786ucgg0gmnims6f1va9ohjd8d', '2025-10-24 22:59:47'),
('171', '2', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-24 23:12:16'),
('172', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '6crk8s631gthf2rf8anl989tvm', '2025-10-24 23:12:17'),
('173', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '6crk8s631gthf2rf8anl989tvm', '2025-10-24 23:28:25'),
('174', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '6crk8s631gthf2rf8anl989tvm', '2025-10-24 23:28:29'),
('175', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '6crk8s631gthf2rf8anl989tvm', '2025-10-25 09:55:50'),
('176', '65', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-25 09:56:44'),
('177', '69', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-25 19:09:48'),
('178', '69', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-25 21:31:08'),
('179', '70', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-25 21:31:22'),
('180', '70', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'ujfmmbg4lebot170anremlt7hp', '2025-10-25 21:31:22'),
('181', '70', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'ujfmmbg4lebot170anremlt7hp', '2025-10-25 21:31:26'),
('182', '70', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'ujfmmbg4lebot170anremlt7hp', '2025-10-25 21:31:56'),
('183', '70', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'ujfmmbg4lebot170anremlt7hp', '2025-10-25 21:32:15'),
('184', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-25 21:45:19'),
('185', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-26 21:50:13'),
('186', '69', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-26 23:12:03'),
('187', '69', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-26 23:16:12'),
('188', '59', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-26 23:17:26'),
('189', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-26 23:18:56'),
('190', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-27 11:10:03'),
('191', '69', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-27 11:43:00'),
('192', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-27 11:48:07'),
('193', '70', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-27 12:04:21'),
('194', '70', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'a12406dhro80vbdjat2s3aemlj', '2025-10-27 12:04:21'),
('195', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-27 12:05:59'),
('196', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-27 12:09:34'),
('197', '65', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-27 12:11:35'),
('198', '70', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-27 17:26:05'),
('199', '70', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '7ldkgoibenr3da05qec4t7b61h', '2025-10-27 17:26:05'),
('200', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-27 17:28:35'),
('201', '69', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-27 17:30:28'),
('202', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-27 17:31:33'),
('203', '70', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-27 22:47:55'),
('204', '70', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '12cemoi1ddkhti1hi1rfqdv775', '2025-10-27 22:47:55'),
('205', '70', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '12cemoi1ddkhti1hi1rfqdv775', '2025-10-27 22:51:30'),
('206', '70', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '12cemoi1ddkhti1hi1rfqdv775', '2025-10-27 22:55:01'),
('207', '70', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '12cemoi1ddkhti1hi1rfqdv775', '2025-10-27 22:55:57'),
('208', '70', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '12cemoi1ddkhti1hi1rfqdv775', '2025-10-27 22:56:54'),
('209', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-27 22:57:27'),
('210', '65', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-27 22:57:37'),
('211', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-27 23:27:42'),
('212', '69', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-27 23:44:34'),
('213', '70', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-27 23:45:02'),
('214', '70', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2fi6m92no8sdhqjbc0bvtf26s4', '2025-10-27 23:45:02'),
('215', '70', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2fi6m92no8sdhqjbc0bvtf26s4', '2025-10-27 23:45:08'),
('216', '70', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2fi6m92no8sdhqjbc0bvtf26s4', '2025-10-27 23:45:14'),
('217', '70', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2fi6m92no8sdhqjbc0bvtf26s4', '2025-10-27 23:46:52'),
('218', '70', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2fi6m92no8sdhqjbc0bvtf26s4', '2025-10-27 23:47:03'),
('219', '70', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2fi6m92no8sdhqjbc0bvtf26s4', '2025-10-27 23:47:14'),
('220', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-27 23:49:54'),
('221', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-28 22:00:28'),
('222', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-28 22:46:07'),
('223', NULL, 'login_failed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '67', '2025-10-28 22:48:32'),
('224', '70', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-28 22:48:44'),
('225', '70', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'rurgghgm4k8ce3jnbgv03uee30', '2025-10-28 22:48:45'),
('226', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-29 06:26:55'),
('227', '2', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-29 11:33:32'),
('228', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'd5jk4jt032ee86m876snuao3jm', '2025-10-29 11:33:32'),
('229', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-29 19:36:12'),
('230', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-29 19:40:33'),
('231', '1', 'login_success', '::1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', NULL, '2025-10-29 19:52:22'),
('232', '1', 'login_success', '::1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', NULL, '2025-10-29 19:55:21'),
('233', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-29 20:11:17'),
('234', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-30 16:11:36'),
('235', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-30 16:14:06'),
('236', '65', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-30 17:20:28'),
('237', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-30 17:21:11'),
('238', '65', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-30 20:31:54'),
('239', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-30 20:57:10'),
('240', '2', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-30 20:58:50'),
('241', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'q5bnv5l71qs6pjeqnh7a2p4l91', '2025-10-30 20:58:50'),
('242', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'q5bnv5l71qs6pjeqnh7a2p4l91', '2025-10-30 21:07:53'),
('243', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'q5bnv5l71qs6pjeqnh7a2p4l91', '2025-10-30 21:09:41'),
('244', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'q5bnv5l71qs6pjeqnh7a2p4l91', '2025-10-30 21:10:34'),
('245', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'q5bnv5l71qs6pjeqnh7a2p4l91', '2025-10-30 21:12:27'),
('246', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'q5bnv5l71qs6pjeqnh7a2p4l91', '2025-10-30 21:12:49'),
('247', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'q5bnv5l71qs6pjeqnh7a2p4l91', '2025-10-30 21:15:25'),
('248', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'q5bnv5l71qs6pjeqnh7a2p4l91', '2025-10-30 21:17:06'),
('249', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'q5bnv5l71qs6pjeqnh7a2p4l91', '2025-10-30 21:23:45'),
('250', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'q5bnv5l71qs6pjeqnh7a2p4l91', '2025-10-30 21:25:19'),
('251', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'q5bnv5l71qs6pjeqnh7a2p4l91', '2025-10-30 21:25:39'),
('252', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'q5bnv5l71qs6pjeqnh7a2p4l91', '2025-10-30 21:25:59'),
('253', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'q5bnv5l71qs6pjeqnh7a2p4l91', '2025-10-30 21:34:47'),
('254', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'q5bnv5l71qs6pjeqnh7a2p4l91', '2025-10-30 21:35:50'),
('255', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'q5bnv5l71qs6pjeqnh7a2p4l91', '2025-10-30 21:35:51'),
('256', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'q5bnv5l71qs6pjeqnh7a2p4l91', '2025-10-30 21:36:28'),
('257', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'q5bnv5l71qs6pjeqnh7a2p4l91', '2025-10-30 21:36:28'),
('258', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'q5bnv5l71qs6pjeqnh7a2p4l91', '2025-10-30 21:36:30'),
('259', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'q5bnv5l71qs6pjeqnh7a2p4l91', '2025-10-30 21:36:31'),
('260', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'q5bnv5l71qs6pjeqnh7a2p4l91', '2025-10-30 21:36:31'),
('261', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'q5bnv5l71qs6pjeqnh7a2p4l91', '2025-10-30 21:38:11'),
('262', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'q5bnv5l71qs6pjeqnh7a2p4l91', '2025-10-30 21:38:12'),
('263', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'q5bnv5l71qs6pjeqnh7a2p4l91', '2025-10-30 21:39:42'),
('264', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'q5bnv5l71qs6pjeqnh7a2p4l91', '2025-10-30 21:47:15'),
('265', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'q5bnv5l71qs6pjeqnh7a2p4l91', '2025-10-30 22:30:12'),
('266', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'q5bnv5l71qs6pjeqnh7a2p4l91', '2025-10-30 22:32:17'),
('267', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'q5bnv5l71qs6pjeqnh7a2p4l91', '2025-10-30 22:32:25'),
('268', '70', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-30 23:00:40'),
('269', '70', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'qot6e02v826ncotejoob7qbtam', '2025-10-30 23:00:40'),
('270', '70', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'qot6e02v826ncotejoob7qbtam', '2025-10-30 23:00:56'),
('271', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-30 23:01:43'),
('272', '2', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-30 23:01:57'),
('273', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 's2n7etgfvts2c86mfavhkairlp', '2025-10-30 23:01:57'),
('274', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 's2n7etgfvts2c86mfavhkairlp', '2025-10-30 23:17:20'),
('275', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-30 23:47:36'),
('276', '2', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-30 23:48:15'),
('277', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'tk4lcjmos4apfvee0e802inasc', '2025-10-30 23:48:15'),
('278', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'tk4lcjmos4apfvee0e802inasc', '2025-10-30 23:54:30'),
('279', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'tk4lcjmos4apfvee0e802inasc', '2025-10-30 23:57:46'),
('280', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-30 23:57:57'),
('281', '65', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-30 23:58:32'),
('282', '2', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-31 00:00:17'),
('283', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'oergbo10hntsbtnpetaj7du58b', '2025-10-31 00:00:17'),
('284', '26', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-31 08:22:02'),
('285', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-31 08:22:22'),
('286', '2', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-31 09:41:36'),
('287', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'pver7s3g1nn5g2io6v1j9agkk0', '2025-10-31 09:41:36'),
('288', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-31 09:45:21'),
('289', '2', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-31 10:11:44'),
('290', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '4e8pbsb65mp43u2h50anu5f1c9', '2025-10-31 10:11:44'),
('291', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-31 10:14:02'),
('292', '2', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-31 10:41:55'),
('293', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'hihsi73hjlsms31s0nndqk5ujk', '2025-10-31 10:41:55'),
('294', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-31 10:48:13'),
('295', '2', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-31 11:06:30'),
('296', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'r2fjrtfvthh4lbi16i99d9hh49', '2025-10-31 11:06:31'),
('297', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'r2fjrtfvthh4lbi16i99d9hh49', '2025-10-31 11:18:16'),
('298', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'r2fjrtfvthh4lbi16i99d9hh49', '2025-10-31 11:18:46'),
('299', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'r2fjrtfvthh4lbi16i99d9hh49', '2025-10-31 11:18:47'),
('300', '65', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-31 17:44:26'),
('301', '2', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-31 18:32:08'),
('302', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'chkqvc9ose7la78fdsb71kqrmd', '2025-10-31 18:32:08'),
('303', '65', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-31 18:33:40'),
('304', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-31 21:25:25'),
('305', '2', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-31 21:26:44'),
('306', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'r4k8f4ckrnu0kgf7ddl25survv', '2025-10-31 21:26:45'),
('307', '65', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-31 21:28:01'),
('308', '2', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-31 21:37:36'),
('309', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2mejhnhbfuu9hhn7b5kaitgj31', '2025-10-31 21:37:36'),
('310', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2mejhnhbfuu9hhn7b5kaitgj31', '2025-10-31 21:48:18'),
('311', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2mejhnhbfuu9hhn7b5kaitgj31', '2025-10-31 21:48:45'),
('312', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', NULL, '2025-10-31 21:49:28'),
('313', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-10-31 21:52:41'),
('314', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-11-01 07:49:38'),
('315', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-11-01 07:51:50'),
('316', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-11-01 07:57:00'),
('317', NULL, 'login_failed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '8990', '2025-11-01 09:45:35'),
('318', NULL, 'login_failed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '8990', '2025-11-01 09:46:24'),
('319', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-11-01 09:46:25'),
('320', NULL, 'login_failed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '8762', '2025-11-01 09:47:19'),
('321', NULL, 'login_failed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '8762', '2025-11-01 09:48:11'),
('322', NULL, 'login_failed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '8762', '2025-11-01 09:48:55'),
('323', NULL, 'login_failed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0', '8990', '2025-11-01 09:59:15'),
('324', NULL, 'login_failed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0', '8990', '2025-11-01 10:00:22'),
('325', NULL, 'login_failed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0', '8990', '2025-11-01 10:00:23'),
('326', NULL, 'login_failed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0', '8990', '2025-11-01 10:03:43'),
('327', '53', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0', NULL, '2025-11-01 10:03:52'),
('328', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-11-01 10:09:39'),
('329', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-11-01 10:10:08'),
('330', '20', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0', NULL, '2025-11-01 10:11:12'),
('331', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-11-01 14:29:09'),
('332', '23', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-11-01 14:41:57'),
('333', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-02 21:31:17'),
('334', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-02 21:31:49'),
('335', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-02 21:34:41'),
('336', NULL, 'admission_submitted', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', '0026', '2025-11-02 22:04:20'),
('337', NULL, 'login_failed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', '0026', '2025-11-02 22:04:33'),
('338', NULL, 'login_failed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', '0026', '2025-11-02 22:04:49'),
('339', NULL, 'login_failed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', '0026', '2025-11-02 22:07:16'),
('340', NULL, 'login_failed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', '0026', '2025-11-02 22:07:21'),
('341', NULL, 'login_failed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', '0026', '2025-11-02 22:07:37'),
('342', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-02 22:07:46'),
('343', '71', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-02 22:08:40'),
('344', '71', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', 'n1qt9cmmi1lfi4u0jvi2p2nvn7', '2025-11-02 22:08:41'),
('345', '71', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', 'n1qt9cmmi1lfi4u0jvi2p2nvn7', '2025-11-02 22:08:48'),
('346', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-02 22:16:54'),
('347', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-02 22:17:17'),
('348', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-02 22:21:08'),
('349', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-02 22:21:30'),
('350', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-02 22:38:01'),
('351', '33', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-02 22:41:32'),
('352', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-02 22:51:22'),
('353', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-02 22:53:59'),
('354', '45', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-02 23:03:53'),
('355', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-02 23:07:05'),
('356', '38', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-02 23:10:21'),
('357', '24', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-02 23:11:47'),
('358', NULL, 'login_failed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', '02', '2025-11-02 23:13:09'),
('359', NULL, 'login_failed', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', '02', '2025-11-02 23:13:25'),
('360', '22', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-02 23:13:54'),
('361', '38', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-02 23:18:11'),
('362', '22', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-02 23:18:25'),
('363', '24', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-02 23:18:33'),
('364', '22', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-02 23:18:41'),
('365', '38', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-02 23:18:50'),
('366', '33', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-02 23:19:01'),
('367', '23', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-02 23:19:43'),
('368', '19', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-02 23:22:26'),
('369', '37', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-02 23:26:12'),
('370', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-02 23:26:52'),
('371', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-02 23:28:17'),
('372', '2', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-02 23:50:27'),
('373', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', 'ekqhp31pq7nkd8jdsr2cjt8egt', '2025-11-02 23:50:27'),
('374', '2', 'Access Dashboard', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', 'ekqhp31pq7nkd8jdsr2cjt8egt', '2025-11-03 00:00:04'),
('375', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-03 00:24:34'),
('376', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-03 01:36:47'),
('377', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-03 03:51:10'),
('378', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-03 04:52:39'),
('379', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-03 11:39:40'),
('380', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-03 23:18:47'),
('381', '65', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-03 23:19:25'),
('382', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-03 23:20:48'),
('383', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-03 23:21:42'),
('384', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-04 04:01:08'),
('385', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-04 05:30:18'),
('386', '1', 'login_success', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', NULL, '2025-11-04 05:44:56');

--
-- Table structure for table `chair_departments`
--

DROP TABLE IF EXISTS `chair_departments`;
CREATE TABLE `chair_departments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `department_id` smallint(5) unsigned NOT NULL,
  `is_primary` tinyint(1) DEFAULT 0,
  `assigned_date` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_chair_dept` (`user_id`,`department_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `chair_departments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `chair_departments_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chair_departments`
--

INSERT INTO `chair_departments` (`id`, `user_id`, `department_id`, `is_primary`, `assigned_date`) VALUES 
('1', '69', '7', '1', '2025-10-22 22:38:37'),
('2', '69', '8', '0', '2025-10-22 22:38:37'),
('3', '70', '12', '1', '2025-10-23 20:24:58'),
('4', '71', '12', '1', '2025-11-02 22:08:03');

--
-- Table structure for table `classroom_departments`
--

DROP TABLE IF EXISTS `classroom_departments`;
CREATE TABLE `classroom_departments` (
  `classroom_department_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `classroom_id` int(10) unsigned NOT NULL,
  `department_id` smallint(5) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`classroom_department_id`),
  UNIQUE KEY `uk_classroom_dept` (`classroom_id`,`department_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `classroom_departments_ibfk_1` FOREIGN KEY (`classroom_id`) REFERENCES `classrooms` (`room_id`) ON DELETE CASCADE,
  CONSTRAINT `classroom_departments_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `classroom_departments`
--

INSERT INTO `classroom_departments` (`classroom_department_id`, `classroom_id`, `department_id`, `created_at`) VALUES 
('2', '1', '17', '2025-10-14 10:28:28');

--
-- Table structure for table `classrooms`
--

DROP TABLE IF EXISTS `classrooms`;
CREATE TABLE `classrooms` (
  `room_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `room_name` varchar(50) NOT NULL,
  `building` varchar(50) NOT NULL,
  `capacity` smallint(5) unsigned NOT NULL,
  `room_type` enum('lecture','avr','classroom','laboratory','auditorium','seminar_room') NOT NULL DEFAULT 'lecture' COMMENT 'Type of room',
  `shared` tinyint(1) DEFAULT 0,
  `availability` enum('available','unavailable','under_maintenance') NOT NULL DEFAULT 'available' COMMENT 'Current availability status of the classroom',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `department_id` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`room_id`),
  UNIQUE KEY `unq_room_name` (`room_name`),
  KEY `idx_building` (`building`),
  KEY `idx_capacity` (`capacity`),
  KEY `idx_room_type` (`room_type`,`availability`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `classrooms_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Physical classrooms and laboratories';

--
-- Dumping data for table `classrooms`
--

INSERT INTO `classrooms` (`room_id`, `room_name`, `building`, `capacity`, `room_type`, `shared`, `availability`, `created_at`, `updated_at`, `department_id`) VALUES 
('1', 'Room 1', 'Nursing Building', '50', 'lecture', '1', 'available', '2025-10-12 18:46:12', '2025-10-14 10:28:04', '14'),
('4', 'Room 2', 'Nursing Building', '50', 'lecture', '0', 'available', '2025-10-12 18:47:42', '2025-10-12 18:47:42', '14'),
('5', 'Room 3', 'Nursing Building', '50', 'lecture', '0', 'available', '2025-10-12 18:48:03', '2025-10-12 18:48:03', '14'),
('6', 'Room 4', 'Nursing Building', '50', 'lecture', '0', 'available', '2025-10-12 18:48:55', '2025-10-12 18:48:55', '14'),
('7', 'Room 8', 'Nursing Building', '50', 'lecture', '0', 'available', '2025-10-12 18:49:22', '2025-10-12 18:49:22', '14'),
('8', 'Laboratory 1', 'CCIT Main Building', '50', 'laboratory', '0', 'available', '2025-10-12 18:50:40', '2025-10-12 18:50:40', '14'),
('9', 'Laboratory 2', 'CCIT Main Building', '50', 'laboratory', '0', 'available', '2025-10-12 18:51:25', '2025-10-12 18:51:25', '14'),
('10', 'Laboratory 3', 'CCIT Main Building', '50', 'laboratory', '0', 'available', '2025-10-12 18:51:58', '2025-10-12 18:51:58', '14'),
('11', 'Room 5', 'Nursing Building', '50', 'lecture', '0', 'available', '2025-10-14 10:25:31', '2025-10-14 10:25:31', '17'),
('12', 'Lab 4', 'CCIT New Building', '50', 'laboratory', '0', 'available', '2025-10-14 10:26:29', '2025-10-14 10:26:29', '17'),
('13', 'Room 6', 'Nursing Building', '50', 'lecture', '0', 'available', '2025-10-14 10:26:57', '2025-10-14 10:26:57', '17');

--
-- Table structure for table `colleges`
--

DROP TABLE IF EXISTS `colleges`;
CREATE TABLE `colleges` (
  `college_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `college_name` varchar(100) NOT NULL,
  `college_code` varchar(20) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `logo_path` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`college_id`),
  UNIQUE KEY `unq_college_name` (`college_name`),
  UNIQUE KEY `unq_college_code` (`college_code`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Academic colleges within the university';

--
-- Dumping data for table `colleges`
--

INSERT INTO `colleges` (`college_id`, `college_name`, `college_code`, `description`, `logo_path`, `created_at`, `updated_at`) VALUES 
('1', 'College of Arts and Sciences', 'CAS', 'Offers liberal arts and sciences programs', NULL, '2025-04-30 08:09:45', '2025-04-30 08:09:45'),
('2', 'College of Business, Accountancy and Public Administration', 'CBAPA', 'Business and accountancy programs', NULL, '2025-04-30 08:09:45', '2025-10-23 19:53:36'),
('3', 'College of Teacher Education', 'CTE', 'Teacher education programs', NULL, '2025-04-30 08:09:45', '2025-10-22 22:34:18'),
('4', 'College of Engineering', 'COE', 'Engineering and technology programs', NULL, '2025-04-30 08:09:45', '2025-04-30 08:09:45'),
('5', 'College of Nursing', 'CON', 'Nursing and health sciences programs', '/assets/logo/college_logo/college_5_1761146495.png', '2025-04-30 08:09:45', '2025-10-22 23:21:35'),
('6', 'College of Criminal Justice Education', 'CCJE', 'Criminal justice and public safety programs', NULL, '2025-04-30 08:09:45', '2025-04-30 08:09:45'),
('7', 'College of Communications and Information Technology', 'CCIT', 'Offers programs in information technology, computer science, and communications', '/assets/logo/college_logo/college_7_1759632357.png', '2025-04-30 08:09:45', '2025-10-05 10:45:57'),
('8', 'College of Industrial Technology', 'CIT', NULL, NULL, '2025-10-23 10:12:35', '2025-10-23 10:12:35');

--
-- Table structure for table `course_offerings`
--

DROP TABLE IF EXISTS `course_offerings`;
CREATE TABLE `course_offerings` (
  `offering_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` int(10) unsigned NOT NULL,
  `semester_id` int(10) unsigned NOT NULL,
  `expected_sections` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `expected_students` tinyint(4) NOT NULL,
  `faculty_requirement` tinyint(3) unsigned DEFAULT NULL COMMENT 'Number of faculty needed',
  `room_requirement` varchar(50) DEFAULT NULL COMMENT 'Special room needs',
  `status` enum('Planned','Scheduled','Cancelled') DEFAULT 'Planned',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`offering_id`),
  UNIQUE KEY `unq_course_semester` (`course_id`,`semester_id`),
  KEY `idx_course_id` (`course_id`),
  KEY `idx_semester_id` (`semester_id`),
  KEY `idx_offering_status` (`status`),
  CONSTRAINT `fk_offering_course` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_offering_semester` FOREIGN KEY (`semester_id`) REFERENCES `semesters` (`semester_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Course offerings for each semester';

--
-- Dumping data for table `course_offerings`
--

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
CREATE TABLE `courses` (
  `course_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `course_code` varchar(20) NOT NULL,
  `course_name` varchar(100) NOT NULL,
  `subject_type` enum('Professional Course','General Education','Elective') NOT NULL,
  `department_id` smallint(5) unsigned NOT NULL,
  `program_id` int(10) unsigned DEFAULT NULL,
  `units` tinyint(3) unsigned NOT NULL,
  `lecture_units` tinyint(3) unsigned DEFAULT 0,
  `lab_units` tinyint(3) unsigned DEFAULT 0,
  `lecture_hours` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `lab_hours` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `semester` enum('1st','2nd','Mid Year') DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`course_id`),
  UNIQUE KEY `unq_course_code` (`course_code`),
  KEY `idx_department_id` (`department_id`),
  KEY `idx_program_id` (`program_id`),
  KEY `idx_course_semester` (`semester`),
  KEY `idx_course_active` (`is_active`),
  KEY `idx_course_code` (`course_code`),
  KEY `idx_course_department_active` (`department_id`,`is_active`),
  CONSTRAINT `fk_course_department` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`),
  CONSTRAINT `fk_course_program` FOREIGN KEY (`program_id`) REFERENCES `programs` (`program_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Academic courses offered by departments';

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`course_id`, `course_code`, `course_name`, `subject_type`, `department_id`, `program_id`, `units`, `lecture_units`, `lab_units`, `lecture_hours`, `lab_hours`, `semester`, `is_active`, `created_at`, `updated_at`) VALUES 
('60', 'CC 101', 'Introduction To Computing', 'Professional Course', '14', NULL, '3', '2', '1', '2', '2', NULL, '0', '2025-05-13 17:16:30', '2025-09-18 09:51:18'),
('61', 'FILN 1', 'Kontekstswalisadong Komunikasyon sa Filipino', 'General Education', '14', NULL, '3', '3', '0', '3', '0', NULL, '0', '2025-05-13 17:16:56', '2025-09-18 10:06:32'),
('62', 'GEC 1', 'Understanding The Self', 'General Education', '14', NULL, '3', '3', '0', '0', '0', NULL, '1', '2025-05-13 17:17:47', '2025-08-05 15:12:36'),
('63', 'GEC 7', 'Science, Technology and Society', 'General Education', '14', NULL, '3', '3', '0', '0', '0', NULL, '1', '2025-05-13 17:18:10', '2025-08-05 15:12:36'),
('64', 'PE 1', 'Physical Activities Toward Health and Fitness 1(PATHFIT1) Movement Contemporary Training', 'General Education', '14', NULL, '2', '2', '0', '0', '0', NULL, '1', '2025-05-13 17:18:39', '2025-08-05 15:12:36'),
('65', 'NSTP 1', 'NSTP 1(CWTS/ROTC/LTS)', 'General Education', '14', NULL, '2', '0', '0', '0', '0', NULL, '1', '2025-05-13 17:19:03', '2025-08-05 15:12:36'),
('66', 'ITEs 102', 'Computer Hardware System', 'Professional Course', '14', NULL, '3', '2', '3', '0', '0', NULL, '1', '2025-05-13 17:19:54', '2025-08-05 15:12:36'),
('67', 'CC 102', 'Computer Programming |', 'Professional Course', '14', NULL, '3', '2', '1', '2', '2', NULL, '0', '2025-05-13 17:20:31', '2025-09-18 09:51:34'),
('68', 'GEC 5', 'Purposive Communication', 'General Education', '14', NULL, '3', '3', '0', '0', '0', NULL, '1', '2025-05-13 17:20:59', '2025-08-05 15:12:36'),
('69', 'HC! 101', 'Introduction to Human Computer Interaction', 'Professional Course', '14', NULL, '3', '2', '1', '2', '2', NULL, '0', '2025-05-13 17:21:19', '2025-09-20 21:07:59'),
('70', 'GEC 4', 'Mathematics In The Modern World', 'General Education', '14', NULL, '3', '3', '0', '0', '0', NULL, '1', '2025-05-13 17:21:50', '2025-08-05 15:21:35'),
('71', 'GEC 2a', 'Readings in Philippines History (with IP Education)', 'General Education', '14', NULL, '3', '3', '0', '3', '0', NULL, '0', '2025-05-13 17:22:10', '2025-09-18 20:59:11'),
('72', 'PE 2', 'Physical Activities Toward Health and Fitnesses (PATHPIT 2) Exercise based Fitness Activities', 'General Education', '14', NULL, '2', '2', '0', '0', '0', NULL, '1', '2025-05-13 17:22:44', '2025-08-05 15:21:35'),
('73', 'NSTP 2', 'NSTP || (CWTS/ROTC/LTS)', 'General Education', '14', NULL, '3', '0', '0', '0', '0', NULL, '1', '2025-05-13 17:29:49', '2025-08-05 15:21:35'),
('74', 'CC 103', 'Computer Programming ||', 'Professional Course', '14', NULL, '3', '2', '1', '2', '2', NULL, '0', '2025-05-13 17:30:18', '2025-09-18 09:51:59'),
('75', 'GEM', 'The Life and Works of Rizal', 'General Education', '14', NULL, '3', '3', '0', '0', '0', NULL, '1', '2025-05-13 17:30:57', '2025-08-05 15:21:35'),
('76', 'ITE 1', 'IT Elective 1 - Web System and Technologies', 'Professional Course', '14', NULL, '3', '2', '3', '0', '0', NULL, '1', '2025-05-13 17:31:24', '2025-08-05 15:21:35'),
('77', 'GEE 15', 'ASEAN Culture and Studies', 'General Education', '14', NULL, '3', '3', '0', '0', '0', NULL, '1', '2025-05-13 17:31:45', '2025-08-05 15:21:35'),
('78', 'GEC 3a', 'The Contemporary World (With Peace Education)', 'General Education', '14', NULL, '3', '3', '0', '0', '0', NULL, '1', '2025-05-13 17:32:05', '2025-08-05 15:21:35'),
('79', 'MS 101', 'Discrete Mathematics', 'General Education', '14', NULL, '3', '3', '0', '0', '0', NULL, '1', '2025-05-13 17:32:23', '2025-08-05 15:21:35'),
('80', 'PE 3', 'Physical Activites Toward Health and Fitness 3(PATHFIT 3) (DANCE)', 'General Education', '14', NULL, '2', '2', '0', '2', '0', NULL, '0', '2025-05-13 17:32:45', '2025-09-18 09:59:03'),
('81', 'CC 104', 'Data Structure and Algorithms', 'Professional Course', '14', NULL, '3', '2', '1', '2', '2', NULL, '0', '2025-05-13 17:34:37', '2025-09-18 09:58:01'),
('82', 'ITE 2', 'IT Elective 2-Objective-Oriented Programming', 'Professional Course', '14', NULL, '3', '2', '3', '0', '0', NULL, '1', '2025-05-13 17:34:57', '2025-08-06 09:49:00'),
('83', 'CC 105', 'Information Management', 'Professional Course', '14', NULL, '3', '2', '1', '2', '2', NULL, '0', '2025-05-13 17:35:22', '2025-09-18 09:57:36'),
('84', 'GEE 14', 'Technopreneurship', 'General Education', '14', NULL, '3', '3', '0', '3', '0', NULL, '0', '2025-05-13 17:35:40', '2025-09-23 18:05:35'),
('85', 'GEE 7', 'Gender and Society', 'General Education', '14', NULL, '3', '3', '0', '3', '0', NULL, '0', '2025-05-13 17:35:58', '2025-09-20 20:59:00'),
('86', 'GEC 6', 'Art Appreciation', 'General Education', '14', NULL, '3', '3', '0', '0', '0', NULL, '1', '2025-05-13 17:36:21', '2025-08-06 09:49:20'),
('87', 'PE 4', 'Physical Activites Toward Health and Fitness 4(PATHFIT 4) (SPORTS)', 'General Education', '14', NULL, '2', '2', '0', '2', '0', NULL, '0', '2025-05-13 17:36:43', '2025-09-25 23:00:56'),
('88', 'IM 101', 'Advance Database Systems', 'Professional Course', '14', NULL, '3', '2', '3', '0', '0', NULL, '1', '2025-05-13 17:37:13', '2025-09-01 11:13:59'),
('89', 'GDDAT', 'Game Development and Digital Animation Technology', 'Professional Course', '14', NULL, '3', '2', '1', '2', '2', NULL, '0', '2025-05-13 17:37:50', '2025-09-20 20:58:38'),
('90', 'EN 1', 'Scientific and Technical Writing', 'General Education', '14', NULL, '3', '3', '0', '3', '0', NULL, '0', '2025-05-13 17:38:08', '2025-09-20 20:58:14'),
('91', 'ITE 3', 'IT Elective 3 - Platform Technologies', 'Professional Course', '14', NULL, '3', '2', '3', '0', '0', NULL, '1', '2025-05-13 17:38:26', '2025-08-06 09:46:26'),
('92', 'PF 102', 'Event Driven Programming', 'Professional Course', '14', NULL, '3', '2', '1', '2', '2', NULL, '0', '2025-05-13 17:38:47', '2025-09-20 21:09:15'),
('93', 'ITP', 'Integrative Programming Technologies 1', 'Professional Course', '14', NULL, '3', '2', '3', '0', '0', NULL, '1', '2025-05-13 17:39:08', '2025-08-06 09:49:48'),
('94', 'SIA 101', 'System Integration and Architecture |', 'Professional Course', '14', NULL, '3', '2', '1', '2', '2', NULL, '0', '2025-05-13 17:40:10', '2025-09-20 21:08:23'),
('95', 'CAP 101', 'Capstone Progect and Research |', 'Professional Course', '14', NULL, '3', '3', '0', '3', '0', NULL, '0', '2025-05-13 17:40:28', '2025-09-18 09:50:45'),
('96', 'CC 106', 'Application Development and Emerging Technologies', 'Professional Course', '14', NULL, '3', '2', '1', '2', '2', NULL, '0', '2025-05-13 17:40:49', '2025-09-18 09:58:23'),
('97', 'NET 101', 'Networking |', 'Professional Course', '14', NULL, '3', '2', '3', '0', '0', NULL, '1', '2025-05-13 17:41:20', '2025-08-06 09:50:00'),
('98', 'IAS 101', 'Information Assurance and Security |', 'Professional Course', '14', NULL, '3', '2', '1', '2', '2', NULL, '0', '2025-05-13 17:53:02', '2025-09-20 21:09:30'),
('99', 'ITE 4', 'IT Elective 4 - Artificial Intelligence', 'Professional Course', '14', NULL, '3', '2', '3', '0', '0', NULL, '1', '2025-05-13 17:53:23', '2025-08-06 09:46:01'),
('100', 'GEC 8', 'Ethics', 'General Education', '14', NULL, '3', '3', '0', '3', '0', NULL, '0', '2025-05-13 17:53:44', '2025-09-20 20:58:49'),
('101', 'SP 101', 'Social and Professional Issues', 'General Education', '14', NULL, '3', '3', '0', '3', '0', NULL, '0', '2025-05-13 17:54:11', '2025-09-18 09:58:51'),
('102', 'NET 102', 'Networking II', 'Professional Course', '14', NULL, '3', '2', '3', '0', '0', NULL, '1', '2025-05-13 17:54:45', '2025-08-06 09:50:18'),
('103', 'MS 102', 'Qualitative Methods', 'General Education', '14', NULL, '3', '3', '0', '0', '0', NULL, '1', '2025-05-13 17:58:52', '2025-08-05 15:28:16'),
('104', 'SA 101', 'System Administration and Maintenance', 'Professional Course', '14', NULL, '3', '2', '1', '2', '2', NULL, '0', '2025-05-13 17:59:19', '2025-09-20 21:08:53'),
('105', 'CAP 102', 'Capstone Project and Research ||', 'Professional Course', '14', NULL, '3', '3', '0', '3', '0', NULL, '0', '2025-05-13 17:59:40', '2025-09-18 09:50:55'),
('106', 'FLNG', 'Foregin Language', 'General Education', '14', NULL, '3', '3', '0', '3', '0', NULL, '0', '2025-05-13 17:59:58', '2025-09-20 20:57:41'),
('107', 'PRAC 101', 'Practicum (600 hours)', 'Professional Course', '14', NULL, '6', '6', '0', '0', '0', NULL, '1', '2025-05-13 18:00:31', '2025-08-06 09:50:28'),
('108', 'ewwef', 'erggse', 'General Education', '14', NULL, '3', '0', '0', '0', '0', NULL, '0', '2025-05-14 03:40:13', '2025-08-05 15:22:53'),
('109', 'CDFR 50', 'Advance Database Systems', 'Professional Course', '14', NULL, '3', '2', '1', '2', '2', NULL, '0', '2025-08-05 16:28:35', '2025-09-20 20:58:00'),
('110', 'COMFUN101', 'Computer Fundamentals', 'Professional Course', '14', NULL, '33', '2', '1', '2', '3', NULL, '0', '2025-09-17 09:52:54', '2025-09-17 09:52:54'),
('111', 'FhJ+', 'qwfewger', 'General Education', '14', NULL, '2', '2', '0', '2', '0', NULL, '0', '2025-09-18 10:16:55', '2025-09-18 10:16:55'),
('112', 'EN+', 'Enhance Communication Skills', 'General Education', '14', NULL, '3', '0', '0', '0', '0', NULL, '0', '2025-11-04 01:51:35', '2025-11-04 01:51:35'),
('113', 'IT ELEC 1', 'IT elective 1', 'Professional Course', '14', NULL, '3', '0', '0', '0', '0', NULL, '0', '2025-11-04 02:01:54', '2025-11-04 03:04:16'),
('114', 'GEE 8', 'The Entrepreneurial Mind', 'General Education', '14', NULL, '3', '3', '0', '3', '0', NULL, '0', '2025-11-04 02:05:35', '2025-11-04 02:05:35'),
('115', 'GEE 1', 'Environmental Science', 'General Education', '14', NULL, '3', '3', '0', '3', '0', NULL, '0', '2025-11-04 02:16:36', '2025-11-04 02:16:36'),
('116', 'GEE 6', 'Art Appreciation', 'General Education', '14', NULL, '3', '3', '0', '3', '0', NULL, '0', '2025-11-04 02:18:17', '2025-11-04 02:18:17'),
('117', 'IM 191', 'Fundamentals of Database Systems', 'General Education', '14', NULL, '3', '2', '1', '2', '2', NULL, '0', '2025-11-04 02:23:17', '2025-11-04 02:34:55'),
('118', 'ITE ELECT 2', 'IT Elective 2', 'Professional Course', '14', NULL, '3', '2', '1', '2', '2', NULL, '0', '2025-11-04 02:25:09', '2025-11-04 02:25:09'),
('119', 'IM 102', 'Advance Database Systems', 'Professional Course', '14', NULL, '3', '2', '1', '2', '2', NULL, '0', '2025-11-04 02:34:01', '2025-11-04 02:34:01'),
('120', 'ITP 101', 'Integrative Programming Technologies', 'Professional Course', '14', NULL, '3', '2', '1', '2', '2', NULL, '0', '2025-11-04 02:37:52', '2025-11-04 02:37:52'),
('121', 'WS 101', 'Web Systems and Technologies', 'Professional Course', '14', NULL, '3', '2', '1', '2', '2', NULL, '0', '2025-11-04 02:39:38', '2025-11-04 02:39:38'),
('122', 'IT ELEC 4', 'IT Elective 4', 'Professional Course', '14', NULL, '3', '2', '1', '2', '2', NULL, '0', '2025-11-04 02:42:45', '2025-11-04 02:42:45'),
('123', 'NCR 101', 'International/National Certification Review', 'Professional Course', '14', NULL, '3', '2', '1', '2', '2', NULL, '0', '2025-11-04 02:46:02', '2025-11-04 02:46:02'),
('124', 'IAS 102', 'Information Assurance and Security 2', 'Professional Course', '14', NULL, '3', '2', '1', '2', '2', NULL, '0', '2025-11-04 02:47:44', '2025-11-04 02:47:44'),
('125', 'IT ELEC 3', 'IT Elective 3', 'Professional Course', '14', NULL, '3', '2', '1', '2', '2', NULL, '0', '2025-11-04 03:14:46', '2025-11-04 03:14:46');

--
-- Table structure for table `curricula`
--

DROP TABLE IF EXISTS `curricula`;
CREATE TABLE `curricula` (
  `curriculum_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `curriculum_name` varchar(100) NOT NULL,
  `curriculum_code` varchar(20) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `total_units` smallint(5) unsigned NOT NULL,
  `department_id` smallint(5) unsigned NOT NULL,
  `effective_year` year(4) NOT NULL,
  `status` enum('Draft','Active','Archived') DEFAULT 'Draft',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`curriculum_id`),
  UNIQUE KEY `unq_curriculum_code` (`curriculum_code`),
  KEY `idx_curriculum_status` (`status`),
  KEY `idx_department_id` (`department_id`),
  KEY `idx_effective_year` (`effective_year`),
  CONSTRAINT `fk_curriculum_department` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Academic program curricula';

--
-- Dumping data for table `curricula`
--

INSERT INTO `curricula` (`curriculum_id`, `curriculum_name`, `curriculum_code`, `description`, `total_units`, `department_id`, `effective_year`, `status`, `created_at`, `updated_at`) VALUES 
('6', 'BACHELOR OF SCIENCE IN INFORMATION TECHNOLOGY(REVISED ON 2022 BASED ON CMO NO.25, s.2022-2015', 'BSIT-2022', '', '143', '14', '2025', 'Active', '2025-05-13 18:01:18', '2025-09-20 20:33:52'),
('7', 'BACHELOR OF SCIENCE IN INFORMATION TECHNOLOGY(REVISED ON 2022 BASED ON CMO NO.25, s.2', 'BSCS-2022', '', '0', '17', '2025', 'Active', '2025-05-14 04:03:20', '2025-10-07 22:17:00'),
('8', 'BSIT 2025', 'BSIT_2025', 'Based on the New CMO series of 2025', '0', '14', '2025', 'Draft', '2025-08-04 10:31:03', '2025-11-04 04:01:27'),
('12', 'test curriculum', 'test', '', '0', '7', '2025', 'Draft', '2025-10-25 21:19:20', '2025-10-25 21:19:20'),
('13', 'Bachelor of Science in Information Technology (BSIT) – Revised Curriculum 2024, Based on CMO No. 25,', 'BSIT-2024', '', '151', '14', '2026', 'Draft', '2025-11-04 01:41:50', '2025-11-04 06:00:02');

--
-- Table structure for table `curriculum_approvals`
--

DROP TABLE IF EXISTS `curriculum_approvals`;
CREATE TABLE `curriculum_approvals` (
  `approval_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `curriculum_id` int(10) unsigned NOT NULL,
  `department_id` smallint(5) unsigned NOT NULL,
  `requested_by` int(10) unsigned NOT NULL,
  `approval_level` tinyint(3) unsigned NOT NULL COMMENT '1=Chair, 2=Dean, 3=VPAA',
  `current_approver` int(10) unsigned DEFAULT NULL,
  `status` enum('Pending','Approved','Rejected','Revised') DEFAULT 'Pending',
  `comments` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`approval_id`),
  KEY `fk_capproval_requestor` (`requested_by`),
  KEY `fk_capproval_approver` (`current_approver`),
  KEY `idx_curriculum_id` (`curriculum_id`),
  KEY `idx_approval_status` (`status`),
  KEY `idx_approval_level` (`approval_level`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `curriculum_approvals_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`),
  CONSTRAINT `fk_capproval_approver` FOREIGN KEY (`current_approver`) REFERENCES `users` (`user_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_capproval_curriculum` FOREIGN KEY (`curriculum_id`) REFERENCES `curricula` (`curriculum_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_capproval_requestor` FOREIGN KEY (`requested_by`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Curriculum approval workflow tracking';

--
-- Dumping data for table `curriculum_approvals`
--

--
-- Table structure for table `curriculum_courses`
--

DROP TABLE IF EXISTS `curriculum_courses`;
CREATE TABLE `curriculum_courses` (
  `curriculum_course_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `curriculum_id` int(10) unsigned NOT NULL,
  `course_id` int(10) unsigned NOT NULL,
  `year_level` enum('1st Year','2nd Year','3rd Year','4th Year') NOT NULL,
  `semester` enum('1st','2nd','Mid Year','Summer') NOT NULL,
  `subject_type` enum('Professional Course','General Education','Elective') NOT NULL,
  `is_core` tinyint(1) DEFAULT 1,
  `prerequisites` text DEFAULT NULL,
  `co_requisites` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`curriculum_course_id`),
  UNIQUE KEY `unq_curriculum_course_sem` (`curriculum_id`,`course_id`,`year_level`,`semester`),
  KEY `idx_curriculum_id` (`curriculum_id`),
  KEY `idx_course_id` (`course_id`),
  KEY `idx_year_semester` (`year_level`,`semester`),
  KEY `idx_subject_type` (`subject_type`),
  CONSTRAINT `fk_cc_course` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_cc_curriculum` FOREIGN KEY (`curriculum_id`) REFERENCES `curricula` (`curriculum_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=232 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Courses required in each curriculum';

--
-- Dumping data for table `curriculum_courses`
--

INSERT INTO `curriculum_courses` (`curriculum_course_id`, `curriculum_id`, `course_id`, `year_level`, `semester`, `subject_type`, `is_core`, `prerequisites`, `co_requisites`, `created_at`) VALUES 
('131', '6', '60', '1st Year', '1st', 'Professional Course', '1', NULL, NULL, '2025-08-31 12:41:53'),
('132', '6', '61', '1st Year', '1st', 'General Education', '1', NULL, NULL, '2025-08-31 12:42:07'),
('133', '6', '62', '1st Year', '1st', 'General Education', '1', NULL, NULL, '2025-08-31 12:42:18'),
('134', '6', '63', '1st Year', '1st', 'General Education', '1', NULL, NULL, '2025-08-31 12:42:28'),
('135', '6', '64', '1st Year', '1st', 'General Education', '1', NULL, NULL, '2025-08-31 12:42:41'),
('136', '6', '65', '1st Year', '1st', 'General Education', '1', NULL, NULL, '2025-08-31 12:42:54'),
('137', '6', '66', '1st Year', '2nd', 'Professional Course', '1', NULL, NULL, '2025-08-31 12:43:11'),
('138', '6', '67', '1st Year', '2nd', 'Professional Course', '1', NULL, NULL, '2025-08-31 12:43:25'),
('139', '6', '68', '1st Year', '2nd', 'General Education', '1', NULL, NULL, '2025-08-31 12:43:38'),
('140', '6', '69', '1st Year', '2nd', 'Professional Course', '1', NULL, NULL, '2025-08-31 12:43:51'),
('141', '6', '70', '1st Year', '2nd', 'General Education', '1', NULL, NULL, '2025-08-31 12:44:10'),
('142', '6', '71', '1st Year', '2nd', 'General Education', '1', NULL, NULL, '2025-08-31 12:44:21'),
('143', '6', '73', '1st Year', '2nd', 'General Education', '1', NULL, NULL, '2025-08-31 12:44:34'),
('144', '6', '74', '2nd Year', '1st', 'Professional Course', '1', NULL, NULL, '2025-08-31 12:44:52'),
('145', '6', '75', '2nd Year', '1st', 'General Education', '1', NULL, NULL, '2025-08-31 12:45:12'),
('146', '6', '76', '2nd Year', '1st', 'Professional Course', '1', NULL, NULL, '2025-08-31 12:45:25'),
('147', '6', '77', '2nd Year', '1st', 'General Education', '1', NULL, NULL, '2025-08-31 12:45:40'),
('148', '6', '78', '2nd Year', '1st', 'General Education', '1', NULL, NULL, '2025-08-31 12:45:56'),
('149', '6', '79', '2nd Year', '1st', 'General Education', '1', NULL, NULL, '2025-08-31 12:46:08'),
('150', '6', '80', '2nd Year', '1st', 'General Education', '1', NULL, NULL, '2025-08-31 12:46:21'),
('151', '6', '87', '2nd Year', '2nd', 'General Education', '1', NULL, NULL, '2025-08-31 12:46:39'),
('152', '6', '81', '2nd Year', '2nd', 'General Education', '1', NULL, NULL, '2025-08-31 12:46:51'),
('153', '6', '82', '2nd Year', '2nd', 'Professional Course', '1', NULL, NULL, '2025-08-31 12:47:09'),
('154', '6', '83', '2nd Year', '2nd', 'General Education', '1', NULL, NULL, '2025-08-31 12:47:24'),
('155', '6', '84', '2nd Year', '2nd', 'General Education', '1', NULL, NULL, '2025-08-31 12:47:44'),
('156', '6', '85', '2nd Year', '2nd', 'General Education', '1', NULL, NULL, '2025-08-31 12:48:03'),
('157', '6', '86', '2nd Year', '2nd', 'General Education', '1', NULL, NULL, '2025-08-31 12:50:48'),
('158', '6', '88', '3rd Year', '1st', 'General Education', '1', NULL, NULL, '2025-08-31 12:51:27'),
('159', '6', '89', '3rd Year', '1st', 'Professional Course', '1', NULL, NULL, '2025-08-31 12:51:42'),
('160', '6', '90', '3rd Year', '1st', 'General Education', '1', NULL, NULL, '2025-08-31 12:52:09'),
('161', '6', '91', '3rd Year', '1st', 'Professional Course', '1', NULL, NULL, '2025-08-31 12:52:21'),
('162', '6', '92', '3rd Year', '1st', 'Professional Course', '1', NULL, NULL, '2025-08-31 12:52:37'),
('163', '6', '93', '3rd Year', '1st', 'Professional Course', '1', NULL, NULL, '2025-08-31 12:52:51'),
('164', '6', '94', '3rd Year', '2nd', 'Professional Course', '1', NULL, NULL, '2025-08-31 12:53:09'),
('166', '6', '96', '3rd Year', '2nd', 'General Education', '1', NULL, NULL, '2025-08-31 12:53:35'),
('167', '6', '97', '3rd Year', '2nd', 'Professional Course', '1', NULL, NULL, '2025-08-31 12:53:53'),
('168', '6', '98', '3rd Year', '2nd', 'Professional Course', '1', NULL, NULL, '2025-08-31 12:54:12'),
('169', '6', '99', '3rd Year', '2nd', 'Professional Course', '1', NULL, NULL, '2025-08-31 12:54:26'),
('170', '6', '100', '3rd Year', '2nd', 'General Education', '1', NULL, NULL, '2025-08-31 12:54:42'),
('171', '6', '101', '3rd Year', 'Mid Year', 'General Education', '1', NULL, NULL, '2025-08-31 12:55:07'),
('172', '6', '102', '3rd Year', 'Mid Year', 'Professional Course', '1', NULL, NULL, '2025-08-31 12:55:22'),
('173', '6', '103', '3rd Year', 'Mid Year', 'General Education', '1', NULL, NULL, '2025-08-31 12:55:48'),
('174', '6', '104', '4th Year', '1st', 'Professional Course', '1', NULL, NULL, '2025-08-31 12:56:03'),
('176', '6', '106', '4th Year', '1st', 'General Education', '1', NULL, NULL, '2025-08-31 12:56:30'),
('177', '6', '107', '4th Year', '2nd', 'Professional Course', '1', NULL, NULL, '2025-08-31 12:56:45'),
('178', '6', '105', '4th Year', '1st', 'Professional Course', '1', NULL, NULL, '2025-09-11 15:08:48'),
('179', '6', '95', '3rd Year', '2nd', 'Professional Course', '1', NULL, NULL, '2025-09-20 20:32:53'),
('180', '13', '62', '1st Year', '1st', 'General Education', '1', NULL, NULL, '2025-11-04 01:46:29'),
('181', '13', '112', '1st Year', '1st', 'General Education', '1', NULL, NULL, '2025-11-04 02:52:14'),
('182', '13', '70', '1st Year', '1st', 'General Education', '1', NULL, NULL, '2025-11-04 02:53:45'),
('183', '13', '63', '1st Year', '1st', 'General Education', '1', NULL, NULL, '2025-11-04 02:54:20'),
('184', '13', '60', '1st Year', '1st', 'Professional Course', '1', NULL, NULL, '2025-11-04 02:56:25'),
('185', '13', '64', '1st Year', '1st', 'General Education', '1', NULL, NULL, '2025-11-04 02:57:00'),
('186', '13', '65', '1st Year', '1st', 'General Education', '1', NULL, NULL, '2025-11-04 02:57:22'),
('187', '13', '68', '1st Year', '2nd', 'General Education', '1', NULL, NULL, '2025-11-04 02:57:56'),
('188', '13', '71', '1st Year', '2nd', 'General Education', '1', NULL, NULL, '2025-11-04 02:58:27'),
('189', '13', '67', '1st Year', '2nd', 'Professional Course', '1', NULL, NULL, '2025-11-04 02:58:48'),
('190', '13', '66', '1st Year', '2nd', 'Professional Course', '1', NULL, NULL, '2025-11-04 02:59:16'),
('191', '13', '69', '1st Year', '2nd', 'Professional Course', '1', NULL, NULL, '2025-11-04 02:59:56'),
('192', '13', '72', '1st Year', '2nd', 'General Education', '1', NULL, NULL, '2025-11-04 03:00:13'),
('193', '13', '73', '1st Year', '2nd', 'General Education', '1', NULL, NULL, '2025-11-04 03:00:34'),
('194', '13', '115', '2nd Year', '1st', 'General Education', '1', NULL, NULL, '2025-11-04 03:01:17'),
('195', '13', '78', '2nd Year', '1st', 'General Education', '1', NULL, NULL, '2025-11-04 03:01:52'),
('196', '13', '75', '2nd Year', '1st', 'General Education', '1', NULL, NULL, '2025-11-04 03:02:12'),
('197', '13', '74', '2nd Year', '1st', 'Professional Course', '1', NULL, NULL, '2025-11-04 03:02:54'),
('198', '13', '79', '2nd Year', '1st', 'General Education', '1', NULL, NULL, '2025-11-04 03:03:23'),
('200', '13', '113', '2nd Year', '1st', 'Professional Course', '1', NULL, NULL, '2025-11-04 03:04:58'),
('201', '13', '80', '2nd Year', '1st', 'General Education', '1', NULL, NULL, '2025-11-04 03:05:19'),
('202', '13', '114', '2nd Year', '2nd', 'General Education', '1', NULL, NULL, '2025-11-04 03:06:48'),
('203', '13', '85', '2nd Year', '2nd', 'General Education', '1', NULL, NULL, '2025-11-04 03:07:14'),
('204', '13', '116', '2nd Year', '2nd', 'General Education', '1', NULL, NULL, '2025-11-04 03:08:02'),
('205', '13', '81', '2nd Year', '2nd', 'Professional Course', '1', NULL, NULL, '2025-11-04 03:08:21'),
('206', '13', '83', '2nd Year', '2nd', 'Professional Course', '1', NULL, NULL, '2025-11-04 03:08:47'),
('207', '13', '117', '2nd Year', '2nd', 'General Education', '1', NULL, NULL, '2025-11-04 03:09:01'),
('208', '13', '118', '2nd Year', '2nd', 'Professional Course', '1', NULL, NULL, '2025-11-04 03:09:26'),
('209', '13', '87', '2nd Year', '2nd', 'General Education', '1', NULL, NULL, '2025-11-04 03:10:06'),
('210', '13', '90', '3rd Year', '1st', 'General Education', '1', NULL, NULL, '2025-11-04 03:10:29'),
('211', '13', '103', '3rd Year', '1st', 'General Education', '1', NULL, NULL, '2025-11-04 03:10:45'),
('212', '13', '119', '3rd Year', '1st', 'Professional Course', '1', NULL, NULL, '2025-11-04 03:11:09'),
('213', '13', '89', '3rd Year', '1st', 'Professional Course', '1', NULL, NULL, '2025-11-04 03:11:44'),
('214', '13', '92', '3rd Year', '1st', 'Professional Course', '1', NULL, NULL, '2025-11-04 03:12:15'),
('215', '13', '120', '3rd Year', '1st', 'Professional Course', '1', NULL, NULL, '2025-11-04 03:12:35'),
('216', '13', '121', '3rd Year', '1st', 'Professional Course', '1', NULL, NULL, '2025-11-04 03:13:34'),
('217', '13', '125', '3rd Year', '1st', 'Professional Course', '1', NULL, NULL, '2025-11-04 03:15:09'),
('218', '13', '100', '3rd Year', '2nd', 'General Education', '1', NULL, NULL, '2025-11-04 03:15:34'),
('219', '13', '94', '3rd Year', '2nd', 'Professional Course', '1', NULL, NULL, '2025-11-04 03:15:55'),
('220', '13', '96', '3rd Year', '2nd', 'Professional Course', '1', NULL, NULL, '2025-11-04 03:16:10'),
('221', '13', '97', '3rd Year', '2nd', 'Professional Course', '1', NULL, NULL, '2025-11-04 03:16:48'),
('222', '13', '98', '3rd Year', '2nd', 'Professional Course', '1', NULL, NULL, '2025-11-04 03:17:08'),
('223', '13', '104', '3rd Year', '2nd', 'Professional Course', '1', NULL, NULL, '2025-11-04 03:17:30'),
('224', '13', '122', '3rd Year', '2nd', 'Professional Course', '1', NULL, NULL, '2025-11-04 03:18:11'),
('225', '13', '95', '3rd Year', '2nd', 'Professional Course', '1', NULL, NULL, '2025-11-04 03:19:47'),
('226', '13', '123', '3rd Year', 'Mid Year', 'Professional Course', '1', NULL, NULL, '2025-11-04 03:20:08'),
('227', '13', '102', '4th Year', '1st', 'Professional Course', '1', NULL, NULL, '2025-11-04 03:20:32'),
('228', '13', '101', '4th Year', '1st', 'General Education', '1', NULL, NULL, '2025-11-04 03:20:50'),
('229', '13', '124', '4th Year', '1st', 'Professional Course', '1', NULL, NULL, '2025-11-04 03:21:17'),
('230', '13', '105', '4th Year', '1st', 'Professional Course', '1', NULL, NULL, '2025-11-04 03:21:38'),
('231', '13', '107', '4th Year', '2nd', 'Professional Course', '1', NULL, NULL, '2025-11-04 03:22:03');

--
-- Table structure for table `curriculum_group_courses`
--

DROP TABLE IF EXISTS `curriculum_group_courses`;
CREATE TABLE `curriculum_group_courses` (
  `group_course_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int(10) unsigned NOT NULL,
  `curriculum_course_id` int(10) unsigned NOT NULL,
  `required` tinyint(1) DEFAULT 1,
  `elective_order` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`group_course_id`),
  UNIQUE KEY `unq_group_cc` (`group_id`,`curriculum_course_id`),
  KEY `idx_group_id` (`group_id`),
  KEY `idx_curriculum_course_id` (`curriculum_course_id`),
  KEY `idx_required_elective` (`required`,`elective_order`),
  CONSTRAINT `fk_gc_curriculum_course` FOREIGN KEY (`curriculum_course_id`) REFERENCES `curriculum_courses` (`curriculum_course_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_gc_group` FOREIGN KEY (`group_id`) REFERENCES `subject_groups` (`group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Courses belonging to subject groups';

--
-- Dumping data for table `curriculum_group_courses`
--

--
-- Table structure for table `curriculum_programs`
--

DROP TABLE IF EXISTS `curriculum_programs`;
CREATE TABLE `curriculum_programs` (
  `curriculum_program_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `curriculum_id` int(10) unsigned NOT NULL,
  `program_id` int(10) unsigned NOT NULL,
  `is_primary` tinyint(1) DEFAULT 0 COMMENT 'True for major, False for minor/concentration',
  `required` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`curriculum_program_id`),
  UNIQUE KEY `unq_curriculum_program` (`curriculum_id`,`program_id`),
  KEY `idx_curriculum_id` (`curriculum_id`),
  KEY `idx_program_id` (`program_id`),
  KEY `idx_is_primary` (`is_primary`),
  CONSTRAINT `fk_cp_curriculum` FOREIGN KEY (`curriculum_id`) REFERENCES `curricula` (`curriculum_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_cp_program` FOREIGN KEY (`program_id`) REFERENCES `programs` (`program_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Relationship between curricula and major/minor programs';

--
-- Dumping data for table `curriculum_programs`
--

INSERT INTO `curriculum_programs` (`curriculum_program_id`, `curriculum_id`, `program_id`, `is_primary`, `required`, `created_at`) VALUES 
('1', '6', '1', '1', '1', '2025-05-13 18:01:18'),
('2', '7', '2', '1', '1', '2025-05-14 04:03:20'),
('3', '8', '1', '1', '1', '2025-08-04 10:31:03'),
('5', '12', '6', '1', '1', '2025-10-25 21:19:20'),
('6', '13', '1', '1', '1', '2025-11-04 01:41:50');

--
-- Table structure for table `curriculum_versions`
--

DROP TABLE IF EXISTS `curriculum_versions`;
CREATE TABLE `curriculum_versions` (
  `version_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `curriculum_id` int(10) unsigned NOT NULL,
  `version_number` varchar(20) NOT NULL,
  `approval_status` enum('Pending','Approved','Rejected') DEFAULT 'Pending',
  `approved_by` int(10) unsigned DEFAULT NULL,
  `approval_date` date DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`version_id`),
  UNIQUE KEY `unq_curriculum_version` (`curriculum_id`,`version_number`),
  KEY `fk_version_approver` (`approved_by`),
  KEY `idx_curriculum_id` (`curriculum_id`),
  KEY `idx_approval_status` (`approval_status`),
  CONSTRAINT `fk_version_approver` FOREIGN KEY (`approved_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_version_curriculum` FOREIGN KEY (`curriculum_id`) REFERENCES `curricula` (`curriculum_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Tracking changes to curriculum versions';

--
-- Dumping data for table `curriculum_versions`
--

--
-- Table structure for table `deans`
--

DROP TABLE IF EXISTS `deans`;
CREATE TABLE `deans` (
  `dean_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `college_id` smallint(5) unsigned NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `is_current` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`dean_id`),
  UNIQUE KEY `unq_current_college_dean` (`college_id`,`is_current`),
  KEY `fk_dean_user` (`user_id`),
  KEY `fk_dean_college` (`college_id`),
  CONSTRAINT `fk_dean_college` FOREIGN KEY (`college_id`) REFERENCES `colleges` (`college_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_dean_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='College dean assignments';

--
-- Dumping data for table `deans`
--

INSERT INTO `deans` (`dean_id`, `user_id`, `college_id`, `start_date`, `end_date`, `is_current`, `created_at`, `updated_at`) VALUES 
('1', '2', '7', '2025-05-13', '2025-06-13', '1', '2025-05-13 08:43:38', '2025-05-13 08:43:38'),
('3', '70', '5', '2025-10-23', NULL, '1', '2025-10-23 20:24:58', '2025-10-23 20:24:58');

--
-- Table structure for table `department_instructors`
--

DROP TABLE IF EXISTS `department_instructors`;
CREATE TABLE `department_instructors` (
  `di_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `department_id` smallint(5) unsigned NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `is_current` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`di_id`),
  UNIQUE KEY `unq_current_department_di` (`department_id`,`is_current`),
  KEY `fk_di_user` (`user_id`),
  KEY `fk_di_department` (`department_id`),
  CONSTRAINT `fk_di_department` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_di_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Department instructor assignments';

--
-- Dumping data for table `department_instructors`
--

INSERT INTO `department_instructors` (`di_id`, `user_id`, `department_id`, `start_date`, `end_date`, `is_current`, `created_at`, `updated_at`) VALUES 
('2', '65', '17', '2025-08-21', NULL, '1', '2025-08-21 22:12:07', '2025-08-21 22:12:07');

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
CREATE TABLE `departments` (
  `department_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `department_name` varchar(100) NOT NULL,
  `department_code` varchar(20) DEFAULT NULL,
  `college_id` smallint(5) unsigned DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`department_id`),
  UNIQUE KEY `unq_department_name` (`department_name`),
  KEY `idx_college_id` (`college_id`),
  CONSTRAINT `fk_department_college` FOREIGN KEY (`college_id`) REFERENCES `colleges` (`college_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Academic departments within colleges';

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`department_id`, `department_name`, `department_code`, `college_id`, `description`, `created_at`, `updated_at`) VALUES 
('1', 'Department of Languages and Literature', NULL, '1', 'English, Filipino, and literature studies', '2025-04-30 08:09:45', '2025-04-30 08:09:45'),
('2', 'Department of Social Sciences', NULL, '1', 'History, sociology, psychology programs', '2025-04-30 08:09:45', '2025-04-30 08:09:45'),
('3', 'Department of Mathematics and Natural Sciences', NULL, '1', 'Math, biology, chemistry, physics', '2025-04-30 08:09:45', '2025-04-30 08:09:45'),
('4', 'Department of Accountancy', NULL, '2', 'BS Accountancy program', '2025-04-30 08:09:45', '2025-04-30 08:09:45'),
('5', 'Department of Business Administration', NULL, '2', 'Marketing, HRM, entrepreneurship', '2025-04-30 08:09:45', '2025-04-30 08:09:45'),
('6', 'Department of Economics', NULL, '2', 'Economics and finance programs', '2025-04-30 08:09:45', '2025-04-30 08:09:45'),
('7', 'Department of Elementary Education', NULL, '3', 'Elementary teacher education', '2025-04-30 08:09:45', '2025-04-30 08:09:45'),
('8', 'Department of Secondary Education', NULL, '3', 'Secondary teacher education', '2025-04-30 08:09:45', '2025-04-30 08:09:45'),
('9', 'Department of Civil Engineering', NULL, '4', 'Civil engineering program', '2025-04-30 08:09:45', '2025-04-30 08:09:45'),
('10', 'Department of Computer Engineering', NULL, '4', 'Computer engineering program', '2025-04-30 08:09:45', '2025-04-30 08:09:45'),
('11', 'Department of Electrical Engineering', NULL, '4', 'Electrical engineering program', '2025-04-30 08:09:45', '2025-04-30 08:09:45'),
('12', 'Department of Nursing', NULL, '5', 'BS Nursing program', '2025-04-30 08:09:45', '2025-04-30 08:09:45'),
('13', 'Department of Criminology', NULL, '6', 'BS Criminology program', '2025-04-30 08:09:45', '2025-04-30 08:09:45'),
('14', 'Department of Information Technology', 'BSInfotech', '7', 'Information technology and computer-related programs', '2025-04-30 08:09:45', '2025-10-25 09:55:26'),
('16', 'N/A', NULL, NULL, '....', '2025-04-30 08:09:45', '2025-04-30 08:09:45'),
('17', 'Department of Computer Science', 'ComSci', '7', '....', '2025-04-30 08:09:45', '2025-10-24 22:43:10'),
('18', 'Bachelor of Science in Administration - Major in Financial Management', NULL, '2', NULL, '2025-10-23 19:57:15', '2025-10-23 19:57:15');

--
-- Table structure for table `faculty`
--

DROP TABLE IF EXISTS `faculty`;
CREATE TABLE `faculty` (
  `faculty_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `employee_id` varchar(20) NOT NULL,
  `academic_rank` enum('Instructor I','Instructor II','Instructor III','Assistant Professor I','Assistant Professor II','Assistant Professor III','Assistant Professor IV','Associate Professor I','Associate Professor II','Associate Professor III','Associate Professor IV','Associate Professor V','Professor I','Professor II','Professor III','Professor IV','Professor V','Professor VI','Professor VII','University Professor') DEFAULT NULL,
  `employment_type` enum('Regular','Contractual','Part-time','Full-time') DEFAULT NULL,
  `classification` enum('TL','VSL') DEFAULT NULL,
  `max_hours` decimal(5,2) NOT NULL DEFAULT 18.00,
  `bachelor_degree` varchar(50) DEFAULT NULL,
  `master_degree` varchar(50) DEFAULT NULL,
  `doctorate_degree` varchar(50) DEFAULT NULL,
  `post_doctorate_degree` varchar(50) DEFAULT NULL,
  `designation` varchar(100) DEFAULT NULL,
  `equiv_teaching_load` decimal(5,2) DEFAULT NULL,
  `total_lecture_hours` decimal(5,2) DEFAULT NULL,
  `total_laboratory_hours` decimal(5,2) DEFAULT NULL,
  `total_laboratory_hours_x075` decimal(5,2) DEFAULT NULL,
  `no_of_preparation` int(3) DEFAULT NULL,
  `advisory_class` varchar(100) DEFAULT NULL,
  `equiv_units_no_of_prep` decimal(5,2) DEFAULT NULL,
  `actual_teaching_loads` decimal(5,2) DEFAULT NULL,
  `total_working_load` decimal(5,2) DEFAULT NULL,
  `excess_hours` decimal(5,2) DEFAULT NULL,
  `primary_program_id` int(10) unsigned DEFAULT NULL,
  `secondary_program_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`faculty_id`),
  UNIQUE KEY `unq_faculty_user` (`user_id`),
  UNIQUE KEY `unq_employee_id` (`employee_id`),
  KEY `idx_position_employment` (`academic_rank`,`employment_type`),
  KEY `idx_primary_program_id` (`primary_program_id`),
  KEY `idx_secondary_program_id` (`secondary_program_id`),
  KEY `idx_faculty_department_classification` (`classification`),
  CONSTRAINT `fk_faculty_primary_program` FOREIGN KEY (`primary_program_id`) REFERENCES `programs` (`program_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_faculty_secondary_program` FOREIGN KEY (`secondary_program_id`) REFERENCES `programs` (`program_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_faculty_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Faculty members information including academic rank';

--
-- Dumping data for table `faculty`
--

INSERT INTO `faculty` (`faculty_id`, `user_id`, `employee_id`, `academic_rank`, `employment_type`, `classification`, `max_hours`, `bachelor_degree`, `master_degree`, `doctorate_degree`, `post_doctorate_degree`, `designation`, `equiv_teaching_load`, `total_lecture_hours`, `total_laboratory_hours`, `total_laboratory_hours_x075`, `no_of_preparation`, `advisory_class`, `equiv_units_no_of_prep`, `actual_teaching_loads`, `total_working_load`, `excess_hours`, `primary_program_id`, `secondary_program_id`, `created_at`, `updated_at`) VALUES 
('1', '18', '7879', 'Professor V', 'Part-time', 'VSL', '18.00', 'Bachelor of Information Technology', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, '2025-05-13 08:49:16', '2025-10-13 23:21:45'),
('2', '19', '01', '', 'Part-time', NULL, '18.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, '2025-05-13 11:56:30', '2025-09-27 23:10:41'),
('3', '20', '02', '', 'Part-time', 'VSL', '18.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, '2025-05-13 11:58:49', '2025-11-01 10:24:26'),
('4', '21', '8008', '', 'Contractual', NULL, '18.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, '2025-05-13 12:00:29', '2025-05-13 12:00:29'),
('5', '22', '03', '', 'Part-time', NULL, '18.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, '2025-05-13 12:01:47', '2025-09-27 23:10:25'),
('6', '23', '04', '', 'Part-time', NULL, '18.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, '2025-05-13 12:04:47', '2025-09-27 23:15:42'),
('7', '24', '39', '', 'Part-time', NULL, '18.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, '2025-05-13 12:07:42', '2025-09-27 23:10:17'),
('8', '25', '05', '', 'Part-time', NULL, '18.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2', NULL, '2025-05-13 12:08:30', '2025-08-14 17:38:53'),
('9', '27', '10009', '', 'Regular', NULL, '18.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, '2025-05-13 13:52:03', '2025-05-13 13:52:03'),
('10', '28', '06', '', 'Part-time', NULL, '18.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2', NULL, '2025-05-13 15:56:16', '2025-09-27 23:10:50'),
('11', '31', '07', '', 'Regular', NULL, '18.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2', NULL, '2025-05-13 17:34:54', '2025-05-13 17:34:54'),
('12', '32', '08', '', 'Part-time', NULL, '18.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2', NULL, '2025-05-13 17:39:53', '2025-09-27 22:47:03'),
('13', '33', '09', '', 'Part-time', NULL, '18.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2', NULL, '2025-05-13 17:53:15', '2025-09-27 23:09:56'),
('14', '36', '10', '', 'Part-time', NULL, '18.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2', NULL, '2025-05-13 18:07:13', '2025-08-14 17:37:34'),
('15', '37', '11', '', 'Regular', NULL, '18.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2', NULL, '2025-05-13 18:09:42', '2025-05-13 18:09:42'),
('16', '38', '12', '', 'Part-time', NULL, '18.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2', NULL, '2025-05-13 18:11:38', '2025-10-13 23:19:54'),
('17', '1', '8000', 'Associate Professor IV', 'Regular', 'VSL', '18.00', 'Bachelor of Information Technology', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, '2025-05-17 09:43:45', '2025-10-29 20:11:40'),
('18', '26', '22', 'Professor IV', 'Regular', 'TL', '18.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2', NULL, '2025-05-17 09:43:45', '2025-10-07 19:42:07'),
('19', '49', '7979', '', 'Part-time', 'TL', '18.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2', NULL, '2025-06-28 14:13:38', '2025-10-18 17:54:20'),
('20', '50', '5555', '', 'Regular', 'TL', '18.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, '2025-08-15 12:56:39', '2025-08-15 12:56:39'),
('21', '54', '2367', '', 'Part-time', 'TL', '18.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-15 14:06:54', '2025-08-15 14:06:54'),
('24', '57', '5824', '', '', '', '18.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '4', NULL, '2025-08-15 14:26:43', '2025-08-15 14:26:43'),
('26', '59', '6740', 'Assistant Professor II', 'Part-time', 'VSL', '18.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-16 09:29:57', '2025-10-15 23:31:16'),
('27', '66', '4524', '', 'Regular', NULL, '18.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-23 11:03:51', '2025-08-23 11:03:51'),
('28', '45', '1234', '', 'Regular', NULL, '18.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 20:48:04', '2025-10-21 21:03:25'),
('29', '2', '1000', 'Professor IV', 'Regular', 'VSL', '18.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-02 14:04:40', '2025-10-04 23:46:39'),
('30', '65', '', 'Associate Professor II', 'Regular', 'TL', '18.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-02 14:10:19', '2025-10-30 17:20:45'),
('31', '67', '34', 'Assistant Professor I', 'Regular', NULL, '18.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-25 16:41:31', '2025-09-25 16:41:31'),
('33', '69', '35', 'Professor III', 'Regular', 'VSL', '18.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-22 22:38:37', '2025-10-22 22:38:37'),
('34', '70', '67', '', 'Part-time', 'VSL', '18.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-23 20:24:58', '2025-10-28 22:46:23'),
('35', '71', '0026', 'Professor I', 'Regular', 'TL', '18.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-02 22:08:03', '2025-11-02 22:08:03');

--
-- Table structure for table `faculty_departments`
--

DROP TABLE IF EXISTS `faculty_departments`;
CREATE TABLE `faculty_departments` (
  `faculty_department_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `faculty_id` int(10) unsigned NOT NULL,
  `department_id` smallint(5) unsigned DEFAULT NULL,
  `is_active` tinyint(6) DEFAULT NULL,
  `is_primary` tinyint(1) DEFAULT 0 COMMENT 'Indicates if this is the primary department',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`faculty_department_id`),
  UNIQUE KEY `unq_faculty_department` (`faculty_id`,`department_id`),
  KEY `idx_faculty_id` (`faculty_id`),
  KEY `idx_department_id` (`department_id`),
  CONSTRAINT `faculty_departments_ibfk_1` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`faculty_id`),
  CONSTRAINT `faculty_departments_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Many-to-many relationship between faculty and departments';

--
-- Dumping data for table `faculty_departments`
--

INSERT INTO `faculty_departments` (`faculty_department_id`, `faculty_id`, `department_id`, `is_active`, `is_primary`, `created_at`, `updated_at`) VALUES 
('2', '12', '14', '1', '1', '2025-09-27 22:47:03', NULL),
('3', '3', '14', NULL, '1', '2025-09-27 23:09:48', NULL),
('4', '13', '14', NULL, '1', '2025-09-27 23:09:56', NULL),
('5', '7', '14', NULL, '1', '2025-09-27 23:10:17', NULL),
('6', '5', '14', NULL, '1', '2025-09-27 23:10:25', NULL),
('7', '2', '14', NULL, '1', '2025-09-27 23:10:41', NULL),
('8', '10', '14', NULL, '1', '2025-09-27 23:10:50', NULL),
('9', '17', '14', NULL, '1', '2025-09-27 23:15:17', NULL),
('10', '6', '14', NULL, '1', '2025-09-27 23:15:42', NULL),
('11', '18', '17', NULL, '1', '2025-10-05 00:10:42', NULL),
('12', '16', '14', NULL, '1', '2025-10-13 23:19:54', NULL);

--
-- Table structure for table `faculty_requests`
--

DROP TABLE IF EXISTS `faculty_requests`;
CREATE TABLE `faculty_requests` (
  `request_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(20) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) NOT NULL,
  `suffix` varchar(10) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(60) NOT NULL,
  `department_id` smallint(5) unsigned NOT NULL,
  `college_id` smallint(5) unsigned NOT NULL,
  `academic_rank` enum('Instructor','Assistant Professor','Associate Professor','Professor','Distinguished Professor','University Professor','Emeritus Professor','Visiting Professor','Adjunct Professor','Lecturer','Senior Lecturer','Research Professor','Clinical Professor','Professor of Practice') NOT NULL,
  `employment_type` enum('Regular','Contractual','Part-time') NOT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`request_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `employee_id` (`employee_id`),
  KEY `department_id` (`department_id`),
  KEY `idx_faculty_requests_status` (`status`),
  KEY `idx_faculty_requests_college_id` (`college_id`),
  CONSTRAINT `faculty_requests_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`),
  CONSTRAINT `faculty_requests_ibfk_2` FOREIGN KEY (`college_id`) REFERENCES `colleges` (`college_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `faculty_requests`
--

--
-- Table structure for table `prerequisite_chains`
--

DROP TABLE IF EXISTS `prerequisite_chains`;
CREATE TABLE `prerequisite_chains` (
  `chain_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `curriculum_course_id` int(10) unsigned NOT NULL,
  `prerequisite_course_id` int(10) unsigned NOT NULL,
  `strict_requirement` tinyint(1) DEFAULT 1,
  `alternative_course_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`chain_id`),
  KEY `idx_curriculum_course_id` (`curriculum_course_id`),
  KEY `idx_prerequisite_course_id` (`prerequisite_course_id`),
  KEY `idx_alternative_course_id` (`alternative_course_id`),
  CONSTRAINT `fk_chain_alt` FOREIGN KEY (`alternative_course_id`) REFERENCES `courses` (`course_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_chain_cc` FOREIGN KEY (`curriculum_course_id`) REFERENCES `curriculum_courses` (`curriculum_course_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_chain_prereq` FOREIGN KEY (`prerequisite_course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Complex prerequisite structure handling';

--
-- Dumping data for table `prerequisite_chains`
--

--
-- Table structure for table `program_chairs`
--

DROP TABLE IF EXISTS `program_chairs`;
CREATE TABLE `program_chairs` (
  `chair_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `faculty_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `program_id` int(10) unsigned NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `is_current` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`chair_id`),
  UNIQUE KEY `unq_current_program_chair` (`program_id`,`is_current`),
  KEY `fk_chair_program` (`program_id`),
  KEY `fk_chair_faculty` (`faculty_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `fk_chair_faculty` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`faculty_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_chair_program` FOREIGN KEY (`program_id`) REFERENCES `programs` (`program_id`) ON DELETE CASCADE,
  CONSTRAINT `program_chairs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Program chair assignments';

--
-- Dumping data for table `program_chairs`
--

INSERT INTO `program_chairs` (`chair_id`, `faculty_id`, `user_id`, `program_id`, `start_date`, `end_date`, `is_current`, `created_at`, `updated_at`) VALUES 
('1', '17', '1', '1', '2025-05-01', '2025-05-31', '1', '2025-05-01 15:49:19', '2025-10-05 00:48:34'),
('5', '18', '26', '2', '2025-05-13', '2025-05-13', '1', '2025-05-13 15:46:03', '2025-10-30 21:14:52'),
('10', '18', '53', '3', '2025-08-15', '2025-08-15', '1', '2025-08-15 13:26:43', '2025-10-30 21:20:04'),
('13', '24', '57', '4', '2025-08-15', NULL, '1', '2025-08-15 14:26:43', '2025-08-15 14:26:43'),
('16', '33', '69', '6', '2025-10-22', NULL, '1', '2025-10-22 22:38:37', '2025-10-22 22:38:37'),
('17', '34', '70', '5', '2025-10-23', NULL, '1', '2025-10-23 20:24:58', '2025-10-23 20:24:58');

--
-- Table structure for table `program_requirements`
--

DROP TABLE IF EXISTS `program_requirements`;
CREATE TABLE `program_requirements` (
  `requirement_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `program_id` int(10) unsigned NOT NULL,
  `curriculum_course_id` int(10) unsigned NOT NULL,
  `requirement_type` enum('Core','Elective','Capstone','Thesis') NOT NULL DEFAULT 'Core',
  `year_level` enum('1st Year','2nd Year','3rd Year','4th Year') NOT NULL,
  `semester` enum('1st','2nd','Summer') NOT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`requirement_id`),
  UNIQUE KEY `unq_program_course` (`program_id`,`curriculum_course_id`),
  KEY `idx_program_id` (`program_id`),
  KEY `idx_curriculum_course_id` (`curriculum_course_id`),
  KEY `idx_requirement_type` (`requirement_type`),
  CONSTRAINT `fk_pr_curriculum_course` FOREIGN KEY (`curriculum_course_id`) REFERENCES `curriculum_courses` (`curriculum_course_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_pr_program` FOREIGN KEY (`program_id`) REFERENCES `programs` (`program_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Courses required for each major/minor program';

--
-- Dumping data for table `program_requirements`
--

--
-- Table structure for table `programs`
--

DROP TABLE IF EXISTS `programs`;
CREATE TABLE `programs` (
  `program_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `program_name` varchar(100) NOT NULL,
  `program_code` varchar(20) NOT NULL,
  `program_type` enum('Major','Minor','Concentration') NOT NULL,
  `department_id` smallint(5) unsigned NOT NULL,
  `total_units` smallint(5) unsigned DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`program_id`),
  UNIQUE KEY `unq_program_code` (`program_code`),
  KEY `idx_program_type` (`program_type`),
  KEY `idx_department_id` (`department_id`),
  CONSTRAINT `fk_program_department` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Academic major and minor programs';

--
-- Dumping data for table `programs`
--

INSERT INTO `programs` (`program_id`, `program_name`, `program_code`, `program_type`, `department_id`, `total_units`, `description`, `is_active`, `created_at`, `updated_at`) VALUES 
('1', 'Bachelor of Science in Information Technology', 'BSIT', 'Major', '14', NULL, 'A program focusing on IT skills and technologies', '1', '2025-04-30 08:09:45', '2025-04-30 08:09:45'),
('2', 'Bachelor of Science in Computer Science', 'BSCS', 'Major', '17', '185', '4-year Computer Science program', '1', '2025-04-30 08:09:45', '2025-04-30 08:09:45'),
('3', 'Business Administration', 'BSbd', 'Major', '5', NULL, 'hello', '1', '2025-08-15 13:12:13', '2025-08-15 13:12:13'),
('4', 'wfgbuwef', 'BSA', 'Major', '4', NULL, NULL, '1', '2025-08-15 14:25:47', '2025-08-15 14:25:47'),
('5', 'Bachelor of Science in Nursing', 'BSN', 'Major', '12', NULL, NULL, '1', '2025-10-21 20:59:33', '2025-10-21 20:59:33'),
('6', 'General: Elementary', 'BEED', 'Major', '7', NULL, NULL, '1', '2025-10-22 22:34:04', '2025-10-22 22:34:04'),
('7', 'Specialist: Secondary', 'Secondary', 'Major', '8', NULL, NULL, '1', '2025-10-22 22:34:50', '2025-10-22 22:34:50'),
('8', 'Major in Finance', 'BSBA - FM', 'Major', '18', NULL, NULL, '1', '2025-10-23 19:57:15', '2025-10-23 19:57:15');

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
CREATE TABLE `reports` (
  `report_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `report_name` varchar(100) NOT NULL,
  `report_type` enum('Schedule','Faculty Load','Room Utilization','Curriculum','Custom') NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `parameters` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`parameters`)),
  `generated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`report_id`),
  KEY `idx_report_type` (`report_type`),
  KEY `idx_created_by` (`created_by`),
  KEY `idx_generated_at` (`generated_at`),
  CONSTRAINT `fk_report_creator` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='System generated reports';

--
-- Dumping data for table `reports`
--

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `role_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `role_name` enum('Admin','VPAA','D.I','Dean','Chair','Faculty') NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`role_id`),
  KEY `idx_role_name` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='User roles for role-based access control';

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`role_id`, `role_name`, `description`, `created_at`) VALUES 
('1', 'Admin', 'System administrator with full access', '2025-04-30 08:09:45'),
('2', 'VPAA', 'Vice President for Academic Affairs', '2025-04-30 08:09:45'),
('3', 'D.I', 'College Director', '2025-04-30 08:09:45'),
('4', 'Dean', 'College Dean', '2025-04-30 08:09:45'),
('5', 'Chair', 'Department Chairperson', '2025-04-30 08:09:45'),
('6', 'Faculty', 'Teaching faculty member', '2025-04-30 08:09:45');

--
-- Table structure for table `room_reservations`
--

DROP TABLE IF EXISTS `room_reservations`;
CREATE TABLE `room_reservations` (
  `reservation_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `room_id` int(10) unsigned NOT NULL,
  `reserved_by` int(10) unsigned NOT NULL,
  `event_name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `approval_status` enum('Pending','Approved','Rejected') DEFAULT 'Pending',
  `approved_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`reservation_id`),
  KEY `fk_reservation_approver` (`approved_by`),
  KEY `idx_room_id` (`room_id`),
  KEY `idx_date_time` (`date`,`start_time`,`end_time`),
  KEY `idx_approval_status` (`approval_status`),
  KEY `idx_reserved_by` (`reserved_by`),
  CONSTRAINT `fk_reservation_approver` FOREIGN KEY (`approved_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_reservation_room` FOREIGN KEY (`room_id`) REFERENCES `classrooms` (`room_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_reservation_user` FOREIGN KEY (`reserved_by`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Room reservations for special events';

--
-- Dumping data for table `room_reservations`
--

--
-- Table structure for table `schedule_deadlines`
--

DROP TABLE IF EXISTS `schedule_deadlines`;
CREATE TABLE `schedule_deadlines` (
  `deadline_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `department_id` smallint(5) unsigned NOT NULL,
  `deadline` datetime NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `is_active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`deadline_id`),
  UNIQUE KEY `unique_dept_deadline` (`department_id`),
  KEY `user_id` (`user_id`),
  KEY `idx_schedule_deadlines_dept_deadline` (`department_id`,`deadline`),
  CONSTRAINT `schedule_deadlines_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `schedule_deadlines_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=410 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `schedule_deadlines`
--

INSERT INTO `schedule_deadlines` (`deadline_id`, `user_id`, `department_id`, `deadline`, `created_at`, `is_active`) VALUES 
('1', '65', '1', '2025-12-03 15:20:00', '2025-11-03 23:20:07', '1'),
('2', '65', '2', '2025-12-03 15:20:00', '2025-11-03 23:20:07', '1'),
('3', '65', '3', '2025-12-03 15:20:00', '2025-11-03 23:20:07', '1'),
('4', '65', '4', '2025-12-03 15:20:00', '2025-11-03 23:20:07', '1'),
('5', '65', '5', '2025-12-03 15:20:00', '2025-11-03 23:20:07', '1'),
('6', '65', '6', '2025-12-03 15:20:00', '2025-11-03 23:20:07', '1'),
('7', '65', '14', '2025-12-03 15:20:00', '2025-11-03 23:20:07', '1'),
('8', '65', '17', '2025-12-03 15:20:00', '2025-11-03 23:20:07', '1'),
('9', '65', '13', '2025-12-03 15:20:00', '2025-11-03 23:20:07', '1'),
('10', '65', '7', '2025-12-03 15:20:00', '2025-11-03 23:20:07', '1'),
('11', '65', '8', '2025-12-03 15:20:00', '2025-11-03 23:20:07', '1'),
('12', '65', '9', '2025-12-03 15:20:00', '2025-11-03 23:20:07', '1'),
('13', '65', '10', '2025-12-03 15:20:00', '2025-11-03 23:20:07', '1'),
('14', '65', '11', '2025-12-03 15:20:00', '2025-11-03 23:20:07', '1'),
('15', '65', '12', '2025-12-03 15:20:00', '2025-11-03 23:20:07', '1'),
('158', '65', '18', '2025-12-03 15:20:00', '2025-11-03 23:20:07', '1');

--
-- Table structure for table `schedule_requests`
--

DROP TABLE IF EXISTS `schedule_requests`;
CREATE TABLE `schedule_requests` (
  `request_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `faculty_id` int(10) unsigned NOT NULL,
  `schedule_id` int(10) unsigned NOT NULL,
  `request_type` enum('time_change','room_change') NOT NULL,
  `details` text NOT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`request_id`),
  KEY `faculty_id` (`faculty_id`),
  KEY `schedule_id` (`schedule_id`),
  CONSTRAINT `schedule_requests_ibfk_1` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`faculty_id`),
  CONSTRAINT `schedule_requests_ibfk_2` FOREIGN KEY (`schedule_id`) REFERENCES `schedules` (`schedule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `schedule_requests`
--

--
-- Table structure for table `schedules`
--

DROP TABLE IF EXISTS `schedules`;
CREATE TABLE `schedules` (
  `schedule_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` int(10) unsigned NOT NULL,
  `section_id` int(10) unsigned NOT NULL,
  `room_id` int(10) unsigned DEFAULT NULL,
  `semester_id` int(10) unsigned NOT NULL,
  `faculty_id` int(10) unsigned NOT NULL,
  `department_id` smallint(5) unsigned NOT NULL,
  `schedule_type` enum('F2F','Online','Hybrid','Asynchronous') NOT NULL,
  `day_of_week` enum('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday') NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `status` enum('Pending','Dean_Approved','Di_Approved','Approved','Rejected') NOT NULL DEFAULT 'Pending',
  `approved_by_dean` int(10) unsigned DEFAULT NULL,
  `approved_by_di` int(11) DEFAULT NULL,
  `is_public` tinyint(4) NOT NULL,
  `approval_date_dean` timestamp NULL DEFAULT NULL,
  `approval_date_di` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `component_type` enum('lecture','laboratory','tutorial','recitation','workshop') DEFAULT 'lecture',
  PRIMARY KEY (`schedule_id`),
  KEY `fk_schedule_section` (`section_id`),
  KEY `fk_schedule_approver` (`approved_by_dean`),
  KEY `idx_course_section` (`course_id`,`section_id`),
  KEY `idx_room_id` (`room_id`),
  KEY `idx_faculty_id` (`faculty_id`),
  KEY `idx_semester_id` (`semester_id`),
  KEY `idx_day_time` (`day_of_week`,`start_time`,`end_time`),
  KEY `idx_schedule_status` (`status`),
  KEY `idx_schedule_type` (`schedule_type`),
  KEY `idx_schedule_status_type` (`status`,`schedule_type`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `fk_schedule_approver` FOREIGN KEY (`approved_by_dean`) REFERENCES `users` (`user_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_schedule_course` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_schedule_room` FOREIGN KEY (`room_id`) REFERENCES `classrooms` (`room_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_schedule_semester` FOREIGN KEY (`semester_id`) REFERENCES `semesters` (`semester_id`) ON DELETE CASCADE,
  CONSTRAINT `schedules_ibfk_1` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`faculty_id`),
  CONSTRAINT `schedules_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Class schedules';

--
-- Dumping data for table `schedules`
--

--
-- Table structure for table `section_courses`
--

DROP TABLE IF EXISTS `section_courses`;
CREATE TABLE `section_courses` (
  `section_course_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `section_id` int(10) unsigned NOT NULL,
  `course_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`section_course_id`),
  UNIQUE KEY `uk_section_course` (`section_id`,`course_id`) COMMENT 'Prevent duplicate course assignments',
  KEY `idx_section_id` (`section_id`),
  KEY `idx_course_id` (`course_id`),
  CONSTRAINT `section_courses_ibfk_1` FOREIGN KEY (`section_id`) REFERENCES `sections` (`section_id`) ON DELETE CASCADE,
  CONSTRAINT `section_courses_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `section_courses`
--

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
CREATE TABLE `sections` (
  `section_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `section_name` varchar(50) NOT NULL COMMENT 'e.g., BSIT-1A',
  `department_id` smallint(5) unsigned NOT NULL,
  `semester_id` int(10) unsigned NOT NULL,
  `year_level` enum('1st Year','2nd Year','3rd Year','4th Year') NOT NULL,
  `semester` enum('1st','2nd','Summer','Mid Year') NOT NULL,
  `academic_year` varchar(9) NOT NULL COMMENT 'Format: YYYY-YYYY',
  `max_students` smallint(5) unsigned NOT NULL DEFAULT 40 COMMENT 'Max students per section',
  `current_students` smallint(5) unsigned DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`section_id`),
  UNIQUE KEY `uk_active_section_name_dept_year` (`section_name`,`department_id`,`academic_year`,`is_active`),
  KEY `idx_department_id` (`department_id`),
  KEY `idx_year_level_semester` (`year_level`,`semester`),
  KEY `idx_academic_year` (`academic_year`),
  KEY `semester_id` (`semester_id`),
  CONSTRAINT `sections_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`),
  CONSTRAINT `sections_ibfk_3` FOREIGN KEY (`semester_id`) REFERENCES `semesters` (`semester_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sections`
--

INSERT INTO `sections` (`section_id`, `section_name`, `department_id`, `semester_id`, `year_level`, `semester`, `academic_year`, `max_students`, `current_students`, `is_active`, `created_at`, `updated_at`) VALUES 
('1', 'BSIT-1A', '14', '6', '1st Year', '2nd', '2025-2026', '40', '40', '0', '2025-09-26 12:32:53', '2025-11-01 07:57:17'),
('2', 'BSIT-1B', '14', '6', '1st Year', '2nd', '2025-2026', '40', '40', '0', '2025-09-26 16:04:19', '2025-11-01 07:57:17'),
('3', 'BSIT-1C', '14', '6', '1st Year', '2nd', '2025-2026', '40', '40', '0', '2025-09-26 16:04:26', '2025-11-01 07:57:17'),
('4', 'BSIT-1D', '14', '6', '1st Year', '2nd', '2025-2026', '40', '40', '0', '2025-09-26 16:04:37', '2025-11-01 07:57:17'),
('5', 'BSIT-2A', '14', '6', '2nd Year', '2nd', '2025-2026', '40', '40', '0', '2025-09-26 16:05:04', '2025-11-01 07:57:17'),
('6', 'BSIT-2B', '14', '6', '2nd Year', '2nd', '2025-2026', '40', '40', '0', '2025-09-26 16:05:16', '2025-11-01 07:57:17'),
('7', 'BSIT-2C', '14', '6', '2nd Year', '2nd', '2025-2026', '40', '40', '0', '2025-09-26 16:05:26', '2025-11-01 07:57:17'),
('8', 'BSIT-2D', '14', '6', '2nd Year', '2nd', '2025-2026', '40', '40', '0', '2025-09-26 16:05:39', '2025-11-01 07:57:17'),
('9', 'BSIT-3A', '14', '6', '3rd Year', '2nd', '2025-2026', '40', '40', '0', '2025-09-26 16:05:51', '2025-11-01 07:57:17'),
('10', 'BSIT-3B', '14', '6', '3rd Year', '2nd', '2025-2026', '40', '40', '0', '2025-09-26 16:06:08', '2025-11-01 07:57:17'),
('11', 'BSIT-3C', '14', '6', '3rd Year', '2nd', '2025-2026', '40', '40', '0', '2025-09-26 16:06:17', '2025-11-01 07:57:17'),
('12', 'BSIT-3D', '14', '6', '3rd Year', '2nd', '2025-2026', '40', '40', '0', '2025-09-26 16:06:30', '2025-11-01 07:57:17'),
('13', 'BSIT-4A', '14', '6', '4th Year', '2nd', '2025-2026', '40', '40', '0', '2025-09-26 16:06:39', '2025-11-01 07:57:17'),
('14', 'BSIT-4B', '14', '6', '4th Year', '2nd', '2025-2026', '40', '40', '0', '2025-09-26 16:07:16', '2025-11-01 07:57:17'),
('15', 'BSIT-4C', '14', '6', '4th Year', '2nd', '2025-2026', '40', '40', '0', '2025-09-26 16:07:28', '2025-11-01 07:57:17'),
('16', 'BSIT-4D', '14', '6', '4th Year', '2nd', '2025-2026', '40', '40', '0', '2025-09-26 16:07:38', '2025-11-01 07:57:17'),
('33', 'BSIT-3A', '14', '8', '3rd Year', 'Mid Year', '2025-2026', '40', '0', '1', '2025-11-01 07:59:42', '2025-11-01 07:59:42'),
('34', 'BSIT-3B', '14', '8', '3rd Year', 'Mid Year', '2025-2026', '40', '0', '1', '2025-11-01 07:59:55', '2025-11-01 07:59:55'),
('35', 'BSIT-3C', '14', '8', '3rd Year', 'Mid Year', '2025-2026', '40', '0', '1', '2025-11-01 08:00:05', '2025-11-01 08:00:05'),
('36', 'BSIT 1-A', '14', '6', '1st Year', '2nd', '2025-2026', '40', '40', '1', '2025-11-02 21:36:54', '2025-11-02 21:36:54'),
('37', 'BSIT 1-B', '14', '6', '1st Year', '2nd', '2025-2026', '40', '40', '1', '2025-11-02 21:37:04', '2025-11-02 21:37:04'),
('38', 'BSIT 1-C', '14', '6', '1st Year', '2nd', '2025-2026', '40', '40', '1', '2025-11-02 21:37:13', '2025-11-02 21:37:13'),
('39', 'BSIT 1-D', '14', '6', '1st Year', '2nd', '2025-2026', '40', '40', '1', '2025-11-02 21:37:27', '2025-11-02 21:37:27'),
('40', 'BSIT 2-A', '14', '6', '2nd Year', '2nd', '2025-2026', '40', '40', '1', '2025-11-02 21:38:05', '2025-11-02 21:38:05'),
('41', 'BSIT 2-B', '14', '6', '2nd Year', '2nd', '2025-2026', '40', '40', '1', '2025-11-02 21:38:14', '2025-11-02 21:38:14'),
('42', 'BSIT 2-C', '14', '6', '2nd Year', '2nd', '2025-2026', '40', '40', '1', '2025-11-02 21:38:33', '2025-11-02 21:38:33'),
('43', 'BSIT 2-D', '14', '6', '2nd Year', '2nd', '2025-2026', '40', '40', '1', '2025-11-02 21:38:53', '2025-11-02 21:38:53'),
('44', 'BSIT 3-A', '14', '6', '3rd Year', '2nd', '2025-2026', '40', '40', '1', '2025-11-02 21:39:10', '2025-11-02 21:39:10'),
('45', 'BSIT 3-B', '14', '6', '3rd Year', '2nd', '2025-2026', '40', '40', '1', '2025-11-02 21:39:20', '2025-11-02 21:39:20'),
('46', 'BSIT 3-C', '14', '6', '3rd Year', '2nd', '2025-2026', '40', '40', '1', '2025-11-02 21:39:32', '2025-11-02 21:39:32'),
('47', 'BSIT 3-D', '14', '6', '3rd Year', '2nd', '2025-2026', '40', '40', '1', '2025-11-02 21:39:47', '2025-11-02 21:39:47'),
('48', 'BSIT 4-A', '14', '6', '4th Year', '2nd', '2025-2026', '40', '40', '1', '2025-11-02 21:40:05', '2025-11-02 21:40:05'),
('49', 'BSIT 4-B', '14', '6', '4th Year', '2nd', '2025-2026', '40', '40', '1', '2025-11-02 21:40:14', '2025-11-02 21:40:14'),
('50', 'BSIT 4-C', '14', '6', '4th Year', '2nd', '2025-2026', '40', '40', '1', '2025-11-02 21:40:25', '2025-11-02 21:40:25'),
('51', 'BSIT 4-D', '14', '6', '4th Year', '2nd', '2025-2026', '40', '40', '1', '2025-11-02 21:40:37', '2025-11-02 21:40:37');

--
-- Table structure for table `semesters`
--

DROP TABLE IF EXISTS `semesters`;
CREATE TABLE `semesters` (
  `semester_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `semester_name` enum('1st','2nd','Mid Year') NOT NULL,
  `academic_year` varchar(9) NOT NULL COMMENT 'Format: YYYY-YYYY',
  `year_start` year(4) NOT NULL,
  `year_end` year(4) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `is_current` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`semester_id`),
  UNIQUE KEY `unq_semester_year` (`semester_name`,`academic_year`),
  KEY `idx_date_range` (`start_date`,`end_date`),
  KEY `idx_is_current` (`is_current`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Academic semesters';

--
-- Dumping data for table `semesters`
--

INSERT INTO `semesters` (`semester_id`, `semester_name`, `academic_year`, `year_start`, `year_end`, `start_date`, `end_date`, `is_current`, `created_at`) VALUES 
('1', '1st', '2023-2024', '2023', '2024', '2023-08-14', '2023-12-15', '0', '2025-04-30 08:09:46'),
('2', '2nd', '2023-2024', '2023', '2024', '2024-01-08', '2024-05-17', '0', '2025-04-30 08:09:46'),
('3', '', '2023-2024', '2023', '2024', '2024-06-03', '2024-07-26', '0', '2025-04-30 08:09:46'),
('4', '1st', '2024-2025', '2024', '2025', '2024-08-12', '2024-12-13', '0', '2025-04-30 08:09:46'),
('5', '1st', '2025-2026', '2025', '2026', '2025-06-01', '2026-05-31', '0', '2025-08-24 21:27:56'),
('6', '2nd', '2025-2026', '2025', '2026', '2025-06-01', '2026-05-31', '1', '2025-09-17 10:34:38'),
('8', 'Mid Year', '2025-2026', '2025', '2026', '2025-06-01', '2026-05-31', '0', '2025-11-01 07:56:39');

--
-- Table structure for table `specializations`
--

DROP TABLE IF EXISTS `specializations`;
CREATE TABLE `specializations` (
  `specialization_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `faculty_id` int(10) unsigned NOT NULL,
  `course_id` int(10) unsigned DEFAULT NULL,
  `expertise_level` enum('Beginner','Intermediate','Expert') DEFAULT 'Intermediate',
  `program_id` int(10) unsigned DEFAULT NULL,
  `is_primary_specialization` tinyint(1) DEFAULT 0,
  `updated_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`specialization_id`),
  UNIQUE KEY `unq_faculty_subject` (`faculty_id`,`course_id`),
  KEY `idx_faculty_subject` (`faculty_id`,`course_id`),
  KEY `idx_program_id` (`program_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `fk_specialization_faculty` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`faculty_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_specialization_program` FOREIGN KEY (`program_id`) REFERENCES `programs` (`program_id`) ON DELETE SET NULL,
  CONSTRAINT `specializations_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Faculty teaching specializations and expertise';

--
-- Dumping data for table `specializations`
--

INSERT INTO `specializations` (`specialization_id`, `faculty_id`, `course_id`, `expertise_level`, `program_id`, `is_primary_specialization`, `updated_at`, `created_at`) VALUES 
('2', '19', '95', 'Beginner', NULL, '0', NULL, '2025-06-28 15:37:35'),
('3', '1', '60', 'Intermediate', NULL, '0', NULL, '2025-08-04 11:22:23'),
('7', '17', '95', 'Expert', NULL, '0', '2025-09-04 19:34:27', '2025-09-02 11:26:02'),
('9', '17', '105', 'Expert', NULL, '0', NULL, '2025-09-06 18:27:44'),
('13', '13', '104', 'Intermediate', NULL, '0', NULL, '2025-11-02 22:50:24'),
('14', '13', '67', 'Intermediate', NULL, '0', NULL, '2025-11-02 22:50:48'),
('15', '16', '98', 'Intermediate', NULL, '0', NULL, '2025-11-02 23:10:47'),
('16', '16', '92', 'Intermediate', NULL, '0', NULL, '2025-11-02 23:11:20'),
('17', '7', '88', 'Intermediate', NULL, '0', NULL, '2025-11-02 23:12:17'),
('18', '7', '109', 'Intermediate', NULL, '0', NULL, '2025-11-02 23:12:25'),
('19', '5', '81', 'Intermediate', NULL, '0', NULL, '2025-11-02 23:14:30'),
('20', '5', '82', 'Intermediate', NULL, '0', NULL, '2025-11-02 23:15:47'),
('21', '5', '76', 'Intermediate', NULL, '0', NULL, '2025-11-02 23:16:44'),
('22', '6', '60', 'Intermediate', NULL, '0', NULL, '2025-11-02 23:20:14'),
('23', '6', '99', 'Intermediate', NULL, '0', NULL, '2025-11-02 23:21:28'),
('24', '6', '102', 'Intermediate', NULL, '0', NULL, '2025-11-02 23:21:52'),
('25', '15', '65', 'Intermediate', NULL, '0', NULL, '2025-11-02 23:26:23'),
('26', '15', '73', 'Intermediate', NULL, '0', NULL, '2025-11-02 23:26:31');

--
-- Table structure for table `subject_groups`
--

DROP TABLE IF EXISTS `subject_groups`;
CREATE TABLE `subject_groups` (
  `group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group_name` varchar(50) NOT NULL,
  `group_code` varchar(20) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `required_units` tinyint(3) unsigned NOT NULL,
  `curriculum_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`group_id`),
  UNIQUE KEY `unq_group_code` (`group_code`),
  KEY `idx_curriculum_id` (`curriculum_id`),
  CONSTRAINT `fk_group_curriculum` FOREIGN KEY (`curriculum_id`) REFERENCES `curricula` (`curriculum_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Course groupings (GE, Professional, etc.)';

--
-- Dumping data for table `subject_groups`
--

--
-- Table structure for table `system_settings`
--

DROP TABLE IF EXISTS `system_settings`;
CREATE TABLE `system_settings` (
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`setting_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `system_settings`
--

INSERT INTO `system_settings` (`setting_key`, `setting_value`, `updated_at`) VALUES 
('primary_color', '#e5ad0f', '2025-10-31 22:59:06'),
('system_logo', '/assets/logo/main_logo/PRMSUlogo.png', '2025-10-31 22:59:06'),
('system_name', 'ACSS', '2025-10-31 22:59:06');

--
-- Table structure for table `teaching_loads`
--

DROP TABLE IF EXISTS `teaching_loads`;
CREATE TABLE `teaching_loads` (
  `load_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `faculty_id` int(10) unsigned NOT NULL,
  `offering_id` int(10) unsigned NOT NULL,
  `section_id` int(10) unsigned NOT NULL,
  `assigned_hours` tinyint(3) unsigned NOT NULL,
  `status` enum('Proposed','Approved','Rejected') DEFAULT 'Proposed',
  `assigned_by` int(10) unsigned DEFAULT NULL,
  `assigned_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`load_id`),
  UNIQUE KEY `unq_faculty_offering_section` (`faculty_id`,`offering_id`,`section_id`),
  KEY `fk_load_assigner` (`assigned_by`),
  KEY `idx_faculty_id` (`faculty_id`),
  KEY `idx_offering_id` (`offering_id`),
  KEY `idx_section_id` (`section_id`),
  KEY `idx_load_status` (`status`),
  CONSTRAINT `fk_load_assigner` FOREIGN KEY (`assigned_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_load_faculty` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`faculty_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_load_offering` FOREIGN KEY (`offering_id`) REFERENCES `course_offerings` (`offering_id`) ON DELETE CASCADE,
  CONSTRAINT `teaching_loads_ibfk_1` FOREIGN KEY (`section_id`) REFERENCES `sections` (`section_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Faculty teaching load assignments';

--
-- Dumping data for table `teaching_loads`
--

--
-- Table structure for table `user_metadata`
--

DROP TABLE IF EXISTS `user_metadata`;
CREATE TABLE `user_metadata` (
  `metadata_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`metadata_id`),
  KEY `idx_ip_address` (`ip_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='User connection metadata for audit logs';

--
-- Dumping data for table `user_metadata`
--

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
CREATE TABLE `user_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `role_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_role` (`user_id`,`role_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`id`, `user_id`, `role_id`) VALUES 
('5', '1', '5'),
('4', '2', '4'),
('15', '18', '6'),
('16', '19', '6'),
('17', '20', '6'),
('18', '21', '6'),
('19', '22', '6'),
('20', '23', '6'),
('21', '24', '6'),
('22', '25', '6'),
('6', '26', '5'),
('23', '27', '6'),
('24', '28', '6'),
('7', '29', '5'),
('8', '30', '5'),
('25', '31', '6'),
('26', '32', '6'),
('27', '33', '6'),
('28', '36', '6'),
('29', '37', '6'),
('30', '38', '6'),
('9', '39', '5'),
('10', '40', '5'),
('1', '45', '1'),
('31', '46', '6'),
('32', '49', '6'),
('33', '50', '6'),
('11', '51', '5'),
('12', '52', '5'),
('13', '53', '5'),
('34', '54', '6'),
('14', '57', '5'),
('35', '59', '6'),
('2', '60', '3'),
('3', '65', '3'),
('36', '66', '6'),
('37', '67', '6'),
('66', '69', '5'),
('67', '70', '4'),
('68', '70', '5'),
('69', '71', '4'),
('70', '71', '5');

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(20) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(60) NOT NULL COMMENT 'For bcrypt hashes',
  `email` varchar(100) NOT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `title` enum('Mr.','Mrs.','Ms.','Miss','Mx.','Dr.','Prof.','Atty.','Rev.','Eng.','Arch.','Capt.','Cpt.','Col.','Gen.','Lt.','Maj.','Sgt.','Hon.','MD','RN','RPh','PT','DDS','DVM','Fr.','Sr.','Imam','Rabbi','Pastor','Sir','Dame','Lady','Lord','Sheikh','Prince','Princess','King','Queen') DEFAULT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) NOT NULL,
  `suffix` varchar(10) DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT NULL COMMENT 'Path to profile picture file',
  `role_id` tinyint(3) unsigned NOT NULL,
  `department_id` smallint(5) unsigned DEFAULT NULL,
  `college_id` smallint(5) unsigned NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `remember_token` varchar(64) DEFAULT NULL,
  `remember_token_expiry` datetime DEFAULT NULL,
  `reset_token` varchar(64) DEFAULT NULL,
  `reset_token_expiry` datetime DEFAULT NULL,
  `rejection_reason` text DEFAULT NULL,
  `terms_accepted` tinyint(1) DEFAULT 0,
  `terms_accepted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `unq_username` (`username`),
  UNIQUE KEY `unq_user_email` (`email`),
  UNIQUE KEY `unq_employee_id` (`employee_id`),
  KEY `fk_user_department` (`department_id`),
  KEY `fk_user_college` (`college_id`),
  KEY `idx_user_role` (`role_id`),
  KEY `idx_user_name` (`last_name`,`first_name`),
  CONSTRAINT `fk_user_college` FOREIGN KEY (`college_id`) REFERENCES `colleges` (`college_id`),
  CONSTRAINT `fk_user_department` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`),
  CONSTRAINT `fk_user_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='System users with authentication and authorization details';

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `employee_id`, `username`, `password_hash`, `email`, `phone`, `title`, `first_name`, `middle_name`, `last_name`, `suffix`, `profile_picture`, `role_id`, `department_id`, `college_id`, `is_active`, `created_at`, `updated_at`, `remember_token`, `remember_token_expiry`, `reset_token`, `reset_token_expiry`, `rejection_reason`, `terms_accepted`, `terms_accepted_at`) VALUES 
('1', '8000', 'Batman', '$2y$10$zNegT.z16ly6b34TBVAUvuROtTWKuKofm4qiDZYoiRpxPJN84qAQO', 'mlbausa10@gmail.com', '', 'Dr.', 'Geoffrey', '', 'Sepillo', '', '/uploads/profile_pictures/profile_1_1756792379.png', '5', '14', '7', '1', '2025-04-30 08:09:45', '2025-10-29 20:11:40', '73fbf30c184e7530298d6e56201aedb3239e18247f826fb7bb8fb0eb73e8860c', '2025-10-29 08:54:19', '5e23f9e4647bb616bd145fe81537412120ad7b4e9103f52429188e62a2d2d6c9', '2025-09-03 11:09:22', NULL, '0', NULL),
('2', '1000', 'dean', '$2y$10$uGR5zZfyJxsEjcNRVPEwE.FReK6Ik0glHgEtx/kWpASja4YaNHlgG', 'dean@gmail.com', NULL, 'Dr.', 'Menchie', 'A.', 'Dela Cruz', NULL, '/uploads/profile_pictures/profile_2_1756793168.png', '4', '14', '7', '1', '2025-04-30 08:09:45', '2025-10-04 23:46:39', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('18', '7879', '7879', '$2y$10$cP8H1zkrzeG2bPTWnoL1IeWajrmeJVA.rNLYbvqAJsLLAWp3vQ3oK', 'luisbausajr@gmail.com', NULL, NULL, 'faculty', 'dar', '00', NULL, NULL, '6', '4', '2', '1', '2025-05-13 08:49:16', '2025-10-13 23:21:45', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('19', '01', 'Joseph Cortez', '$2y$10$0HxVl6e35JVNn4G7fYOpo.xeBMyjyj1OTrK4JVUH8fsuu.Uw2o6mu', 'cortezsigurU@gmailcom', '', NULL, 'Joseph', 'S.', 'Cortez', '', NULL, '6', '14', '7', '1', '2025-05-13 11:56:30', '2025-11-02 23:03:05', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('20', '02', 'Ma\'am Rowela', '$2y$10$Fs6/TNsdP/x7mVx9MG/RSeb9a7u2OdQqe2WycROMuRiiU3bfj2vhm', 'PrincessGrow@gmail.com', '', NULL, 'Rowela', '', 'Gongora', '', NULL, '6', '14', '7', '1', '2025-05-13 11:58:49', '2025-11-01 10:24:26', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('21', '8008', 'Chris', '$2y$10$cCUlT4.ngw9DiE5fRlpJBOGHAsTfA9MyVsLiCRxrVSZ3G2bdPHyMS', 'christianspillers58@gmail.com', '09206795073', NULL, 'Chrisadsaf', 'C.', 'Spillers', '', NULL, '6', '14', '7', '1', '2025-05-13 12:00:29', '2025-08-15 16:08:51', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('22', '03', 'Professor Darwin', '$2y$10$ZeBdxDztljEFh4ljqxl5ie4ol0fMtmt6r3RM8eTTbptyzR8riJmN.', 'darwinpogi@gmail.com', '', NULL, 'Darwin', '', 'Morona', '', NULL, '6', '14', '7', '1', '2025-05-13 12:01:46', '2025-11-02 23:16:44', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('23', '04', 'Engineer Marave', '$2y$10$RZZbIRdmFb1a8R43wqd4kesYH/IGnKV4Y0XL9fQDDxJuUvMv4Qyvm', 'Maravetree@gmail.com', '', NULL, 'Melojean', 'C.', 'Marave', '', NULL, '6', '14', '7', '1', '2025-05-13 12:04:47', '2025-11-02 23:21:52', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('24', '39', 'WorldDevourer', '$2y$10$O3tELz2lvmHM3dibOTeske.6zulQlP9v1NfnErFk53/KUjkUlINEO', 'crpitdjdoss@gmail.com', '', NULL, 'Hansel', 'S.', 'Ada', '', NULL, '6', '14', '7', '1', '2025-05-13 12:07:42', '2025-11-02 23:12:25', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('25', '05', 'Sir Israel', '$2y$10$1LwmwuQehv.1cPju8NxW6eMfvIM/7uhX6zMjhdjFFRfOozV6kW/la', 'CommanderIsrael@gmail.com', '', NULL, 'Israel', 'M.', 'Cabasug', '', NULL, '6', '17', '7', '1', '2025-05-13 12:08:30', '2025-05-13 15:59:40', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('26', '22', 'CarlAngelo', '$2y$10$k4rQ8L1kvNAHFSmxxMOVOOHWL58EfdUaSs0s0hUYvPY/NHGouHCOy', 'kaarusansama@gmail.com', '', 'Dr.', 'Carl Angelo', 'S.', 'Pamplona', '', '/uploads/profile_pictures/profile_26_1759837327.png', '5', '17', '7', '1', '2025-05-13 12:17:41', '2025-10-07 19:42:07', '433aff3bdaad8790741cbb38df442622dbbc49757553e6cc96007d92070c2cc8', '2025-11-03 16:56:39', NULL, NULL, NULL, '0', NULL),
('27', '10009', 'Beast', '$2y$10$foA/kSjNAoBCXmyHShyh4OQmPOArZb5piA/MIR/8hVysgNyXOkK7S', 'beast@email.com', '', NULL, 'Beast', 'Beast', 'Beast', 'Sr', NULL, '6', NULL, '7', '1', '2025-05-13 13:52:03', '2025-09-27 16:56:20', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('28', '06', 'Sir JJ', '$2y$10$B0i2EBQax95IZPI7QCjoKu0s.h50p6.5j6w1SJft2iw3GhxzBuj2i', 'DirectorJJJ@gmail.com', '', NULL, 'Joseph', 'J.', 'Juliano', '', NULL, '6', '14', '7', '1', '2025-05-13 15:56:16', '2025-09-27 23:10:50', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('29', '999', 'sungjinwoo', '$2y$10$I3iAfUk2KozPQn5cVN2UZOBhNWMKLFTCZ.bVHJFsBruvzaN6uamv.', 'Sung@email.com', '', NULL, 'Sung', 'Jin', 'Woo', 'Jr', NULL, '5', '17', '7', '1', '2025-05-13 17:21:51', '2025-05-13 17:21:51', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('30', '998', 'tanjirokamado', '$2y$10$hhfTUvJ7wvIHBN5Dxr.bguWUq15x.rLE9b4zojKQPM5E5RCb7i4eq', 'tanjiro@email.com', '', NULL, 'Tanjiro', 'vin', 'Kamado', 'jr', NULL, '5', '14', '7', '1', '2025-05-13 17:30:25', '2025-05-13 17:30:25', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('31', '07', 'Sir Ronnel', '$2y$10$OaeyuhfXrD5ar007AGcFBebM0KWfgTGlUHigefB.a1WFW2cHwVCP.', 'Ronnelmesia@gmail.com', '', NULL, 'Ronnel', 'C.', 'Mesia', '', NULL, '6', '17', '7', '1', '2025-05-13 17:34:54', '2025-05-13 17:34:54', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('32', '08', 'BachieBabe', '$2y$10$az400rLL00e4Xb5Enm3/1OPz7jw6NDCT5hvZKcfmeHzEFIGV/tDom', 'Bachiebabe27@gmail.com', '', NULL, 'Daniel', 'A.', 'Bachillar', '', NULL, '6', '14', '7', '1', '2025-05-13 17:39:53', '2025-08-04 11:00:24', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('33', '09', 'Daryl', '$2y$10$fRdBwKMGnhFQGtXCXsoAD.t.oON5tl6M.alVgjlfPUa7sZmFC/QdW', 'DjragadioOnward@gmail.com', '', 'Dr.', 'Daryl John', '', 'Ragadio', '', NULL, '6', '14', '7', '1', '2025-05-13 17:53:15', '2025-11-02 22:50:48', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('36', '10', 'Ma\'am Joyce', '$2y$10$yn8E5oXKhkpQn.C43HFIA.tt9x9rUNkSCDnkaATSWh.oJoKyFqL7.', 'Majoyce@gmail.com', '', NULL, 'Marionne Joyce', 'F.', 'Tapado', '', NULL, '6', '17', '7', '1', '2025-05-13 18:07:13', '2025-05-13 18:07:13', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('37', '11', 'Sir Jason', '$2y$10$x/9/lBswS8BunIqhCKLf/.U78fUcnv/fbb70lL5DT5epHwF1tWPHu', 'JasonArtGaming@gmail.com', '', NULL, 'Jason', 'S.', 'Artates', 'JasonArtGa', NULL, '6', '17', '7', '1', '2025-05-13 18:09:42', '2025-11-02 23:26:31', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('38', '12', 'Sir Fiel Dullas', '$2y$10$xbdqovUZ3csJqV//N4PuQ.9pIjDoLSGResrCDV7OOiD1aReM.M3n6', 'FielVisorSerpent@gmail.com', '', NULL, 'Fiel', 'M.', 'Dullas', 'Jr.', NULL, '6', '14', '7', '1', '2025-05-13 18:11:38', '2025-11-02 23:11:20', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('39', '2000', 'jhon', '$2y$10$qXHwKUpN2qkE0ocgsBb/GegtYFWWn8NuAm8M8p8ATY1tnV65dZ0zC', 'jhon@gmail.com', '', NULL, 'John', '', 'Kinam', '', NULL, '5', '5', '2', '1', '2025-05-13 20:06:48', '2025-05-13 20:06:48', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('40', '5000', 'test', '$2y$10$gHklonyOLeEayrgx1.tSdu9humesMmz..HVGL1bCR7i8Khf5uaZdu', 'test27@gmail.com', '', NULL, 'test', '', 'test01', '', NULL, '5', '17', '7', '1', '2025-05-13 21:10:13', '2025-05-13 21:10:13', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('45', '1234', 'admin', '$2y$10$.F6.T/.5/J8ZEc6ey5Wtf.oyO.aDI4qnSZxiki/osdBY1TsI1zXO2', 'admin@gmail.com', '098765432123', 'Dr.', 'admin', 'g', '00', '', '/uploads/profile_pictures/profile_45_1758014886.png', '1', '17', '7', '1', '2025-06-08 10:03:51', '2025-10-21 21:03:25', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('46', '7575', 'hello world', '$2y$10$WkWgEV306LdFzipDpm/LCudRg6S5q4.2YD.2xpGnxNtc3bB1jSaES', 'hello@gmail.com', '', NULL, 'hello', '', 'world', '', NULL, '6', '17', '7', '1', '2025-06-28 13:42:42', '2025-06-28 13:42:42', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('49', '7979', 'helloworld', '$2y$10$8cv5HR/gEMhMpn.jpoBYnOmjtxiuWRb./XTdYI3pjOyZZEY2p90Hq', 'helloword@gmail.com', NULL, NULL, 'hello', '', 'world', '', '/uploads/profile_pictures/user_49_1751092559.png', '6', NULL, '7', '1', '2025-06-28 14:13:38', '2025-10-22 21:59:39', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('50', '5555', 'gge', '$2y$10$4iJ9UKc2ttfSzLXspmmBr.nhnVErF6yMSZeB/ZHB14WgW.WB7Duw2', 'agreg@gmail.com', '', NULL, 'dge', 'dsa', 'gaege', '', NULL, '6', '14', '7', '1', '2025-08-15 12:56:39', '2025-08-15 12:56:39', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('51', '6789', 'sayo', '$2y$10$QSJVhq/4j6HbkuEYgsV6NeJPzm30cetITOzJUlM8SthXwnX7TV1yi', 'sayo@gmail.com', '', NULL, 'Awit', 'N.', 'Sayo', '', NULL, '5', '14', '7', '1', '2025-08-15 12:58:43', '2025-08-15 12:58:43', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('52', '8990', 'asdf', '$2y$10$784K0av9p8qvd.FgupqxKeJSJvZDLB.qekX3Vp9yGNaJicLxGpBw.', 'adsf@gmail.com', '', NULL, 'adsf', 'e', 'wfaw', '', NULL, '5', '17', '7', '1', '2025-08-15 13:06:44', '2025-08-15 13:06:44', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('53', '8762', 'asf', '$2y$10$aG7o0ri2AKq/61Dwubuzp.2D2eDrbTI/8Vmn9znsIWyNobF3zbQ6C', 'asf@gmail.com', '', NULL, 'assf', 'a', 'dw', '', NULL, '5', '5', '2', '1', '2025-08-15 13:21:50', '2025-11-01 10:03:21', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('54', '2367', 'qw', '$2y$10$CjDb53UvWOUypBJB3PbbI.gHlakPEboTNEKu3VxODCQE8md0N4EDm', 'qwe@gmai.com', '', NULL, 'qwfwe', 'w', 'wqf', '', NULL, '6', NULL, '7', '0', '2025-08-15 14:06:54', '2025-10-05 00:00:02', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('57', '5824', 'sdvsdv', '$2y$10$7fzeIHvOouQTf75M97Eb1ORBGRylcEUKqJsakqFwclYhXd34ebLDm', 'adsdef@gmail.com', '', NULL, 'wdqq', 'd', 'qwfwf', '', NULL, '5', '4', '2', '1', '2025-08-15 14:26:43', '2025-08-15 14:26:43', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('59', '6740', 'tst003', '$2y$10$Wpv8hr/4rPo.mPmvkiV0BeEkqUAinO9FrLtQbLgSJqDinL8vrdKJW', 'mlbausa84@gmail.com', NULL, 'Dr.', 'test003', 's', 'sfweqwe', '', '/uploads/profile_pictures/user_59_1755335861.png', '6', NULL, '7', '1', '2025-08-16 09:29:57', '2025-10-15 23:31:16', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('60', '2345', 'sfdgdg', '$2y$10$1PUkARN8VI6/0iGQwhX68uguU0YPSQP0s6Dy9bxVc46.MkMAcEq8C', 'hasWF@gmail.com', NULL, NULL, 'test67', 'd', 'asfd', '', NULL, '3', '17', '7', '1', '2025-08-21 21:54:46', '2025-08-21 21:54:46', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('65', '1248', 'svsa', '$2y$10$Qo5KeltWly3qfWxhKK46VucQj8syuGDPXwu0LzIbM2un8vj9uRE3q', 'gwdb@gmail.com', NULL, 'Dr.', 'Nemia', 'M.', 'Galang', '', '/uploads/profile_pictures/profile_65_1755868685.png', '3', '17', '7', '1', '2025-08-21 22:12:07', '2025-10-30 17:20:45', 'c7e9d6bb63e42c96f5f6dbc3e517d904a25b2e2a87ffbc6f0b0d9759e6a86852', '2025-11-10 09:09:55', NULL, NULL, NULL, '0', NULL),
('66', '4524', 'dsvzdv', '$2y$10$JaOtWHFV.oX0ZqskBg9fQOzH8AOafPB95Ca7ZdCm7A14hiTxWEdkW', 'WDEAWF@gmail.com', NULL, NULL, 'wsevaeg', 'e', 'wef', '', NULL, '6', '17', '7', '0', '2025-08-23 11:03:51', '2025-08-28 13:34:07', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('67', '34', 'test1', '$2y$10$prvUwsZyYNpLHLrMmecJluc9I9DXkymQbQ2b2O3f23z7rC6NG2ARm', 'test@test', NULL, NULL, 'fwfwef', 'd', 'wfWF', '', NULL, '6', '17', '7', '1', '2025-09-25 16:41:31', '2025-10-24 23:13:12', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('69', '35', 'Teacher', '$2y$10$ARds69VGJfEq22oCfgYHB..EjGjstQj.aAxDheP9pdYnWE58QRaLm', 'teacher@gmail.com', NULL, NULL, 'Teacher', '', 'sfweqwe', '', NULL, '5', '7', '3', '1', '2025-10-22 22:38:37', '2025-10-22 22:39:47', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('70', '67', '67', '$2y$10$8uxavonnMgeFsG9NVOqM2e8Q0nh0ea2EUpNDLU.6W8I0auHKPeAPy', 'con@gmail.com', NULL, NULL, 'maam con', '', 'qwfew', '', NULL, '4', NULL, '7', '1', '2025-10-23 20:24:58', '2025-10-28 22:48:11', NULL, NULL, NULL, NULL, NULL, '0', NULL),
('71', '0026', 'penek', '$2y$10$bEbuDML2BV7oJFQNvZKzfeu5HOWXIWRXP3Wfhe49R4FimMvxGzZdG', 'penek@hotmilk.com', '', NULL, 'penek', 'penek', 'penek', '', NULL, '4', '12', '5', '1', '2025-11-02 22:08:03', '2025-11-02 22:08:03', NULL, NULL, NULL, NULL, NULL, '0', NULL);

--
-- Table structure for table `vpaa`
--

DROP TABLE IF EXISTS `vpaa`;
CREATE TABLE `vpaa` (
  `vpaa_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `is_current` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`vpaa_id`),
  UNIQUE KEY `unq_current_vpaa` (`is_current`),
  KEY `fk_vpaa_user` (`user_id`),
  CONSTRAINT `fk_vpaa_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='VPAA assignments';

--
-- Dumping data for table `vpaa`
--

INSERT INTO `vpaa` (`vpaa_id`, `user_id`, `start_date`, `end_date`, `is_current`, `created_at`, `updated_at`) VALUES 
('1', '45', '2025-08-24', NULL, '1', '2025-08-24 20:39:26', '2025-08-24 20:39:48');

--
-- Table structure for table `vw_subject_types`
--

DROP TABLE IF EXISTS `vw_subject_types`;
;

--
-- Dumping data for table `vw_subject_types`
--

INSERT INTO `vw_subject_types` (`course_id`, `course_code`, `course_name`, `curriculum_course_id`, `subject_type`, `program_id`, `program_name`, `program_type`, `is_primary`, `department_id`, `department_name`, `college_id`, `college_name`) VALUES 
('60', 'CC 101', 'Introduction To Computing', '131', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('60', 'CC 101', 'Introduction To Computing', '184', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('61', 'FILN 1', 'Kontekstswalisadong Komunikasyon sa Filipino', '132', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('62', 'GEC 1', 'Understanding The Self', '133', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('62', 'GEC 1', 'Understanding The Self', '180', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('63', 'GEC 7', 'Science, Technology and Society', '134', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('63', 'GEC 7', 'Science, Technology and Society', '183', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('64', 'PE 1', 'Physical Activities Toward Health and Fitness 1(PATHFIT1) Movement Contemporary Training', '135', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('64', 'PE 1', 'Physical Activities Toward Health and Fitness 1(PATHFIT1) Movement Contemporary Training', '185', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('65', 'NSTP 1', 'NSTP 1(CWTS/ROTC/LTS)', '136', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('65', 'NSTP 1', 'NSTP 1(CWTS/ROTC/LTS)', '186', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('66', 'ITEs 102', 'Computer Hardware System', '137', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('66', 'ITEs 102', 'Computer Hardware System', '190', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('67', 'CC 102', 'Computer Programming |', '138', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('67', 'CC 102', 'Computer Programming |', '189', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('68', 'GEC 5', 'Purposive Communication', '139', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('68', 'GEC 5', 'Purposive Communication', '187', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('69', 'HC! 101', 'Introduction to Human Computer Interaction', '140', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('69', 'HC! 101', 'Introduction to Human Computer Interaction', '191', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('70', 'GEC 4', 'Mathematics In The Modern World', '141', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('70', 'GEC 4', 'Mathematics In The Modern World', '182', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('71', 'GEC 2a', 'Readings in Philippines History (with IP Education)', '142', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('71', 'GEC 2a', 'Readings in Philippines History (with IP Education)', '188', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('72', 'PE 2', 'Physical Activities Toward Health and Fitnesses (PATHPIT 2) Exercise based Fitness Activities', '192', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('73', 'NSTP 2', 'NSTP || (CWTS/ROTC/LTS)', '143', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('73', 'NSTP 2', 'NSTP || (CWTS/ROTC/LTS)', '193', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('74', 'CC 103', 'Computer Programming ||', '144', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('74', 'CC 103', 'Computer Programming ||', '197', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('75', 'GEM', 'The Life and Works of Rizal', '145', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('75', 'GEM', 'The Life and Works of Rizal', '196', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('76', 'ITE 1', 'IT Elective 1 - Web System and Technologies', '146', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('77', 'GEE 15', 'ASEAN Culture and Studies', '147', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('78', 'GEC 3a', 'The Contemporary World (With Peace Education)', '148', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('78', 'GEC 3a', 'The Contemporary World (With Peace Education)', '195', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('79', 'MS 101', 'Discrete Mathematics', '149', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('79', 'MS 101', 'Discrete Mathematics', '198', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('80', 'PE 3', 'Physical Activites Toward Health and Fitness 3(PATHFIT 3) (DANCE)', '150', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('80', 'PE 3', 'Physical Activites Toward Health and Fitness 3(PATHFIT 3) (DANCE)', '201', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('81', 'CC 104', 'Data Structure and Algorithms', '152', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('81', 'CC 104', 'Data Structure and Algorithms', '205', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('82', 'ITE 2', 'IT Elective 2-Objective-Oriented Programming', '153', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('83', 'CC 105', 'Information Management', '154', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('83', 'CC 105', 'Information Management', '206', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('84', 'GEE 14', 'Technopreneurship', '155', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('85', 'GEE 7', 'Gender and Society', '156', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('85', 'GEE 7', 'Gender and Society', '203', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('86', 'GEC 6', 'Art Appreciation', '157', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('87', 'PE 4', 'Physical Activites Toward Health and Fitness 4(PATHFIT 4) (SPORTS)', '151', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('87', 'PE 4', 'Physical Activites Toward Health and Fitness 4(PATHFIT 4) (SPORTS)', '209', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('88', 'IM 101', 'Advance Database Systems', '158', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('89', 'GDDAT', 'Game Development and Digital Animation Technology', '159', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('89', 'GDDAT', 'Game Development and Digital Animation Technology', '213', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('90', 'EN 1', 'Scientific and Technical Writing', '160', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('90', 'EN 1', 'Scientific and Technical Writing', '210', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('91', 'ITE 3', 'IT Elective 3 - Platform Technologies', '161', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('92', 'PF 102', 'Event Driven Programming', '162', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('92', 'PF 102', 'Event Driven Programming', '214', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('93', 'ITP', 'Integrative Programming Technologies 1', '163', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('94', 'SIA 101', 'System Integration and Architecture |', '164', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('94', 'SIA 101', 'System Integration and Architecture |', '219', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('95', 'CAP 101', 'Capstone Progect and Research |', '179', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('95', 'CAP 101', 'Capstone Progect and Research |', '225', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('96', 'CC 106', 'Application Development and Emerging Technologies', '166', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('96', 'CC 106', 'Application Development and Emerging Technologies', '220', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('97', 'NET 101', 'Networking |', '167', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('97', 'NET 101', 'Networking |', '221', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('98', 'IAS 101', 'Information Assurance and Security |', '168', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('98', 'IAS 101', 'Information Assurance and Security |', '222', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('99', 'ITE 4', 'IT Elective 4 - Artificial Intelligence', '169', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('100', 'GEC 8', 'Ethics', '170', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('100', 'GEC 8', 'Ethics', '218', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('101', 'SP 101', 'Social and Professional Issues', '171', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('101', 'SP 101', 'Social and Professional Issues', '228', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('102', 'NET 102', 'Networking II', '172', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('102', 'NET 102', 'Networking II', '227', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('103', 'MS 102', 'Qualitative Methods', '173', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('103', 'MS 102', 'Qualitative Methods', '211', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('104', 'SA 101', 'System Administration and Maintenance', '174', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('104', 'SA 101', 'System Administration and Maintenance', '223', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('105', 'CAP 102', 'Capstone Project and Research ||', '178', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('105', 'CAP 102', 'Capstone Project and Research ||', '230', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('106', 'FLNG', 'Foregin Language', '176', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('107', 'PRAC 101', 'Practicum (600 hours)', '177', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('107', 'PRAC 101', 'Practicum (600 hours)', '231', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('112', 'EN+', 'Enhance Communication Skills', '181', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('113', 'IT ELEC 1', 'IT elective 1', '200', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('114', 'GEE 8', 'The Entrepreneurial Mind', '202', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('115', 'GEE 1', 'Environmental Science', '194', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('116', 'GEE 6', 'Art Appreciation', '204', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('117', 'IM 191', 'Fundamentals of Database Systems', '207', 'General Education', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('118', 'ITE ELECT 2', 'IT Elective 2', '208', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('119', 'IM 102', 'Advance Database Systems', '212', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('120', 'ITP 101', 'Integrative Programming Technologies', '215', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('121', 'WS 101', 'Web Systems and Technologies', '216', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('122', 'IT ELEC 4', 'IT Elective 4', '224', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('123', 'NCR 101', 'International/National Certification Review', '226', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('124', 'IAS 102', 'Information Assurance and Security 2', '229', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology'),
('125', 'IT ELEC 3', 'IT Elective 3', '217', 'Professional Course', NULL, NULL, NULL, NULL, '14', 'Department of Information Technology', '7', 'College of Communications and Information Technology');

SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT;
SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS;
SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION;
SET FOREIGN_KEY_CHECKS=1;
