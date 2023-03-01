-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jul 14, 2022 at 08:40 AM
-- Server version: 5.7.36
-- PHP Version: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `loans_with_accounts`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_log`
--

DROP TABLE IF EXISTS `activity_log`;
CREATE TABLE IF NOT EXISTS `activity_log` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `log_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject_id` bigint(20) UNSIGNED DEFAULT NULL,
  `subject_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `causer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `causer_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `properties` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `activity_log_log_name_index` (`log_name`)
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `activity_log`
--

INSERT INTO `activity_log` (`id`, `log_name`, `description`, `subject_id`, `subject_type`, `causer_id`, `causer_type`, `properties`, `created_at`, `updated_at`) VALUES
(1, 'default', 'Create Chart Of Account', 1, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":1}', '2022-07-13 11:30:05', '2022-07-13 11:30:05'),
(2, 'default', 'Update Chart Of Account', 1, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":1}', '2022-07-13 11:32:21', '2022-07-13 11:32:21'),
(3, 'default', 'Create Chart Of Account', 2, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":2}', '2022-07-13 11:34:41', '2022-07-13 11:34:41'),
(4, 'default', 'Create Chart Of Account', 3, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":3}', '2022-07-13 11:35:25', '2022-07-13 11:35:25'),
(5, 'default', 'Create Chart Of Account', 4, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":4}', '2022-07-13 11:36:12', '2022-07-13 11:36:12'),
(6, 'default', 'Create Chart Of Account', 5, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":5}', '2022-07-13 11:37:00', '2022-07-13 11:37:00'),
(7, 'default', 'Create Chart Of Account', 6, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":6}', '2022-07-13 11:44:34', '2022-07-13 11:44:34'),
(8, 'default', 'Create Chart Of Account', 7, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":7}', '2022-07-13 11:45:20', '2022-07-13 11:45:20'),
(9, 'default', 'Create Chart Of Account', 8, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":8}', '2022-07-13 11:45:50', '2022-07-13 11:45:50'),
(10, 'default', 'Create Chart Of Account', 9, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":9}', '2022-07-13 11:46:37', '2022-07-13 11:46:37'),
(11, 'default', 'Create Chart Of Account', 10, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":10}', '2022-07-13 11:47:32', '2022-07-13 11:47:32'),
(12, 'default', 'Create Chart Of Account', 11, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":11}', '2022-07-13 11:48:05', '2022-07-13 11:48:05'),
(13, 'default', 'Create Chart Of Account', 12, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":12}', '2022-07-13 11:48:30', '2022-07-13 11:48:30'),
(14, 'default', 'Create Chart Of Account', 13, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":13}', '2022-07-13 11:49:00', '2022-07-13 11:49:00'),
(15, 'default', 'Create Chart Of Account', 14, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":14}', '2022-07-13 11:49:28', '2022-07-13 11:49:28'),
(16, 'default', 'Create Chart Of Account', 15, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":15}', '2022-07-13 11:50:44', '2022-07-13 11:50:44'),
(17, 'default', 'Create Chart Of Account', 16, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":16}', '2022-07-13 11:52:26', '2022-07-13 11:52:26'),
(18, 'default', 'Create Chart Of Account', 17, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":17}', '2022-07-13 11:53:12', '2022-07-13 11:53:12'),
(19, 'default', 'Create Chart Of Account', 18, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":18}', '2022-07-13 11:54:48', '2022-07-13 11:54:48'),
(20, 'default', 'Create Chart Of Account', 19, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":19}', '2022-07-13 11:55:17', '2022-07-13 11:55:17'),
(21, 'default', 'Create Chart Of Account', 20, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":20}', '2022-07-13 11:56:12', '2022-07-13 11:56:12'),
(22, 'default', 'Create Chart Of Account', 21, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":21}', '2022-07-13 11:56:37', '2022-07-13 11:56:37'),
(23, 'default', 'Create Chart Of Account', 22, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":22}', '2022-07-13 11:57:11', '2022-07-13 11:57:11'),
(24, 'default', 'Create Chart Of Account', 23, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":23}', '2022-07-13 11:57:48', '2022-07-13 11:57:48'),
(25, 'default', 'Create Chart Of Account', 24, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":24}', '2022-07-13 11:58:28', '2022-07-13 11:58:28'),
(26, 'default', 'Create Chart Of Account', 25, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":25}', '2022-07-13 12:01:57', '2022-07-13 12:01:57'),
(27, 'default', 'Create Chart Of Account', 26, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":26}', '2022-07-13 12:02:52', '2022-07-13 12:02:52'),
(28, 'default', 'Create Chart Of Account', 27, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":27}', '2022-07-13 12:03:27', '2022-07-13 12:03:27'),
(29, 'default', 'Create Chart Of Account', 28, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":28}', '2022-07-13 12:03:56', '2022-07-13 12:03:56'),
(30, 'default', 'Create Chart Of Account', 29, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":29}', '2022-07-13 12:04:20', '2022-07-13 12:04:20'),
(31, 'default', 'Create Chart Of Account', 30, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":30}', '2022-07-13 12:04:41', '2022-07-13 12:04:41'),
(32, 'default', 'Create Chart Of Account', 31, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":31}', '2022-07-13 12:05:19', '2022-07-13 12:05:19'),
(33, 'default', 'Create Chart Of Account', 32, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":32}', '2022-07-13 12:05:43', '2022-07-13 12:05:43'),
(34, 'default', 'Create Chart Of Account', 33, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":33}', '2022-07-13 12:06:17', '2022-07-13 12:06:17'),
(35, 'default', 'Create Chart Of Account', 34, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":34}', '2022-07-13 12:06:52', '2022-07-13 12:06:52'),
(36, 'default', 'Create Chart Of Account', 35, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":35}', '2022-07-13 12:07:27', '2022-07-13 12:07:27'),
(37, 'default', 'Create Chart Of Account', 36, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":36}', '2022-07-13 12:07:56', '2022-07-13 12:07:56'),
(38, 'default', 'Create Chart Of Account', 37, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":37}', '2022-07-13 12:12:10', '2022-07-13 12:12:10'),
(39, 'default', 'Create Chart Of Account', 38, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":38}', '2022-07-13 12:13:02', '2022-07-13 12:13:02'),
(40, 'default', 'Create Chart Of Account', 39, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":39}', '2022-07-13 12:14:06', '2022-07-13 12:14:06'),
(41, 'default', 'Create Chart Of Account', 40, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":40}', '2022-07-13 12:15:06', '2022-07-13 12:15:06'),
(42, 'default', 'Create Chart Of Account', 41, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":41}', '2022-07-13 12:15:37', '2022-07-13 12:15:37'),
(43, 'default', 'Create Chart Of Account', 42, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":42}', '2022-07-13 12:16:24', '2022-07-13 12:16:24'),
(44, 'default', 'Create Chart Of Account', 43, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":43}', '2022-07-13 12:17:16', '2022-07-13 12:17:16'),
(45, 'default', 'Update Chart Of Account', 39, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":39}', '2022-07-13 12:18:38', '2022-07-13 12:18:38'),
(46, 'default', 'Create Chart Of Account', 44, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":44}', '2022-07-13 12:19:21', '2022-07-13 12:19:21'),
(47, 'default', 'Create Chart Of Account', 45, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":45}', '2022-07-13 12:19:48', '2022-07-13 12:19:48'),
(48, 'default', 'Create Chart Of Account', 46, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":46}', '2022-07-13 12:20:21', '2022-07-13 12:20:21'),
(49, 'default', 'Create Chart Of Account', 47, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":47}', '2022-07-13 12:21:03', '2022-07-13 12:21:03'),
(50, 'default', 'Create Chart Of Account', 48, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":48}', '2022-07-13 12:22:51', '2022-07-13 12:22:51'),
(51, 'default', 'Create Chart Of Account', 49, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":49}', '2022-07-13 12:23:19', '2022-07-13 12:23:19'),
(52, 'default', 'Create Chart Of Account', 50, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":50}', '2022-07-13 12:23:50', '2022-07-13 12:23:50'),
(53, 'default', 'Create Chart Of Account', 51, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":51}', '2022-07-13 12:24:21', '2022-07-13 12:24:21'),
(54, 'default', 'Create Chart Of Account', 52, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":52}', '2022-07-13 12:25:23', '2022-07-13 12:25:23'),
(55, 'default', 'Create Chart Of Account', 53, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":53}', '2022-07-13 12:26:57', '2022-07-13 12:26:57'),
(56, 'default', 'Create Chart Of Account', 54, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":54}', '2022-07-13 12:27:29', '2022-07-13 12:27:29'),
(57, 'default', 'Create Chart Of Account', 55, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":55}', '2022-07-13 12:33:13', '2022-07-13 12:33:13'),
(58, 'default', 'Update Chart Of Account', 55, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":55}', '2022-07-13 12:33:38', '2022-07-13 12:33:38'),
(59, 'default', 'Update Chart Of Account', 55, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":55}', '2022-07-13 12:33:58', '2022-07-13 12:33:58'),
(60, 'default', 'Create Chart Of Account', 56, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":56}', '2022-07-13 12:34:53', '2022-07-13 12:34:53'),
(61, 'default', 'Create Chart Of Account', 57, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":57}', '2022-07-13 12:35:22', '2022-07-13 12:35:22'),
(62, 'default', 'Create Chart Of Account', 58, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":58}', '2022-07-13 12:36:03', '2022-07-13 12:36:03'),
(63, 'default', 'Create Chart Of Account', 59, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":59}', '2022-07-13 12:37:33', '2022-07-13 12:37:33'),
(64, 'default', 'Create Chart Of Account', 60, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":60}', '2022-07-13 12:39:26', '2022-07-13 12:39:26'),
(65, 'default', 'Create Chart Of Account', 61, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":61}', '2022-07-13 12:40:07', '2022-07-13 12:40:07'),
(66, 'default', 'Create Chart Of Account', 62, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":62}', '2022-07-13 12:40:43', '2022-07-13 12:40:43'),
(67, 'default', 'Create Chart Of Account', 63, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":63}', '2022-07-13 12:41:14', '2022-07-13 12:41:14'),
(68, 'default', 'Create Chart Of Account', 64, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":64}', '2022-07-13 12:41:35', '2022-07-13 12:41:35'),
(69, 'default', 'Create Chart Of Account', 65, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":65}', '2022-07-13 12:41:57', '2022-07-13 12:41:57'),
(70, 'default', 'Create Chart Of Account', 66, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":66}', '2022-07-13 12:45:17', '2022-07-13 12:45:17'),
(71, 'default', 'Create Chart Of Account', 67, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":67}', '2022-07-13 12:45:48', '2022-07-13 12:45:48'),
(72, 'default', 'Create Chart Of Account', 68, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":68}', '2022-07-13 12:46:07', '2022-07-13 12:46:07'),
(73, 'default', 'Create Chart Of Account', 69, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":69}', '2022-07-13 12:46:26', '2022-07-13 12:46:26'),
(74, 'default', 'Create Chart Of Account', 70, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":70}', '2022-07-13 12:47:15', '2022-07-13 12:47:15'),
(75, 'default', 'Create Chart Of Account', 71, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":71}', '2022-07-13 12:47:56', '2022-07-13 12:47:56'),
(76, 'default', 'Create Chart Of Account', 72, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":72}', '2022-07-13 12:48:17', '2022-07-13 12:48:17'),
(77, 'default', 'Create Chart Of Account', 73, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":73}', '2022-07-13 12:48:38', '2022-07-13 12:48:38'),
(78, 'default', 'Create Chart Of Account', 74, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":74}', '2022-07-13 12:49:00', '2022-07-13 12:49:00'),
(79, 'default', 'Create Chart Of Account', 75, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":75}', '2022-07-13 12:49:30', '2022-07-13 12:49:30'),
(80, 'default', 'Create Chart Of Account', 76, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":76}', '2022-07-13 12:50:04', '2022-07-13 12:50:04'),
(81, 'default', 'Create Chart Of Account', 77, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":77}', '2022-07-13 12:50:26', '2022-07-13 12:50:26'),
(82, 'default', 'Update Chart Of Account', 77, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":77}', '2022-07-13 12:51:02', '2022-07-13 12:51:02'),
(83, 'default', 'Create Chart Of Account', 78, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":78}', '2022-07-13 13:27:03', '2022-07-13 13:27:03'),
(84, 'default', 'Create Chart Of Account', 79, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":79}', '2022-07-13 13:27:46', '2022-07-13 13:27:46'),
(85, 'default', 'Create Chart Of Account', 80, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":80}', '2022-07-13 13:31:04', '2022-07-13 13:31:04'),
(86, 'default', 'Create Chart Of Account', 81, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":81}', '2022-07-13 13:31:34', '2022-07-13 13:31:34'),
(87, 'default', 'Create Chart Of Account', 82, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":82}', '2022-07-13 13:31:54', '2022-07-13 13:31:54'),
(88, 'default', 'Create Chart Of Account', 83, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":83}', '2022-07-13 13:32:10', '2022-07-13 13:32:10'),
(89, 'default', 'Create Chart Of Account', 84, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":84}', '2022-07-13 13:32:44', '2022-07-13 13:32:44'),
(90, 'default', 'Create Chart Of Account', 85, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":85}', '2022-07-13 13:33:19', '2022-07-13 13:33:19'),
(91, 'default', 'Create Chart Of Account', 86, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":86}', '2022-07-13 13:34:57', '2022-07-13 13:34:57'),
(92, 'default', 'Create Chart Of Account', 87, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":87}', '2022-07-13 13:35:31', '2022-07-13 13:35:31'),
(93, 'default', 'Create Chart Of Account', 88, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":88}', '2022-07-13 13:36:15', '2022-07-13 13:36:15'),
(94, 'default', 'Create Chart Of Account', 89, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":89}', '2022-07-13 13:36:33', '2022-07-13 13:36:33'),
(95, 'default', 'Create Chart Of Account', 90, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":90}', '2022-07-13 13:37:18', '2022-07-13 13:37:18'),
(96, 'default', 'Create Chart Of Account', 91, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":91}', '2022-07-13 13:37:52', '2022-07-13 13:37:52'),
(97, 'default', 'Create Chart Of Account', 92, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":92}', '2022-07-13 13:38:27', '2022-07-13 13:38:27'),
(98, 'default', 'Create Chart Of Account', 93, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":93}', '2022-07-13 13:39:10', '2022-07-13 13:39:10'),
(99, 'default', 'Create Chart Of Account', 94, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":94}', '2022-07-13 13:42:04', '2022-07-13 13:42:04'),
(100, 'default', 'Create Chart Of Account', 95, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":95}', '2022-07-13 13:42:59', '2022-07-13 13:42:59'),
(101, 'default', 'Create Chart Of Account', 96, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":96}', '2022-07-13 13:43:17', '2022-07-13 13:43:17'),
(102, 'default', 'Create Chart Of Account', 97, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":97}', '2022-07-13 13:43:35', '2022-07-13 13:43:35'),
(103, 'default', 'Create Chart Of Account', 98, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":98}', '2022-07-13 13:43:53', '2022-07-13 13:43:53'),
(104, 'default', 'Create Chart Of Account', 99, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":99}', '2022-07-13 13:44:14', '2022-07-13 13:44:14'),
(105, 'default', 'Create Chart Of Account', 100, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":100}', '2022-07-13 13:44:44', '2022-07-13 13:44:44'),
(106, 'default', 'Create Chart Of Account', 101, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":101}', '2022-07-13 13:45:50', '2022-07-13 13:45:50'),
(107, 'default', 'Create Chart Of Account', 102, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":102}', '2022-07-13 13:46:34', '2022-07-13 13:46:34'),
(108, 'default', 'Create Chart Of Account', 103, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":103}', '2022-07-13 13:46:54', '2022-07-13 13:46:54'),
(109, 'default', 'Create Chart Of Account', 104, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":104}', '2022-07-13 13:47:13', '2022-07-13 13:47:13'),
(110, 'default', 'Create Chart Of Account', 105, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":105}', '2022-07-13 13:47:55', '2022-07-13 13:47:55'),
(111, 'default', 'Create Chart Of Account', 106, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":106}', '2022-07-13 13:57:10', '2022-07-13 13:57:10'),
(112, 'default', 'Create Chart Of Account', 107, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":107}', '2022-07-13 13:57:48', '2022-07-13 13:57:48'),
(113, 'default', 'Create Chart Of Account', 108, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":108}', '2022-07-13 13:58:22', '2022-07-13 13:58:22'),
(114, 'default', 'Create Chart Of Account', 109, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":109}', '2022-07-13 13:58:44', '2022-07-13 13:58:44'),
(115, 'default', 'Create Chart Of Account', 110, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":110}', '2022-07-13 13:59:06', '2022-07-13 13:59:06'),
(116, 'default', 'Create Chart Of Account', 111, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":111}', '2022-07-13 13:59:27', '2022-07-13 13:59:27'),
(117, 'default', 'Create Chart Of Account', 112, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":112}', '2022-07-13 14:00:16', '2022-07-13 14:00:16'),
(118, 'default', 'Create Chart Of Account', 113, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":113}', '2022-07-13 14:00:49', '2022-07-13 14:00:49'),
(119, 'default', 'Create Chart Of Account', 114, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":114}', '2022-07-13 14:01:16', '2022-07-13 14:01:16'),
(120, 'default', 'Create Chart Of Account', 115, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":115}', '2022-07-13 14:01:41', '2022-07-13 14:01:41'),
(121, 'default', 'Create Chart Of Account', 116, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":116}', '2022-07-13 14:02:09', '2022-07-13 14:02:09'),
(122, 'default', 'Create Chart Of Account', 117, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":117}', '2022-07-13 14:02:25', '2022-07-13 14:02:25'),
(123, 'default', 'Create Chart Of Account', 118, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":118}', '2022-07-13 14:03:00', '2022-07-13 14:03:00'),
(124, 'default', 'Create Chart Of Account', 119, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":119}', '2022-07-13 14:04:04', '2022-07-13 14:04:04'),
(125, 'default', 'Create Chart Of Account', 120, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":120}', '2022-07-13 14:04:48', '2022-07-13 14:04:48'),
(126, 'default', 'Create Chart Of Account', 121, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":121}', '2022-07-13 14:05:09', '2022-07-13 14:05:09'),
(127, 'default', 'Create Chart Of Account', 122, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":122}', '2022-07-13 14:05:28', '2022-07-13 14:05:28'),
(128, 'default', 'Create Chart Of Account', 123, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":123}', '2022-07-13 14:05:46', '2022-07-13 14:05:46'),
(129, 'default', 'Create Chart Of Account', 124, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":124}', '2022-07-13 14:06:03', '2022-07-13 14:06:03'),
(130, 'default', 'Create Chart Of Account', 125, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":125}', '2022-07-13 14:06:31', '2022-07-13 14:06:31'),
(131, 'default', 'Create Chart Of Account', 126, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":126}', '2022-07-13 14:07:07', '2022-07-13 14:07:07'),
(132, 'default', 'Create Chart Of Account', 127, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":127}', '2022-07-13 14:09:20', '2022-07-13 14:09:20'),
(133, 'default', 'Create Chart Of Account', 128, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":128}', '2022-07-13 14:09:39', '2022-07-13 14:09:39'),
(134, 'default', 'Create Chart Of Account', 129, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":129}', '2022-07-13 14:09:56', '2022-07-13 14:09:56'),
(135, 'default', 'Create Chart Of Account', 130, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":130}', '2022-07-13 14:10:16', '2022-07-13 14:10:16'),
(136, 'default', 'Create Chart Of Account', 131, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":131}', '2022-07-13 14:10:52', '2022-07-13 14:10:52'),
(137, 'default', 'Create Chart Of Account', 132, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":132}', '2022-07-13 14:11:31', '2022-07-13 14:11:31'),
(138, 'default', 'Create Chart Of Account', 133, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":133}', '2022-07-13 14:11:51', '2022-07-13 14:11:51'),
(139, 'default', 'Create Chart Of Account', 134, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":134}', '2022-07-13 14:12:35', '2022-07-13 14:12:35'),
(140, 'default', 'Create Chart Of Account', 135, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":135}', '2022-07-13 14:13:05', '2022-07-13 14:13:05'),
(141, 'default', 'Create Chart Of Account', 136, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":136}', '2022-07-13 14:13:22', '2022-07-13 14:13:22'),
(142, 'default', 'Create Chart Of Account', 137, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":137}', '2022-07-13 14:13:44', '2022-07-13 14:13:44'),
(143, 'default', 'Create Chart Of Account', 138, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":138}', '2022-07-13 14:14:12', '2022-07-13 14:14:12'),
(144, 'default', 'Create Chart Of Account', 139, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":139}', '2022-07-13 14:14:56', '2022-07-13 14:14:56'),
(145, 'default', 'Create Chart Of Account', 140, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":140}', '2022-07-13 14:16:24', '2022-07-13 14:16:24'),
(146, 'default', 'Create Chart Of Account', 141, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":141}', '2022-07-13 14:17:01', '2022-07-13 14:17:01'),
(147, 'default', 'Create Chart Of Account', 142, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":142}', '2022-07-13 14:17:30', '2022-07-13 14:17:30'),
(148, 'default', 'Create Chart Of Account', 143, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":143}', '2022-07-13 14:18:51', '2022-07-13 14:18:51'),
(149, 'default', 'Create Chart Of Account', 144, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":144}', '2022-07-13 14:19:16', '2022-07-13 14:19:16'),
(150, 'default', 'Create Chart Of Account', 145, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":145}', '2022-07-13 14:19:40', '2022-07-13 14:19:40'),
(151, 'default', 'Create Chart Of Account', 146, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":146}', '2022-07-13 14:20:08', '2022-07-13 14:20:08'),
(152, 'default', 'Update Chart Of Account', 142, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":142}', '2022-07-13 14:21:27', '2022-07-13 14:21:27'),
(153, 'default', 'Update Chart Of Account', 131, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":131}', '2022-07-13 14:21:55', '2022-07-13 14:21:55'),
(154, 'default', 'Update Chart Of Account', 107, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":107}', '2022-07-13 14:22:37', '2022-07-13 14:22:37'),
(155, 'default', 'Update Chart Of Account', 80, 'Modules\\Accounting\\Entities\\ChartOfAccount', 1, 'Modules\\User\\Entities\\User', '{\"id\":80}', '2022-07-13 14:23:16', '2022-07-13 14:23:16');

-- --------------------------------------------------------

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
CREATE TABLE IF NOT EXISTS `assets` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `asset_type_id` bigint(20) UNSIGNED DEFAULT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `purchase_price` decimal(65,2) DEFAULT NULL,
  `replacement_value` decimal(65,2) DEFAULT NULL,
  `value` decimal(65,2) DEFAULT NULL,
  `life_span` int(11) DEFAULT NULL,
  `salvage_value` decimal(65,2) DEFAULT NULL,
  `serial_number` text COLLATE utf8mb4_unicode_ci,
  `bought_from` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_year` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `status` enum('active','inactive','sold','damaged','written_off') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(4) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `asset_depreciation`
--

DROP TABLE IF EXISTS `asset_depreciation`;
CREATE TABLE IF NOT EXISTS `asset_depreciation` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `asset_id` bigint(20) UNSIGNED DEFAULT NULL,
  `year` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `beginning_value` decimal(65,2) DEFAULT NULL,
  `depreciation_value` decimal(65,2) DEFAULT NULL,
  `rate` decimal(65,2) DEFAULT NULL,
  `cost` decimal(65,2) DEFAULT NULL,
  `accumulated` decimal(65,2) DEFAULT NULL,
  `ending_value` decimal(65,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `asset_files`
--

DROP TABLE IF EXISTS `asset_files`;
CREATE TABLE IF NOT EXISTS `asset_files` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `asset_id` bigint(20) UNSIGNED DEFAULT NULL,
  `file` text COLLATE utf8mb4_unicode_ci,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `asset_maintenance`
--

DROP TABLE IF EXISTS `asset_maintenance`;
CREATE TABLE IF NOT EXISTS `asset_maintenance` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `asset_maintenance_type_id` bigint(20) UNSIGNED DEFAULT NULL,
  `asset_id` bigint(20) UNSIGNED DEFAULT NULL,
  `performed_by` text COLLATE utf8mb4_unicode_ci,
  `date` date DEFAULT NULL,
  `amount` decimal(65,2) DEFAULT NULL,
  `mileage` decimal(65,2) DEFAULT NULL,
  `record_expense` tinyint(4) NOT NULL DEFAULT '0',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `asset_maintenance_types`
--

DROP TABLE IF EXISTS `asset_maintenance_types`;
CREATE TABLE IF NOT EXISTS `asset_maintenance_types` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `asset_notes`
--

DROP TABLE IF EXISTS `asset_notes`;
CREATE TABLE IF NOT EXISTS `asset_notes` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` int(10) UNSIGNED DEFAULT NULL,
  `asset_id` bigint(20) UNSIGNED DEFAULT NULL,
  `attachment` text COLLATE utf8mb4_unicode_ci,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `asset_pictures`
--

DROP TABLE IF EXISTS `asset_pictures`;
CREATE TABLE IF NOT EXISTS `asset_pictures` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `asset_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `primary_picture` tinyint(4) NOT NULL DEFAULT '0',
  `picture` text COLLATE utf8mb4_unicode_ci,
  `date_taken` date DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `asset_types`
--

DROP TABLE IF EXISTS `asset_types`;
CREATE TABLE IF NOT EXISTS `asset_types` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` enum('current','fixed','intangible','investment','other') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `chart_of_account_fixed_asset_id` int(11) DEFAULT NULL,
  `chart_of_account_asset_id` int(11) DEFAULT NULL,
  `chart_of_account_contra_asset_id` int(11) DEFAULT NULL,
  `chart_of_account_expense_id` int(11) DEFAULT NULL,
  `chart_of_account_liability_id` int(11) DEFAULT NULL,
  `chart_of_account_income_id` int(11) DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `asset_types`
--

INSERT INTO `asset_types` (`id`, `name`, `type`, `chart_of_account_fixed_asset_id`, `chart_of_account_asset_id`, `chart_of_account_contra_asset_id`, `chart_of_account_expense_id`, `chart_of_account_liability_id`, `chart_of_account_income_id`, `notes`) VALUES
(1, 'Current Assets', NULL, 1, 1, 2, 2, NULL, 3, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

DROP TABLE IF EXISTS `branches`;
CREATE TABLE IF NOT EXISTS `branches` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `manager_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `open_date` date DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `is_system` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`id`, `created_by_id`, `parent_id`, `manager_id`, `name`, `open_date`, `notes`, `active`, `is_system`, `created_at`, `updated_at`) VALUES
(1, NULL, NULL, NULL, 'Biashara Street', '2020-09-02', NULL, 1, 1, '2020-09-02 06:59:25', '2022-03-16 10:48:00'),
(2, NULL, NULL, NULL, 'Tom Mboya Street', '2020-10-20', 'ff', 1, 0, '2020-10-20 07:51:37', '2022-03-16 10:48:31');

-- --------------------------------------------------------

--
-- Table structure for table `branch_users`
--

DROP TABLE IF EXISTS `branch_users`;
CREATE TABLE IF NOT EXISTS `branch_users` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `branch_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `branch_users`
--

INSERT INTO `branch_users` (`id`, `created_by_id`, `user_id`, `branch_id`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `chart_of_accounts`
--

DROP TABLE IF EXISTS `chart_of_accounts`;
CREATE TABLE IF NOT EXISTS `chart_of_accounts` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `name` text COLLATE utf8mb4_unicode_ci,
  `gl_code` int(11) DEFAULT NULL,
  `account_type` enum('asset','expense','equity','liability','income') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'asset',
  `allow_manual` tinyint(4) NOT NULL DEFAULT '0',
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=147 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `chart_of_accounts`
--

INSERT INTO `chart_of_accounts` (`id`, `parent_id`, `name`, `gl_code`, `account_type`, `allow_manual`, `active`, `notes`, `created_at`, `updated_at`) VALUES
(1, NULL, 'NON CURRENT ASSETS', 100100, 'asset', 1, 1, NULL, '2022-07-13 11:30:05', '2022-07-13 11:32:21'),
(2, 1, 'Motor Vehicle', 100101, 'asset', 1, 1, NULL, '2022-07-13 11:34:41', '2022-07-13 11:34:41'),
(3, 2, 'Motor Vehicles', 100102, 'asset', 1, 1, NULL, '2022-07-13 11:35:25', '2022-07-13 11:35:25'),
(4, 2, 'Motor Vehicles Depreciation', 100103, 'asset', 1, 1, NULL, '2022-07-13 11:36:12', '2022-07-13 11:36:12'),
(5, 1, 'Furniture and Fittings', 100110, 'asset', 1, 1, NULL, '2022-07-13 11:37:00', '2022-07-13 11:37:00'),
(6, 5, 'Furniture', 100111, 'asset', 1, 1, NULL, '2022-07-13 11:44:33', '2022-07-13 11:44:33'),
(7, 5, 'Furniture and Fittings Depreciation', 100112, 'asset', 1, 1, NULL, '2022-07-13 11:45:20', '2022-07-13 11:45:20'),
(8, 5, 'Office Equipment', 100113, 'asset', 1, 1, NULL, '2022-07-13 11:45:50', '2022-07-13 11:45:50'),
(9, 5, 'Office Equipment Accumulated Depreciation', 100114, 'asset', 1, 1, NULL, '2022-07-13 11:46:37', '2022-07-13 11:46:37'),
(10, 1, 'Computer and Peripherals', 100120, 'asset', 1, 1, NULL, '2022-07-13 11:47:32', '2022-07-13 11:47:32'),
(11, 10, 'Computers Software', 100121, 'asset', 1, 1, NULL, '2022-07-13 11:48:05', '2022-07-13 11:48:05'),
(12, 10, 'Computer Software Depreciation', 100122, 'asset', 1, 1, NULL, '2022-07-13 11:48:30', '2022-07-13 11:48:30'),
(13, 10, 'Bluchip System Deposit', 100123, 'asset', 1, 1, NULL, '2022-07-13 11:49:00', '2022-07-13 11:49:00'),
(14, 10, 'Computer Hardware & Pheripherals', 100124, 'asset', 1, 1, NULL, '2022-07-13 11:49:28', '2022-07-13 11:49:28'),
(15, 10, 'Computer Hardware & Peripherals Accumulated Depreciation', 100125, 'asset', 1, 1, NULL, '2022-07-13 11:50:44', '2022-07-13 11:50:44'),
(16, NULL, 'CURRENT ASSETS', 100200, 'asset', 1, 1, NULL, '2022-07-13 11:52:26', '2022-07-13 11:52:26'),
(17, 16, 'Cash and Bank Balances', 100210, 'asset', 1, 1, NULL, '2022-07-13 11:53:12', '2022-07-13 11:53:12'),
(18, 17, 'Paybill C2B-7180377', 100211, 'asset', 1, 1, NULL, '2022-07-13 11:54:48', '2022-07-13 11:54:48'),
(19, 17, 'Paybill B2C-3012183', 100212, 'asset', 1, 1, NULL, '2022-07-13 11:55:17', '2022-07-13 11:55:17'),
(20, 17, 'Relationship Officers Cash control Account', 100213, 'asset', 1, 1, NULL, '2022-07-13 11:56:11', '2022-07-13 11:56:11'),
(21, 17, 'Call Deposit', 100214, 'asset', 1, 1, NULL, '2022-07-13 11:56:37', '2022-07-13 11:56:37'),
(22, 17, 'Cash In Hand', 100215, 'asset', 1, 1, NULL, '2022-07-13 11:57:11', '2022-07-13 11:57:11'),
(23, 17, 'Petty Cash', 100216, 'asset', 1, 1, NULL, '2022-07-13 11:57:48', '2022-07-13 11:57:48'),
(24, 17, 'Equity Bank Account', 100217, 'asset', 1, 1, NULL, '2022-07-13 11:58:28', '2022-07-13 11:58:28'),
(25, 16, 'Trade and Other Receivables', 100300, 'asset', 1, 1, NULL, '2022-07-13 12:01:57', '2022-07-13 12:01:57'),
(26, 16, 'Loans', 100400, 'asset', 1, 1, NULL, '2022-07-13 12:02:52', '2022-07-13 12:02:52'),
(27, 26, 'Pap Loan', 100401, 'asset', 1, 1, NULL, '2022-07-13 12:03:27', '2022-07-13 12:03:27'),
(28, 26, 'Nawiri Loan', 100402, 'asset', 1, 1, NULL, '2022-07-13 12:03:56', '2022-07-13 12:03:56'),
(29, 26, 'Platinum Loan', 100403, 'asset', 1, 1, NULL, '2022-07-13 12:04:20', '2022-07-13 12:04:20'),
(30, 26, 'Staff Loans', 100404, 'asset', 1, 1, NULL, '2022-07-13 12:04:41', '2022-07-13 12:04:41'),
(31, 26, 'Asset Finance Loan', 100405, 'asset', 1, 1, NULL, '2022-07-13 12:05:19', '2022-07-13 12:05:19'),
(32, 26, 'Executive Loan', 100406, 'asset', 1, 1, NULL, '2022-07-13 12:05:43', '2022-07-13 12:05:43'),
(33, 26, 'Interest Free Loan', 100407, 'asset', 1, 1, NULL, '2022-07-13 12:06:17', '2022-07-13 12:06:17'),
(34, 16, 'Deposits', 100500, 'asset', 1, 1, NULL, '2022-07-13 12:06:52', '2022-07-13 12:06:52'),
(35, 34, 'Rent Deposit', 100501, 'asset', 1, 1, NULL, '2022-07-13 12:07:27', '2022-07-13 12:07:27'),
(36, 16, 'Other Receivables', 100600, 'asset', 1, 1, NULL, '2022-07-13 12:07:56', '2022-07-13 12:07:56'),
(37, NULL, 'CURRENT LIABILITIES', 200100, 'liability', 1, 1, NULL, '2022-07-13 12:12:10', '2022-07-13 12:12:10'),
(38, 37, 'Member Savings', 200110, 'liability', 1, 1, NULL, '2022-07-13 12:13:02', '2022-07-13 12:13:02'),
(39, 38, 'Nawiri Savings', 200111, 'liability', 1, 1, NULL, '2022-07-13 12:14:06', '2022-07-13 12:18:38'),
(40, 38, 'Akiba Savings', 200112, 'liability', 1, 1, NULL, '2022-07-13 12:15:06', '2022-07-13 12:15:06'),
(41, 37, 'Payroll Liabilities', 200200, 'liability', 1, 1, NULL, '2022-07-13 12:15:37', '2022-07-13 12:15:37'),
(42, 41, 'Staff Gratuity', 200201, 'liability', 1, 1, NULL, '2022-07-13 12:16:24', '2022-07-13 12:16:24'),
(43, 41, 'Staff Welfare Scheme', 200202, 'liability', 1, 1, NULL, '2022-07-13 12:17:16', '2022-07-13 12:17:16'),
(44, 41, 'NSSF', 200203, 'liability', 1, 1, NULL, '2022-07-13 12:19:21', '2022-07-13 12:19:21'),
(45, 41, 'PAYE', 200204, 'liability', 1, 1, NULL, '2022-07-13 12:19:48', '2022-07-13 12:19:48'),
(46, 41, 'PENSION', 200205, 'liability', 1, 1, NULL, '2022-07-13 12:20:21', '2022-07-13 12:20:21'),
(47, 41, 'NHIF', 200206, 'liability', 1, 1, NULL, '2022-07-13 12:21:03', '2022-07-13 12:21:03'),
(48, 37, 'Other Liabilities', 200300, 'liability', 1, 1, NULL, '2022-07-13 12:22:51', '2022-07-13 12:22:51'),
(49, 48, 'Group Payables', 200301, 'liability', 1, 1, NULL, '2022-07-13 12:23:19', '2022-07-13 12:23:19'),
(50, 48, 'Other Payables', 200302, 'liability', 1, 1, NULL, '2022-07-13 12:23:50', '2022-07-13 12:23:50'),
(51, 48, 'Tax Liability Account', 200303, 'liability', 1, 1, NULL, '2022-07-13 12:24:21', '2022-07-13 12:24:21'),
(52, NULL, 'NON CURRENT LIABILITIES', 200400, 'liability', 1, 1, NULL, '2022-07-13 12:25:23', '2022-07-13 12:25:23'),
(53, 52, 'Long Term Loans', 200401, 'liability', 1, 1, NULL, '2022-07-13 12:26:56', '2022-07-13 12:26:56'),
(54, 52, 'Other Loans', 200402, 'liability', 1, 1, NULL, '2022-07-13 12:27:29', '2022-07-13 12:27:29'),
(55, NULL, 'CAPITAL', 200500, 'liability', 1, 1, NULL, '2022-07-13 12:33:13', '2022-07-13 12:33:58'),
(56, 55, 'Share Capital', 200501, 'liability', 1, 1, NULL, '2022-07-13 12:34:53', '2022-07-13 12:34:53'),
(57, 55, 'Directors Current Account', 200502, 'liability', 1, 1, NULL, '2022-07-13 12:35:22', '2022-07-13 12:35:22'),
(58, 55, 'Retained Earnings', 200503, 'liability', 1, 1, NULL, '2022-07-13 12:36:03', '2022-07-13 12:36:03'),
(59, NULL, 'LOAN INTEREST INCOME', 300100, 'income', 1, 1, NULL, '2022-07-13 12:37:33', '2022-07-13 12:37:33'),
(60, 59, 'Pap Loan', 300101, 'income', 1, 1, NULL, '2022-07-13 12:39:26', '2022-07-13 12:39:26'),
(61, 59, 'Nawiri Loan', 300102, 'income', 1, 1, NULL, '2022-07-13 12:40:07', '2022-07-13 12:40:07'),
(62, 59, 'Platinum Loan', 300103, 'income', 1, 1, NULL, '2022-07-13 12:40:43', '2022-07-13 12:40:43'),
(63, 59, 'Staff Loans', 300104, 'income', 1, 1, NULL, '2022-07-13 12:41:14', '2022-07-13 12:41:14'),
(64, 59, 'Asset Finance Loan', 300105, 'income', 1, 1, NULL, '2022-07-13 12:41:35', '2022-07-13 12:41:35'),
(65, 59, 'Executive Loan', 300106, 'income', 1, 1, NULL, '2022-07-13 12:41:57', '2022-07-13 12:41:57'),
(66, NULL, 'LOAN PROCESSING FEE', 300200, 'income', 1, 1, NULL, '2022-07-13 12:45:17', '2022-07-13 12:45:17'),
(67, NULL, 'Loan Processing Insurance Fee', 300300, 'income', 1, 1, NULL, '2022-07-13 12:45:48', '2022-07-13 12:45:48'),
(68, NULL, 'Passbook and Registration Fee', 300400, 'income', 1, 1, NULL, '2022-07-13 12:46:07', '2022-07-13 12:46:07'),
(69, NULL, 'Other Incomes', 300500, 'income', 1, 1, NULL, '2022-07-13 12:46:25', '2022-07-13 12:46:25'),
(70, 69, 'Penalties on Loans', 300501, 'income', 1, 1, NULL, '2022-07-13 12:47:15', '2022-07-13 12:47:15'),
(71, 69, 'Disposal Gain', 300502, 'income', 1, 1, NULL, '2022-07-13 12:47:56', '2022-07-13 12:47:56'),
(72, 69, 'Investment Income', 300503, 'income', 1, 1, NULL, '2022-07-13 12:48:17', '2022-07-13 12:48:17'),
(73, 69, 'Sundry Incomes', 300504, 'income', 1, 1, NULL, '2022-07-13 12:48:38', '2022-07-13 12:48:38'),
(74, 69, 'CRB Search fees', 300505, 'income', 1, 1, NULL, '2022-07-13 12:49:00', '2022-07-13 12:49:00'),
(75, 69, 'Hall Fees Income', 300507, 'income', 1, 1, NULL, '2022-07-13 12:49:30', '2022-07-13 12:49:30'),
(76, 69, 'Commission On Tracking Services', 300508, 'income', 1, 1, NULL, '2022-07-13 12:50:03', '2022-07-13 12:50:03'),
(77, 69, 'Fines and Charges', 300509, 'income', 1, 1, NULL, '2022-07-13 12:50:26', '2022-07-13 12:51:02'),
(78, NULL, 'ADMINISTRATIVE EXPENSE', 400000, 'expense', 1, 1, NULL, '2022-07-13 13:27:03', '2022-07-13 13:27:03'),
(79, 78, 'Employment Cost', 400100, 'expense', 1, 1, NULL, '2022-07-13 13:27:46', '2022-07-13 13:27:46'),
(80, 79, 'Salaries and Wages', 400101, 'expense', 1, 1, NULL, '2022-07-13 13:31:04', '2022-07-13 14:23:16'),
(81, 79, 'Casual Payments', 400102, 'expense', 1, 1, NULL, '2022-07-13 13:31:34', '2022-07-13 13:31:34'),
(82, 79, 'Bonuses', 400103, 'expense', 1, 1, NULL, '2022-07-13 13:31:54', '2022-07-13 13:31:54'),
(83, 79, 'Overtime & Holiday Pay', 400104, 'expense', 1, 1, NULL, '2022-07-13 13:32:10', '2022-07-13 13:32:10'),
(84, 79, 'Directors and Management Expense', 400105, 'expense', 1, 1, NULL, '2022-07-13 13:32:44', '2022-07-13 13:32:44'),
(85, 79, 'NSSF Employer Contribution', 400106, 'expense', 1, 1, NULL, '2022-07-13 13:33:19', '2022-07-13 13:33:19'),
(86, 79, 'Staff Welfare Employer Contribution', 400107, 'expense', 1, 1, NULL, '2022-07-13 13:34:57', '2022-07-13 13:34:57'),
(87, 78, 'Staff Welfare', 400200, 'expense', 1, 1, NULL, '2022-07-13 13:35:31', '2022-07-13 13:35:31'),
(88, 87, 'Staff training & welfare', 400201, 'expense', 1, 1, NULL, '2022-07-13 13:36:15', '2022-07-13 13:36:15'),
(89, 87, 'Postage and stationary', 400202, 'expense', 1, 1, NULL, '2022-07-13 13:36:33', '2022-07-13 13:36:33'),
(90, 78, 'Communication', 400300, 'expense', 1, 1, NULL, '2022-07-13 13:37:18', '2022-07-13 13:37:18'),
(91, 90, 'Airtime', 400301, 'expense', 1, 1, NULL, '2022-07-13 13:37:52', '2022-07-13 13:37:52'),
(92, 90, 'Internet', 400302, 'expense', 1, 1, NULL, '2022-07-13 13:38:27', '2022-07-13 13:38:27'),
(93, 90, 'Bulk SMS', 400303, 'expense', 1, 1, NULL, '2022-07-13 13:39:10', '2022-07-13 13:39:10'),
(94, 78, 'Office Expenses', 400400, 'expense', 1, 1, NULL, '2022-07-13 13:42:04', '2022-07-13 13:42:04'),
(95, 94, 'Office running Expenses', 400401, 'expense', 1, 1, NULL, '2022-07-13 13:42:59', '2022-07-13 13:42:59'),
(96, 94, 'Office Shopping', 400402, 'expense', 1, 1, NULL, '2022-07-13 13:43:17', '2022-07-13 13:43:17'),
(97, 94, 'Staff Meals', 400403, 'expense', 1, 1, NULL, '2022-07-13 13:43:35', '2022-07-13 13:43:35'),
(98, 94, 'Purchase of office equipment', 400404, 'expense', 1, 1, NULL, '2022-07-13 13:43:52', '2022-07-13 13:43:52'),
(99, 94, 'Office repairs and maintenance', 400405, 'expense', 1, 1, NULL, '2022-07-13 13:44:14', '2022-07-13 13:44:14'),
(100, 94, 'Journals and newspapers', 400406, 'expense', 1, 1, NULL, '2022-07-13 13:44:44', '2022-07-13 13:44:44'),
(101, 78, 'Professional and Legal Fees', 400500, 'expense', 1, 1, NULL, '2022-07-13 13:45:49', '2022-07-13 13:45:49'),
(102, 101, 'Audit Fees', 400501, 'expense', 1, 1, NULL, '2022-07-13 13:46:34', '2022-07-13 13:46:34'),
(103, 101, 'ICT Fees', 400502, 'expense', 1, 1, NULL, '2022-07-13 13:46:54', '2022-07-13 13:46:54'),
(104, 101, 'Others', 400503, 'expense', 1, 1, NULL, '2022-07-13 13:47:13', '2022-07-13 13:47:13'),
(105, 78, 'Permits and Licenses', 400600, 'expense', 1, 1, NULL, '2022-07-13 13:47:55', '2022-07-13 13:47:55'),
(106, NULL, 'OPERATIONAL EXPENSES', 400700, 'expense', 1, 1, NULL, '2022-07-13 13:57:09', '2022-07-13 13:57:09'),
(107, 106, 'ICT Repairs and Maintenance', 400710, 'expense', 1, 1, NULL, '2022-07-13 13:57:48', '2022-07-13 14:22:37'),
(108, 107, 'Computer Repairs', 400711, 'expense', 1, 1, NULL, '2022-07-13 13:58:22', '2022-07-13 13:58:22'),
(109, 107, 'Software upgrade & Maintanance', 400712, 'expense', 1, 1, NULL, '2022-07-13 13:58:44', '2022-07-13 13:58:44'),
(110, 107, 'Equipment Repairs', 400713, 'expense', 1, 1, NULL, '2022-07-13 13:59:06', '2022-07-13 13:59:06'),
(111, 107, 'Repair & Maintenance', 400714, 'expense', 1, 1, NULL, '2022-07-13 13:59:27', '2022-07-13 13:59:27'),
(112, 106, 'Travel Expenses', 400720, 'expense', 1, 1, NULL, '2022-07-13 14:00:16', '2022-07-13 14:00:16'),
(113, 112, 'Transport Expenses', 400721, 'expense', 1, 1, NULL, '2022-07-13 14:00:49', '2022-07-13 14:00:49'),
(114, 112, 'Meeting Expenses', 400722, 'expense', 1, 1, NULL, '2022-07-13 14:01:16', '2022-07-13 14:01:16'),
(115, 106, 'Utilities', 400730, 'expense', 1, 1, NULL, '2022-07-13 14:01:41', '2022-07-13 14:01:41'),
(116, 115, 'Rent', 400731, 'expense', 1, 1, NULL, '2022-07-13 14:02:09', '2022-07-13 14:02:09'),
(117, 115, 'Water', 400732, 'expense', 1, 1, NULL, '2022-07-13 14:02:25', '2022-07-13 14:02:25'),
(118, 115, 'Electricity', 400733, 'expense', 1, 1, NULL, '2022-07-13 14:03:00', '2022-07-13 14:03:00'),
(119, 106, 'Members Direct Expenses', 400740, 'expense', 1, 1, NULL, '2022-07-13 14:04:04', '2022-07-13 14:04:04'),
(120, 119, 'Fines expense', 400741, 'expense', 1, 1, NULL, '2022-07-13 14:04:48', '2022-07-13 14:04:48'),
(121, 119, 'Field officers transport', 400742, 'expense', 1, 1, NULL, '2022-07-13 14:05:09', '2022-07-13 14:05:09'),
(122, 119, 'Field officers airtime', 400743, 'expense', 1, 1, NULL, '2022-07-13 14:05:28', '2022-07-13 14:05:28'),
(123, 119, 'Hall Expenses', 400744, 'expense', 1, 1, NULL, '2022-07-13 14:05:46', '2022-07-13 14:05:46'),
(124, 119, 'Deceased Members Expenses', 400745, 'expense', 1, 1, NULL, '2022-07-13 14:06:03', '2022-07-13 14:06:03'),
(125, 119, 'Member welfare expense', 400746, 'expense', 1, 1, NULL, '2022-07-13 14:06:31', '2022-07-13 14:06:31'),
(126, 106, 'Advertisement', 400750, 'expense', 1, 1, NULL, '2022-07-13 14:07:07', '2022-07-13 14:07:07'),
(127, 106, 'Marketing', 400751, 'expense', 1, 1, NULL, '2022-07-13 14:09:20', '2022-07-13 14:09:20'),
(128, 126, 'Online Marketing', 400752, 'expense', 1, 1, NULL, '2022-07-13 14:09:39', '2022-07-13 14:09:39'),
(129, 126, 'Commissions', 400753, 'expense', 1, 1, NULL, '2022-07-13 14:09:56', '2022-07-13 14:09:56'),
(130, 126, 'Printing and stationery expenses', 400754, 'expense', 1, 1, NULL, '2022-07-13 14:10:16', '2022-07-13 14:10:16'),
(131, 106, 'Interest Expenses', 400760, 'expense', 1, 1, NULL, '2022-07-13 14:10:52', '2022-07-13 14:21:55'),
(132, 131, 'Interest Payables', 400761, 'expense', 1, 1, NULL, '2022-07-13 14:11:31', '2022-07-13 14:11:31'),
(133, 131, 'Dividend Payables', 400762, 'expense', 1, 1, NULL, '2022-07-13 14:11:51', '2022-07-13 14:11:51'),
(134, 106, 'Motor Vehicle Expenses', 400770, 'expense', 1, 1, NULL, '2022-07-13 14:12:35', '2022-07-13 14:12:35'),
(135, 134, 'Repair and maintenance', 400771, 'expense', 1, 1, NULL, '2022-07-13 14:13:05', '2022-07-13 14:13:05'),
(136, 134, 'Insurance', 400772, 'expense', 1, 1, NULL, '2022-07-13 14:13:22', '2022-07-13 14:13:22'),
(137, 134, 'Fuel', 400773, 'expense', 1, 1, NULL, '2022-07-13 14:13:44', '2022-07-13 14:13:44'),
(138, 106, 'CSR', 400780, 'expense', 1, 1, NULL, '2022-07-13 14:14:12', '2022-07-13 14:14:12'),
(139, 106, 'Depreciation', 400790, 'expense', 1, 1, NULL, '2022-07-13 14:14:56', '2022-07-13 14:14:56'),
(140, 106, 'Other Expenses', 400800, 'expense', 1, 1, NULL, '2022-07-13 14:16:24', '2022-07-13 14:16:24'),
(141, 140, 'Hygiene & sanitation', 400801, 'expense', 1, 1, NULL, '2022-07-13 14:17:01', '2022-07-13 14:17:01'),
(142, 140, 'Sundry expense', 400802, 'expense', 1, 1, NULL, '2022-07-13 14:17:30', '2022-07-13 14:21:27'),
(143, NULL, 'FINANCE COST', 400900, 'expense', 1, 1, NULL, '2022-07-13 14:18:51', '2022-07-13 14:18:51'),
(144, 143, 'Bank service charges', 400901, 'expense', 1, 1, NULL, '2022-07-13 14:19:16', '2022-07-13 14:19:16'),
(145, 143, 'Mpesa Charges', 400902, 'expense', 1, 1, NULL, '2022-07-13 14:19:40', '2022-07-13 14:19:40'),
(146, 143, 'Other charges', 400903, 'expense', 1, 1, NULL, '2022-07-13 14:20:08', '2022-07-13 14:20:08');

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `group_id` bigint(20) UNSIGNED NOT NULL,
  `loan_officer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `reference` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `middle_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` enum('male','female','other','unspecified') COLLATE utf8mb4_unicode_ci DEFAULT 'unspecified',
  `status` enum('pending','active','inactive','deceased','unspecified','closed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `marital_status` enum('married','single','divorced','widowed','unspecified','other') COLLATE utf8mb4_unicode_ci DEFAULT 'unspecified',
  `country_id` bigint(20) UNSIGNED DEFAULT NULL,
  `title_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profession_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_type_id` bigint(20) UNSIGNED DEFAULT NULL,
  `mobile` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `external_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employer` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `signature` text COLLATE utf8mb4_unicode_ci,
  `created_date` date DEFAULT NULL,
  `joined_date` date DEFAULT NULL,
  `activation_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_group_id_foreign` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `client_files`
--

DROP TABLE IF EXISTS `client_files`;
CREATE TABLE IF NOT EXISTS `client_files` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `size` int(11) DEFAULT NULL,
  `link` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `client_groups`
--

DROP TABLE IF EXISTS `client_groups`;
CREATE TABLE IF NOT EXISTS `client_groups` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `group_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_id` bigint(20) UNSIGNED NOT NULL DEFAULT '1',
  `status` enum('pending','active','inactive','closed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `client_groups`
--

INSERT INTO `client_groups` (`id`, `group_name`, `branch_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Paradise Group 1', 1, 'active', NULL, NULL),
(2, 'Hekima Group', 1, 'active', NULL, NULL),
(3, 'Sisters Of Mary Group', 1, 'active', NULL, NULL),
(4, 'Samoa Maidens', 1, 'active', NULL, NULL),
(5, 'AHADI GROUP', 1, 'active', NULL, NULL),
(6, 'EMAIYAN GROUP', 1, 'active', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `client_identification`
--

DROP TABLE IF EXISTS `client_identification`;
CREATE TABLE IF NOT EXISTS `client_identification` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_identification_type_id` bigint(20) UNSIGNED DEFAULT NULL,
  `identification_value` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `size` int(11) DEFAULT NULL,
  `link` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `client_identification_types`
--

DROP TABLE IF EXISTS `client_identification_types`;
CREATE TABLE IF NOT EXISTS `client_identification_types` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `client_identification_types`
--

INSERT INTO `client_identification_types` (`id`, `name`) VALUES
(1, 'National ID'),
(2, 'Passport'),
(3, 'Driving Licence'),
(4, 'Alien ID');

-- --------------------------------------------------------

--
-- Table structure for table `client_next_of_kin`
--

DROP TABLE IF EXISTS `client_next_of_kin`;
CREATE TABLE IF NOT EXISTS `client_next_of_kin` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_relationship_id` bigint(20) UNSIGNED DEFAULT NULL,
  `first_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `middle_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` enum('male','female','other','unspecified') COLLATE utf8mb4_unicode_ci DEFAULT 'unspecified',
  `marital_status` enum('married','single','divorced','widowed','unspecified','other') COLLATE utf8mb4_unicode_ci DEFAULT 'unspecified',
  `next_kin_id` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country_id` bigint(20) UNSIGNED DEFAULT NULL,
  `title_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profession_id` bigint(20) UNSIGNED DEFAULT NULL,
  `mobile` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shares` int(5) DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employer` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `client_relationships`
--

DROP TABLE IF EXISTS `client_relationships`;
CREATE TABLE IF NOT EXISTS `client_relationships` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `client_relationships`
--

INSERT INTO `client_relationships` (`id`, `name`) VALUES
(1, 'Father'),
(2, 'Mother'),
(3, 'Uncle'),
(4, 'Aunt'),
(5, 'Mother In Law'),
(6, 'Father In Law'),
(7, 'Daughter In Law'),
(8, 'Son In Law'),
(9, 'GrandParent');

-- --------------------------------------------------------

--
-- Table structure for table `client_types`
--

DROP TABLE IF EXISTS `client_types`;
CREATE TABLE IF NOT EXISTS `client_types` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `client_types`
--

INSERT INTO `client_types` (`id`, `name`) VALUES
(1, 'Individual'),
(2, 'Group');

-- --------------------------------------------------------

--
-- Table structure for table `client_users`
--

DROP TABLE IF EXISTS `client_users`;
CREATE TABLE IF NOT EXISTS `client_users` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `communication_campaigns`
--

DROP TABLE IF EXISTS `communication_campaigns`;
CREATE TABLE IF NOT EXISTS `communication_campaigns` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `sms_gateway_id` bigint(20) UNSIGNED DEFAULT NULL,
  `communication_campaign_business_rule_id` bigint(20) UNSIGNED DEFAULT NULL,
  `communication_campaign_attachment_type_id` bigint(20) UNSIGNED DEFAULT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `loan_officer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `loan_product_id` bigint(20) UNSIGNED DEFAULT NULL,
  `subject` text COLLATE utf8mb4_unicode_ci,
  `name` text COLLATE utf8mb4_unicode_ci,
  `campaign_type` enum('sms','email') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'email',
  `trigger_type` enum('direct','schedule','triggered') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'direct',
  `scheduled_date` date DEFAULT NULL,
  `scheduled_time` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `schedule_frequency` int(11) DEFAULT NULL,
  `schedule_frequency_type` enum('days','weeks','months','years') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'days',
  `scheduled_next_run_date` date DEFAULT NULL,
  `scheduled_last_run_date` date DEFAULT NULL,
  `from_x` int(11) DEFAULT NULL,
  `to_y` int(11) DEFAULT NULL,
  `cycle_x` int(11) DEFAULT NULL,
  `cycle_y` int(11) DEFAULT NULL,
  `overdue_x` int(11) DEFAULT NULL,
  `overdue_y` int(11) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '0',
  `status` enum('pending','active','inactive','closed','done') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `description` text COLLATE utf8mb4_unicode_ci,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `communication_campaign_attachment_types`
--

DROP TABLE IF EXISTS `communication_campaign_attachment_types`;
CREATE TABLE IF NOT EXISTS `communication_campaign_attachment_types` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_unicode_ci,
  `translated_name` text COLLATE utf8mb4_unicode_ci,
  `is_trigger` tinyint(4) NOT NULL DEFAULT '0',
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `communication_campaign_attachment_types`
--

INSERT INTO `communication_campaign_attachment_types` (`id`, `name`, `translated_name`, `is_trigger`, `active`) VALUES
(1, 'Loan Schedule', NULL, 0, 1),
(2, 'Client Statement', NULL, 0, 1),
(3, 'Saving Mini Statement', NULL, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `communication_campaign_business_rules`
--

DROP TABLE IF EXISTS `communication_campaign_business_rules`;
CREATE TABLE IF NOT EXISTS `communication_campaign_business_rules` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_unicode_ci,
  `translated_name` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `is_trigger` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `communication_campaign_business_rules`
--

INSERT INTO `communication_campaign_business_rules` (`id`, `name`, `translated_name`, `description`, `active`, `is_trigger`) VALUES
(1, 'Active Clients', NULL, 'All clients with the status ‘Active’', 1, 0),
(2, 'Prospective Clients', NULL, 'All clients with the status ‘Active’ who have never had a loan before', 1, 0),
(3, 'Active Loan Clients', NULL, 'All clients with an outstanding loan', 1, 0),
(4, 'Loans in arrears', NULL, 'All clients with an outstanding loan in arrears between X and Y days', 1, 0),
(5, 'Loans disbursed to clients', NULL, 'All clients who have had a loan disbursed to them in the last X to Y days', 1, 0),
(6, 'Loan payments due', NULL, 'All clients with an unpaid installment due on their loan between X and Y days', 1, 0),
(7, 'Dormant Prospects', NULL, 'All individuals who have not yet received a loan but were also entered into the system more than 3 months', 0, 0),
(8, 'Loan Payments Due (Overdue Loans)', NULL, 'Loan Payments Due between X to Y days for clients in arrears between X and Y days', 0, 0),
(9, 'Loan Payments Received (Active Loans)', NULL, 'Payments received in the last X to Y days for any loan with the status Active (on-time)', 0, 0),
(10, 'Loan Payments Received (Overdue Loans) ', NULL, 'Payments received in the last X to Y days for any loan with the status Overdue (arrears) between X and Y days', 0, 0),
(11, 'Happy Birthday', NULL, 'This sends a message to all clients with the status Active on their Birthday', 0, 0),
(12, 'Loan Fully Repaid', NULL, 'All loans that have been fully repaid (Closed or Overpaid) in the last X to Y days', 0, 0),
(13, 'Loans Outstanding after final instalment date', NULL, 'All active loans (with an outstanding balance) between X to Y days after the final instalment date on their loan schedule', 0, 0),
(14, 'Past Loan Clients', NULL, 'Past Loan Clients who have previously had a loan but do not currently have one and finished repaying their most recent loan in the last X to Y days.', 0, 0),
(15, 'Loan Submitted', NULL, 'Loan and client data of submitted loan', 1, 1),
(16, 'Loan Rejected', NULL, 'Loan and client data of rejected loan', 1, 1),
(17, 'Loan Approved', NULL, 'Loan and client data of approved loan', 1, 1),
(18, 'Loan Disbursed', NULL, 'Loan Disbursed', 1, 1),
(19, 'Loan Rescheduled', NULL, 'Loan Rescheduled', 1, 1),
(20, 'Loan Closed', NULL, 'Loan Closed', 1, 1),
(21, 'Loan Repayment', NULL, 'Loan Repayment', 1, 1),
(22, 'Savings Submitted', NULL, 'Savings and client data of submitted savings', 1, 1),
(23, 'Savings Rejected', NULL, 'Savings and client data of rejected savings', 1, 1),
(24, 'Savings Approved', NULL, 'Savings and client data of approved savings', 1, 1),
(25, 'Savings Activated', NULL, 'Savings Activated', 1, 1),
(26, 'Savings Dormant', NULL, 'Savings Dormant', 1, 1),
(27, 'Savings Inactive', NULL, 'Savings Inactive', 1, 1),
(28, 'Savings Closed', NULL, 'Savings Closed', 1, 1),
(29, 'Savings Deposit', NULL, 'Savings Deposit', 1, 1),
(30, 'Savings Withdrawal', NULL, 'Savings Withdrawal', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `communication_campaign_logs`
--

DROP TABLE IF EXISTS `communication_campaign_logs`;
CREATE TABLE IF NOT EXISTS `communication_campaign_logs` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` bigint(20) UNSIGNED DEFAULT NULL,
  `sms_gateway_id` bigint(20) DEFAULT NULL,
  `communication_campaign_id` bigint(20) DEFAULT NULL,
  `campaign_type` enum('sms','email') COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `send_to` text COLLATE utf8mb4_unicode_ci,
  `campaign_name` text COLLATE utf8mb4_unicode_ci,
  `status` enum('pending','sent','delivered','failed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
CREATE TABLE IF NOT EXISTS `countries` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sortname` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=247 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `sortname`, `name`, `created_at`, `updated_at`) VALUES
(1, 'AF', 'Afghanistan', NULL, NULL),
(2, 'AL', 'Albania', NULL, NULL),
(3, 'DZ', 'Algeria', NULL, NULL),
(4, 'AS', 'American Samoa', NULL, NULL),
(5, 'AD', 'Andorra', NULL, NULL),
(6, 'AO', 'Angola', NULL, NULL),
(7, 'AI', 'Anguilla', NULL, NULL),
(8, 'AQ', 'Antarctica', NULL, NULL),
(9, 'AG', 'Antigua And Barbuda', NULL, NULL),
(10, 'AR', 'Argentina', NULL, NULL),
(11, 'AM', 'Armenia', NULL, NULL),
(12, 'AW', 'Aruba', NULL, NULL),
(13, 'AU', 'Australia', NULL, NULL),
(14, 'AT', 'Austria', NULL, NULL),
(15, 'AZ', 'Azerbaijan', NULL, NULL),
(16, 'BS', 'Bahamas The', NULL, NULL),
(17, 'BH', 'Bahrain', NULL, NULL),
(18, 'BD', 'Bangladesh', NULL, NULL),
(19, 'BB', 'Barbados', NULL, NULL),
(20, 'BY', 'Belarus', NULL, NULL),
(21, 'BE', 'Belgium', NULL, NULL),
(22, 'BZ', 'Belize', NULL, NULL),
(23, 'BJ', 'Benin', NULL, NULL),
(24, 'BM', 'Bermuda', NULL, NULL),
(25, 'BT', 'Bhutan', NULL, NULL),
(26, 'BO', 'Bolivia', NULL, NULL),
(27, 'BA', 'Bosnia and Herzegovina', NULL, NULL),
(28, 'BW', 'Botswana', NULL, NULL),
(29, 'BV', 'Bouvet Island', NULL, NULL),
(30, 'BR', 'Brazil', NULL, NULL),
(31, 'IO', 'British Indian Ocean Territory', NULL, NULL),
(32, 'BN', 'Brunei', NULL, NULL),
(33, 'BG', 'Bulgaria', NULL, NULL),
(34, 'BF', 'Burkina Faso', NULL, NULL),
(35, 'BI', 'Burundi', NULL, NULL),
(36, 'KH', 'Cambodia', NULL, NULL),
(37, 'CM', 'Cameroon', NULL, NULL),
(38, 'CA', 'Canada', NULL, NULL),
(39, 'CV', 'Cape Verde', NULL, NULL),
(40, 'KY', 'Cayman Islands', NULL, NULL),
(41, 'CF', 'Central African Republic', NULL, NULL),
(42, 'TD', 'Chad', NULL, NULL),
(43, 'CL', 'Chile', NULL, NULL),
(44, 'CN', 'China', NULL, NULL),
(45, 'CX', 'Christmas Island', NULL, NULL),
(46, 'CC', 'Cocos (Keeling) Islands', NULL, NULL),
(47, 'CO', 'Colombia', NULL, NULL),
(48, 'KM', 'Comoros', NULL, NULL),
(49, 'CG', 'Congo', NULL, NULL),
(50, 'CD', 'Congo The Democratic Republic Of The', NULL, NULL),
(51, 'CK', 'Cook Islands', NULL, NULL),
(52, 'CR', 'Costa Rica', NULL, NULL),
(53, 'CI', 'Cote D\'Ivoire (Ivory Coast)', NULL, NULL),
(54, 'HR', 'Croatia (Hrvatska)', NULL, NULL),
(55, 'CU', 'Cuba', NULL, NULL),
(56, 'CY', 'Cyprus', NULL, NULL),
(57, 'CZ', 'Czech Republic', NULL, NULL),
(58, 'DK', 'Denmark', NULL, NULL),
(59, 'DJ', 'Djibouti', NULL, NULL),
(60, 'DM', 'Dominica', NULL, NULL),
(61, 'DO', 'Dominican Republic', NULL, NULL),
(62, 'TP', 'East Timor', NULL, NULL),
(63, 'EC', 'Ecuador', NULL, NULL),
(64, 'EG', 'Egypt', NULL, NULL),
(65, 'SV', 'El Salvador', NULL, NULL),
(66, 'GQ', 'Equatorial Guinea', NULL, NULL),
(67, 'ER', 'Eritrea', NULL, NULL),
(68, 'EE', 'Estonia', NULL, NULL),
(69, 'ET', 'Ethiopia', NULL, NULL),
(70, 'XA', 'External Territories of Australia', NULL, NULL),
(71, 'FK', 'Falkland Islands', NULL, NULL),
(72, 'FO', 'Faroe Islands', NULL, NULL),
(73, 'FJ', 'Fiji Islands', NULL, NULL),
(74, 'FI', 'Finland', NULL, NULL),
(75, 'FR', 'France', NULL, NULL),
(76, 'GF', 'French Guiana', NULL, NULL),
(77, 'PF', 'French Polynesia', NULL, NULL),
(78, 'TF', 'French Southern Territories', NULL, NULL),
(79, 'GA', 'Gabon', NULL, NULL),
(80, 'GM', 'Gambia The', NULL, NULL),
(81, 'GE', 'Georgia', NULL, NULL),
(82, 'DE', 'Germany', NULL, NULL),
(83, 'GH', 'Ghana', NULL, NULL),
(84, 'GI', 'Gibraltar', NULL, NULL),
(85, 'GR', 'Greece', NULL, NULL),
(86, 'GL', 'Greenland', NULL, NULL),
(87, 'GD', 'Grenada', NULL, NULL),
(88, 'GP', 'Guadeloupe', NULL, NULL),
(89, 'GU', 'Guam', NULL, NULL),
(90, 'GT', 'Guatemala', NULL, NULL),
(91, 'XU', 'Guernsey and Alderney', NULL, NULL),
(92, 'GN', 'Guinea', NULL, NULL),
(93, 'GW', 'Guinea-Bissau', NULL, NULL),
(94, 'GY', 'Guyana', NULL, NULL),
(95, 'HT', 'Haiti', NULL, NULL),
(96, 'HM', 'Heard and McDonald Islands', NULL, NULL),
(97, 'HN', 'Honduras', NULL, NULL),
(98, 'HK', 'Hong Kong S.A.R.', NULL, NULL),
(99, 'HU', 'Hungary', NULL, NULL),
(100, 'IS', 'Iceland', NULL, NULL),
(101, 'IN', 'India', NULL, NULL),
(102, 'ID', 'Indonesia', NULL, NULL),
(103, 'IR', 'Iran', NULL, NULL),
(104, 'IQ', 'Iraq', NULL, NULL),
(105, 'IE', 'Ireland', NULL, NULL),
(106, 'IL', 'Israel', NULL, NULL),
(107, 'IT', 'Italy', NULL, NULL),
(108, 'JM', 'Jamaica', NULL, NULL),
(109, 'JP', 'Japan', NULL, NULL),
(110, 'XJ', 'Jersey', NULL, NULL),
(111, 'JO', 'Jordan', NULL, NULL),
(112, 'KZ', 'Kazakhstan', NULL, NULL),
(113, 'KE', 'Kenya', NULL, NULL),
(114, 'KI', 'Kiribati', NULL, NULL),
(115, 'KP', 'Korea North', NULL, NULL),
(116, 'KR', 'Korea South', NULL, NULL),
(117, 'KW', 'Kuwait', NULL, NULL),
(118, 'KG', 'Kyrgyzstan', NULL, NULL),
(119, 'LA', 'Laos', NULL, NULL),
(120, 'LV', 'Latvia', NULL, NULL),
(121, 'LB', 'Lebanon', NULL, NULL),
(122, 'LS', 'Lesotho', NULL, NULL),
(123, 'LR', 'Liberia', NULL, NULL),
(124, 'LY', 'Libya', NULL, NULL),
(125, 'LI', 'Liechtenstein', NULL, NULL),
(126, 'LT', 'Lithuania', NULL, NULL),
(127, 'LU', 'Luxembourg', NULL, NULL),
(128, 'MO', 'Macau S.A.R.', NULL, NULL),
(129, 'MK', 'Macedonia', NULL, NULL),
(130, 'MG', 'Madagascar', NULL, NULL),
(131, 'MW', 'Malawi', NULL, NULL),
(132, 'MY', 'Malaysia', NULL, NULL),
(133, 'MV', 'Maldives', NULL, NULL),
(134, 'ML', 'Mali', NULL, NULL),
(135, 'MT', 'Malta', NULL, NULL),
(136, 'XM', 'Man (Isle of)', NULL, NULL),
(137, 'MH', 'Marshall Islands', NULL, NULL),
(138, 'MQ', 'Martinique', NULL, NULL),
(139, 'MR', 'Mauritania', NULL, NULL),
(140, 'MU', 'Mauritius', NULL, NULL),
(141, 'YT', 'Mayotte', NULL, NULL),
(142, 'MX', 'Mexico', NULL, NULL),
(143, 'FM', 'Micronesia', NULL, NULL),
(144, 'MD', 'Moldova', NULL, NULL),
(145, 'MC', 'Monaco', NULL, NULL),
(146, 'MN', 'Mongolia', NULL, NULL),
(147, 'MS', 'Montserrat', NULL, NULL),
(148, 'MA', 'Morocco', NULL, NULL),
(149, 'MZ', 'Mozambique', NULL, NULL),
(150, 'MM', 'Myanmar', NULL, NULL),
(151, 'NA', 'Namibia', NULL, NULL),
(152, 'NR', 'Nauru', NULL, NULL),
(153, 'NP', 'Nepal', NULL, NULL),
(154, 'AN', 'Netherlands Antilles', NULL, NULL),
(155, 'NL', 'Netherlands The', NULL, NULL),
(156, 'NC', 'New Caledonia', NULL, NULL),
(157, 'NZ', 'New Zealand', NULL, NULL),
(158, 'NI', 'Nicaragua', NULL, NULL),
(159, 'NE', 'Niger', NULL, NULL),
(160, 'NG', 'Nigeria', NULL, NULL),
(161, 'NU', 'Niue', NULL, NULL),
(162, 'NF', 'Norfolk Island', NULL, NULL),
(163, 'MP', 'Northern Mariana Islands', NULL, NULL),
(164, 'NO', 'Norway', NULL, NULL),
(165, 'OM', 'Oman', NULL, NULL),
(166, 'PK', 'Pakistan', NULL, NULL),
(167, 'PW', 'Palau', NULL, NULL),
(168, 'PS', 'Palestinian Territory Occupied', NULL, NULL),
(169, 'PA', 'Panama', NULL, NULL),
(170, 'PG', 'Papua new Guinea', NULL, NULL),
(171, 'PY', 'Paraguay', NULL, NULL),
(172, 'PE', 'Peru', NULL, NULL),
(173, 'PH', 'Philippines', NULL, NULL),
(174, 'PN', 'Pitcairn Island', NULL, NULL),
(175, 'PL', 'Poland', NULL, NULL),
(176, 'PT', 'Portugal', NULL, NULL),
(177, 'PR', 'Puerto Rico', NULL, NULL),
(178, 'QA', 'Qatar', NULL, NULL),
(179, 'RE', 'Reunion', NULL, NULL),
(180, 'RO', 'Romania', NULL, NULL),
(181, 'RU', 'Russia', NULL, NULL),
(182, 'RW', 'Rwanda', NULL, NULL),
(183, 'SH', 'Saint Helena', NULL, NULL),
(184, 'KN', 'Saint Kitts And Nevis', NULL, NULL),
(185, 'LC', 'Saint Lucia', NULL, NULL),
(186, 'PM', 'Saint Pierre and Miquelon', NULL, NULL),
(187, 'VC', 'Saint Vincent And The Grenadines', NULL, NULL),
(188, 'WS', 'Samoa', NULL, NULL),
(189, 'SM', 'San Marino', NULL, NULL),
(190, 'ST', 'Sao Tome and Principe', NULL, NULL),
(191, 'SA', 'Saudi Arabia', NULL, NULL),
(192, 'SN', 'Senegal', NULL, NULL),
(193, 'RS', 'Serbia', NULL, NULL),
(194, 'SC', 'Seychelles', NULL, NULL),
(195, 'SL', 'Sierra Leone', NULL, NULL),
(196, 'SG', 'Singapore', NULL, NULL),
(197, 'SK', 'Slovakia', NULL, NULL),
(198, 'SI', 'Slovenia', NULL, NULL),
(199, 'XG', 'Smaller Territories of the UK', NULL, NULL),
(200, 'SB', 'Solomon Islands', NULL, NULL),
(201, 'SO', 'Somalia', NULL, NULL),
(202, 'ZA', 'South Africa', NULL, NULL),
(203, 'GS', 'South Georgia', NULL, NULL),
(204, 'SS', 'South Sudan', NULL, NULL),
(205, 'ES', 'Spain', NULL, NULL),
(206, 'LK', 'Sri Lanka', NULL, NULL),
(207, 'SD', 'Sudan', NULL, NULL),
(208, 'SR', 'Suriname', NULL, NULL),
(209, 'SJ', 'Svalbard And Jan Mayen Islands', NULL, NULL),
(210, 'SZ', 'Swaziland', NULL, NULL),
(211, 'SE', 'Sweden', NULL, NULL),
(212, 'CH', 'Switzerland', NULL, NULL),
(213, 'SY', 'Syria', NULL, NULL),
(214, 'TW', 'Taiwan', NULL, NULL),
(215, 'TJ', 'Tajikistan', NULL, NULL),
(216, 'TZ', 'Tanzania', NULL, NULL),
(217, 'TH', 'Thailand', NULL, NULL),
(218, 'TG', 'Togo', NULL, NULL),
(219, 'TK', 'Tokelau', NULL, NULL),
(220, 'TO', 'Tonga', NULL, NULL),
(221, 'TT', 'Trinidad And Tobago', NULL, NULL),
(222, 'TN', 'Tunisia', NULL, NULL),
(223, 'TR', 'Turkey', NULL, NULL),
(224, 'TM', 'Turkmenistan', NULL, NULL),
(225, 'TC', 'Turks And Caicos Islands', NULL, NULL),
(226, 'TV', 'Tuvalu', NULL, NULL),
(227, 'UG', 'Uganda', NULL, NULL),
(228, 'UA', 'Ukraine', NULL, NULL),
(229, 'AE', 'United Arab Emirates', NULL, NULL),
(230, 'GB', 'United Kingdom', NULL, NULL),
(231, 'US', 'United States', NULL, NULL),
(232, 'UM', 'United States Minor Outlying Islands', NULL, NULL),
(233, 'UY', 'Uruguay', NULL, NULL),
(234, 'UZ', 'Uzbekistan', NULL, NULL),
(235, 'VU', 'Vanuatu', NULL, NULL),
(236, 'VA', 'Vatican City State (Holy See)', NULL, NULL),
(237, 'VE', 'Venezuela', NULL, NULL),
(238, 'VN', 'Vietnam', NULL, NULL),
(239, 'VG', 'Virgin Islands (British)', NULL, NULL),
(240, 'VI', 'Virgin Islands (US)', NULL, NULL),
(241, 'WF', 'Wallis And Futuna Islands', NULL, NULL),
(242, 'EH', 'Western Sahara', NULL, NULL),
(243, 'YE', 'Yemen', NULL, NULL),
(244, 'YU', 'Yugoslavia', NULL, NULL),
(245, 'ZM', 'Zambia', NULL, NULL),
(246, 'ZW', 'Zimbabwe', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS `currencies`;
CREATE TABLE IF NOT EXISTS `currencies` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` int(11) DEFAULT NULL,
  `rate` decimal(65,8) DEFAULT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `symbol` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` enum('left','right') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'left',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `created_by_id`, `rate`, `code`, `name`, `symbol`, `position`, `created_at`, `updated_at`) VALUES
(1, NULL, '1.00000000', 'USD', 'United States dollar', '$', 'left', NULL, NULL),
(3, NULL, NULL, 'Ksh', 'KENYAN SHILLINGS', 'Ksh', 'left', '2022-02-26 17:03:54', '2022-02-26 17:03:54');

-- --------------------------------------------------------

--
-- Table structure for table `custom_fields`
--

DROP TABLE IF EXISTS `custom_fields`;
CREATE TABLE IF NOT EXISTS `custom_fields` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `category` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci,
  `label` text COLLATE utf8mb4_unicode_ci,
  `options` text COLLATE utf8mb4_unicode_ci,
  `class` text COLLATE utf8mb4_unicode_ci,
  `db_columns` text COLLATE utf8mb4_unicode_ci,
  `rules` text COLLATE utf8mb4_unicode_ci,
  `default_values` text COLLATE utf8mb4_unicode_ci,
  `required` tinyint(4) NOT NULL DEFAULT '0',
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `custom_fields`
--

INSERT INTO `custom_fields` (`id`, `created_by_id`, `category`, `type`, `name`, `label`, `options`, `class`, `db_columns`, `rules`, `default_values`, `required`, `active`, `created_at`, `updated_at`) VALUES
(1, 1, 'add_client', 'textfield', 'Member Number', 'Member Number', NULL, NULL, NULL, NULL, NULL, 0, 1, '2020-10-22 15:05:01', '2022-04-13 14:56:13'),
(2, 1, 'add_client', 'textfield', 'Source of Income', 'Source of Income', NULL, NULL, NULL, NULL, NULL, 0, 1, '2022-04-13 15:00:28', '2022-04-13 15:00:28'),
(3, 1, 'add_client', 'textfield', 'Residence', 'Residence', NULL, NULL, NULL, NULL, NULL, 0, 1, '2022-04-13 15:01:11', '2022-04-13 15:01:11');

-- --------------------------------------------------------

--
-- Table structure for table `custom_fields_meta`
--

DROP TABLE IF EXISTS `custom_fields_meta`;
CREATE TABLE IF NOT EXISTS `custom_fields_meta` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `category` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int(11) NOT NULL,
  `custom_field_id` bigint(20) UNSIGNED NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `custom_fields_meta`
--

INSERT INTO `custom_fields_meta` (`id`, `category`, `parent_id`, `custom_field_id`, `value`, `created_at`, `updated_at`) VALUES
(1, 'add_client', 1, 1, NULL, '2020-12-13 18:31:15', '2020-12-13 18:31:15'),
(2, 'add_client', 3, 1, NULL, '2020-12-21 08:25:40', '2020-12-21 08:25:40'),
(3, 'add_client', 2, 1, NULL, '2022-03-17 06:53:22', '2022-03-17 06:53:22'),
(4, 'add_client', 4, 1, 'HKM3245', '2022-03-17 16:15:11', '2022-03-17 16:15:11'),
(5, 'add_client', 5, 1, '23565', '2022-03-22 06:03:11', '2022-03-22 06:03:11'),
(6, 'add_client', 6, 1, NULL, '2022-03-23 07:28:14', '2022-03-23 07:28:14'),
(7, 'add_client', 7, 1, NULL, '2022-04-07 15:03:20', '2022-04-07 15:03:20'),
(8, 'add_client', 8, 1, NULL, '2022-04-25 20:50:45', '2022-04-25 20:50:45'),
(9, 'add_client', 8, 2, NULL, '2022-04-25 20:50:45', '2022-04-25 20:50:45'),
(10, 'add_client', 8, 3, NULL, '2022-04-25 20:50:45', '2022-04-25 20:50:45'),
(11, 'add_client', 9, 1, NULL, '2022-05-02 15:05:50', '2022-05-02 15:05:50'),
(12, 'add_client', 9, 2, NULL, '2022-05-02 15:05:50', '2022-05-02 15:05:50'),
(13, 'add_client', 9, 3, NULL, '2022-05-02 15:05:50', '2022-05-02 15:05:50'),
(14, 'add_client', 10, 1, '1', '2022-05-24 12:07:48', '2022-05-24 12:07:48'),
(15, 'add_client', 10, 2, 'Salonist', '2022-05-24 12:07:48', '2022-05-24 12:07:48'),
(16, 'add_client', 10, 3, 'Maili TISA', '2022-05-24 12:07:48', '2022-05-24 12:07:48'),
(17, 'add_client', 11, 1, '2', '2022-05-24 12:23:16', '2022-05-24 12:23:16'),
(18, 'add_client', 11, 2, 'Farming', '2022-05-24 12:23:17', '2022-05-24 12:23:17'),
(19, 'add_client', 11, 3, 'Maili TISA', '2022-05-24 12:23:17', '2022-05-24 12:23:17'),
(20, 'add_client', 12, 1, NULL, '2022-06-08 14:41:47', '2022-06-08 14:41:47'),
(21, 'add_client', 12, 2, NULL, '2022-06-08 14:41:47', '2022-06-08 14:41:47'),
(22, 'add_client', 12, 3, NULL, '2022-06-08 14:41:47', '2022-06-08 14:41:47'),
(23, 'add_client', 13, 1, NULL, '2022-06-08 14:53:16', '2022-06-08 14:53:16'),
(24, 'add_client', 13, 2, NULL, '2022-06-08 14:53:16', '2022-06-08 14:53:16'),
(25, 'add_client', 13, 3, NULL, '2022-06-08 14:53:16', '2022-06-08 14:53:16'),
(26, 'add_client', 14, 1, NULL, '2022-06-08 14:57:31', '2022-06-08 14:57:31'),
(27, 'add_client', 14, 2, NULL, '2022-06-08 14:57:31', '2022-06-08 14:57:31'),
(28, 'add_client', 14, 3, NULL, '2022-06-08 14:57:31', '2022-06-08 14:57:31'),
(29, 'add_client', 15, 1, NULL, '2022-06-08 15:02:30', '2022-06-08 15:02:30'),
(30, 'add_client', 15, 2, NULL, '2022-06-08 15:02:30', '2022-06-08 15:02:30'),
(31, 'add_client', 15, 3, NULL, '2022-06-08 15:02:30', '2022-06-08 15:02:30'),
(32, 'add_client', 16, 1, NULL, '2022-06-08 15:14:16', '2022-06-08 15:14:16'),
(33, 'add_client', 16, 2, NULL, '2022-06-08 15:14:16', '2022-06-08 15:14:16'),
(34, 'add_client', 16, 3, NULL, '2022-06-08 15:14:16', '2022-06-08 15:14:16'),
(35, 'add_client', 17, 1, NULL, '2022-06-08 20:22:11', '2022-06-08 20:22:11'),
(36, 'add_client', 17, 2, NULL, '2022-06-08 20:22:11', '2022-06-08 20:22:11'),
(37, 'add_client', 17, 3, NULL, '2022-06-08 20:22:11', '2022-06-08 20:22:11'),
(38, 'add_client', 18, 1, NULL, '2022-06-08 21:34:32', '2022-06-08 21:34:32'),
(39, 'add_client', 18, 2, NULL, '2022-06-08 21:34:32', '2022-06-08 21:34:32'),
(40, 'add_client', 18, 3, NULL, '2022-06-08 21:34:32', '2022-06-08 21:34:32'),
(41, 'add_client', 19, 1, NULL, '2022-06-24 06:35:22', '2022-06-24 06:35:22'),
(42, 'add_client', 19, 2, NULL, '2022-06-24 06:35:22', '2022-06-24 06:35:22'),
(43, 'add_client', 19, 3, NULL, '2022-06-24 06:35:22', '2022-06-24 06:35:22'),
(44, 'add_client', 20, 1, NULL, '2022-06-24 06:50:33', '2022-06-24 06:50:33'),
(45, 'add_client', 20, 2, NULL, '2022-06-24 06:50:33', '2022-06-24 06:50:33'),
(46, 'add_client', 20, 3, NULL, '2022-06-24 06:50:33', '2022-06-24 06:50:33'),
(47, 'add_client', 21, 1, NULL, '2022-06-24 06:55:08', '2022-06-24 06:55:08'),
(48, 'add_client', 21, 2, NULL, '2022-06-24 06:55:09', '2022-06-24 06:55:09'),
(49, 'add_client', 21, 3, NULL, '2022-06-24 06:55:09', '2022-06-24 06:55:09'),
(50, 'add_client', 22, 1, NULL, '2022-06-24 07:00:50', '2022-06-24 07:00:50'),
(51, 'add_client', 22, 2, NULL, '2022-06-24 07:00:50', '2022-06-24 07:00:50'),
(52, 'add_client', 22, 3, NULL, '2022-06-24 07:00:50', '2022-06-24 07:00:50'),
(53, 'add_client', 23, 1, NULL, '2022-06-24 07:20:03', '2022-06-24 07:20:03'),
(54, 'add_client', 23, 2, NULL, '2022-06-24 07:20:03', '2022-06-24 07:20:03'),
(55, 'add_client', 23, 3, NULL, '2022-06-24 07:20:03', '2022-06-24 07:20:03'),
(56, 'add_client', 24, 1, NULL, '2022-06-24 07:25:16', '2022-06-24 07:25:16'),
(57, 'add_client', 24, 2, NULL, '2022-06-24 07:25:16', '2022-06-24 07:25:16'),
(58, 'add_client', 24, 3, NULL, '2022-06-24 07:25:16', '2022-06-24 07:25:16'),
(59, 'add_client', 25, 1, NULL, '2022-06-24 07:29:27', '2022-06-24 07:29:27'),
(60, 'add_client', 25, 2, NULL, '2022-06-24 07:29:27', '2022-06-24 07:29:27'),
(61, 'add_client', 25, 3, NULL, '2022-06-24 07:29:27', '2022-06-24 07:29:27'),
(62, 'add_client', 26, 1, NULL, '2022-06-24 08:03:27', '2022-06-24 08:03:27'),
(63, 'add_client', 26, 2, NULL, '2022-06-24 08:03:27', '2022-06-24 08:03:27'),
(64, 'add_client', 26, 3, NULL, '2022-06-24 08:03:27', '2022-06-24 08:03:27'),
(65, 'add_client', 27, 1, NULL, '2022-06-24 08:06:56', '2022-06-24 08:06:56'),
(66, 'add_client', 27, 2, NULL, '2022-06-24 08:06:56', '2022-06-24 08:06:56'),
(67, 'add_client', 27, 3, NULL, '2022-06-24 08:06:56', '2022-06-24 08:06:56'),
(68, 'add_client', 28, 1, NULL, '2022-06-24 08:16:35', '2022-06-24 08:16:35'),
(69, 'add_client', 28, 2, NULL, '2022-06-24 08:16:35', '2022-06-24 08:16:35'),
(70, 'add_client', 28, 3, NULL, '2022-06-24 08:16:35', '2022-06-24 08:16:35'),
(71, 'add_client', 29, 1, NULL, '2022-06-24 17:52:00', '2022-06-24 17:52:00'),
(72, 'add_client', 29, 2, NULL, '2022-06-24 17:52:00', '2022-06-24 17:52:00'),
(73, 'add_client', 29, 3, NULL, '2022-06-24 17:52:00', '2022-06-24 17:52:00'),
(74, 'add_client', 30, 1, NULL, '2022-06-24 18:02:57', '2022-06-24 18:02:57'),
(75, 'add_client', 30, 2, NULL, '2022-06-24 18:02:57', '2022-06-24 18:02:57'),
(76, 'add_client', 30, 3, NULL, '2022-06-24 18:02:57', '2022-06-24 18:02:57'),
(77, 'add_client', 31, 1, NULL, '2022-06-24 19:38:48', '2022-06-24 19:38:48'),
(78, 'add_client', 31, 2, NULL, '2022-06-24 19:38:48', '2022-06-24 19:38:48'),
(79, 'add_client', 31, 3, NULL, '2022-06-24 19:38:48', '2022-06-24 19:38:48'),
(80, 'add_client', 32, 1, NULL, '2022-06-24 20:59:18', '2022-06-24 20:59:18'),
(81, 'add_client', 32, 2, NULL, '2022-06-24 20:59:18', '2022-06-24 20:59:18'),
(82, 'add_client', 32, 3, NULL, '2022-06-24 20:59:18', '2022-06-24 20:59:18'),
(83, 'add_client', 33, 1, NULL, '2022-06-24 21:42:08', '2022-06-24 21:42:08'),
(84, 'add_client', 33, 2, NULL, '2022-06-24 21:42:08', '2022-06-24 21:42:08'),
(85, 'add_client', 33, 3, NULL, '2022-06-24 21:42:09', '2022-06-24 21:42:09'),
(86, 'add_client', 34, 1, NULL, '2022-07-13 09:05:23', '2022-07-13 09:05:23'),
(87, 'add_client', 34, 2, NULL, '2022-07-13 09:05:23', '2022-07-13 09:05:23'),
(88, 'add_client', 34, 3, NULL, '2022-07-13 09:05:23', '2022-07-13 09:05:23');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
CREATE TABLE IF NOT EXISTS `events` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `group_id` bigint(20) UNSIGNED NOT NULL,
  `branch_id` bigint(20) UNSIGNED NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `location` text COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

DROP TABLE IF EXISTS `expenses`;
CREATE TABLE IF NOT EXISTS `expenses` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `expense_type_id` bigint(20) UNSIGNED DEFAULT NULL,
  `expense_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `currency_id` bigint(20) UNSIGNED DEFAULT NULL,
  `register_id` bigint(20) UNSIGNED NOT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `group_id` bigint(20) UNSIGNED DEFAULT NULL,
  `asset_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `amount` decimal(65,2) NOT NULL DEFAULT '0.00',
  `date` date DEFAULT NULL,
  `payment_type_id` bigint(20) NOT NULL,
  `receipt` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recurring` tinyint(4) NOT NULL DEFAULT '0',
  `recur_frequency` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '31',
  `recur_start_date` date DEFAULT NULL,
  `recur_end_date` date DEFAULT NULL,
  `recur_next_date` date DEFAULT NULL,
  `recur_type` enum('day','week','month','year') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'month',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `files` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expense_types`
--

DROP TABLE IF EXISTS `expense_types`;
CREATE TABLE IF NOT EXISTS `expense_types` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expense_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `asset_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `funds`
--

DROP TABLE IF EXISTS `funds`;
CREATE TABLE IF NOT EXISTS `funds` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `funds`
--

INSERT INTO `funds` (`id`, `name`) VALUES
(1, 'Equity'),
(2, 'Donor Fund');

-- --------------------------------------------------------

--
-- Table structure for table `income`
--

DROP TABLE IF EXISTS `income`;
CREATE TABLE IF NOT EXISTS `income` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `income_type_id` bigint(20) UNSIGNED DEFAULT NULL,
  `currency_id` bigint(20) UNSIGNED DEFAULT NULL,
  `register_id` bigint(20) UNSIGNED NOT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `group_id` bigint(20) UNSIGNED DEFAULT NULL,
  `income_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `asset_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `amount` decimal(65,2) NOT NULL DEFAULT '0.00',
  `date` date DEFAULT NULL,
  `recurring` tinyint(4) NOT NULL DEFAULT '0',
  `recur_frequency` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '31',
  `recur_start_date` date DEFAULT NULL,
  `recur_end_date` date DEFAULT NULL,
  `recur_next_date` date DEFAULT NULL,
  `recur_type` enum('day','week','month','year') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'month',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `files` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `income_types`
--

DROP TABLE IF EXISTS `income_types`;
CREATE TABLE IF NOT EXISTS `income_types` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `income_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `asset_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `journal_entries`
--

DROP TABLE IF EXISTS `journal_entries`;
CREATE TABLE IF NOT EXISTS `journal_entries` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `transaction_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_detail_id` bigint(20) UNSIGNED DEFAULT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `currency_id` bigint(20) UNSIGNED DEFAULT NULL,
  `chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `transaction_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_sub_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` text COLLATE utf8mb4_unicode_ci,
  `date` date DEFAULT NULL,
  `month` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `debit` decimal(65,4) DEFAULT NULL,
  `credit` decimal(65,4) DEFAULT NULL,
  `balance` decimal(65,4) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `reversed` tinyint(4) NOT NULL DEFAULT '0',
  `reversible` tinyint(4) NOT NULL DEFAULT '1',
  `manual_entry` tinyint(4) NOT NULL DEFAULT '0',
  `receipt` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `branch_id_index` (`branch_id`),
  KEY `chart_of_account_id_index` (`chart_of_account_id`),
  KEY `currency_id_index` (`currency_id`),
  KEY `created_by_id_index` (`created_by_id`),
  KEY `client_id_index` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loans`
--

DROP TABLE IF EXISTS `loans`;
CREATE TABLE IF NOT EXISTS `loans` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_type` enum('client','group') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'client',
  `client_id` bigint(20) UNSIGNED DEFAULT NULL,
  `group_id` bigint(20) UNSIGNED DEFAULT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `currency_id` bigint(20) UNSIGNED NOT NULL,
  `loan_product_id` bigint(20) UNSIGNED NOT NULL,
  `loan_transaction_processing_strategy_id` bigint(20) UNSIGNED NOT NULL,
  `fund_id` bigint(20) UNSIGNED NOT NULL,
  `loan_purpose_id` bigint(20) UNSIGNED NOT NULL,
  `loan_officer_id` bigint(20) UNSIGNED NOT NULL,
  `linked_savings_id` bigint(20) UNSIGNED DEFAULT NULL,
  `loan_disbursement_channel_id` bigint(20) UNSIGNED DEFAULT NULL,
  `submitted_on_date` date DEFAULT NULL,
  `submitted_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `approved_on_date` date DEFAULT NULL,
  `approved_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `approved_notes` text COLLATE utf8mb4_unicode_ci,
  `expected_disbursement_date` date DEFAULT NULL,
  `expected_first_payment_date` date DEFAULT NULL,
  `first_payment_date` date DEFAULT NULL,
  `expected_maturity_date` date DEFAULT NULL,
  `disbursed_on_date` date DEFAULT NULL,
  `disbursed_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `disbursed_notes` text COLLATE utf8mb4_unicode_ci,
  `rejected_on_date` date DEFAULT NULL,
  `rejected_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `rejected_notes` text COLLATE utf8mb4_unicode_ci,
  `written_off_on_date` date DEFAULT NULL,
  `written_off_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `written_off_notes` text COLLATE utf8mb4_unicode_ci,
  `closed_on_date` date DEFAULT NULL,
  `closed_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `closed_notes` text COLLATE utf8mb4_unicode_ci,
  `rescheduled_on_date` date DEFAULT NULL,
  `rescheduled_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `rescheduled_notes` text COLLATE utf8mb4_unicode_ci,
  `withdrawn_on_date` date DEFAULT NULL,
  `withdrawn_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `withdrawn_notes` text COLLATE utf8mb4_unicode_ci,
  `external_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `principal` decimal(65,6) NOT NULL,
  `applied_amount` decimal(65,6) DEFAULT NULL,
  `approved_amount` decimal(65,6) DEFAULT NULL,
  `interest_rate` decimal(65,6) NOT NULL,
  `decimals` int(11) DEFAULT NULL,
  `instalment_multiple_of` int(11) DEFAULT '1',
  `loan_term` int(11) NOT NULL,
  `repayment_frequency` int(11) NOT NULL,
  `repayment_frequency_type` enum('days','weeks','months','years') COLLATE utf8mb4_unicode_ci NOT NULL,
  `interest_rate_type` enum('day','week','month','year') COLLATE utf8mb4_unicode_ci NOT NULL,
  `enable_balloon_payments` tinyint(4) NOT NULL DEFAULT '0',
  `allow_schedule_adjustments` tinyint(4) NOT NULL DEFAULT '0',
  `grace_on_principal_paid` int(11) NOT NULL DEFAULT '0',
  `grace_on_interest_paid` int(11) NOT NULL DEFAULT '0',
  `grace_on_interest_charged` int(11) NOT NULL DEFAULT '0',
  `allow_custom_grace_period` tinyint(4) NOT NULL DEFAULT '0',
  `allow_topup` tinyint(4) NOT NULL DEFAULT '0',
  `interest_methodology` enum('flat','declining_balance') COLLATE utf8mb4_unicode_ci NOT NULL,
  `interest_recalculation` tinyint(4) NOT NULL DEFAULT '0',
  `amortization_method` enum('equal_installments','equal_principal_payments') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interest_calculation_period_type` enum('daily','same') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `days_in_year` enum('actual','360','365','364') COLLATE utf8mb4_unicode_ci DEFAULT 'actual',
  `days_in_month` enum('actual','30','31') COLLATE utf8mb4_unicode_ci DEFAULT 'actual',
  `include_in_loan_cycle` tinyint(4) NOT NULL DEFAULT '0',
  `lock_guarantee_funds` tinyint(4) NOT NULL DEFAULT '0',
  `auto_allocate_overpayments` tinyint(4) NOT NULL DEFAULT '0',
  `allow_additional_charges` tinyint(4) NOT NULL DEFAULT '0',
  `auto_disburse` tinyint(4) NOT NULL DEFAULT '0',
  `status` enum('pending','approved','active','withdrawn','rejected','closed','rescheduled','written_off','overpaid','submitted') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'submitted',
  `disbursement_charges` decimal(65,6) DEFAULT NULL,
  `principal_disbursed_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `principal_repaid_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `principal_written_off_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `principal_outstanding_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `interest_disbursed_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `interest_repaid_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `interest_written_off_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `interest_waived_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `interest_outstanding_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `fees_disbursed_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `fees_repaid_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `fees_written_off_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `fees_waived_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `fees_outstanding_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `penalties_disbursed_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `penalties_repaid_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `penalties_written_off_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `penalties_waived_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `penalties_outstanding_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `total_disbursed_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `total_repaid_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `total_written_off_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `total_waived_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `total_outstanding_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `loans_external_id_unique` (`external_id`),
  UNIQUE KEY `loans_account_number_unique` (`account_number`),
  KEY `loans_client_id_index` (`client_id`),
  KEY `loans_loan_officer_id_index` (`loan_officer_id`),
  KEY `loans_loan_product_id_index` (`loan_product_id`),
  KEY `loans_branch_id_index` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan_applications`
--

DROP TABLE IF EXISTS `loan_applications`;
CREATE TABLE IF NOT EXISTS `loan_applications` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `loan_id` bigint(20) UNSIGNED DEFAULT NULL,
  `loan_product_id` bigint(20) UNSIGNED NOT NULL,
  `amount` decimal(65,4) NOT NULL DEFAULT '0.0000',
  `status` enum('approved','pending','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan_charges`
--

DROP TABLE IF EXISTS `loan_charges`;
CREATE TABLE IF NOT EXISTS `loan_charges` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `currency_id` bigint(20) UNSIGNED NOT NULL,
  `loan_charge_type_id` bigint(20) UNSIGNED NOT NULL,
  `loan_charge_option_id` bigint(20) UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(65,6) NOT NULL,
  `min_amount` decimal(65,6) DEFAULT NULL,
  `max_amount` decimal(65,6) DEFAULT NULL,
  `payment_mode` enum('regular','account_transfer') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'regular',
  `schedule` tinyint(4) DEFAULT '0',
  `schedule_frequency` int(11) DEFAULT NULL,
  `schedule_frequency_type` enum('days','weeks','months','years') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_penalty` tinyint(4) DEFAULT '0',
  `active` tinyint(4) NOT NULL DEFAULT '0',
  `allow_override` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `loan_charges_currency_id_foreign` (`currency_id`),
  KEY `loan_charges_loan_charge_type_id_foreign` (`loan_charge_type_id`),
  KEY `loan_charges_loan_charge_option_id_foreign` (`loan_charge_option_id`),
  KEY `loan_charges_created_by_id_foreign` (`created_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan_charge_options`
--

DROP TABLE IF EXISTS `loan_charge_options`;
CREATE TABLE IF NOT EXISTS `loan_charge_options` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `translated_name` text COLLATE utf8mb4_unicode_ci,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loan_charge_options`
--

INSERT INTO `loan_charge_options` (`id`, `name`, `translated_name`, `active`) VALUES
(1, 'Flat', 'Flat', 1),
(2, 'Principal due on installment', 'Principal due on installment', 1),
(3, 'Principal + Interest due on installment', 'Principal + Interest due on installment', 1),
(4, 'Interest due on installment', 'Interest due on installment', 1),
(5, 'Total Outstanding Loan Principal', 'Total Outstanding Loan Principal', 1),
(6, 'Percentage of Original Loan Principal per Installment', 'Percentage of Original Loan Principal per Installment', 1),
(7, 'Original Loan Principal', 'Original Loan Principal', 1);

-- --------------------------------------------------------

--
-- Table structure for table `loan_charge_types`
--

DROP TABLE IF EXISTS `loan_charge_types`;
CREATE TABLE IF NOT EXISTS `loan_charge_types` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `translated_name` text COLLATE utf8mb4_unicode_ci,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loan_charge_types`
--

INSERT INTO `loan_charge_types` (`id`, `name`, `translated_name`, `active`) VALUES
(1, 'Disbursement', 'Disbursement', 1),
(2, 'Specified Due Date', 'Specified Due Date', 1),
(3, 'Installment Fees', 'Installment Fees', 1),
(4, 'Overdue Installment Fee', 'Overdue Installment Fee', 1),
(5, 'Disbursement - Paid With Repayment', 'Disbursement - Paid With Repayment', 1),
(6, 'Loan Rescheduling Fee', 'Loan Rescheduling Fee', 1),
(7, 'Overdue On Loan Maturity', 'Overdue On Loan Maturity', 1),
(8, 'Last installment fee', 'Last installment fee', 1);

-- --------------------------------------------------------

--
-- Table structure for table `loan_collateral`
--

DROP TABLE IF EXISTS `loan_collateral`;
CREATE TABLE IF NOT EXISTS `loan_collateral` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `loan_id` bigint(20) UNSIGNED NOT NULL,
  `loan_collateral_type_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `value` decimal(65,6) DEFAULT NULL,
  `link` text COLLATE utf8mb4_unicode_ci,
  `status` enum('active','repossessed','sold','closed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `loan_collateral_loan_id_index` (`loan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan_collateral_types`
--

DROP TABLE IF EXISTS `loan_collateral_types`;
CREATE TABLE IF NOT EXISTS `loan_collateral_types` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loan_collateral_types`
--

INSERT INTO `loan_collateral_types` (`id`, `name`) VALUES
(1, 'TV Set');

-- --------------------------------------------------------

--
-- Table structure for table `loan_credit_checks`
--

DROP TABLE IF EXISTS `loan_credit_checks`;
CREATE TABLE IF NOT EXISTS `loan_credit_checks` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `translated_name` text COLLATE utf8mb4_unicode_ci,
  `security_level` enum('block','pass','warning') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'warning',
  `rating_type` enum('boolean','score') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'boolean',
  `pass_min_amount` decimal(65,6) DEFAULT NULL,
  `pass_max_amount` decimal(65,6) DEFAULT NULL,
  `warn_min_amount` decimal(65,6) DEFAULT NULL,
  `warn_max_amount` decimal(65,6) DEFAULT NULL,
  `fail_min_amount` decimal(65,6) DEFAULT NULL,
  `fail_max_amount` decimal(65,6) DEFAULT NULL,
  `general_error_msg` text COLLATE utf8mb4_unicode_ci,
  `user_friendly_error_msg` text COLLATE utf8mb4_unicode_ci,
  `general_warning_msg` text COLLATE utf8mb4_unicode_ci,
  `user_friendly_warning_msg` text COLLATE utf8mb4_unicode_ci,
  `general_success_msg` text COLLATE utf8mb4_unicode_ci,
  `user_friendly_success_msg` text COLLATE utf8mb4_unicode_ci,
  `active` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `loan_credit_checks_created_by_id_foreign` (`created_by_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loan_credit_checks`
--

INSERT INTO `loan_credit_checks` (`id`, `created_by_id`, `name`, `translated_name`, `security_level`, `rating_type`, `pass_min_amount`, `pass_max_amount`, `warn_min_amount`, `warn_max_amount`, `fail_min_amount`, `fail_max_amount`, `general_error_msg`, `user_friendly_error_msg`, `general_warning_msg`, `user_friendly_warning_msg`, `general_success_msg`, `user_friendly_success_msg`, `active`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Client Written-Off Loans Check', 'Client Written-Off Loans Check', 'block', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'The client has one or more written-off loans', 'The client has one or more written-off loans', 'The client has one or more written-off loans', 'The client has one or more written-off loans', 'The client has one or more written-off loans', 'The client has one or more written-off loans', 1, NULL, NULL),
(2, NULL, 'Same Product Outstanding', 'Same Product Outstanding', 'block', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'The client has an active loan for the same product', 'The client has an active loan for the same product', 'The client has an active loan for the same product', 'The client has an active loan for the same product', 'The client has an active loan for the same product', 'The client has an active loan for the same product', 1, NULL, NULL),
(3, NULL, 'Client Arrears', 'Client Arrears', 'block', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'Client has arrears on existing loans', 'Client has arrears on existing loans', 'Client has arrears on existing loans', 'Client has arrears on existing loans', 'Client has arrears on existing loans', 'Client has arrears on existing loans', 1, NULL, NULL),
(4, NULL, 'Outstanding Loan Balance', 'Outstanding Loan Balance', 'block', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'Client has outstanding balance on existing loans', 'Client has outstanding balance on existing loans', 'Client has outstanding balance on existing loans', 'Client has outstanding balance on existing loans', 'Client has outstanding balance on existing loans', 'Client has outstanding balance on existing loans', 1, NULL, NULL),
(5, NULL, 'Rejected and withdrawn loans', 'Rejected and withdrawn loans', 'block', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'This client has had one or more rejected or withdrawn loans', 'This client has had one or more rejected or withdrawn loans', 'This client has had one or more rejected or withdrawn loans', 'This client has had one or more rejected or withdrawn loans', 'This client has had one or more rejected or withdrawn loans', 'This client has had one or more rejected or withdrawn loans', 1, NULL, NULL),
(6, NULL, 'Total collateral items value', 'Total collateral items value', 'block', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'The total value of collateral items for this loan is less than the principal loanamount', 'The total value of collateral items for this loan is less than the principal loanamount', 'The total value of collateral items for this loan is less than the principal loanamount', 'The total value of collateral items for this loan is less than the principal loanamount', 'The total value of collateral items for this loan is less than the principal loanamount', 'The total value of collateral items for this loan is less than the principal loanamount', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `loan_disbursement_channels`
--

DROP TABLE IF EXISTS `loan_disbursement_channels`;
CREATE TABLE IF NOT EXISTS `loan_disbursement_channels` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_system` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan_files`
--

DROP TABLE IF EXISTS `loan_files`;
CREATE TABLE IF NOT EXISTS `loan_files` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `loan_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `size` int(11) DEFAULT NULL,
  `link` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `loan_files_loan_id_index` (`loan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan_guarantors`
--

DROP TABLE IF EXISTS `loan_guarantors`;
CREATE TABLE IF NOT EXISTS `loan_guarantors` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `loan_id` bigint(20) UNSIGNED DEFAULT NULL,
  `is_client` tinyint(4) NOT NULL DEFAULT '0',
  `client_id` bigint(20) UNSIGNED DEFAULT NULL,
  `first_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `middle_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` enum('male','female','other','unspecified') COLLATE utf8mb4_unicode_ci DEFAULT 'unspecified',
  `status` enum('pending','active','inactive','deceased','unspecified','closed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `marital_status` enum('married','single','divorced','widowed','unspecified','other') COLLATE utf8mb4_unicode_ci DEFAULT 'unspecified',
  `country_id` bigint(20) UNSIGNED DEFAULT NULL,
  `title_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profession_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_relationship_id` bigint(20) UNSIGNED DEFAULT NULL,
  `mobile` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_number` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employer` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_date` date DEFAULT NULL,
  `joined_date` date DEFAULT NULL,
  `guaranteed_amount` decimal(65,6) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `loan_guarantors_loan_id_index` (`loan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan_history`
--

DROP TABLE IF EXISTS `loan_history`;
CREATE TABLE IF NOT EXISTS `loan_history` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) UNSIGNED NOT NULL,
  `created_by_id` bigint(20) UNSIGNED NOT NULL,
  `action` text COLLATE utf8mb4_unicode_ci,
  `user` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `loan_history_loan_id_index` (`loan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan_linked_charges`
--

DROP TABLE IF EXISTS `loan_linked_charges`;
CREATE TABLE IF NOT EXISTS `loan_linked_charges` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) UNSIGNED NOT NULL,
  `loan_charge_id` bigint(20) UNSIGNED NOT NULL,
  `loan_charge_type_id` bigint(20) UNSIGNED DEFAULT NULL,
  `loan_charge_option_id` bigint(20) UNSIGNED DEFAULT NULL,
  `loan_transaction_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` text COLLATE utf8mb4_unicode_ci,
  `amount` decimal(65,6) NOT NULL,
  `calculated_amount` decimal(65,6) DEFAULT NULL,
  `amount_paid_derived` decimal(65,6) DEFAULT NULL,
  `amount_waived_derived` decimal(65,6) DEFAULT NULL,
  `amount_written_off_derived` decimal(65,6) DEFAULT NULL,
  `amount_outstanding_derived` decimal(65,6) DEFAULT NULL,
  `is_penalty` tinyint(4) NOT NULL DEFAULT '0',
  `waived` tinyint(4) NOT NULL DEFAULT '0',
  `is_paid` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `loan_linked_charges_loan_id_index` (`loan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan_linked_credit_checks`
--

DROP TABLE IF EXISTS `loan_linked_credit_checks`;
CREATE TABLE IF NOT EXISTS `loan_linked_credit_checks` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) UNSIGNED NOT NULL,
  `loan_credit_check_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan_notes`
--

DROP TABLE IF EXISTS `loan_notes`;
CREATE TABLE IF NOT EXISTS `loan_notes` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `loan_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `loan_notes_loan_id_index` (`loan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan_officer_history`
--

DROP TABLE IF EXISTS `loan_officer_history`;
CREATE TABLE IF NOT EXISTS `loan_officer_history` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) UNSIGNED NOT NULL,
  `created_by_id` bigint(20) UNSIGNED NOT NULL,
  `loan_officer_id` bigint(20) UNSIGNED NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `loan_officer_history_loan_id_index` (`loan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan_products`
--

DROP TABLE IF EXISTS `loan_products`;
CREATE TABLE IF NOT EXISTS `loan_products` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `currency_id` bigint(20) UNSIGNED NOT NULL,
  `loan_disbursement_channel_id` bigint(20) UNSIGNED DEFAULT NULL,
  `loan_transaction_processing_strategy_id` bigint(20) UNSIGNED NOT NULL,
  `fund_id` bigint(20) UNSIGNED NOT NULL,
  `multiplier` bigint(20) UNSIGNED NOT NULL DEFAULT '1',
  `loan_repayment_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `fund_source_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `loan_portfolio_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `interest_receivable_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `penalties_receivable_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `fees_receivable_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `fees_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `overpayments_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `suspended_income_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `income_from_interest_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `income_from_penalties_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `income_from_fees_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `income_from_recovery_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `losses_written_off_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `interest_written_off_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_name` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `decimals` int(11) DEFAULT NULL,
  `instalment_multiple_of` int(11) DEFAULT '1',
  `minimum_principal` decimal(65,6) DEFAULT NULL,
  `default_principal` decimal(65,6) DEFAULT NULL,
  `maximum_principal` decimal(65,6) DEFAULT NULL,
  `minimum_loan_term` int(11) DEFAULT NULL,
  `default_loan_term` int(11) DEFAULT NULL,
  `maximum_loan_term` int(11) DEFAULT NULL,
  `repayment_frequency` int(11) NOT NULL,
  `repayment_frequency_type` enum('days','weeks','months','years') COLLATE utf8mb4_unicode_ci NOT NULL,
  `minimum_interest_rate` decimal(65,6) DEFAULT NULL,
  `default_interest_rate` decimal(65,6) NOT NULL,
  `maximum_interest_rate` decimal(65,6) DEFAULT NULL,
  `interest_rate_type` enum('day','week','month','year') COLLATE utf8mb4_unicode_ci NOT NULL,
  `enable_balloon_payments` tinyint(4) NOT NULL DEFAULT '0',
  `allow_schedule_adjustments` tinyint(4) NOT NULL DEFAULT '0',
  `grace_on_principal_paid` int(11) NOT NULL DEFAULT '0',
  `grace_on_interest_paid` int(11) NOT NULL DEFAULT '0',
  `grace_on_interest_charged` int(11) NOT NULL DEFAULT '0',
  `allow_custom_grace_period` tinyint(4) NOT NULL DEFAULT '0',
  `allow_topup` tinyint(4) NOT NULL DEFAULT '0',
  `interest_methodology` enum('flat','declining_balance') COLLATE utf8mb4_unicode_ci NOT NULL,
  `interest_recalculation` tinyint(4) NOT NULL DEFAULT '0',
  `amortization_method` enum('equal_installments','equal_principal_payments') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interest_calculation_period_type` enum('daily','same') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `days_in_year` enum('actual','360','365','364') COLLATE utf8mb4_unicode_ci DEFAULT 'actual',
  `days_in_month` enum('actual','30','31') COLLATE utf8mb4_unicode_ci DEFAULT 'actual',
  `include_in_loan_cycle` tinyint(4) NOT NULL DEFAULT '0',
  `lock_guarantee_funds` tinyint(4) NOT NULL DEFAULT '0',
  `auto_allocate_overpayments` tinyint(4) NOT NULL DEFAULT '0',
  `allow_additional_charges` tinyint(4) NOT NULL DEFAULT '0',
  `auto_disburse` tinyint(4) NOT NULL DEFAULT '0',
  `require_linked_savings_account` tinyint(4) NOT NULL DEFAULT '0',
  `min_amount` decimal(65,6) DEFAULT NULL,
  `max_amount` decimal(65,6) DEFAULT NULL,
  `accounting_rule` enum('none','cash','accrual_periodic','accrual_upfront') COLLATE utf8mb4_unicode_ci DEFAULT 'none',
  `npa_overdue_days` int(11) NOT NULL DEFAULT '0',
  `npa_suspend_accrued_income` tinyint(4) NOT NULL DEFAULT '0',
  `active` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan_product_linked_charges`
--

DROP TABLE IF EXISTS `loan_product_linked_charges`;
CREATE TABLE IF NOT EXISTS `loan_product_linked_charges` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `loan_product_id` bigint(20) UNSIGNED NOT NULL,
  `loan_charge_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan_product_linked_credit_checks`
--

DROP TABLE IF EXISTS `loan_product_linked_credit_checks`;
CREATE TABLE IF NOT EXISTS `loan_product_linked_credit_checks` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `loan_product_id` bigint(20) UNSIGNED NOT NULL,
  `loan_credit_check_id` bigint(20) UNSIGNED NOT NULL,
  `check_order` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan_purposes`
--

DROP TABLE IF EXISTS `loan_purposes`;
CREATE TABLE IF NOT EXISTS `loan_purposes` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loan_purposes`
--

INSERT INTO `loan_purposes` (`id`, `name`) VALUES
(1, 'Agriculture'),
(2, 'Business Capital'),
(3, 'Family Emergency'),
(4, 'Personal Use'),
(5, 'Assets Purchase');

-- --------------------------------------------------------

--
-- Table structure for table `loan_repayment_schedules`
--

DROP TABLE IF EXISTS `loan_repayment_schedules`;
CREATE TABLE IF NOT EXISTS `loan_repayment_schedules` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `loan_id` bigint(20) UNSIGNED DEFAULT NULL,
  `paid_by_date` date DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `due_date` date NOT NULL,
  `installment` int(11) DEFAULT NULL,
  `principal` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `principal_repaid_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `principal_written_off_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `interest` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `interest_repaid_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `interest_written_off_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `interest_waived_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `fees` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `fees_repaid_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `fees_written_off_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `fees_waived_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `penalties` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `penalties_repaid_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `penalties_written_off_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `penalties_waived_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `total_due` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `month` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `loan_repayment_schedules_loan_id_index` (`loan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan_transactions`
--

DROP TABLE IF EXISTS `loan_transactions`;
CREATE TABLE IF NOT EXISTS `loan_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) UNSIGNED NOT NULL,
  `register_id` bigint(20) UNSIGNED NOT NULL DEFAULT '1',
  `group_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payment_detail_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` text COLLATE utf8mb4_unicode_ci,
  `amount` decimal(65,6) NOT NULL,
  `credit` decimal(65,6) DEFAULT NULL,
  `debit` decimal(65,6) DEFAULT NULL,
  `principal_repaid_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `interest_repaid_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `fees_repaid_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `penalties_repaid_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `loan_transaction_type_id` bigint(20) UNSIGNED NOT NULL,
  `reversed` tinyint(4) NOT NULL DEFAULT '0',
  `reversible` tinyint(4) NOT NULL DEFAULT '0',
  `submitted_on` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `created_on` date DEFAULT NULL,
  `status` enum('pending','approved','declined') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gateway_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `payment_gateway_data` text COLLATE utf8mb4_unicode_ci,
  `online_transaction` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `loan_transactions_loan_id_index` (`loan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan_transaction_processing_strategies`
--

DROP TABLE IF EXISTS `loan_transaction_processing_strategies`;
CREATE TABLE IF NOT EXISTS `loan_transaction_processing_strategies` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `translated_name` text COLLATE utf8mb4_unicode_ci,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loan_transaction_processing_strategies`
--

INSERT INTO `loan_transaction_processing_strategies` (`id`, `name`, `translated_name`, `active`) VALUES
(1, 'Penalties, Fees, Interest, Principal order', 'Penalties, Fees, Interest, Principal order', 1),
(2, 'Principal, Interest, Penalties, Fees Order', 'Principal, Interest, Penalties, Fees Order', 1),
(3, 'Interest, Principal, Penalties, Fees Order', 'Interest, Principal, Penalties, Fees Order', 1);

-- --------------------------------------------------------

--
-- Table structure for table `loan_transaction_types`
--

DROP TABLE IF EXISTS `loan_transaction_types`;
CREATE TABLE IF NOT EXISTS `loan_transaction_types` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `translated_name` text COLLATE utf8mb4_unicode_ci,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loan_transaction_types`
--

INSERT INTO `loan_transaction_types` (`id`, `name`, `translated_name`, `active`) VALUES
(1, 'Disbursement', 'Disbursement', 1),
(2, 'Repayment', 'Repayment', 1),
(3, 'Contra', 'Contra', 1),
(4, 'Waive Interest', 'Waive Interest', 1),
(5, 'Repayment At Disbursement', 'Repayment At Disbursement', 1),
(6, 'Write Off', 'Write Off', 1),
(7, 'Marked for Rescheduling', 'Marked for Rescheduling', 1),
(8, 'Recovery Repayment', 'Recovery Repayment', 1),
(9, 'Waive Charges', 'Waive Charges', 1),
(10, 'Apply Charges', 'Apply Charges', 1),
(11, 'Apply Interest', 'Apply Interest', 1);

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

DROP TABLE IF EXISTS `menus`;
CREATE TABLE IF NOT EXISTS `menus` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `menu_id` bigint(20) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `parent_slug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_parent` tinyint(4) NOT NULL DEFAULT '0',
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `menu_order` int(11) DEFAULT NULL,
  `url` text COLLATE utf8mb4_unicode_ci,
  `permissions` text COLLATE utf8mb4_unicode_ci,
  `icon` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `module` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `menu_id`, `parent_id`, `parent_slug`, `is_parent`, `name`, `title`, `slug`, `description`, `menu_order`, `url`, `permissions`, `icon`, `module`, `created_at`, `updated_at`) VALUES
(65, NULL, NULL, '', 1, 'Activity Logs', NULL, 'activity_log', NULL, 60, 'activity_log', 'activitylog.activity_logs.index', 'fa fa-database', 'Activitylog', '2020-09-02 06:59:45', '2020-09-02 06:59:45'),
(89, NULL, NULL, '', 1, 'Dashboard', NULL, 'dashboard', NULL, 0, 'dashboard', 'dashboard.index', 'fas fa-home', 'Dashboard', '2020-12-16 10:07:59', '2020-12-16 10:07:59'),
(106, NULL, NULL, '', 1, 'Accounting', NULL, 'accounting', NULL, 3, 'accounting', '', 'fas fa-money-bill', 'Accounting', '2020-12-16 10:14:53', '2020-12-16 10:14:53'),
(107, NULL, 106, 'accounting', 0, 'View Charts of Accounts', NULL, 'view_charts_of_accounts', NULL, 4, 'accounting/chart_of_account', 'accounting.chart_of_accounts.index', 'far fa-circle', 'Accounting', '2020-12-16 10:14:53', '2020-12-16 10:14:53'),
(108, NULL, 106, 'accounting', 0, 'Journal Entries', NULL, 'journal_entries', NULL, 5, 'accounting/journal_entry', 'accounting.journal_entries.index', 'far fa-circle', 'Accounting', '2020-12-16 10:14:53', '2020-12-16 10:14:53'),
(109, NULL, NULL, '', 1, 'Branches', NULL, 'branches', NULL, 6, 'branch', '', 'fas fa-building', 'Branch', '2020-12-16 10:16:00', '2020-12-16 10:16:00'),
(110, NULL, 109, 'branches', 0, 'View Branches', NULL, 'view_branches', NULL, 7, 'branch', 'branch.branches.index', 'far fa-circle', 'Branch', '2020-12-16 10:16:00', '2020-12-16 10:16:00'),
(111, NULL, 109, 'branches', 0, 'Create Branch', NULL, 'create_branch', NULL, 8, 'branch/create', 'branch.branches.create', 'far fa-circle', 'Branch', '2020-12-16 10:16:00', '2020-12-16 10:16:00'),
(117, NULL, NULL, '', 1, 'Manage Modules', NULL, 'modules', NULL, 30, 'module', 'core.modules.index', 'fas fa-plug', 'Core', '2020-12-16 10:20:25', '2020-12-16 10:20:25'),
(118, NULL, NULL, '', 1, 'Manage Menu', NULL, 'menu', NULL, 31, 'menu', 'core.menu.index', 'fas fa-bars', 'Core', '2020-12-16 10:20:25', '2020-12-16 10:20:25'),
(119, NULL, 79, 'settings', 0, 'Payment Gateways', NULL, 'menu', NULL, 32, 'settings/payment_gateway', 'core.payment_gateways.index', 'fas fa-money-bill', 'Core', '2020-12-16 10:20:25', '2020-12-16 10:20:25'),
(120, NULL, NULL, '', 1, 'Themes', NULL, 'themes', NULL, 40, 'theme', 'core.themes.index', 'fas fa-palette', 'Core', '2020-12-16 10:20:25', '2020-12-16 10:20:25'),
(126, NULL, NULL, '', 1, 'Payroll', NULL, 'payroll', NULL, 10, 'payroll', 'payroll.payroll.index', 'fab fa-paypal', 'Payroll', '2020-12-16 10:22:53', '2020-12-16 10:22:53'),
(127, NULL, 126, 'payroll', 0, 'View Payroll', NULL, 'view_payroll', NULL, 11, 'payroll', 'payroll.payroll.index', 'far fa-circle', 'Payroll', '2020-12-16 10:22:53', '2020-12-16 10:22:53'),
(128, NULL, 126, 'payroll', 0, 'Create Payroll', NULL, 'create_payroll', NULL, 12, 'payroll/create', 'payroll.payroll.create', 'far fa-circle', 'Payroll', '2020-12-16 10:22:53', '2020-12-16 10:22:53'),
(129, NULL, 126, 'payroll', 0, 'Manage Payroll Items', NULL, 'manage_payroll_items', NULL, 12, 'payroll/item', 'payroll.payroll.items.index', 'far fa-circle', 'Payroll', '2020-12-16 10:22:53', '2020-12-16 10:22:53'),
(130, NULL, 126, 'payroll', 0, 'Manage Payroll Templates', NULL, 'manage_payroll_templates', NULL, 12, 'payroll/template', 'payroll.payroll.templates.index', 'far fa-circle', 'Payroll', '2020-12-16 10:22:53', '2020-12-16 10:22:53'),
(138, NULL, NULL, '', 1, 'Loans', NULL, 'loans', NULL, 18, 'loan', '', 'fas fa-money-bill', 'Loan', '2020-12-16 10:26:27', '2020-12-16 10:26:27'),
(139, NULL, 138, 'loans', 0, 'View Loans', NULL, 'view_loans', NULL, 19, 'loan', 'loan.loans.index', 'far fa-circle', 'Loan', '2020-12-16 10:26:27', '2020-12-16 10:26:27'),
(140, NULL, 138, 'loans', 0, 'View Applications', NULL, 'view_applications', NULL, 20, 'loan/application', 'loan.loans.index', 'far fa-circle', 'Loan', '2020-12-16 10:26:27', '2020-12-16 10:26:27'),
(141, NULL, 138, 'loans', 0, 'Create Loan', NULL, 'create_loan', NULL, 21, 'loan/create', 'loan.loans.create', 'far fa-circle', 'Loan', '2020-12-16 10:26:27', '2020-12-16 10:26:27'),
(142, NULL, 138, 'loans', 0, 'Manage Products', NULL, 'manage_products', NULL, 22, 'loan/product', 'loan.loans.products.index', 'far fa-circle', 'Loan', '2020-12-16 10:26:27', '2020-12-16 10:26:27'),
(143, NULL, 138, 'loans', 0, 'Manage Charges', NULL, 'manage_charges', NULL, 23, 'loan/charge', 'loan.loans.charges.index', 'far fa-circle', 'Loan', '2020-12-16 10:26:27', '2020-12-16 10:26:27'),
(144, NULL, 138, 'loans', 0, 'Loan Calculator', NULL, 'loan_calculator', NULL, 24, 'loan/calculator', 'loan.loans.index', 'far fa-circle', 'Loan', '2020-12-16 10:26:27', '2020-12-16 10:26:27'),
(150, NULL, NULL, '', 1, 'Communication', NULL, 'communication', NULL, 13, 'communication', '', 'fas fa-envelope', 'Communication', '2020-12-16 10:29:01', '2020-12-16 10:29:01'),
(151, NULL, 150, 'communication', 0, 'View Campaigns', NULL, 'view_campaigns', NULL, 14, 'communication/campaign', 'communication.campaigns.index', 'far fa-circle', 'Communication', '2020-12-16 10:29:01', '2020-12-16 10:29:01'),
(152, NULL, 150, 'communication', 0, 'Create Campaign', NULL, 'create_campaign', NULL, 15, 'communication/campaign/create', 'communication.campaigns.create', 'far fa-circle', 'Communication', '2020-12-16 10:29:01', '2020-12-16 10:29:01'),
(153, NULL, 150, 'communication', 0, 'View Logs', NULL, 'view_logs', NULL, 16, 'communication/log', 'communication.logs.index', 'far fa-circle', 'Communication', '2020-12-16 10:29:01', '2020-12-16 10:29:01'),
(154, NULL, 150, 'communication', 0, 'Manage SMS Gateways', NULL, 'manage_sms_gateways', NULL, 17, 'communication/sms_gateway', 'communication.sms_gateways.index', 'far fa-circle', 'Communication', '2020-12-16 10:29:01', '2020-12-16 10:29:01'),
(155, NULL, NULL, '', 1, 'Expenses', NULL, 'expenses', NULL, 20, 'expense', 'expense.expenses.index', 'fas fa-share', 'Expense', '2020-12-16 10:30:24', '2020-12-16 10:30:24'),
(156, NULL, 155, 'expenses', 0, 'View Expenses', NULL, 'view_expenses', NULL, 0, 'expense', 'expense.expenses.index', 'far fa-circle', 'Expense', '2020-12-16 10:30:24', '2020-12-16 10:30:24'),
(157, NULL, 155, 'expenses', 0, 'Create Expense', NULL, 'create_expense', NULL, 1, 'expense/create', 'expense.expenses.create', 'far fa-circle', 'Expense', '2020-12-16 10:30:24', '2020-12-16 10:30:24'),
(158, NULL, 155, 'expenses', 0, 'Manage Expense Types', NULL, 'manage_expense_types', NULL, 2, 'expense/type', 'expense.expenses.types.index', 'far fa-circle', 'Expense', '2020-12-16 10:30:24', '2020-12-16 10:30:24'),
(160, NULL, NULL, 'report', 1, 'Reports', NULL, 'reports', NULL, 20, 'report', 'reports.index', 'fas fa-chart-bar', 'Report', '2020-12-16 10:32:37', '2020-12-16 10:32:37'),
(161, NULL, NULL, '', 1, 'Custom Fields', NULL, 'custom_fields', NULL, 25, 'custom_field', '', 'fas fa-list', 'CustomField', '2020-12-16 10:34:09', '2020-12-16 10:34:09'),
(164, NULL, NULL, '', 1, 'Savings', NULL, 'savings', NULL, 25, 'savings', '', 'fas fa-university', 'Savings', '2020-12-16 10:36:25', '2020-12-16 10:36:25'),
(165, NULL, 164, 'savings', 0, 'View Savings', NULL, 'view_savings', NULL, 26, 'savings', 'savings.savings.index', 'far fa-circle', 'Savings', '2020-12-16 10:36:25', '2020-12-16 10:36:25'),
(166, NULL, 164, 'savings', 0, 'Create Savings', NULL, 'create_savings', NULL, 27, 'savings/create', 'savings.savings.create', 'far fa-circle', 'Savings', '2020-12-16 10:36:25', '2020-12-16 10:36:25'),
(167, NULL, 164, 'savings', 0, 'Manage Products', NULL, 'manage_products', NULL, 28, 'savings/product', 'savings.savings.products.index', 'far fa-circle', 'Savings', '2020-12-16 10:36:25', '2020-12-16 10:36:25'),
(168, NULL, 164, 'savings', 0, 'Manage Charges', NULL, 'manage_charges', NULL, 29, 'savings/charge', 'savings.savings.charges.index', 'far fa-circle', 'Savings', '2020-12-16 10:36:25', '2020-12-16 10:36:25'),
(169, NULL, NULL, '', 1, 'Income', NULL, 'income', NULL, 25, 'income', 'income.income.index', 'fas fa-money-bill', 'Income', '2020-12-16 10:38:36', '2020-12-16 10:38:36'),
(170, NULL, 169, 'income', 0, 'View Income', NULL, 'view_assets', NULL, 7, 'income', 'income.income.index', 'far fa-circle', 'Income', '2020-12-16 10:38:36', '2020-12-16 10:38:36'),
(171, NULL, 169, 'income', 0, 'Create Income', NULL, 'create_asset', NULL, 8, 'income/create', 'income.income.create', 'far fa-circle', 'Income', '2020-12-16 10:38:36', '2020-12-16 10:38:36'),
(172, NULL, 169, 'income', 0, 'Manage Income Types', NULL, 'manage_asset_types', NULL, 9, 'income/type', 'income.income.types.index', 'far fa-circle', 'Income', '2020-12-16 10:38:36', '2020-12-16 10:38:36'),
(182, NULL, NULL, '', 1, 'Shares', NULL, 'shares', NULL, 30, 'share', 'share.shares.index', 'fas fa-database', 'Share', '2020-12-16 10:43:29', '2020-12-16 10:43:29'),
(183, NULL, 182, 'shares', 0, 'View Shares', NULL, 'view_shares', NULL, 1, 'share', 'share.shares.index', 'far fa-circle', 'Share', '2020-12-16 10:43:29', '2020-12-16 10:43:29'),
(184, NULL, 182, 'shares', 0, 'Create Share', NULL, 'create_share', NULL, 2, 'share/create', 'share.shares.create', 'far fa-circle', 'Share', '2020-12-16 10:43:29', '2020-12-16 10:43:29'),
(185, NULL, 182, 'shares', 0, 'Manage Products', NULL, 'manage_share_products', NULL, 3, 'share/product', 'share.shares.products.index', 'far fa-circle', 'Share', '2020-12-16 10:43:29', '2020-12-16 10:43:29'),
(186, NULL, 182, 'shares', 0, 'Manage Charges', NULL, 'manage_share_charges', NULL, 3, 'share/charge', 'share.shares.charges.index', 'far fa-circle', 'Share', '2020-12-16 10:43:29', '2020-12-16 10:43:29'),
(187, NULL, NULL, '', 1, 'Settings', NULL, 'settings', NULL, 31, 'setting', 'setting.setting.index', 'fas fa-cogs', 'Setting', '2020-12-16 10:44:59', '2020-12-16 10:44:59'),
(188, NULL, 187, 'settings', 0, 'Organisation Settings', NULL, 'organisation_settings', NULL, 32, 'setting/organisation', 'setting.setting.index', 'far fa-circle', 'Setting', '2020-12-16 10:44:59', '2020-12-16 10:44:59'),
(189, NULL, 187, 'settings', 0, 'General Settings', NULL, 'general_settings', NULL, 33, 'setting/general', 'setting.setting.index', 'far fa-circle', 'Setting', '2020-12-16 10:44:59', '2020-12-16 10:44:59'),
(190, NULL, 187, 'settings', 0, 'Email Settings', NULL, 'email_settings', NULL, 34, 'setting/email', 'setting.setting.index', 'far fa-circle', 'Setting', '2020-12-16 10:44:59', '2020-12-16 10:44:59'),
(191, NULL, 187, 'settings', 0, 'SMS Settings', NULL, 'sms_settings', NULL, 35, 'setting/sms', 'setting.setting.index', 'far fa-circle', 'Setting', '2020-12-16 10:44:59', '2020-12-16 10:44:59'),
(192, NULL, 187, 'settings', 0, 'System Settings', NULL, 'system_settings', NULL, 36, 'setting/system', 'setting.setting.index', 'far fa-circle', 'Setting', '2020-12-16 10:44:59', '2020-12-16 10:44:59'),
(193, NULL, 187, 'settings', 0, 'System Update', NULL, 'system_update', NULL, 37, 'setting/system_update', 'setting.setting.index', 'far fa-circle', 'Setting', '2020-12-16 10:44:59', '2020-12-16 10:44:59'),
(194, NULL, 187, 'settings', 0, 'Other Settings', NULL, 'other_settings', NULL, 38, 'setting/other', 'setting.setting.index', 'far fa-circle', 'Setting', '2020-12-16 10:44:59', '2020-12-16 10:44:59'),
(195, NULL, NULL, '', 1, 'Assets', NULL, 'assets', NULL, 30, 'asset', 'asset.assets.index', 'fas fa-building', 'Asset', '2020-12-16 10:46:22', '2020-12-16 10:46:22'),
(196, NULL, 195, 'assets', 0, 'View Assets', NULL, 'view_assets', NULL, 7, 'asset', 'asset.assets.index', 'far fa-circle', 'Asset', '2020-12-16 10:46:22', '2020-12-16 10:46:22'),
(197, NULL, 195, 'assets', 0, 'Create Asset', NULL, 'create_asset', NULL, 8, 'asset/create', 'asset.assets.create', 'far fa-circle', 'Asset', '2020-12-16 10:46:22', '2020-12-16 10:46:22'),
(198, NULL, 195, 'assets', 0, 'Manage Asset Types', NULL, 'manage_asset_types', NULL, 9, 'asset/type', 'asset.assets.types.index', 'far fa-circle', 'Asset', '2020-12-16 10:46:22', '2020-12-16 10:46:22'),
(202, NULL, NULL, '', 1, 'Users', NULL, 'users', NULL, 27, 'user', '', 'fas fa-users', 'User', '2021-01-15 11:25:39', '2021-01-15 11:25:39'),
(203, NULL, 202, 'users', 0, 'View Users', NULL, 'view_loans', NULL, 28, 'user', 'user.users.index', 'far fa-circle', 'User', '2021-01-15 11:25:39', '2021-01-15 11:25:39'),
(204, NULL, 202, 'users', 0, 'Create User', NULL, 'create_loan', NULL, 29, 'user/create', 'user.users.create', 'far fa-circle', 'User', '2021-01-15 11:25:39', '2021-01-15 11:25:39'),
(205, NULL, 202, 'users', 0, 'Manage Roles', NULL, 'manage_roles', NULL, 30, 'user/role', 'user.roles.index', 'far fa-circle', 'User', '2021-01-15 11:25:39', '2021-01-15 11:25:39'),
(207, NULL, NULL, '', 1, 'Clients', NULL, 'clients', NULL, 10, 'client', '', 'fas fa-users', 'Client', '2022-03-14 09:24:23', '2022-03-14 09:24:23'),
(208, NULL, 207, 'clients', 0, 'View Clients', NULL, 'view_clients', NULL, 11, 'client', 'client.clients.index', 'far fa-circle', 'Client', '2022-03-14 09:24:23', '2022-03-14 09:24:23'),
(209, NULL, 207, 'clients', 0, 'Create Client', NULL, 'create_client', NULL, 12, 'client/create', 'client.clients.create', 'far fa-circle', 'Client', '2022-03-14 09:24:23', '2022-03-14 09:24:23'),
(210, NULL, 207, 'clients', 0, 'View Groups', NULL, 'view_groups', NULL, 13, 'client/group', 'client.clients.groups.index', 'far fa-circle', 'Client', '2022-03-14 09:24:23', '2022-03-14 09:24:23');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1093 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(955, '2019_07_06_133107_create_settings_table', 1),
(956, '2018_08_08_100000_create_telescope_entries_table', 2),
(957, '2019_07_06_135714_create_countries_table', 2),
(958, '2019_07_06_140045_create_currencies_table', 2),
(959, '2019_07_06_140908_create_timezones_table', 2),
(960, '2019_07_07_110645_create_payment_types_table', 2),
(961, '2019_07_07_110717_create_payment_details_table', 2),
(962, '2019_07_10_225923_create_notifications_table', 2),
(963, '2019_07_27_080313_create_jobs_table', 2),
(964, '2019_09_07_001758_create_menus_table', 2),
(965, '2019_11_04_152950_create_tax_rates_table', 2),
(966, '2020_01_14_114056_create_failed_jobs_table', 2),
(967, '2014_10_12_000000_create_users_table', 3),
(968, '2014_10_12_100000_create_password_resets_table', 3),
(969, '2019_07_01_214429_create_permission_tables', 3),
(970, '2019_08_03_085238_create_widgets_table', 4),
(971, '2019_07_06_111125_create_branches_table', 5),
(972, '2019_07_06_111419_create_branch_users_table', 5),
(973, '2019_07_07_093258_create_chart_of_accounts_table', 6),
(974, '2019_07_07_093648_create_journal_entries_table', 6),
(975, '2019_09_26_153830_create_asset_types_table', 7),
(976, '2019_09_26_153906_create_assets_table', 7),
(977, '2019_09_26_153953_create_asset_notes_table', 7),
(978, '2019_09_26_153954_create_asset_maintenance_types_table', 7),
(979, '2019_09_26_154012_create_asset_maintenance_table', 7),
(980, '2019_09_26_154050_create_asset_files_table', 7),
(981, '2019_09_26_154103_create_asset_pictures_table', 7),
(982, '2019_09_27_063335_create_asset_depreciation_table', 7),
(983, '2019_07_08_130052_create_titles_table', 8),
(984, '2019_07_08_130053_create_client_relationships_table', 8),
(985, '2019_07_08_130533_create_professions_table', 8),
(986, '2019_07_08_150347_create_client_types_table', 8),
(987, '2019_07_08_151636_create_client_identification_types_table', 8),
(988, '2019_07_08_182818_create_clients_table', 8),
(989, '2019_07_08_182911_create_client_files_table', 8),
(990, '2019_07_08_182938_create_client_identification_table', 8),
(991, '2019_07_08_183031_create_client_next_of_kin_table', 8),
(992, '2019_07_11_180428_create_client_users_table', 8),
(993, '2019_08_05_093954_create_savings_charge_options_table', 9),
(994, '2019_08_05_094221_create_savings_charge_types_table', 9),
(995, '2019_08_05_094458_create_savings_charges_table', 9),
(996, '2019_08_05_094544_create_savings_transaction_types_table', 9),
(997, '2019_08_05_094956_create_savings_products_table', 9),
(998, '2019_08_05_095030_create_savings_table', 9),
(999, '2019_08_05_095031_create_savings_linked_charges_table', 9),
(1000, '2019_08_05_095048_create_savings_transactions_table', 9),
(1001, '2019_08_05_095148_create_savings_product_linked_charges_table', 9),
(1002, '2019_07_15_094401_create_loan_transaction_processing_strategies_table', 10),
(1003, '2019_07_15_100526_create_loan_charge_types_table', 10),
(1004, '2019_07_15_100649_create_loan_charge_options_table', 10),
(1005, '2019_07_15_104331_create_loan_credit_checks_table', 10),
(1006, '2019_07_15_141230_create_loan_purposes_table', 10),
(1007, '2019_07_15_201056_create_loan_transaction_types_table', 10),
(1008, '2019_07_15_214326_create_funds_table', 10),
(1009, '2019_07_15_214410_create_loan_charges_table', 10),
(1010, '2019_07_15_214940_create_loan_products_table', 10),
(1011, '2019_07_15_215017_create_loan_product_linked_charges_table', 10),
(1012, '2019_07_15_215107_create_loan_disbursement_channels_table', 10),
(1013, '2019_07_15_215314_create_loan_collateral_types_table', 10),
(1014, '2019_07_15_215355_create_loans_table', 10),
(1015, '2019_07_15_215451_create_loan_collateral_table', 10),
(1016, '2019_07_15_215546_create_loan_repayment_schedules_table', 10),
(1017, '2019_07_15_215604_create_loan_transactions_table', 10),
(1018, '2019_07_15_221258_create_loan_linked_charges_table', 10),
(1019, '2019_07_17_130522_create_loan_product_linked_credit_checks_table', 10),
(1020, '2019_07_17_130536_create_loan_linked_credit_checks_table', 10),
(1021, '2019_07_17_162121_create_loan_guarantors_table', 10),
(1022, '2019_07_17_194223_create_loan_officer_history_table', 10),
(1023, '2019_07_17_194247_create_loan_history_table', 10),
(1024, '2019_07_17_194817_create_loan_files_table', 10),
(1025, '2019_07_17_194827_create_loan_notes_table', 10),
(1026, '2019_08_30_074012_create_loan_applications_table', 10),
(1027, '2019_07_27_161835_create_communication_campaign_business_rules_table', 11),
(1028, '2019_07_27_161902_create_communication_campaign_attachment_types_table', 11),
(1029, '2019_07_28_150020_create_sms_gateways_table', 11),
(1030, '2019_07_28_150053_create_communication_campaigns_table', 11),
(1031, '2019_07_28_161940_create_communication_campaign_logs_table', 11),
(1032, '2016_06_01_000001_create_oauth_auth_codes_table', 12),
(1033, '2016_06_01_000002_create_oauth_access_tokens_table', 12),
(1034, '2016_06_01_000003_create_oauth_refresh_tokens_table', 12),
(1035, '2016_06_01_000004_create_oauth_clients_table', 12),
(1036, '2016_06_01_000005_create_oauth_personal_access_clients_table', 12),
(1037, '2019_09_22_080345_create_payroll_items_table', 13),
(1038, '2019_09_22_081303_create_payroll_templates_table', 13),
(1039, '2019_09_22_081304_create_payroll_template_items_table', 13),
(1040, '2019_09_22_081326_create_payroll_table', 13),
(1041, '2019_09_22_081441_create_payroll_items_meta_table', 13),
(1042, '2019_09_22_082657_create_payroll_payments_table', 13),
(1043, '2019_09_15_164302_create_custom_fields_table', 14),
(1044, '2019_09_15_164434_create_custom_fields_meta_table', 14),
(1045, '2020_02_24_114006_create_expense_types_table', 15),
(1046, '2020_02_24_114018_create_expenses_table', 15),
(1047, '2020_02_24_114052_create_income_types_table', 16),
(1048, '2020_02_24_114104_create_income_table', 16),
(1049, '2019_07_15_125704_create_activity_log_table', 17),
(1050, '2020_08_31_141646_create_wallets_table', 18),
(1051, '2020_08_31_150716_create_wallet_transactions_table', 18),
(1065, '2020_09_10_171351_create_share_charge_options_table', 19),
(1066, '2020_09_10_171936_create_share_transaction_types_table', 19),
(1067, '2020_09_10_171940_create_share_charge_types_table', 19),
(1068, '2020_09_10_171940_create_share_charges_table', 19),
(1069, '2020_09_10_171959_create_share_products_table', 19),
(1070, '2020_09_10_172033_create_share_product_linked_charges_table', 19),
(1071, '2020_09_10_172054_create_shares_table', 19),
(1072, '2020_09_10_172110_create_share_linked_charges_table', 19),
(1073, '2020_09_10_172120_create_share_transactions_table', 19),
(1074, '2020_09_10_172155_create_share_market_periods_table', 19),
(1075, '2022_03_12_115516_create_client_groups_table', 20),
(1076, '2019_12_14_000001_create_personal_access_tokens_table', 21),
(1077, '2022_03_12_120226_add_group_id_column_clients_table', 22),
(1078, '2022_03_29_130100_create_registers_table', 23),
(1079, '2022_04_05_210536_create_events_table', 24),
(1080, '2022_04_14_171211_add_column_to_savings_table', 25),
(1081, '2022_04_14_171412_add_column_to_savings_transactions_table', 25),
(1082, '2022_04_14_174200_add_column_to_loan__transactions_table', 26),
(1083, '2022_04_14_220723_add_column_to_loan_products_table', 27),
(1084, '2022_04_19_162727_add_column_to_expenses_table', 28),
(1085, '2022_04_19_162817_add_column_to_income_table', 29),
(1086, '2022_03_29_135309_add_colum_to_loan_transactions_table', 30),
(1087, '2022_03_29_135637_add_column_to_savings_transactions_table', 31),
(1088, '2022_03_29_235113_add_column_to_payment_details_table', 31),
(1089, '2022_04_13_161716_add_column_to_clients_table', 31),
(1090, '2022_04_23_173216_add_colum_to_client_groups_table', 31),
(1091, '2022_04_24_213213_add_column_to_payment_details_table', 32),
(1092, '2022_05_02_185324_add_column_to_loan_products_table', 33);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
CREATE TABLE IF NOT EXISTS `model_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

DROP TABLE IF EXISTS `model_has_roles`;
CREATE TABLE IF NOT EXISTS `model_has_roles` (
  `role_id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'Modules\\User\\Entities\\User', 1),
(2, 'Modules\\User\\Entities\\User', 2),
(1, 'Modules\\User\\Entities\\User', 3),
(2, 'Modules\\User\\Entities\\User', 7),
(2, 'Modules\\User\\Entities\\User', 8);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('20a72c3f-590f-4c35-a038-7e4860bf33ce', 'Modules\\User\\Notifications\\DemoNotification', 'Modules\\User\\Entities\\User', 1, '{\"url\":\"http:\\/\\/loan.local\\/user\\/profile\",\"message\":\"Sample notification\"}', '2020-12-14 14:35:44', '2020-10-15 16:54:53', '2020-12-14 14:35:44'),
('a5d5aec4-f1d0-4f38-85d7-f5942a6d4843', 'Modules\\User\\Notifications\\DemoNotification', 'Modules\\User\\Entities\\User', 1, '{\"url\":\"http:\\/\\/loan.local\\/user\\/profile\",\"message\":\"Sample notification\"}', '2020-12-16 07:18:04', '2020-10-15 16:55:11', '2020-12-16 07:18:04'),
('ff641911-2c54-4dd5-a947-dde7a2255d6b', 'Modules\\User\\Notifications\\DemoNotification', 'Modules\\User\\Entities\\User', 1, '{\"url\":\"http:\\/\\/loan.local\\/user\\/profile\",\"message\":\"Sample notification\"}', '2020-12-09 09:21:22', '2020-10-15 16:55:07', '2020-12-09 09:21:22');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

DROP TABLE IF EXISTS `oauth_access_tokens`;
CREATE TABLE IF NOT EXISTS `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('0289cd380247f52961c7aadd00dca52fdd8c71fb68e87f6bf6092da07cf87f7a072c1d5c548a9f83', 1, 2, NULL, '[]', 0, '2022-05-21 19:45:47', '2022-05-21 19:45:47', '2023-05-21 22:45:47'),
('04d34dfd0153609e302b053f412731426b5f28d8f97e1208954dccc19254d94fdfd93152430fbf4a', 1, 2, NULL, '[]', 0, '2022-03-16 10:02:04', '2022-03-16 10:02:04', '2023-03-16 13:02:04'),
('08a6e7194a6c6f3e2c66064bb72f53566d48a78acfd1c346aa10be0ad21b6644b9177d64f4b503c6', 1, 2, NULL, '[]', 0, '2022-03-16 08:03:14', '2022-03-16 08:03:14', '2023-03-16 11:03:14'),
('10e09127982c079e0b1bf2c54454e4f6200a4f7058bf62edf139c9129fee8a06cf9868c4559eb1a9', 1, 2, NULL, '[]', 0, '2022-03-16 10:01:54', '2022-03-16 10:01:54', '2023-03-16 13:01:54'),
('442971b37374d914614b4cebffce8c2ea13c7987e67825f1e1661389d017c8ff9bd0b22d89ee066d', 1, 2, NULL, '[]', 0, '2022-03-15 14:54:33', '2022-03-15 14:54:33', '2023-03-15 17:54:33'),
('551ecddcb8a2782acac7259b2694945cfa9b56916be5e435d8c0b02cb9c94fb87d27f192757efb3e', 1, 2, NULL, '[]', 0, '2022-04-05 20:56:59', '2022-04-05 20:56:59', '2023-04-05 23:56:59'),
('64d56ebd68c0f8ca2904d2d165752296d985de6ebf1978f3a29a318021974cbed010482829d0893e', 1, 2, NULL, '[]', 0, '2022-03-16 10:01:01', '2022-03-16 10:01:01', '2023-03-16 13:01:01'),
('7ba243cd92297b2e1a04c8e041f4fa437ee57f54c72de4d6604ff07897367500ec3e5c6f20cf814b', 1, 2, NULL, '[]', 0, '2022-05-07 06:47:12', '2022-05-07 06:47:12', '2023-05-07 09:47:12'),
('9d1e1eed13eb278c705c5acc1d464e14ea0f9db4ebb19a63f2002a0fed88ebd39ec546e06be9c4ad', 1, 2, NULL, '[]', 0, '2022-03-16 08:03:47', '2022-03-16 08:03:47', '2023-03-16 11:03:47'),
('c1c9081d052e02b7087f13198d7c0ed870cee518d2961d17a4f9600cc764ce2e2719df512774f1ae', 1, 2, NULL, '[]', 0, '2022-03-16 10:01:15', '2022-03-16 10:01:15', '2023-03-16 13:01:15'),
('d92774da819ccc1f353ec84588fdbad4639f3d06ef8a5351d6e23a5e6f166d59679dd9db74139f6d', 1, 2, NULL, '[]', 0, '2022-04-04 13:26:53', '2022-04-04 13:26:53', '2023-04-04 16:26:53'),
('db9597107d475e174348d21427adc276a4ed8466a52c2c78f00bea0462189462bf9eb141f82f3580', 1, 2, NULL, '[]', 0, '2022-04-05 12:16:25', '2022-04-05 12:16:25', '2023-04-05 15:16:25'),
('dbcdbea896ed981f650b9d3e802030a5f18b29c0c64fba2d3464091bf1b29bfa0a41bd8305adb063', 1, 2, NULL, '[]', 0, '2022-05-21 19:45:42', '2022-05-21 19:45:42', '2023-05-21 22:45:42'),
('dc294b0ff38465ad1ff5a8282f1b07cf019e7334c03e9a263838418c34448d4fb21a99f12e7c6dde', 1, 2, NULL, '[]', 0, '2022-06-23 19:39:06', '2022-06-23 19:39:06', '2023-06-23 22:39:06'),
('e14b1c94b94a11e68167ce83b6e41a7691f61728ccc25532db1f213effd182ff3998a2b7ff9b8c66', 1, 2, NULL, '[]', 0, '2022-03-28 11:30:50', '2022-03-28 11:30:50', '2023-03-28 14:30:50'),
('e2931ce69d2392696f4dccba48a9b92ab6ec1bae46b28682498b17a6ea713d900198c2357a001561', 1, 2, NULL, '[]', 0, '2022-03-16 10:00:49', '2022-03-16 10:00:49', '2023-03-16 13:00:49'),
('e565722f099b756677c2bf40016d05d0c28b7663d9ca904e3639dde2276b1b1a9e249bb7c7e99238', 1, 2, NULL, '[]', 0, '2022-03-16 10:10:48', '2022-03-16 10:10:48', '2023-03-16 13:10:48'),
('e72e74e1ef870cf59be29ecb4a31e5ed8c49c34e2a685d49d2d3a99800b60c175dc70c8d39e027f2', 1, 2, NULL, '[]', 0, '2022-03-15 14:52:51', '2022-03-15 14:52:51', '2023-03-15 17:52:51'),
('ed805a3995c784ee43a423bd854d2a8d98e3cd7a718e284c3a4c976cccf0d6382b1e9ac8d29b2d14', 1, 1, NULL, '[]', 0, '2022-03-15 14:08:41', '2022-03-15 14:08:41', '2023-03-15 17:08:41'),
('fad058dfbfb51c06da39a6b6d7669d720a5171ccb73b6258e65d8af7634b1a8353afe12a0c1d9d74', 1, 2, NULL, '[]', 0, '2022-03-15 14:55:03', '2022-03-15 14:55:03', '2023-03-15 17:55:03');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

DROP TABLE IF EXISTS `oauth_auth_codes`;
CREATE TABLE IF NOT EXISTS `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

DROP TABLE IF EXISTS `oauth_clients`;
CREATE TABLE IF NOT EXISTS `oauth_clients` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider` varchar(191) CHARACTER SET utf8mb4 DEFAULT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `redirect`, `provider`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'laravelPassportPassword', 't26Ve1AmtDURR5NZ7IPwAMxR3XBLANfHWjl46Lp9', 'http://localhost', 'users', 0, 1, 0, '2022-03-15 12:57:02', '2022-03-15 12:57:02'),
(2, NULL, 'laravelPassportGrant', 'eHdvEFyjdavPWef45CHER7L8nEwuukWg7819qIUp', 'http://localhost:3000', 'users', 0, 1, 0, '2022-03-15 14:34:28', '2022-03-15 14:34:28');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

DROP TABLE IF EXISTS `oauth_personal_access_clients`;
CREATE TABLE IF NOT EXISTS `oauth_personal_access_clients` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `client_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_personal_access_clients_client_id_index` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

DROP TABLE IF EXISTS `oauth_refresh_tokens`;
CREATE TABLE IF NOT EXISTS `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_refresh_tokens`
--

INSERT INTO `oauth_refresh_tokens` (`id`, `access_token_id`, `revoked`, `expires_at`) VALUES
('0b91320005b5ccf9102d9b9c6ab14450314bb9559c5a189fdb41ef9b389b683ffb861129be80926a', 'ed805a3995c784ee43a423bd854d2a8d98e3cd7a718e284c3a4c976cccf0d6382b1e9ac8d29b2d14', 0, '2023-03-15 17:08:41'),
('2950a145906ac375987b9a3d055673ff0110989f1866972a8a332a849730a40d6a75f421d4c4728f', 'e72e74e1ef870cf59be29ecb4a31e5ed8c49c34e2a685d49d2d3a99800b60c175dc70c8d39e027f2', 0, '2023-03-15 17:52:52'),
('383db9ec8fa1acc3ceef96cecd970bacee9ab1bc361d80334c5d7cc8425e8ab510f4f59c2fa8469d', 'd92774da819ccc1f353ec84588fdbad4639f3d06ef8a5351d6e23a5e6f166d59679dd9db74139f6d', 0, '2023-04-04 16:26:54'),
('5b4b366feaedfdb2ddfe9310244f22c5b97b5c7f55791ac6d872940ff5c4ab7b7c4bcd14814b879f', '7ba243cd92297b2e1a04c8e041f4fa437ee57f54c72de4d6604ff07897367500ec3e5c6f20cf814b', 0, '2023-05-07 09:47:14'),
('8064538f9a8157edf0c790409107b0768e22a9bb891c14443c8dc1b1ae0048cbd65513475f8b8946', 'e14b1c94b94a11e68167ce83b6e41a7691f61728ccc25532db1f213effd182ff3998a2b7ff9b8c66', 0, '2023-03-28 14:30:50'),
('8154211919371af1b9f3d8f4c4e7f45d76fa472b737b5910590b1ea847a2ce69847a17f69bc5bec2', '9d1e1eed13eb278c705c5acc1d464e14ea0f9db4ebb19a63f2002a0fed88ebd39ec546e06be9c4ad', 0, '2023-03-16 11:03:47'),
('8b3504dbbc78243d39c56966f4f2c64088bcb52130fca4ed5b7c573029ea0d15af470b5dec059465', '442971b37374d914614b4cebffce8c2ea13c7987e67825f1e1661389d017c8ff9bd0b22d89ee066d', 0, '2023-03-15 17:54:33'),
('8dbdb5cff538fe7aa8964f86a71b65433de2919e986ac128661771f19a7c41baa31f99cd807e0a4e', '551ecddcb8a2782acac7259b2694945cfa9b56916be5e435d8c0b02cb9c94fb87d27f192757efb3e', 0, '2023-04-05 23:57:00'),
('8dfba7f6fc0bbb7911682b6ed9c8112ed4e584f7a42540f0979c106d458bcca7ea6e25a899abe625', 'dc294b0ff38465ad1ff5a8282f1b07cf019e7334c03e9a263838418c34448d4fb21a99f12e7c6dde', 0, '2023-06-23 22:39:06'),
('91a8363f46a42663bf4206a5d0a991414e8a1d15712e3c29c10733ed3a5a0e4c4ccd5fe923072568', '0289cd380247f52961c7aadd00dca52fdd8c71fb68e87f6bf6092da07cf87f7a072c1d5c548a9f83', 0, '2023-05-21 22:45:47'),
('a321b240dd8ca122e3a436310845e29921eae8f67ec3ab7a9c3d16eb0dafee763cdd1977912d4289', '10e09127982c079e0b1bf2c54454e4f6200a4f7058bf62edf139c9129fee8a06cf9868c4559eb1a9', 0, '2023-03-16 13:01:54'),
('c7fd40df05a7f28726832364e16e72915d004a54c7482123da9b996ed8db8d71c2c178a557445732', 'e565722f099b756677c2bf40016d05d0c28b7663d9ca904e3639dde2276b1b1a9e249bb7c7e99238', 0, '2023-03-16 13:10:48'),
('cf0875b6da489cfaeda5c8c792e66d499fbf0a4d55218fd364b8077af720c96fd40540b67213f24a', '04d34dfd0153609e302b053f412731426b5f28d8f97e1208954dccc19254d94fdfd93152430fbf4a', 0, '2023-03-16 13:02:05'),
('da4c937cbb05a2db348fe4132524d07fb8e913ecbd41f2360c3a621c26131cc1d9214d99a548ab34', 'fad058dfbfb51c06da39a6b6d7669d720a5171ccb73b6258e65d8af7634b1a8353afe12a0c1d9d74', 0, '2023-03-15 17:55:03'),
('dc169e28ff1b035a216826f645410d38cee8b93fd3e8ea52b062330e72d1425645f19fc3db41feb3', 'c1c9081d052e02b7087f13198d7c0ed870cee518d2961d17a4f9600cc764ce2e2719df512774f1ae', 0, '2023-03-16 13:01:15'),
('e29852f0e27e0e52e693d952d1baf7f5d3aa0c471a06455037cb1a2dc51180f260244ce57bfe4c3d', 'dbcdbea896ed981f650b9d3e802030a5f18b29c0c64fba2d3464091bf1b29bfa0a41bd8305adb063', 0, '2023-05-21 22:45:42'),
('e2c9c954e5302aa802418a128f7977607500e1e2662f7423dcb24be547281f256b3f185d5ca308bb', '08a6e7194a6c6f3e2c66064bb72f53566d48a78acfd1c346aa10be0ad21b6644b9177d64f4b503c6', 0, '2023-03-16 11:03:14'),
('e45952f75f508b5697a16a1e02ec3d80f9808f6588a14089eb94b2c7c209a5d6a99467da5653f233', 'e2931ce69d2392696f4dccba48a9b92ab6ec1bae46b28682498b17a6ea713d900198c2357a001561', 0, '2023-03-16 13:00:50'),
('ebc3042f5450927f71b61f27752007122b8f1187771b9658bb40685ddf86597025b8831562c32507', '64d56ebd68c0f8ca2904d2d165752296d985de6ebf1978f3a29a318021974cbed010482829d0893e', 0, '2023-03-16 13:01:01'),
('f60fcd40f52b2f9c1f75e7df0d98dba11dc6f746a30a275fa1248aa4ec318b7b6b588586cb8d7503', 'db9597107d475e174348d21427adc276a4ed8466a52c2c78f00bea0462189462bf9eb141f82f3580', 0, '2023-04-05 15:16:26');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_details`
--

DROP TABLE IF EXISTS `payment_details`;
CREATE TABLE IF NOT EXISTS `payment_details` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `register_id` bigint(20) UNSIGNED NOT NULL DEFAULT '1',
  `group_id` bigint(20) UNSIGNED DEFAULT NULL,
  `amount` decimal(65,2) DEFAULT '0.00',
  `created_by_id` int(11) DEFAULT NULL,
  `payment_type_id` int(11) DEFAULT NULL,
  `transaction_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference` int(11) DEFAULT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `cheque_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `routing_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_types`
--

DROP TABLE IF EXISTS `payment_types`;
CREATE TABLE IF NOT EXISTS `payment_types` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `system_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_cash` tinyint(4) NOT NULL DEFAULT '0',
  `is_online` tinyint(4) NOT NULL DEFAULT '0',
  `is_system` tinyint(4) NOT NULL DEFAULT '0',
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `position` int(11) DEFAULT NULL,
  `options` text COLLATE utf8mb4_unicode_ci,
  `unique_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_types`
--

INSERT INTO `payment_types` (`id`, `name`, `system_name`, `description`, `is_cash`, `is_online`, `is_system`, `active`, `position`, `options`, `unique_id`, `created_at`, `updated_at`) VALUES
(1, 'CASH', 'CSH', 'Cash Payment', 1, 0, 0, 1, NULL, NULL, NULL, '2020-09-22 14:00:09', '2022-03-22 19:40:07'),
(2, 'CHEQUE', 'CHQ', 'Bankers Cheque', 0, 0, 0, 1, 1, NULL, NULL, '2020-10-19 07:57:26', '2022-03-22 19:39:33'),
(3, 'MPESA', 'MPS', 'Pay via Mpesa', 0, 1, 0, 1, NULL, NULL, NULL, '2020-12-04 13:27:45', '2022-03-22 19:38:57');

-- --------------------------------------------------------

--
-- Table structure for table `payroll`
--

DROP TABLE IF EXISTS `payroll`;
CREATE TABLE IF NOT EXISTS `payroll` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `currency_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payroll_template_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `employee_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comments` text COLLATE utf8mb4_unicode_ci,
  `work_duration` decimal(65,2) NOT NULL DEFAULT '0.00',
  `duration_unit` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount_per_duration` decimal(65,2) NOT NULL DEFAULT '0.00',
  `total_duration_amount` decimal(65,2) NOT NULL DEFAULT '0.00',
  `gross_amount` decimal(65,2) NOT NULL DEFAULT '0.00',
  `total_allowances` decimal(65,2) NOT NULL DEFAULT '0.00',
  `total_deductions` decimal(65,2) NOT NULL DEFAULT '0.00',
  `date` date DEFAULT NULL,
  `year` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `month` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recurring` tinyint(4) DEFAULT '0',
  `recur_frequency` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '31',
  `recur_start_date` date DEFAULT NULL,
  `recur_end_date` date DEFAULT NULL,
  `recur_next_date` date DEFAULT NULL,
  `recur_type` enum('day','week','month','year') COLLATE utf8mb4_unicode_ci DEFAULT 'month',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payroll_items`
--

DROP TABLE IF EXISTS `payroll_items`;
CREATE TABLE IF NOT EXISTS `payroll_items` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` enum('allowance','deduction') COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount_type` enum('fixed','percentage') COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(65,2) NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payroll_items`
--

INSERT INTO `payroll_items` (`id`, `name`, `type`, `amount_type`, `amount`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Basic Salary', 'allowance', 'fixed', '200.00', 'ff', '2020-10-27 16:19:42', '2020-10-27 16:21:43');

-- --------------------------------------------------------

--
-- Table structure for table `payroll_items_meta`
--

DROP TABLE IF EXISTS `payroll_items_meta`;
CREATE TABLE IF NOT EXISTS `payroll_items_meta` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `payroll_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payroll_item_id` bigint(20) UNSIGNED DEFAULT NULL,
  `percentage` decimal(65,2) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` enum('allowance','deduction') COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount_type` enum('fixed','percentage') COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(65,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payroll_items_meta`
--

INSERT INTO `payroll_items_meta` (`id`, `payroll_id`, `payroll_item_id`, `percentage`, `name`, `type`, `amount_type`, `amount`, `created_at`, `updated_at`) VALUES
(6, 2, 4, NULL, 'Basic Salary', 'allowance', 'fixed', '200.00', '2020-12-13 16:48:38', '2020-12-13 16:48:38'),
(7, 2, 5, NULL, 'payee', 'deduction', 'fixed', '10.00', '2020-12-13 16:48:39', '2020-12-13 16:48:39');

-- --------------------------------------------------------

--
-- Table structure for table `payroll_payments`
--

DROP TABLE IF EXISTS `payroll_payments`;
CREATE TABLE IF NOT EXISTS `payroll_payments` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payroll_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payment_type_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payment_detail_id` bigint(20) UNSIGNED DEFAULT NULL,
  `amount` decimal(65,2) NOT NULL,
  `submitted_on` date DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payroll_templates`
--

DROP TABLE IF EXISTS `payroll_templates`;
CREATE TABLE IF NOT EXISTS `payroll_templates` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `work_duration` decimal(65,2) NOT NULL DEFAULT '0.00',
  `duration_unit` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount_per_duration` decimal(65,2) NOT NULL DEFAULT '0.00',
  `total_duration_amount` decimal(65,2) NOT NULL DEFAULT '0.00',
  `picture` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `items` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payroll_templates`
--

INSERT INTO `payroll_templates` (`id`, `name`, `work_duration`, `duration_unit`, `amount_per_duration`, `total_duration_amount`, `picture`, `description`, `items`, `created_at`, `updated_at`) VALUES
(1, 'Default Template', '8.00', 'Day', '10.00', '80.00', NULL, 'test', NULL, '2020-11-23 06:56:09', '2020-12-13 16:24:29');

-- --------------------------------------------------------

--
-- Table structure for table `payroll_template_items`
--

DROP TABLE IF EXISTS `payroll_template_items`;
CREATE TABLE IF NOT EXISTS `payroll_template_items` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `payroll_template_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payroll_item_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payroll_template_items`
--

INSERT INTO `payroll_template_items` (`id`, `payroll_template_id`, `payroll_item_id`, `created_at`, `updated_at`) VALUES
(3, 1, 1, '2020-12-13 16:24:29', '2020-12-13 16:24:29');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `module` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=311 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `parent_id`, `name`, `display_name`, `module`, `description`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, NULL, 'setting.setting.index', 'View settings', 'Setting', NULL, 'web', '2020-09-02 06:59:29', '2020-09-02 06:59:29'),
(2, NULL, 'setting.setting.edit', 'Edit Settings', 'Setting', NULL, 'web', '2020-09-02 06:59:29', '2020-09-02 06:59:29'),
(3, NULL, 'core.payment_types.index', 'View Payment Types', 'Core', NULL, 'web', '2020-09-02 06:59:29', '2020-09-02 06:59:29'),
(4, NULL, 'core.payment_types.create', 'Create Payment Types', 'Core', NULL, 'web', '2020-09-02 06:59:29', '2020-09-02 06:59:29'),
(5, NULL, 'core.payment_types.edit', 'Edit Payment Types', 'Core', NULL, 'web', '2020-09-02 06:59:29', '2020-09-02 06:59:29'),
(6, NULL, 'core.payment_types.destroy', 'Delete Payment Types', 'Core', NULL, 'web', '2020-09-02 06:59:29', '2020-09-02 06:59:29'),
(7, NULL, 'core.currencies.index', 'View Payment Details', 'Core', NULL, 'web', '2020-09-02 06:59:29', '2020-09-02 06:59:29'),
(8, NULL, 'core.currencies.create', 'Create Currencies', 'Core', NULL, 'web', '2020-09-02 06:59:29', '2020-09-02 06:59:29'),
(9, NULL, 'core.currencies.edit', 'Edit Currencies', 'Core', NULL, 'web', '2020-09-02 06:59:29', '2020-09-02 06:59:29'),
(10, NULL, 'core.currencies.destroy', 'Delete Currencies', 'Core', NULL, 'web', '2020-09-02 06:59:29', '2020-09-02 06:59:29'),
(11, NULL, 'core.modules.index', 'View Modules', 'Core', NULL, 'web', '2020-09-02 06:59:29', '2020-09-02 06:59:29'),
(12, NULL, 'core.modules.create', 'Create Modules', 'Core', NULL, 'web', '2020-09-02 06:59:29', '2020-09-02 06:59:29'),
(13, NULL, 'core.modules.destroy', 'Delete Modules', 'Core', NULL, 'web', '2020-09-02 06:59:29', '2020-09-02 06:59:29'),
(14, NULL, 'core.menu.index', 'Manage Menu', 'Core', NULL, 'web', '2020-09-02 06:59:29', '2020-09-02 06:59:29'),
(15, NULL, 'core.payment_gateways.index', 'View Payment Gateway', 'Core', NULL, 'web', '2020-09-02 06:59:29', '2020-09-02 06:59:29'),
(16, NULL, 'core.payment_gateways.create', 'Create Payment Gateway', 'Core', NULL, 'web', '2020-09-02 06:59:29', '2020-09-02 06:59:29'),
(17, NULL, 'core.payment_gateways.edit', 'Edit Payment Gateway', 'Core', NULL, 'web', '2020-09-02 06:59:29', '2020-09-02 06:59:29'),
(18, NULL, 'core.payment_gateways.destroy', 'Delete Payment Gateway', 'Core', NULL, 'web', '2020-09-02 06:59:29', '2020-09-02 06:59:29'),
(19, NULL, 'user.users.index', 'View Users', 'User', NULL, 'web', '2020-09-02 06:59:29', '2020-09-02 06:59:29'),
(20, NULL, 'user.users.create', 'Create Users', 'User', NULL, 'web', '2020-09-02 06:59:29', '2020-09-02 06:59:29'),
(21, NULL, 'user.users.edit', 'Edit Users', 'User', NULL, 'web', '2020-09-02 06:59:29', '2020-09-02 06:59:29'),
(22, NULL, 'user.users.destroy', 'Delete Users', 'User', NULL, 'web', '2020-09-02 06:59:29', '2020-09-02 06:59:29'),
(23, NULL, 'user.roles.index', 'View Roles', 'User', NULL, 'web', '2020-09-02 06:59:29', '2020-09-02 06:59:29'),
(24, NULL, 'user.roles.create', 'Create Roles', 'User', NULL, 'web', '2020-09-02 06:59:29', '2020-09-02 06:59:29'),
(25, NULL, 'user.roles.edit', 'Edit Roles', 'User', NULL, 'web', '2020-09-02 06:59:29', '2020-09-02 06:59:29'),
(26, NULL, 'user.roles.destroy', 'Delete Roles', 'User', NULL, 'web', '2020-09-02 06:59:29', '2020-09-02 06:59:29'),
(27, NULL, 'dashboard.index', 'View Dashboard', 'Dashboard', NULL, 'web', '2020-09-02 06:59:29', '2020-09-02 06:59:29'),
(28, NULL, 'dashboard.edit', 'Edit Dashboard', 'Dashboard', NULL, 'web', '2020-09-02 06:59:29', '2020-09-02 06:59:29'),
(29, NULL, 'branch.branches.index', 'View Branches', 'Branch', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(30, NULL, 'branch.branches.create', 'Create Branches', 'Branch', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(31, NULL, 'branch.branches.edit', 'Edit Branches', 'Branch', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(32, NULL, 'branch.branches.destroy', 'Delete Branches', 'Branch', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(33, NULL, 'branch.branches.assign_user', 'Assign Users', 'Branch', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(34, NULL, 'accounting.chart_of_accounts.index', 'View Chart of accounts', 'Accounting', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(35, NULL, 'accounting.chart_of_accounts.create', 'Create Chart of accounts', 'Accounting', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(36, NULL, 'accounting.chart_of_accounts.edit', 'Edit Chart of accounts', 'Accounting', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(37, NULL, 'accounting.chart_of_accounts.destroy', 'Delete Chart of accounts', 'Accounting', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(38, NULL, 'accounting.journal_entries.index', 'View Journal Entries', 'Accounting', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(39, NULL, 'accounting.journal_entries.create', 'Create Journal Entries', 'Accounting', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(40, NULL, 'accounting.journal_entries.edit', 'Edit Journal Entries', 'Accounting', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(41, NULL, 'accounting.journal_entries.reverse', 'Reverse Journal Entries', 'Accounting', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(42, NULL, 'accounting.reports.balance_sheet', 'View Balance Sheet', 'Accounting', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(43, NULL, 'accounting.reports.trial_balance', 'View Trial Balance', 'Accounting', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(44, NULL, 'accounting.reports.income_statement', 'View Income Statement', 'Accounting', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(45, NULL, 'accounting.reports.ledger', 'View Ledger', 'Accounting', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(46, NULL, 'asset.assets.index', 'View Assets', 'Asset', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(47, NULL, 'asset.assets.create', 'Create Assets', 'Asset', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(48, NULL, 'asset.assets.edit', 'Edit Assets', 'Asset', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(49, NULL, 'asset.assets.destroy', 'Delete Assets', 'Asset', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(50, NULL, 'asset.assets.types.index', 'View Asset Types', 'Asset', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(51, NULL, 'asset.assets.types.create', 'Create Asset Types', 'Asset', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(52, NULL, 'asset.assets.types.edit', 'Edit Asset Types', 'Asset', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(53, NULL, 'asset.assets.types.destroy', 'Delete Asset Types', 'Asset', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(54, NULL, 'asset.assets.notes.index', 'View Asset Notes', 'Asset', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(55, NULL, 'asset.assets.notes.create', 'Create Asset Notes', 'Asset', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(56, NULL, 'asset.assets.notes.edit', 'Edit Asset Notes', 'Asset', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(57, NULL, 'asset.assets.notes.destroy', 'Delete Asset Notes', 'Asset', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(58, NULL, 'asset.assets.maintenance.index', 'View Asset Maintenance', 'Asset', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(59, NULL, 'asset.assets.maintenance.create', 'Create Asset Maintenance', 'Asset', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(60, NULL, 'asset.assets.maintenance.edit', 'Edit Asset Maintenance', 'Asset', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(61, NULL, 'asset.assets.maintenance.destroy', 'Delete Asset Maintenance', 'Asset', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(62, NULL, 'asset.assets.files.index', 'View Asset Files', 'Asset', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(63, NULL, 'asset.assets.files.create', 'Create Asset Files', 'Asset', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(64, NULL, 'asset.assets.files.edit', 'Edit Asset Files', 'Asset', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(65, NULL, 'asset.assets.files.destroy', 'Delete Asset Files', 'Asset', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(66, NULL, 'asset.assets.pictures.index', 'View Asset Pictures', 'Asset', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(67, NULL, 'asset.assets.pictures.create', 'Create Asset Pictures', 'Asset', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(68, NULL, 'asset.assets.pictures.edit', 'Edit Asset Pictures', 'Asset', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(69, NULL, 'asset.assets.pictures.destroy', 'Delete Asset Pictures', 'Asset', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(70, NULL, 'asset.assets.valuations.index', 'View Asset Valuations', 'Asset', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(71, NULL, 'asset.assets.valuations.create', 'Create Asset Valuations', 'Asset', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(72, NULL, 'asset.assets.valuations.edit', 'Edit Asset Valuations', 'Asset', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(73, NULL, 'asset.assets.valuations.destroy', 'Delete Asset Valuations', 'Asset', NULL, 'web', '2020-09-02 06:59:30', '2020-09-02 06:59:30'),
(74, NULL, 'client.clients.index', 'View Clients', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(75, NULL, 'client.clients.index_own', 'View Own Clients Only', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(76, NULL, 'client.clients.create', 'Create Clients', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(77, NULL, 'client.clients.edit', 'Edit Clients', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(78, NULL, 'client.clients.edit_own', 'Edit Own Clients', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(79, NULL, 'client.clients.activate', 'Activate Clients', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(80, NULL, 'client.clients.activate_own', 'Activate Own Clients', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(81, NULL, 'client.clients.destroy', 'Delete Clients', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(82, NULL, 'client.clients.destroy_own', 'Delete Own Clients', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(83, NULL, 'client.clients.user.create', 'Create Client Users', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(84, NULL, 'client.clients.user.destroy', 'Delete Client Users', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(85, NULL, 'client.clients.titles.index', 'View Titles', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(86, NULL, 'client.clients.titles.create', 'Create Titles', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(87, NULL, 'client.clients.titles.edit', 'Edit Titles', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(88, NULL, 'client.clients.titles.destroy', 'Delete Titles', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(89, NULL, 'client.clients.professions.index', 'View Professions', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(90, NULL, 'client.clients.professions.create', 'Create Professions', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(91, NULL, 'client.clients.professions.edit', 'Edit Professions', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(92, NULL, 'client.clients.professions.destroy', 'Delete Professions', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(93, NULL, 'client.clients.client_relationships.index', 'View Client Relationships', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(94, NULL, 'client.clients.client_relationships.create', 'Create Client Relationships', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(95, NULL, 'client.clients.client_relationships.edit', 'Edit Client Relationships', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(96, NULL, 'client.clients.client_relationships.destroy', 'Delete Client Relationships', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(97, NULL, 'client.clients.client_types.index', 'View Client Types', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(98, NULL, 'client.clients.client_types.create', 'Create Client Types', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(99, NULL, 'client.clients.client_types.edit', 'Edit Client Types', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(100, NULL, 'client.clients.client_types.destroy', 'Delete Client Types', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(101, NULL, 'client.clients.identification_types.index', 'View Identification Types', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(102, NULL, 'client.clients.identification_types.create', 'Create Identification Types', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(103, NULL, 'client.clients.identification_types.edit', 'Edit Identification Types', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(104, NULL, 'client.clients.identification_types.destroy', 'Delete Identification Types', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(105, NULL, 'client.clients.files.index', 'View Files', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(106, NULL, 'client.clients.files.create', 'Create Files', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(107, NULL, 'client.clients.files.edit', 'Edit Files', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(108, NULL, 'client.clients.files.destroy', 'Delete Files', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(109, NULL, 'client.clients.next_of_kin.index', 'View Next of kin', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(110, NULL, 'client.clients.next_of_kin.create', 'Create Next of kin', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(111, NULL, 'client.clients.next_of_kin.edit', 'Edit Next of kin', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(112, NULL, 'client.clients.next_of_kin.destroy', 'Delete Next of kins', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(113, NULL, 'client.clients.identification.index', 'View Identification', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(114, NULL, 'client.clients.identification.create', 'Create Identification', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(115, NULL, 'client.clients.identification.edit', 'Edit Identification', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(116, NULL, 'client.clients.identification.destroy', 'Delete Identification', 'Client', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(117, NULL, 'savings.savings.index', 'View Savings', 'Savings', NULL, 'web', '2020-09-02 06:59:31', '2020-09-02 06:59:31'),
(118, NULL, 'savings.savings.create', 'Create Savings', 'Savings', NULL, 'web', '2020-09-02 06:59:32', '2020-09-02 06:59:32'),
(119, NULL, 'savings.savings.edit', 'Edit Savings', 'Savings', NULL, 'web', '2020-09-02 06:59:32', '2020-09-02 06:59:32'),
(120, NULL, 'savings.savings.destroy', 'Delete Savings', 'Savings', NULL, 'web', '2020-09-02 06:59:32', '2020-09-02 06:59:32'),
(121, NULL, 'savings.savings.approve_savings', 'Approve/Reject Savings', 'Savings', NULL, 'web', '2020-09-02 06:59:32', '2020-09-02 06:59:32'),
(122, NULL, 'savings.savings.activate_savings', 'Activate Savings', 'Savings', NULL, 'web', '2020-09-02 06:59:32', '2020-09-02 06:59:32'),
(123, NULL, 'savings.savings.withdraw_savings', 'Withdraw Savings', 'Savings', NULL, 'web', '2020-09-02 06:59:32', '2020-09-02 06:59:32'),
(124, NULL, 'savings.savings.inactive_savings', 'Inactive Savings', 'Savings', NULL, 'web', '2020-09-02 06:59:32', '2020-09-02 06:59:32'),
(125, NULL, 'savings.savings.dormant_savings', 'Dormant Savings', 'Savings', NULL, 'web', '2020-09-02 06:59:32', '2020-09-02 06:59:32'),
(126, NULL, 'savings.savings.close_savings', 'Close Savings', 'Savings', NULL, 'web', '2020-09-02 06:59:32', '2020-09-02 06:59:32'),
(127, NULL, 'savings.savings.products.index', 'View savings Products', 'Savings', NULL, 'web', '2020-09-02 06:59:32', '2020-09-02 06:59:32'),
(128, NULL, 'savings.savings.products.create', 'Create savings Products', 'Savings', NULL, 'web', '2020-09-02 06:59:32', '2020-09-02 06:59:32'),
(129, NULL, 'savings.savings.products.edit', 'Edit savings Products', 'Savings', NULL, 'web', '2020-09-02 06:59:32', '2020-09-02 06:59:32'),
(130, NULL, 'savings.savings.products.destroy', 'Delete savings Products', 'Savings', NULL, 'web', '2020-09-02 06:59:32', '2020-09-02 06:59:32'),
(131, NULL, 'savings.savings.transactions.index', 'View Transactions', 'Savings', NULL, 'web', '2020-09-02 06:59:32', '2020-09-02 06:59:32'),
(132, NULL, 'savings.savings.transactions.create', 'Create Transactions', 'Savings', NULL, 'web', '2020-09-02 06:59:32', '2020-09-02 06:59:32'),
(133, NULL, 'savings.savings.transactions.edit', 'Edit Transactions', 'Savings', NULL, 'web', '2020-09-02 06:59:32', '2020-09-02 06:59:32'),
(134, NULL, 'savings.savings.transactions.destroy', 'Delete/Reverse Transactions', 'Savings', NULL, 'web', '2020-09-02 06:59:32', '2020-09-02 06:59:32'),
(135, NULL, 'savings.savings.charges.index', 'View Charges', 'Savings', NULL, 'web', '2020-09-02 06:59:32', '2020-09-02 06:59:32'),
(136, NULL, 'savings.savings.charges.create', 'Create Charges', 'Savings', NULL, 'web', '2020-09-02 06:59:32', '2020-09-02 06:59:32'),
(137, NULL, 'savings.savings.charges.edit', 'Edit Charges', 'Savings', NULL, 'web', '2020-09-02 06:59:32', '2020-09-02 06:59:32'),
(138, NULL, 'savings.savings.charges.destroy', 'Delete Charges', 'Savings', NULL, 'web', '2020-09-02 06:59:32', '2020-09-02 06:59:32'),
(139, NULL, 'savings.savings.reports.transactions', 'View Transactions Report', 'Savings', NULL, 'web', '2020-09-02 06:59:32', '2020-09-02 06:59:32'),
(140, NULL, 'savings.savings.reports.balances', 'View Balances Report', 'Savings', NULL, 'web', '2020-09-02 06:59:32', '2020-09-02 06:59:32'),
(141, NULL, 'savings.savings.reports.accounts', 'View Accounts Report', 'Savings', NULL, 'web', '2020-09-02 06:59:32', '2020-09-02 06:59:32'),
(142, NULL, 'reports.index', 'View Reports', 'Report', NULL, 'web', '2020-09-02 06:59:33', '2020-09-02 06:59:33'),
(143, NULL, 'loan.loans.index', 'View Loans', 'Loan', NULL, 'web', '2020-09-02 06:59:33', '2020-09-02 06:59:33'),
(144, NULL, 'loan.loans.create', 'Create Loans', 'Loan', NULL, 'web', '2020-09-02 06:59:33', '2020-09-02 06:59:33'),
(145, NULL, 'loan.loans.edit', 'Edit Loans', 'Loan', NULL, 'web', '2020-09-02 06:59:33', '2020-09-02 06:59:33'),
(146, NULL, 'loan.loans.destroy', 'Delete Loans', 'Loan', NULL, 'web', '2020-09-02 06:59:33', '2020-09-02 06:59:33'),
(147, NULL, 'loan.loans.approve_loan', 'Approve/Reject Loans', 'Loan', NULL, 'web', '2020-09-02 06:59:33', '2020-09-02 06:59:33'),
(148, NULL, 'loan.loans.disburse_loan', 'Disburse Loans', 'Loan', NULL, 'web', '2020-09-02 06:59:33', '2020-09-02 06:59:33'),
(149, NULL, 'loan.loans.withdraw_loan', 'Withdraw Loans', 'Loan', NULL, 'web', '2020-09-02 06:59:33', '2020-09-02 06:59:33'),
(150, NULL, 'loan.loans.write_off_loan', 'Write Off Loans', 'Loan', NULL, 'web', '2020-09-02 06:59:33', '2020-09-02 06:59:33'),
(151, NULL, 'loan.loans.reschedule_loan', 'Reschedule Loans', 'Loan', NULL, 'web', '2020-09-02 06:59:33', '2020-09-02 06:59:33'),
(152, NULL, 'loan.loans.close_loan', 'Close Loans', 'Loan', NULL, 'web', '2020-09-02 06:59:33', '2020-09-02 06:59:33'),
(153, NULL, 'loan.loans.calculator', 'Use Loan Calculator', 'Loan', NULL, 'web', '2020-09-02 06:59:33', '2020-09-02 06:59:33'),
(154, NULL, 'loan.loans.loan_history', 'View Loan History', 'Loan', NULL, 'web', '2020-09-02 06:59:33', '2020-09-02 06:59:33'),
(155, NULL, 'loan.loans.products.index', 'View Loan Products', 'Loan', NULL, 'web', '2020-09-02 06:59:33', '2020-09-02 06:59:33'),
(156, NULL, 'loan.loans.products.create', 'Create Loan Products', 'Loan', NULL, 'web', '2020-09-02 06:59:33', '2020-09-02 06:59:33'),
(157, NULL, 'loan.loans.products.edit', 'Edit Loan Products', 'Loan', NULL, 'web', '2020-09-02 06:59:33', '2020-09-02 06:59:33'),
(158, NULL, 'loan.loans.products.destroy', 'Delete Loan Products', 'Loan', NULL, 'web', '2020-09-02 06:59:33', '2020-09-02 06:59:33'),
(159, NULL, 'loan.loans.transactions.index', 'View Transactions', 'Loan', NULL, 'web', '2020-09-02 06:59:33', '2020-09-02 06:59:33'),
(160, NULL, 'loan.loans.transactions.create', 'Create Transactions', 'Loan', NULL, 'web', '2020-09-02 06:59:33', '2020-09-02 06:59:33'),
(161, NULL, 'loan.loans.transactions.edit', 'Edit Transactions', 'Loan', NULL, 'web', '2020-09-02 06:59:33', '2020-09-02 06:59:33'),
(162, NULL, 'loan.loans.transactions.destroy', 'Delete/Reverse Transactions', 'Loan', NULL, 'web', '2020-09-02 06:59:33', '2020-09-02 06:59:33'),
(163, NULL, 'loan.loans.charges.index', 'View Charges', 'Loan', NULL, 'web', '2020-09-02 06:59:33', '2020-09-02 06:59:33'),
(164, NULL, 'loan.loans.charges.create', 'Create Charges', 'Loan', NULL, 'web', '2020-09-02 06:59:33', '2020-09-02 06:59:33'),
(165, NULL, 'loan.loans.charges.edit', 'Edit Charges', 'Loan', NULL, 'web', '2020-09-02 06:59:33', '2020-09-02 06:59:33'),
(166, NULL, 'loan.loans.charges.destroy', 'Delete Charges', 'Loan', NULL, 'web', '2020-09-02 06:59:33', '2020-09-02 06:59:33'),
(167, NULL, 'loan.loans.funds.index', 'View Funds', 'Loan', NULL, 'web', '2020-09-02 06:59:33', '2020-09-02 06:59:33'),
(168, NULL, 'loan.loans.funds.create', 'Create Funds', 'Loan', NULL, 'web', '2020-09-02 06:59:33', '2020-09-02 06:59:33'),
(169, NULL, 'loan.loans.funds.edit', 'Edit Funds', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(170, NULL, 'loan.loans.funds.destroy', 'Delete Funds', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(171, NULL, 'loan.loans.credit_checks.index', 'View Credit Checks', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(172, NULL, 'loan.loans.credit_checks.create', 'Create Credit Checks', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(173, NULL, 'loan.loans.credit_checks.edit', 'Edit Credit Checks', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(174, NULL, 'loan.loans.credit_checks.destroy', 'Delete Credit Checks', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(175, NULL, 'loan.loans.collateral.index', 'View Collateral', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(176, NULL, 'loan.loans.collateral.create', 'Create Collateral', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(177, NULL, 'loan.loans.collateral.edit', 'Edit Collateral', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(178, NULL, 'loan.loans.collateral.destroy', 'Delete Collateral', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(179, NULL, 'loan.loans.collateral_types.index', 'View Collateral Types', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(180, NULL, 'loan.loans.collateral_types.create', 'Create Collateral Types', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(181, NULL, 'loan.loans.collateral_types.edit', 'Edit Collateral Types', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(182, NULL, 'loan.loans.collateral_types.destroy', 'Delete Collateral Types', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(183, NULL, 'loan.loans.purposes.index', 'View Purposes', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(184, NULL, 'loan.loans.purposes.create', 'Create Purposes', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(185, NULL, 'loan.loans.purposes.edit', 'Edit Purposes', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(186, NULL, 'loan.loans.purposes.destroy', 'Delete Purposes', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(187, NULL, 'loan.loans.files.index', 'View Files', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(188, NULL, 'loan.loans.files.create', 'Create Files', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(189, NULL, 'loan.loans.files.edit', 'Edit Files', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(190, NULL, 'loan.loans.files.destroy', 'Delete Files', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(191, NULL, 'loan.loans.guarantors.index', 'View Guarantors', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(192, NULL, 'loan.loans.guarantors.create', 'Create Guarantors', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(193, NULL, 'loan.loans.guarantors.edit', 'Edit Guarantors', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(194, NULL, 'loan.loans.guarantors.destroy', 'Delete Guarantors', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(195, NULL, 'loan.loans.notes.index', 'View Notes', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(196, NULL, 'loan.loans.notes.create', 'Create Notes', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(197, NULL, 'loan.loans.notes.edit', 'Edit Notes', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(198, NULL, 'loan.loans.notes.destroy', 'Delete Notes', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(199, NULL, 'loan.loans.reports.collection_sheet', 'View Collection Sheet Reports', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(200, NULL, 'loan.loans.reports.repayments', 'View Repayments Report', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(201, NULL, 'loan.loans.reports.expected_repayments', 'View Expected Repayments Report', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(202, NULL, 'loan.loans.reports.arrears', 'View Arrears Reports', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(203, NULL, 'loan.loans.reports.disbursements', 'View Disbursements Report', 'Loan', NULL, 'web', '2020-09-02 06:59:34', '2020-09-02 06:59:34'),
(204, NULL, 'communication.index', 'View Communication', 'Communication', NULL, 'web', '2020-09-02 06:59:35', '2020-09-02 06:59:35'),
(205, NULL, 'communication.campaigns.index', 'View Campaigns', 'Communication', NULL, 'web', '2020-09-02 06:59:35', '2020-09-02 06:59:35'),
(206, NULL, 'communication.campaigns.create', 'Create Campaigns', 'Communication', NULL, 'web', '2020-09-02 06:59:35', '2020-09-02 06:59:35'),
(207, NULL, 'communication.campaigns.edit', 'Edit Campaigns', 'Communication', NULL, 'web', '2020-09-02 06:59:35', '2020-09-02 06:59:35'),
(208, NULL, 'communication.campaigns.destroy', 'Delete Campaigns', 'Communication', NULL, 'web', '2020-09-02 06:59:35', '2020-09-02 06:59:35'),
(209, NULL, 'communication.logs.index', 'View Logs', 'Communication', NULL, 'web', '2020-09-02 06:59:35', '2020-09-02 06:59:35'),
(210, NULL, 'communication.logs.create', 'Create Logs', 'Communication', NULL, 'web', '2020-09-02 06:59:35', '2020-09-02 06:59:35'),
(211, NULL, 'communication.logs.edit', 'Edit Logs', 'Communication', NULL, 'web', '2020-09-02 06:59:35', '2020-09-02 06:59:35'),
(212, NULL, 'communication.logs.destroy', 'Delete Logs', 'Communication', NULL, 'web', '2020-09-02 06:59:35', '2020-09-02 06:59:35'),
(213, NULL, 'communication.sms_gateways.index', 'View SMS Gateways', 'Communication', NULL, 'web', '2020-09-02 06:59:35', '2020-09-02 06:59:35'),
(214, NULL, 'communication.sms_gateways.create', 'Create SMS Gateways', 'Communication', NULL, 'web', '2020-09-02 06:59:35', '2020-09-02 06:59:35'),
(215, NULL, 'communication.sms_gateways.edit', 'Edit SMS Gateways', 'Communication', NULL, 'web', '2020-09-02 06:59:35', '2020-09-02 06:59:35'),
(216, NULL, 'communication.sms_gateways.destroy', 'Delete SMS Gateways', 'Communication', NULL, 'web', '2020-09-02 06:59:35', '2020-09-02 06:59:35'),
(217, NULL, 'payroll.payroll.index', 'View Payroll', 'Payroll', NULL, 'web', '2020-09-02 06:59:37', '2020-09-02 06:59:37'),
(218, NULL, 'payroll.payroll.create', 'Create Payroll', 'Payroll', NULL, 'web', '2020-09-02 06:59:37', '2020-09-02 06:59:37'),
(219, NULL, 'payroll.payroll.edit', 'Edit Payroll', 'Payroll', NULL, 'web', '2020-09-02 06:59:37', '2020-09-02 06:59:37'),
(220, NULL, 'payroll.payroll.destroy', 'Delete Payroll', 'Payroll', NULL, 'web', '2020-09-02 06:59:37', '2020-09-02 06:59:37'),
(221, NULL, 'payroll.payroll.items.index', 'View Payroll Items', 'Payroll', NULL, 'web', '2020-09-02 06:59:37', '2020-09-02 06:59:37'),
(222, NULL, 'payroll.payroll.items.create', 'Create Payroll Items', 'Payroll', NULL, 'web', '2020-09-02 06:59:37', '2020-09-02 06:59:37'),
(223, NULL, 'payroll.payroll.items.edit', 'Edit Payroll Items', 'Payroll', NULL, 'web', '2020-09-02 06:59:38', '2020-09-02 06:59:38'),
(224, NULL, 'payroll.payroll.items.destroy', 'Delete Payroll Items', 'Payroll', NULL, 'web', '2020-09-02 06:59:38', '2020-09-02 06:59:38'),
(225, NULL, 'payroll.payroll.templates.index', 'View Templates', 'Payroll', NULL, 'web', '2020-09-02 06:59:38', '2020-09-02 06:59:38'),
(226, NULL, 'payroll.payroll.templates.create', 'Create Templates', 'Payroll', NULL, 'web', '2020-09-02 06:59:38', '2020-09-02 06:59:38'),
(227, NULL, 'payroll.payroll.templates.edit', 'Edit Templates', 'Payroll', NULL, 'web', '2020-09-02 06:59:38', '2020-09-02 06:59:38'),
(228, NULL, 'payroll.payroll.templates.destroy', 'Delete Templates', 'Payroll', NULL, 'web', '2020-09-02 06:59:38', '2020-09-02 06:59:38'),
(229, NULL, 'customfield.custom_fields.index', 'View Custom Fields', 'CustomField', NULL, 'web', '2020-09-02 06:59:38', '2020-09-02 06:59:38'),
(230, NULL, 'customfield.custom_fields.create', 'Create Custom Field', 'CustomField', NULL, 'web', '2020-09-02 06:59:38', '2020-09-02 06:59:38'),
(231, NULL, 'customfield.custom_fields.edit', 'Edit Custom Field', 'CustomField', NULL, 'web', '2020-09-02 06:59:38', '2020-09-02 06:59:38'),
(232, NULL, 'customfield.custom_fields.destroy', 'Delete Custom Field', 'CustomField', NULL, 'web', '2020-09-02 06:59:38', '2020-09-02 06:59:38'),
(233, NULL, 'expense.expenses.index', 'View Expenses', 'Expense', NULL, 'web', '2020-09-02 06:59:39', '2020-09-02 06:59:39'),
(234, NULL, 'expense.expenses.create', 'Create Expenses', 'Expense', NULL, 'web', '2020-09-02 06:59:39', '2020-09-02 06:59:39'),
(235, NULL, 'expense.expenses.edit', 'Edit Expenses', 'Expense', NULL, 'web', '2020-09-02 06:59:39', '2020-09-02 06:59:39'),
(236, NULL, 'expense.expenses.destroy', 'Delete Expenses', 'Expense', NULL, 'web', '2020-09-02 06:59:39', '2020-09-02 06:59:39'),
(237, NULL, 'expense.expenses.types.index', 'View Expense Types', 'Expense', NULL, 'web', '2020-09-02 06:59:39', '2020-09-02 06:59:39'),
(238, NULL, 'expense.expenses.types.create', 'Create Expense Types', 'Expense', NULL, 'web', '2020-09-02 06:59:39', '2020-09-02 06:59:39'),
(239, NULL, 'expense.expenses.types.edit', 'Edit Expense Types', 'Expense', NULL, 'web', '2020-09-02 06:59:39', '2020-09-02 06:59:39'),
(240, NULL, 'expense.expenses.types.destroy', 'Delete Expense Types', 'Expense', NULL, 'web', '2020-09-02 06:59:39', '2020-09-02 06:59:39'),
(241, NULL, 'expense.expenses.notes.index', 'View Expense Notes', 'Expense', NULL, 'web', '2020-09-02 06:59:39', '2020-09-02 06:59:39'),
(242, NULL, 'expense.expenses.notes.create', 'Create Expense Notes', 'Expense', NULL, 'web', '2020-09-02 06:59:39', '2020-09-02 06:59:39'),
(243, NULL, 'expense.expenses.notes.edit', 'Edit Expense Notes', 'Expense', NULL, 'web', '2020-09-02 06:59:39', '2020-09-02 06:59:39'),
(244, NULL, 'expense.expenses.notes.destroy', 'Delete Expense Notes', 'Expense', NULL, 'web', '2020-09-02 06:59:39', '2020-09-02 06:59:39'),
(245, NULL, 'income.income.index', 'View Income', 'Income', NULL, 'web', '2020-09-02 06:59:40', '2020-09-02 06:59:40'),
(246, NULL, 'income.income.create', 'Create Income', 'Income', NULL, 'web', '2020-09-02 06:59:40', '2020-09-02 06:59:40'),
(247, NULL, 'income.income.edit', 'Edit Income', 'Income', NULL, 'web', '2020-09-02 06:59:40', '2020-09-02 06:59:40'),
(248, NULL, 'income.income.destroy', 'Delete Income', 'Income', NULL, 'web', '2020-09-02 06:59:40', '2020-09-02 06:59:40'),
(249, NULL, 'income.income.types.index', 'View Income Types', 'Income', NULL, 'web', '2020-09-02 06:59:40', '2020-09-02 06:59:40'),
(250, NULL, 'income.income.types.create', 'Create Income Types', 'Income', NULL, 'web', '2020-09-02 06:59:40', '2020-09-02 06:59:40'),
(251, NULL, 'income.income.types.edit', 'Edit Income Types', 'Income', NULL, 'web', '2020-09-02 06:59:40', '2020-09-02 06:59:40'),
(252, NULL, 'income.income.types.destroy', 'Delete Income Types', 'Income', NULL, 'web', '2020-09-02 06:59:40', '2020-09-02 06:59:40'),
(253, NULL, 'income.income.notes.index', 'View Income Notes', 'Income', NULL, 'web', '2020-09-02 06:59:40', '2020-09-02 06:59:40'),
(254, NULL, 'income.income.notes.create', 'Create Income Notes', 'Income', NULL, 'web', '2020-09-02 06:59:40', '2020-09-02 06:59:40'),
(255, NULL, 'income.income.notes.edit', 'Edit Income Notes', 'Income', NULL, 'web', '2020-09-02 06:59:40', '2020-09-02 06:59:40'),
(256, NULL, 'income.income.notes.destroy', 'Delete Income Notes', 'Income', NULL, 'web', '2020-09-02 06:59:40', '2020-09-02 06:59:40'),
(257, NULL, 'upgrade.upgrades.index', 'View Upgrade Page', 'Upgrade', NULL, 'web', '2020-09-02 06:59:43', '2020-09-02 06:59:43'),
(258, NULL, 'upgrade.upgrades.manage', 'Manage Upgrades', 'Upgrade', NULL, 'web', '2020-09-02 06:59:43', '2020-09-02 06:59:43'),
(259, NULL, 'activitylog.activity_logs.index', 'View Activity Logs', 'Activitylog', NULL, 'web', '2020-09-02 06:59:44', '2020-09-02 06:59:44'),
(260, NULL, 'activitylog.activity_logs.destroy', 'Delete Activity Logs', 'Activitylog', NULL, 'web', '2020-09-02 06:59:44', '2020-09-02 06:59:44'),
(261, NULL, 'wallet.wallets.index', 'View Wallet', 'Wallet', NULL, 'web', '2020-09-02 06:59:45', '2020-09-02 06:59:45'),
(262, NULL, 'wallet.wallets.create', 'Create Wallet', 'Wallet', NULL, 'web', '2020-09-02 06:59:45', '2020-09-02 06:59:45'),
(263, NULL, 'wallet.wallets.edit', 'Edit Wallet', 'Wallet', NULL, 'web', '2020-09-02 06:59:45', '2020-09-02 06:59:45'),
(264, NULL, 'wallet.wallets.destroy', 'Delete Wallet', 'Wallet', NULL, 'web', '2020-09-02 06:59:45', '2020-09-02 06:59:45'),
(265, NULL, 'wallet.wallets.approve_wallets', 'Approve/Reject Wallet', 'Wallet', NULL, 'web', '2020-09-02 06:59:45', '2020-09-02 06:59:45'),
(266, NULL, 'wallet.wallets.activate_wallets', 'Activate Wallet', 'Wallet', NULL, 'web', '2020-09-02 06:59:45', '2020-09-02 06:59:45'),
(267, NULL, 'wallet.wallets.withdraw_wallets', 'Withdraw Wallet', 'Wallet', NULL, 'web', '2020-09-02 06:59:45', '2020-09-02 06:59:45'),
(268, NULL, 'wallet.wallets.inactive_wallets', 'Inactive Wallet', 'Wallet', NULL, 'web', '2020-09-02 06:59:45', '2020-09-02 06:59:45'),
(269, NULL, 'wallet.wallets.close_wallets', 'Close Wallet', 'Wallet', NULL, 'web', '2020-09-02 06:59:45', '2020-09-02 06:59:45'),
(270, NULL, 'wallet.wallets.transactions.index', 'View Transactions', 'Wallet', NULL, 'web', '2020-09-02 06:59:45', '2020-09-02 06:59:45'),
(271, NULL, 'wallet.wallets.transactions.create', 'Create Transactions', 'Wallet', NULL, 'web', '2020-09-02 06:59:45', '2020-09-02 06:59:45'),
(272, NULL, 'wallet.wallets.transactions.edit', 'Edit Transactions', 'Wallet', NULL, 'web', '2020-09-02 06:59:45', '2020-09-02 06:59:45'),
(273, NULL, 'wallet.wallets.transactions.destroy', 'Delete/Reverse Transactions', 'Wallet', NULL, 'web', '2020-09-02 06:59:45', '2020-09-02 06:59:45'),
(274, NULL, 'wallet.wallets.reports.transactions', 'View Transactions Report', 'Wallet', NULL, 'web', '2020-09-02 06:59:45', '2020-09-02 06:59:45'),
(275, NULL, 'wallet.wallets.reports.balances', 'View Balances Report', 'Wallet', NULL, 'web', '2020-09-02 06:59:45', '2020-09-02 06:59:45'),
(276, NULL, 'wallet.wallets.reports.accounts', 'View Accounts Report', 'Wallet', NULL, 'web', '2020-09-02 06:59:45', '2020-09-02 06:59:45'),
(277, NULL, 'share.shares.index', 'View Shares', 'Share', NULL, 'web', '2020-09-15 10:10:41', '2020-09-15 10:10:41'),
(278, NULL, 'share.shares.create', 'Create Shares', 'Share', NULL, 'web', '2020-09-15 10:10:41', '2020-09-15 10:10:41'),
(279, NULL, 'share.shares.edit', 'Edit Shares', 'Share', NULL, 'web', '2020-09-15 10:10:41', '2020-09-15 10:10:41'),
(280, NULL, 'share.shares.destroy', 'Delete Shares', 'Share', NULL, 'web', '2020-09-15 10:10:41', '2020-09-15 10:10:41'),
(281, NULL, 'share.shares.approve_shares', 'Approve Shares', 'Share', NULL, 'web', '2020-09-15 10:10:41', '2020-09-15 10:10:41'),
(282, NULL, 'share.shares.activate_shares', 'Activate Shares', 'Share', NULL, 'web', '2020-09-15 10:10:41', '2020-09-15 10:10:41'),
(283, NULL, 'share.shares.close_shares', 'Close Shares', 'Share', NULL, 'web', '2020-09-15 10:10:41', '2020-09-15 10:10:41'),
(284, NULL, 'share.shares.products.index', 'View Share Products', 'Share', NULL, 'web', '2020-09-15 10:10:41', '2020-09-15 10:10:41'),
(285, NULL, 'share.shares.products.create', 'Create Share Products', 'Share', NULL, 'web', '2020-09-15 10:10:41', '2020-09-15 10:10:41'),
(286, NULL, 'share.shares.products.edit', 'Edit Share Products', 'Share', NULL, 'web', '2020-09-15 10:10:41', '2020-09-15 10:10:41'),
(287, NULL, 'share.shares.products.destroy', 'Delete Share Products', 'Share', NULL, 'web', '2020-09-15 10:10:41', '2020-09-15 10:10:41'),
(288, NULL, 'share.shares.transactions.index', 'View Transactions', 'Share', NULL, 'web', '2020-09-15 10:10:41', '2020-09-15 10:10:41'),
(289, NULL, 'share.shares.transactions.create', 'Create Transactions', 'Share', NULL, 'web', '2020-09-15 10:10:41', '2020-09-15 10:10:41'),
(290, NULL, 'share.shares.transactions.edit', 'Edit Transactions', 'Share', NULL, 'web', '2020-09-15 10:10:41', '2020-09-15 10:10:41'),
(291, NULL, 'share.shares.transactions.destroy', 'Delete/Reverse Transactions', 'Share', NULL, 'web', '2020-09-15 10:10:42', '2020-09-15 10:10:42'),
(292, NULL, 'share.shares.notes.index', 'View Share Notes', 'Share', NULL, 'web', '2020-09-15 10:10:42', '2020-09-15 10:10:42'),
(293, NULL, 'share.shares.notes.create', 'Create Share Notes', 'Share', NULL, 'web', '2020-09-15 10:10:42', '2020-09-15 10:10:42'),
(294, NULL, 'share.shares.notes.edit', 'Edit Share Notes', 'Share', NULL, 'web', '2020-09-15 10:10:42', '2020-09-15 10:10:42'),
(295, NULL, 'share.shares.notes.destroy', 'Delete Share Notes', 'Share', NULL, 'web', '2020-09-15 10:10:42', '2020-09-15 10:10:42'),
(296, NULL, 'share.shares.charges.index', 'View Share Charges', 'Share', NULL, 'web', '2020-09-15 10:10:42', '2020-09-15 10:10:42'),
(297, NULL, 'share.shares.charges.create', 'Create Share Charges', 'Share', NULL, 'web', '2020-09-15 10:10:42', '2020-09-15 10:10:42'),
(298, NULL, 'share.shares.charges.edit', 'Edit Share Charges', 'Share', NULL, 'web', '2020-09-15 10:10:42', '2020-09-15 10:10:42'),
(299, NULL, 'share.shares.charges.destroy', 'Delete Share Charges', 'Share', NULL, 'web', '2020-09-15 10:10:42', '2020-09-15 10:10:42'),
(300, NULL, 'share.shares.files.index', 'View Share Files', 'Share', NULL, 'web', '2020-09-15 10:10:42', '2020-09-15 10:10:42'),
(301, NULL, 'share.shares.files.create', 'Create Share Files', 'Share', NULL, 'web', '2020-09-15 10:10:42', '2020-09-15 10:10:42'),
(302, NULL, 'share.shares.files.edit', 'Edit Share Files', 'Share', NULL, 'web', '2020-09-15 10:10:42', '2020-09-15 10:10:42'),
(303, NULL, 'share.shares.files.destroy', 'Delete Share Files', 'Share', NULL, 'web', '2020-09-15 10:10:42', '2020-09-15 10:10:42'),
(304, NULL, 'core.themes.index', 'Themes', 'Core', NULL, 'web', '2020-10-11 10:42:48', '2020-10-11 10:42:48'),
(305, NULL, 'user.reports.index', 'View Reports', 'User', NULL, 'web', '2021-01-15 11:25:37', '2021-01-15 11:25:37'),
(306, NULL, 'user.reports.performance', 'View Performance Reports', 'User', NULL, 'web', '2021-01-15 11:25:37', '2021-01-15 11:25:37'),
(307, NULL, 'client.clients.groups.create', 'Create Group', 'Client', NULL, 'web', '2022-03-12 12:08:21', '2022-03-12 12:08:21'),
(308, NULL, 'client.clients.groups.index', 'View Groups', 'Client', NULL, 'web', '2022-03-12 12:08:21', '2022-03-12 12:08:21'),
(309, NULL, 'client.clients.groups.edit', 'Edit Groups', 'Client', NULL, 'web', '2022-03-12 12:10:32', '2022-03-12 12:10:32'),
(310, NULL, 'client.clients.groups.destroy', 'Delete Groups', 'Client', NULL, 'web', '2022-03-12 12:11:10', '2022-03-12 12:11:10');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `professions`
--

DROP TABLE IF EXISTS `professions`;
CREATE TABLE IF NOT EXISTS `professions` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `professions`
--

INSERT INTO `professions` (`id`, `name`) VALUES
(1, 'Teacher'),
(2, 'Business Owner'),
(3, 'Farmer'),
(4, 'Transportation'),
(5, 'Boda Boda Rider'),
(6, 'Taxi Driver');

-- --------------------------------------------------------

--
-- Table structure for table `registers`
--

DROP TABLE IF EXISTS `registers`;
CREATE TABLE IF NOT EXISTS `registers` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `status` enum('active','closed','idle','disabled','reopened','approved') COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `approved` int(1) DEFAULT '0',
  `closed_by_user_id` bigint(20) DEFAULT NULL,
  `approved_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `approval_notes` text COLLATE utf8mb4_unicode_ci,
  `closing_notes` text COLLATE utf8mb4_unicode_ci,
  `opening_notes` text COLLATE utf8mb4_unicode_ci,
  `approval_time` datetime DEFAULT NULL,
  `closing_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `registers_user_id_foreign` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `register_notes`
--

DROP TABLE IF EXISTS `register_notes`;
CREATE TABLE IF NOT EXISTS `register_notes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `register_id` int(20) UNSIGNED NOT NULL,
  `action` enum('activated','closed','opened','approved','reopened','rejected','cancelled','deleted') NOT NULL,
  `notes` text,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `action_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `is_system` tinyint(4) NOT NULL DEFAULT '0',
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `is_system`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 1, 'admin', 'web', '2020-09-02 06:59:25', '2020-09-02 06:59:25'),
(2, 1, 'client', 'web', '2020-09-02 06:59:25', '2020-09-02 06:59:25'),
(3, 0, 'Test', 'web', '2020-10-18 09:54:43', '2020-10-18 09:54:43');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

DROP TABLE IF EXISTS `role_has_permissions`;
CREATE TABLE IF NOT EXISTS `role_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(34, 1),
(35, 1),
(36, 1),
(37, 1),
(38, 1),
(39, 1),
(40, 1),
(41, 1),
(42, 1),
(43, 1),
(44, 1),
(45, 1),
(46, 1),
(47, 1),
(48, 1),
(49, 1),
(50, 1),
(51, 1),
(52, 1),
(53, 1),
(54, 1),
(55, 1),
(56, 1),
(57, 1),
(58, 1),
(59, 1),
(60, 1),
(61, 1),
(62, 1),
(63, 1),
(64, 1),
(65, 1),
(66, 1),
(67, 1),
(68, 1),
(69, 1),
(70, 1),
(71, 1),
(72, 1),
(73, 1),
(74, 1),
(75, 1),
(76, 1),
(77, 1),
(78, 1),
(79, 1),
(80, 1),
(81, 1),
(82, 1),
(83, 1),
(84, 1),
(85, 1),
(86, 1),
(87, 1),
(88, 1),
(89, 1),
(90, 1),
(91, 1),
(92, 1),
(93, 1),
(94, 1),
(95, 1),
(96, 1),
(97, 1),
(98, 1),
(99, 1),
(100, 1),
(101, 1),
(102, 1),
(103, 1),
(104, 1),
(105, 1),
(106, 1),
(107, 1),
(108, 1),
(109, 1),
(110, 1),
(111, 1),
(112, 1),
(113, 1),
(114, 1),
(115, 1),
(116, 1),
(117, 1),
(118, 1),
(119, 1),
(120, 1),
(121, 1),
(122, 1),
(123, 1),
(124, 1),
(125, 1),
(126, 1),
(127, 1),
(128, 1),
(129, 1),
(130, 1),
(131, 1),
(132, 1),
(133, 1),
(134, 1),
(135, 1),
(136, 1),
(137, 1),
(138, 1),
(139, 1),
(140, 1),
(141, 1),
(142, 1),
(143, 1),
(144, 1),
(145, 1),
(146, 1),
(147, 1),
(148, 1),
(149, 1),
(150, 1),
(151, 1),
(152, 1),
(153, 1),
(154, 1),
(155, 1),
(156, 1),
(157, 1),
(158, 1),
(159, 1),
(160, 1),
(161, 1),
(162, 1),
(163, 1),
(164, 1),
(165, 1),
(166, 1),
(167, 1),
(168, 1),
(169, 1),
(170, 1),
(171, 1),
(172, 1),
(173, 1),
(174, 1),
(175, 1),
(176, 1),
(177, 1),
(178, 1),
(179, 1),
(180, 1),
(181, 1),
(182, 1),
(183, 1),
(184, 1),
(185, 1),
(186, 1),
(187, 1),
(188, 1),
(189, 1),
(190, 1),
(191, 1),
(192, 1),
(193, 1),
(194, 1),
(195, 1),
(196, 1),
(197, 1),
(198, 1),
(199, 1),
(200, 1),
(201, 1),
(202, 1),
(203, 1),
(204, 1),
(205, 1),
(206, 1),
(207, 1),
(208, 1),
(209, 1),
(210, 1),
(211, 1),
(212, 1),
(213, 1),
(214, 1),
(215, 1),
(216, 1),
(217, 1),
(218, 1),
(219, 1),
(220, 1),
(221, 1),
(222, 1),
(223, 1),
(224, 1),
(225, 1),
(226, 1),
(227, 1),
(228, 1),
(229, 1),
(230, 1),
(231, 1),
(232, 1),
(233, 1),
(234, 1),
(235, 1),
(236, 1),
(237, 1),
(238, 1),
(239, 1),
(240, 1),
(241, 1),
(242, 1),
(243, 1),
(244, 1),
(245, 1),
(246, 1),
(247, 1),
(248, 1),
(249, 1),
(250, 1),
(251, 1),
(252, 1),
(253, 1),
(254, 1),
(255, 1),
(256, 1),
(257, 1),
(258, 1),
(259, 1),
(260, 1),
(261, 1),
(262, 1),
(263, 1),
(264, 1),
(265, 1),
(266, 1),
(267, 1),
(268, 1),
(269, 1),
(270, 1),
(271, 1),
(272, 1),
(273, 1),
(274, 1),
(275, 1),
(276, 1),
(277, 1),
(278, 1),
(279, 1),
(280, 1),
(281, 1),
(282, 1),
(283, 1),
(284, 1),
(285, 1),
(286, 1),
(287, 1),
(288, 1),
(289, 1),
(290, 1),
(291, 1),
(292, 1),
(293, 1),
(294, 1),
(295, 1),
(296, 1),
(297, 1),
(298, 1),
(299, 1),
(300, 1),
(301, 1),
(302, 1),
(303, 1),
(304, 1),
(305, 1),
(306, 1),
(307, 1),
(308, 1),
(309, 1),
(310, 1),
(1, 3),
(2, 3),
(3, 3),
(4, 3),
(5, 3),
(6, 3),
(7, 3),
(8, 3),
(9, 3),
(10, 3),
(11, 3),
(12, 3),
(13, 3),
(14, 3),
(15, 3),
(16, 3),
(17, 3),
(18, 3),
(19, 3),
(20, 3),
(21, 3),
(22, 3),
(23, 3),
(24, 3),
(25, 3),
(26, 3),
(27, 3),
(28, 3),
(29, 3),
(30, 3),
(31, 3),
(32, 3),
(33, 3),
(34, 3),
(35, 3),
(36, 3),
(37, 3),
(38, 3),
(39, 3),
(40, 3),
(41, 3),
(42, 3),
(43, 3),
(44, 3),
(45, 3),
(46, 3),
(47, 3),
(48, 3),
(49, 3),
(50, 3),
(51, 3),
(52, 3),
(53, 3),
(54, 3),
(55, 3),
(56, 3),
(57, 3),
(58, 3),
(59, 3),
(60, 3),
(61, 3),
(62, 3),
(63, 3),
(64, 3),
(65, 3),
(66, 3),
(67, 3),
(68, 3),
(69, 3),
(70, 3),
(71, 3),
(72, 3),
(73, 3),
(74, 3),
(75, 3),
(76, 3),
(77, 3),
(78, 3),
(79, 3),
(80, 3),
(81, 3),
(82, 3),
(83, 3),
(84, 3),
(85, 3),
(86, 3),
(87, 3),
(88, 3),
(89, 3),
(90, 3),
(91, 3),
(92, 3),
(93, 3),
(94, 3),
(95, 3),
(96, 3),
(97, 3),
(98, 3),
(99, 3),
(100, 3),
(101, 3),
(102, 3),
(103, 3),
(104, 3),
(105, 3),
(106, 3),
(107, 3),
(108, 3),
(109, 3),
(110, 3),
(111, 3),
(112, 3),
(113, 3),
(114, 3),
(115, 3),
(116, 3),
(233, 3),
(234, 3),
(235, 3),
(236, 3),
(237, 3),
(238, 3),
(239, 3),
(240, 3),
(241, 3),
(242, 3),
(243, 3),
(244, 3),
(277, 3),
(278, 3),
(279, 3),
(280, 3),
(281, 3),
(282, 3),
(283, 3),
(284, 3),
(285, 3),
(286, 3),
(287, 3),
(288, 3),
(289, 3),
(290, 3),
(291, 3),
(292, 3),
(293, 3),
(294, 3),
(295, 3),
(296, 3),
(297, 3),
(298, 3),
(299, 3),
(300, 3),
(301, 3),
(302, 3),
(303, 3),
(304, 3);

-- --------------------------------------------------------

--
-- Table structure for table `savings`
--

DROP TABLE IF EXISTS `savings`;
CREATE TABLE IF NOT EXISTS `savings` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `currency_id` bigint(20) UNSIGNED NOT NULL,
  `savings_officer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `savings_product_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_type` enum('client','group') COLLATE utf8mb4_unicode_ci DEFAULT 'client',
  `client_id` bigint(20) UNSIGNED DEFAULT NULL,
  `group_id` bigint(20) UNSIGNED DEFAULT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `account_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `external_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `decimals` int(11) DEFAULT NULL,
  `interest_rate` decimal(65,6) NOT NULL,
  `interest_rate_type` enum('day','week','month','year') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'year',
  `compounding_period` enum('daily','weekly','monthly','biannual','annually') COLLATE utf8mb4_unicode_ci NOT NULL,
  `interest_posting_period_type` enum('daily','weekly','monthly','biannual','annually') COLLATE utf8mb4_unicode_ci NOT NULL,
  `interest_calculation_type` enum('daily_balance','average_daily_balance') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'daily_balance',
  `balance_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `total_deposits_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `total_withdrawals_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `total_interest_posted_derived` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `minimum_balance_for_interest_calculation` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `lockin_period` int(11) NOT NULL DEFAULT '0',
  `lockin_type` enum('days','weeks','months','years') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'days',
  `automatic_opening_balance` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `allow_overdraft` tinyint(4) NOT NULL DEFAULT '0',
  `overdraft_limit` decimal(65,6) DEFAULT NULL,
  `overdraft_interest_rate` decimal(65,6) DEFAULT NULL,
  `minimum_overdraft_for_interest` decimal(65,6) DEFAULT NULL,
  `submitted_on_date` date DEFAULT NULL,
  `submitted_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `approved_on_date` date DEFAULT NULL,
  `approved_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `approved_notes` text COLLATE utf8mb4_unicode_ci,
  `activated_on_date` date DEFAULT NULL,
  `activated_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `activated_notes` text COLLATE utf8mb4_unicode_ci,
  `rejected_on_date` date DEFAULT NULL,
  `rejected_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `rejected_notes` text COLLATE utf8mb4_unicode_ci,
  `dormant_on_date` date DEFAULT NULL,
  `dormant_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `dormant_notes` text COLLATE utf8mb4_unicode_ci,
  `closed_on_date` date DEFAULT NULL,
  `closed_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `closed_notes` text COLLATE utf8mb4_unicode_ci,
  `inactive_on_date` date DEFAULT NULL,
  `inactive_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `inactive_notes` text COLLATE utf8mb4_unicode_ci,
  `withdrawn_on_date` date DEFAULT NULL,
  `withdrawn_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `withdrawn_notes` text COLLATE utf8mb4_unicode_ci,
  `status` enum('pending','approved','active','withdrawn','rejected','closed','inactive','dormant','submitted') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'submitted',
  `start_interest_posting_date` date DEFAULT NULL,
  `next_interest_posting_date` date DEFAULT NULL,
  `start_interest_calculation_date` date DEFAULT NULL,
  `next_interest_calculation_date` date DEFAULT NULL,
  `last_interest_calculation_date` date DEFAULT NULL,
  `last_interest_posting_date` date DEFAULT NULL,
  `calculated_interest` decimal(65,6) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `register_id` bigint(20) UNSIGNED NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `savings_client_id_index` (`client_id`),
  KEY `savings_branch_id_index` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `savings_charges`
--

DROP TABLE IF EXISTS `savings_charges`;
CREATE TABLE IF NOT EXISTS `savings_charges` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `currency_id` bigint(20) UNSIGNED NOT NULL,
  `savings_charge_type_id` bigint(20) UNSIGNED NOT NULL,
  `savings_charge_option_id` bigint(20) UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(65,6) NOT NULL,
  `min_amount` decimal(65,6) DEFAULT NULL,
  `max_amount` decimal(65,6) DEFAULT NULL,
  `payment_mode` enum('regular','account_transfer') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'regular',
  `schedule` tinyint(4) NOT NULL DEFAULT '0',
  `schedule_frequency` int(11) DEFAULT NULL,
  `schedule_frequency_type` enum('days','weeks','months','years') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '0',
  `allow_override` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `savings_charges_currency_id_foreign` (`currency_id`),
  KEY `savings_charges_savings_charge_type_id_foreign` (`savings_charge_type_id`),
  KEY `savings_charges_savings_charge_option_id_foreign` (`savings_charge_option_id`),
  KEY `savings_charges_created_by_id_foreign` (`created_by_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `savings_charges`
--

INSERT INTO `savings_charges` (`id`, `created_by_id`, `currency_id`, `savings_charge_type_id`, `savings_charge_option_id`, `name`, `amount`, `min_amount`, `max_amount`, `payment_mode`, `schedule`, `schedule_frequency`, `schedule_frequency_type`, `active`, `allow_override`, `created_at`, `updated_at`) VALUES
(1, 1, 3, 1, 1, 'Activation', '100.000000', NULL, NULL, 'regular', 0, NULL, NULL, 1, 0, '2020-12-05 07:37:27', '2022-03-22 19:43:32'),
(2, 1, 3, 2, 3, 'Annual Charges', '1.000000', NULL, NULL, 'regular', 0, NULL, NULL, 1, 0, '2022-03-23 07:31:15', '2022-03-23 07:31:15');

-- --------------------------------------------------------

--
-- Table structure for table `savings_charge_options`
--

DROP TABLE IF EXISTS `savings_charge_options`;
CREATE TABLE IF NOT EXISTS `savings_charge_options` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `translated_name` text COLLATE utf8mb4_unicode_ci,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `savings_charge_options`
--

INSERT INTO `savings_charge_options` (`id`, `name`, `translated_name`, `active`) VALUES
(1, 'Flat', 'Flat', 1),
(2, 'Percentage of amount', 'Percentage of amount', 1),
(3, 'Percentage of savings balance', 'Percentage of savings balance', 1);

-- --------------------------------------------------------

--
-- Table structure for table `savings_charge_types`
--

DROP TABLE IF EXISTS `savings_charge_types`;
CREATE TABLE IF NOT EXISTS `savings_charge_types` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `translated_name` text COLLATE utf8mb4_unicode_ci,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `savings_charge_types`
--

INSERT INTO `savings_charge_types` (`id`, `name`, `translated_name`, `active`) VALUES
(1, 'Savings Activation', 'Savings Activation', 1),
(2, 'Specified Due Date', 'Specified Due Date', 1),
(3, 'Withdrawal Fee', 'Withdrawal Fee', 1),
(4, 'Annual Fee', 'Annual Fee', 1),
(5, 'Monthly Fee', 'Monthly Fee', 1),
(6, 'Inactivity Fee', 'Inactivity Fee', 1),
(7, 'Quarterly Fee', 'Quarterly Fee', 1);

-- --------------------------------------------------------

--
-- Table structure for table `savings_linked_charges`
--

DROP TABLE IF EXISTS `savings_linked_charges`;
CREATE TABLE IF NOT EXISTS `savings_linked_charges` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `currency_id` bigint(20) UNSIGNED DEFAULT NULL,
  `savings_id` bigint(20) UNSIGNED DEFAULT NULL,
  `savings_charge_id` bigint(20) UNSIGNED DEFAULT NULL,
  `savings_charge_type_id` bigint(20) UNSIGNED DEFAULT NULL,
  `savings_charge_option_id` bigint(20) UNSIGNED DEFAULT NULL,
  `savings_transaction_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` text COLLATE utf8mb4_unicode_ci,
  `amount` decimal(65,6) NOT NULL,
  `calculated_amount` decimal(65,6) DEFAULT NULL,
  `paid_amount` decimal(65,6) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '0',
  `waived` tinyint(4) NOT NULL DEFAULT '0',
  `is_paid` tinyint(4) NOT NULL DEFAULT '0',
  `submitted_on` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `savings_products`
--

DROP TABLE IF EXISTS `savings_products`;
CREATE TABLE IF NOT EXISTS `savings_products` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `currency_id` bigint(20) UNSIGNED NOT NULL,
  `savings_reference_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `overdraft_portfolio_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `savings_control_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `interest_on_savings_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `write_off_savings_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `income_from_fees_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `income_from_penalties_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `income_from_interest_overdraft_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_name` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `decimals` int(11) DEFAULT NULL,
  `savings_category` enum('voluntary','compulsory') COLLATE utf8mb4_unicode_ci NOT NULL,
  `auto_create` tinyint(4) NOT NULL DEFAULT '0',
  `minimum_interest_rate` decimal(65,6) NOT NULL,
  `default_interest_rate` decimal(65,6) NOT NULL,
  `maximum_interest_rate` decimal(65,6) NOT NULL,
  `interest_rate_type` enum('day','week','month','year') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'year',
  `compounding_period` enum('daily','weekly','monthly','biannual','annually') COLLATE utf8mb4_unicode_ci NOT NULL,
  `interest_posting_period_type` enum('daily','weekly','monthly','biannual','annually') COLLATE utf8mb4_unicode_ci NOT NULL,
  `interest_calculation_type` enum('daily_balance','average_daily_balance') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'daily_balance',
  `automatic_opening_balance` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `minimum_balance_for_interest_calculation` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `lockin_period` int(11) NOT NULL DEFAULT '0',
  `lockin_type` enum('days','weeks','months','years') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'days',
  `minimum_balance` decimal(65,6) NOT NULL DEFAULT '0.000000',
  `allow_overdraft` tinyint(4) NOT NULL DEFAULT '0',
  `overdraft_limit` decimal(65,6) DEFAULT NULL,
  `overdraft_interest_rate` decimal(65,6) DEFAULT NULL,
  `minimum_overdraft_for_interest` decimal(65,6) DEFAULT NULL,
  `days_in_year` enum('actual','360','365','364') COLLATE utf8mb4_unicode_ci DEFAULT '365',
  `days_in_month` enum('actual','30','31') COLLATE utf8mb4_unicode_ci DEFAULT '30',
  `accounting_rule` enum('none','cash') COLLATE utf8mb4_unicode_ci DEFAULT 'none',
  `active` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `savings_product_linked_charges`
--

DROP TABLE IF EXISTS `savings_product_linked_charges`;
CREATE TABLE IF NOT EXISTS `savings_product_linked_charges` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `savings_product_id` bigint(20) UNSIGNED NOT NULL,
  `savings_charge_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `savings_transactions`
--

DROP TABLE IF EXISTS `savings_transactions`;
CREATE TABLE IF NOT EXISTS `savings_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `savings_id` bigint(20) UNSIGNED NOT NULL,
  `register_id` bigint(20) UNSIGNED NOT NULL DEFAULT '1',
  `group_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `savings_linked_charge_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payment_detail_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` text COLLATE utf8mb4_unicode_ci,
  `amount` decimal(65,6) NOT NULL,
  `credit` decimal(65,6) DEFAULT NULL,
  `debit` decimal(65,6) DEFAULT NULL,
  `balance` decimal(65,6) DEFAULT NULL,
  `savings_transaction_type_id` bigint(20) UNSIGNED NOT NULL,
  `reversed` tinyint(4) NOT NULL DEFAULT '0',
  `reversible` tinyint(4) NOT NULL DEFAULT '0',
  `submitted_on` date DEFAULT NULL,
  `created_on` date DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `reference` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gateway_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_gateway_data` text COLLATE utf8mb4_unicode_ci,
  `online_transaction` tinyint(4) NOT NULL DEFAULT '0',
  `status` enum('pending','approved','declined') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `savings_transactions_savings_id_index` (`savings_id`),
  KEY `savings_transactions_branch_id_index` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `savings_transaction_types`
--

DROP TABLE IF EXISTS `savings_transaction_types`;
CREATE TABLE IF NOT EXISTS `savings_transaction_types` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `translated_name` text COLLATE utf8mb4_unicode_ci,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `savings_transaction_types`
--

INSERT INTO `savings_transaction_types` (`id`, `name`, `translated_name`, `active`) VALUES
(1, 'Deposit', 'Deposit', 1),
(2, 'Withdrawal', 'Withdrawal', 1),
(3, 'Dividend', 'Dividend', 1),
(4, 'Waive Interest', 'Waive Interest', 1),
(5, 'Guarantee', 'Guarantee', 1),
(6, 'Guarantee Restored', 'Guarantee Restored', 1),
(7, 'Loan Repayment', 'Loan Repayment', 1),
(8, 'Transfer', 'Transfer', 1),
(9, 'Waive Charges', 'Waive Charges', 1),
(10, 'Apply Charges', 'Apply Charges', 1),
(11, 'Apply Interest', 'Apply Interest', 1),
(12, 'Pay Charge', 'Pay Charge', 1);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
CREATE TABLE IF NOT EXISTS `settings` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `setting_key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `module` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `setting_value` text COLLATE utf8mb4_unicode_ci,
  `order` int(11) DEFAULT NULL,
  `category` enum('email','sms','general','system','update','other') COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('text','textarea','number','select','radio','date','select_db','radio_db','select_multiple','select_multiple_db','checkbox','checkbox_db','file','info') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'text',
  `options` text COLLATE utf8mb4_unicode_ci,
  `rules` text COLLATE utf8mb4_unicode_ci,
  `class` text COLLATE utf8mb4_unicode_ci,
  `required` tinyint(4) NOT NULL DEFAULT '0',
  `db_columns` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `info` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `displayed` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_setting_key_unique` (`setting_key`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `name`, `setting_key`, `module`, `setting_value`, `order`, `category`, `type`, `options`, `rules`, `class`, `required`, `db_columns`, `info`, `displayed`, `created_at`, `updated_at`) VALUES
(1, 'Company Name', 'core.company_name', 'Core', 'SACCO System', NULL, 'general', 'text', '', '', '', 1, '', NULL, 1, NULL, '2022-02-26 17:02:45'),
(2, 'Company Address', 'core.company_address', 'Core', 'Senteu Plaza, 6th Floor Suite 602\r\nGalana Road - Hurlingham', NULL, 'general', 'textarea', '', '', '', 0, '', NULL, 1, NULL, '2022-03-22 19:51:15'),
(3, 'Company Country', 'core.company_country', 'Core', '113', NULL, 'general', 'select_db', 'countries', '', 'select2', 0, 'id,name', NULL, 1, NULL, '2022-02-26 17:02:46'),
(4, 'Timezone', 'core.timezone', 'Core', '204', NULL, 'general', 'select_db', 'timezones', '', 'select2', 1, 'id,zone_name', NULL, 1, NULL, '2022-02-26 17:02:46'),
(5, 'System Version', 'core.system_version', 'Core', '3.0', NULL, 'update', 'info', '', '', '', 1, '', NULL, 1, NULL, NULL),
(6, 'Company Email', 'core.company_email', 'Core', 'hscott@bluchip.co.ke', NULL, 'general', 'text', '', '', '', 1, '', NULL, 1, NULL, '2022-02-26 17:02:46'),
(7, 'Company Logo', 'core.company_logo', 'Core', NULL, NULL, 'general', 'file', 'jpeg,jpg,bmp,png', 'nullable|file|mimes:jpeg,jpg,bmp,png', '', 0, '', NULL, 1, NULL, '2020-10-18 17:34:34'),
(8, 'Site Online', 'core.site_online', 'Core', 'yes', NULL, 'system', 'select', 'yes,no', '', '', 1, '', NULL, 1, NULL, NULL),
(9, 'Console Last Run', 'core.console_last_run', 'Core', NULL, NULL, 'system', 'info', '', '', '', 1, '', NULL, 1, NULL, '2021-01-15 15:28:29'),
(10, 'Update Url', 'core.update_url', 'Core', 'http://webstudio.co.zw/ulm/update', NULL, 'general', 'info', '', '', '', 1, '', NULL, 0, NULL, NULL),
(11, 'Auto Download Update', 'core.auto_download_update', 'Core', 'no', NULL, 'system', 'select', 'yes,no', '', '', 1, '', NULL, 1, NULL, NULL),
(12, 'Update last checked', 'core.update_last_checked', 'Core', NULL, NULL, 'system', 'info', '', '', '', 1, '', NULL, 1, NULL, '2021-01-15 15:28:29'),
(13, 'Extra Javascript', 'core.extra_javascript', 'Core', NULL, NULL, 'system', 'textarea', '', '', '', 0, '', NULL, 1, NULL, '2021-01-15 15:28:29'),
(14, 'Extra Styles', 'core.extra_styles', 'Core', NULL, NULL, 'system', 'textarea', '', '', '', 0, '', NULL, 1, NULL, '2021-01-15 15:28:29'),
(15, 'Demo Mode', 'core.demo_mode', 'Core', 'no', NULL, 'system', 'select', 'yes,no', '', '', 1, '', NULL, 1, NULL, NULL),
(16, 'Purchase Code', 'core.purchase_code', 'Core', NULL, NULL, 'system', 'text', '', '', '', 0, '', NULL, 1, NULL, '2021-01-15 15:28:29'),
(17, 'Registration Enabled', 'user.enable_registration', 'User', 'no', NULL, 'system', 'select', 'yes,no', NULL, '', 1, '', NULL, 1, NULL, NULL),
(18, 'Enable Google recaptcha', 'user.enable_google_recaptcha', 'User', 'no', NULL, 'system', 'select', 'yes,no', NULL, '', 1, '', NULL, 1, NULL, NULL),
(19, 'Google recaptcha site key', 'user.google_recaptcha_site_key', 'User', NULL, NULL, 'system', 'text', '', NULL, '', 0, '', NULL, 1, NULL, '2021-01-15 15:28:29'),
(20, 'Google recaptcha secret key', 'user.google_recaptcha_secret_key', 'User', NULL, NULL, 'system', 'text', '', NULL, '', 0, '', NULL, 1, NULL, '2021-01-15 15:28:29'),
(21, 'SMS Enabled', 'communication.sms_enabled', 'Communication', 'no', NULL, 'sms', 'select', 'yes,no', '', '', 1, '', NULL, 1, NULL, NULL),
(22, 'Active SMS Gateway', 'communication.active_sms_gateway', 'Communication', '1', NULL, 'sms', 'select_db', 'sms_gateways', '', 'select2', 0, 'id,name', NULL, 1, NULL, NULL),
(23, 'Active Theme', 'core.active_theme', 'Core', 'AdminLTE', NULL, 'system', 'text', '', '', '', 0, '', NULL, 0, NULL, '2020-12-19 02:37:11'),
(24, 'Status', 'mpesa.status', NULL, 'active', NULL, 'other', 'select', 'active,inactive', '', '', 1, '', NULL, 0, NULL, '2020-12-04 13:29:46'),
(25, 'Name', 'mpesa.gateway_name', NULL, 'Mpesa', NULL, 'other', 'text', '', '', '', 1, '', NULL, 0, NULL, NULL),
(26, 'Logo', 'mpesa.logo', NULL, NULL, NULL, 'other', 'file', '', '', '', 0, '', NULL, 0, NULL, '2020-12-04 13:29:46'),
(27, 'Consumer Key', 'mpesa.consumer_key', NULL, '5WgKtWpluUIpPUwuzHP4WdY6dACzQffY', NULL, 'other', 'text', '', '', '', 0, '', NULL, 0, NULL, '2020-12-04 13:29:46'),
(28, 'Consumer Secret', 'mpesa.consumer_secret', NULL, 'rNXAfVcoyFkil3He', NULL, 'other', 'text', '', '', '', 0, '', NULL, 0, NULL, '2020-12-04 13:29:46'),
(29, 'Passkey', 'mpesa.passkey', NULL, 'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919', NULL, 'other', 'text', '', '', '', 0, '', NULL, 0, NULL, '2020-12-04 14:13:27'),
(30, 'Business Shortcode', 'mpesa.business_shortcode', NULL, '174379', NULL, 'other', 'text', '', '', '', 0, '', NULL, 0, NULL, '2020-12-04 14:13:27'),
(31, 'Sandbox URl', 'mpesa.sandbox_url', NULL, 'https://sandbox.safaricom.co.ke', NULL, 'other', 'text', '', '', '', 0, '', NULL, 0, NULL, NULL),
(32, 'Live URl', 'mpesa.live_url', NULL, 'https://sandbox.safaricom.co.ke', NULL, 'other', 'text', '', '', '', 0, '', NULL, 0, NULL, NULL),
(33, 'Test Mode', 'mpesa.test_mode', NULL, 'yes', NULL, 'other', 'select', 'yes,no', '', '', 0, '', NULL, 0, NULL, NULL),
(34, 'Currency Code', 'mpesa.currency_code', NULL, 'USD', NULL, 'other', 'text', '', '', '', 1, '', NULL, 0, NULL, NULL),
(35, 'Savings Reference Prefix', 'savings.reference_prefix', 'Savings', NULL, NULL, 'system', 'text', '', '', '', 0, '', NULL, 1, NULL, '2021-01-15 15:28:29'),
(36, 'Savings Reference Format', 'savings.reference_format', 'Savings', 'Branch Product Sequence Number', NULL, 'system', 'select', 'YEAR/Sequence Number (SL/2014/001),YEAR/MONTH/Sequence Number (SL/2014/08/001),Sequence Number,Random Number,Branch Product Sequence Number', '', '', 1, '', NULL, 1, NULL, '2021-01-15 15:28:29'),
(37, 'Loan Reference Prefix', 'loan.reference_prefix', 'Loan', 'L', NULL, 'system', 'text', '', '', '', 0, '', NULL, 1, NULL, NULL),
(38, 'Loan Reference Format', 'loan.reference_format', 'Loan', 'YEAR/Sequence Number (SL/2014/001)', NULL, 'system', 'select', 'YEAR/Sequence Number (SL/2014/001),YEAR/MONTH/Sequence Number (SL/2014/08/001),Sequence Number,Random Number,Branch Product Sequence Number', '', '', 1, '', NULL, 1, NULL, NULL),
(39, 'Client Reference Prefix', 'client.reference_prefix', 'Client', 'CL', NULL, 'system', 'text', '', '', '', 0, '', NULL, 1, NULL, NULL),
(40, 'Client Reference Format', 'client.reference_format', 'Client', 'YEAR/Sequence Number (SL/2014/001)', NULL, 'system', 'select', 'YEAR/Sequence Number (SL/2014/001),YEAR/MONTH/Sequence Number (SL/2014/08/001),Sequence Number,Random Number,Branch Sequence Number', '', '', 1, '', NULL, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `shares`
--

DROP TABLE IF EXISTS `shares`;
CREATE TABLE IF NOT EXISTS `shares` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `currency_id` bigint(20) UNSIGNED NOT NULL,
  `share_officer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `share_product_id` bigint(20) UNSIGNED DEFAULT NULL,
  `savings_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_type` enum('client','group') COLLATE utf8mb4_unicode_ci DEFAULT 'client',
  `client_id` bigint(20) UNSIGNED DEFAULT NULL,
  `group_id` bigint(20) UNSIGNED DEFAULT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `account_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `external_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `decimals` int(11) DEFAULT NULL,
  `total_shares` int(11) DEFAULT NULL,
  `nominal_price` decimal(65,6) DEFAULT NULL,
  `minimum_active_period` int(11) DEFAULT NULL,
  `minimum_active_period_type` enum('days','weeks','months','years') COLLATE utf8mb4_unicode_ci DEFAULT 'days',
  `lockin_period` int(11) NOT NULL DEFAULT '0',
  `lockin_type` enum('days','weeks','months','years') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'days',
  `allow_dividends_for_inactive_clients` tinyint(4) NOT NULL DEFAULT '0',
  `submitted_on_date` date DEFAULT NULL,
  `application_date` date DEFAULT NULL,
  `submitted_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `approved_on_date` date DEFAULT NULL,
  `approved_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `approved_notes` text COLLATE utf8mb4_unicode_ci,
  `activated_on_date` date DEFAULT NULL,
  `activated_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `activated_notes` text COLLATE utf8mb4_unicode_ci,
  `rejected_on_date` date DEFAULT NULL,
  `rejected_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `rejected_notes` text COLLATE utf8mb4_unicode_ci,
  `dormant_on_date` date DEFAULT NULL,
  `dormant_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `dormant_notes` text COLLATE utf8mb4_unicode_ci,
  `closed_on_date` date DEFAULT NULL,
  `closed_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `closed_notes` text COLLATE utf8mb4_unicode_ci,
  `inactive_on_date` date DEFAULT NULL,
  `inactive_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `inactive_notes` text COLLATE utf8mb4_unicode_ci,
  `withdrawn_on_date` date DEFAULT NULL,
  `withdrawn_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `withdrawn_notes` text COLLATE utf8mb4_unicode_ci,
  `status` enum('pending','approved','active','withdrawn','rejected','closed','inactive','dormant','submitted') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'submitted',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shares_client_id_index` (`client_id`),
  KEY `shares_branch_id_index` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `share_charges`
--

DROP TABLE IF EXISTS `share_charges`;
CREATE TABLE IF NOT EXISTS `share_charges` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `currency_id` bigint(20) UNSIGNED NOT NULL,
  `share_charge_type_id` bigint(20) UNSIGNED NOT NULL,
  `share_charge_option_id` bigint(20) UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(65,6) NOT NULL,
  `min_amount` decimal(65,6) DEFAULT NULL,
  `max_amount` decimal(65,6) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '0',
  `allow_override` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `share_charge_options`
--

DROP TABLE IF EXISTS `share_charge_options`;
CREATE TABLE IF NOT EXISTS `share_charge_options` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `translated_name` text COLLATE utf8mb4_unicode_ci,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `share_charge_options`
--

INSERT INTO `share_charge_options` (`id`, `name`, `translated_name`, `active`, `created_at`, `updated_at`) VALUES
(1, 'Flat', 'Flat', 1, NULL, NULL),
(2, 'Percentage of amount', 'Percentage of amount', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `share_charge_types`
--

DROP TABLE IF EXISTS `share_charge_types`;
CREATE TABLE IF NOT EXISTS `share_charge_types` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `translated_name` text COLLATE utf8mb4_unicode_ci,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `share_charge_types`
--

INSERT INTO `share_charge_types` (`id`, `name`, `translated_name`, `active`, `created_at`, `updated_at`) VALUES
(1, 'Share Account Activation', 'Share Account Activation', 1, NULL, NULL),
(2, 'Share Purchase', 'Share Purchase', 1, NULL, NULL),
(3, 'Share Redeem', 'Share Redeem', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `share_linked_charges`
--

DROP TABLE IF EXISTS `share_linked_charges`;
CREATE TABLE IF NOT EXISTS `share_linked_charges` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `currency_id` bigint(20) UNSIGNED DEFAULT NULL,
  `share_id` bigint(20) UNSIGNED DEFAULT NULL,
  `share_charge_id` bigint(20) UNSIGNED DEFAULT NULL,
  `share_charge_type_id` bigint(20) UNSIGNED DEFAULT NULL,
  `share_charge_option_id` bigint(20) UNSIGNED DEFAULT NULL,
  `share_transaction_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` text COLLATE utf8mb4_unicode_ci,
  `amount` decimal(65,6) NOT NULL,
  `calculated_amount` decimal(65,6) DEFAULT NULL,
  `paid_amount` decimal(65,6) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '0',
  `waived` tinyint(4) NOT NULL DEFAULT '0',
  `is_paid` tinyint(4) NOT NULL DEFAULT '0',
  `submitted_on` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `share_market_periods`
--

DROP TABLE IF EXISTS `share_market_periods`;
CREATE TABLE IF NOT EXISTS `share_market_periods` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `share_product_id` bigint(20) UNSIGNED DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `nominal_price` decimal(65,6) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `share_products`
--

DROP TABLE IF EXISTS `share_products`;
CREATE TABLE IF NOT EXISTS `share_products` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `currency_id` bigint(20) UNSIGNED NOT NULL,
  `share_reference_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `share_suspense_control_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `equity_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `income_from_fees_chart_of_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_name` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `decimals` int(11) DEFAULT NULL,
  `total_shares` int(11) DEFAULT NULL,
  `shares_to_be_issued` int(11) DEFAULT NULL,
  `nominal_price` decimal(65,6) DEFAULT NULL,
  `capital_value` decimal(65,6) DEFAULT NULL,
  `minimum_shares_per_client` decimal(65,6) DEFAULT NULL,
  `default_shares_per_client` decimal(65,6) DEFAULT NULL,
  `maximum_shares_per_client` decimal(65,6) DEFAULT NULL,
  `minimum_active_period` int(11) DEFAULT NULL,
  `minimum_active_period_type` enum('days','weeks','months','years') COLLATE utf8mb4_unicode_ci DEFAULT 'days',
  `lockin_period` int(11) NOT NULL DEFAULT '0',
  `lockin_type` enum('days','weeks','months','years') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'days',
  `allow_dividends_for_inactive_clients` tinyint(4) NOT NULL DEFAULT '0',
  `accounting_rule` enum('none','cash') COLLATE utf8mb4_unicode_ci DEFAULT 'none',
  `active` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `share_product_linked_charges`
--

DROP TABLE IF EXISTS `share_product_linked_charges`;
CREATE TABLE IF NOT EXISTS `share_product_linked_charges` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `share_product_id` bigint(20) UNSIGNED NOT NULL,
  `share_charge_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `share_transactions`
--

DROP TABLE IF EXISTS `share_transactions`;
CREATE TABLE IF NOT EXISTS `share_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `share_id` bigint(20) UNSIGNED NOT NULL,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `share_linked_charge_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payment_detail_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` text COLLATE utf8mb4_unicode_ci,
  `amount` decimal(65,6) NOT NULL,
  `credit` decimal(65,6) DEFAULT NULL,
  `debit` decimal(65,6) DEFAULT NULL,
  `balance` decimal(65,6) DEFAULT NULL,
  `share_transaction_type_id` bigint(20) UNSIGNED NOT NULL,
  `reversed` tinyint(4) NOT NULL DEFAULT '0',
  `reversible` tinyint(4) NOT NULL DEFAULT '0',
  `submitted_on` date DEFAULT NULL,
  `created_on` date DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `reference` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gateway_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_gateway_data` text COLLATE utf8mb4_unicode_ci,
  `online_transaction` tinyint(4) NOT NULL DEFAULT '0',
  `status` enum('pending','approved','declined') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `charge_amount` decimal(10,0) DEFAULT NULL,
  `total_shares` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `share_transactions_share_id_index` (`share_id`),
  KEY `share_transactions_branch_id_index` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `share_transaction_types`
--

DROP TABLE IF EXISTS `share_transaction_types`;
CREATE TABLE IF NOT EXISTS `share_transaction_types` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `translated_name` text COLLATE utf8mb4_unicode_ci,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sms_gateways`
--

DROP TABLE IF EXISTS `sms_gateways`;
CREATE TABLE IF NOT EXISTS `sms_gateways` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` text COLLATE utf8mb4_unicode_ci,
  `to_name` text COLLATE utf8mb4_unicode_ci,
  `url` text COLLATE utf8mb4_unicode_ci,
  `msg_name` text COLLATE utf8mb4_unicode_ci,
  `active` tinyint(4) NOT NULL DEFAULT '0',
  `is_current` tinyint(4) NOT NULL DEFAULT '0',
  `http_api` tinyint(4) NOT NULL DEFAULT '1',
  `class_name` text COLLATE utf8mb4_unicode_ci,
  `key_one` text COLLATE utf8mb4_unicode_ci,
  `key_one_description` text COLLATE utf8mb4_unicode_ci,
  `key_two` text COLLATE utf8mb4_unicode_ci,
  `key_two_description` text COLLATE utf8mb4_unicode_ci,
  `key_three` text COLLATE utf8mb4_unicode_ci,
  `key_three_description` text COLLATE utf8mb4_unicode_ci,
  `key_four` text COLLATE utf8mb4_unicode_ci,
  `key_four_description` text COLLATE utf8mb4_unicode_ci,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sms_gateways_created_by_id_foreign` (`created_by_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sms_gateways`
--

INSERT INTO `sms_gateways` (`id`, `created_by_id`, `name`, `to_name`, `url`, `msg_name`, `active`, `is_current`, `http_api`, `class_name`, `key_one`, `key_one_description`, `key_two`, `key_two_description`, `key_three`, `key_three_description`, `key_four`, `key_four_description`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 'Route', 'number', 'https://api.rmlconnect.net/bulksms/bulksms?username=webz-web&amp;amp;amp;password=heroes20&amp;amp;amp;type=0&amp;amp;amp;dlr=1&amp;amp;amp;destination=263774175438&amp;amp;amp;source=webstudio&amp;amp;amp;message=test', 'msg', 1, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-10-22 12:16:41', '2020-12-14 10:13:30');

-- --------------------------------------------------------

--
-- Table structure for table `tax_rates`
--

DROP TABLE IF EXISTS `tax_rates`;
CREATE TABLE IF NOT EXISTS `tax_rates` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_unicode_ci,
  `code` text COLLATE utf8mb4_unicode_ci,
  `amount` decimal(65,2) DEFAULT NULL,
  `type` enum('fixed','percentage') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'percentage',
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `telescope_entries`
--

DROP TABLE IF EXISTS `telescope_entries`;
CREATE TABLE IF NOT EXISTS `telescope_entries` (
  `sequence` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `family_hash` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `should_display_on_index` tinyint(1) NOT NULL DEFAULT '1',
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`sequence`),
  UNIQUE KEY `telescope_entries_uuid_unique` (`uuid`),
  KEY `telescope_entries_batch_id_index` (`batch_id`),
  KEY `telescope_entries_type_should_display_on_index_index` (`type`,`should_display_on_index`),
  KEY `telescope_entries_family_hash_index` (`family_hash`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `telescope_entries`
--

INSERT INTO `telescope_entries` (`sequence`, `uuid`, `batch_id`, `family_hash`, `should_display_on_index`, `type`, `content`, `created_at`) VALUES
(1, '95cd2f0f-3dea-469d-9672-bce935e0eed8', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.setting.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(2, '95cd2f0f-49ae-40a4-bec9-04df4aedf45e', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.installer.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(3, '95cd2f0f-4a61-4cab-8800-9d2c03551b98', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.core.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(4, '95cd2f0f-4b14-4f02-ada5-7caef828005d', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.user.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(5, '95cd2f0f-4bcb-48d2-ae9d-19af8cf5eb4f', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.paynow.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(6, '95cd2f0f-4c8f-48ff-8bb3-6b5edbf77375', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.stripe.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(7, '95cd2f0f-4d86-4404-a26d-6bed9d81e4a5', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.dashboard.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(8, '95cd2f0f-4e76-41c5-992b-62f39767a9c9', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.branch.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(9, '95cd2f0f-4f8a-45a2-8bf0-b1b0a00401c3', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.accounting.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(10, '95cd2f0f-5046-449f-93b0-7ba93275ddae', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.asset.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(11, '95cd2f0f-5105-4901-9226-c2e22a6c28d3', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.client.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(12, '95cd2f0f-51db-4f82-aafe-2c20526d9020', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.savings.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(13, '95cd2f0f-529a-4e21-90e1-471116d0d934', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.report.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(14, '95cd2f0f-5482-4e7e-be3f-ce3c2e076b27', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.loan.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(15, '95cd2f0f-555b-48a2-9d92-09bef4b9418d', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.communication.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(16, '95cd2f0f-5639-43d1-828c-482ac5456b9b', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.portal.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(17, '95cd2f0f-56fe-42df-9909-f30fbfd21f78', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.api.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(18, '95cd2f0f-57c0-4dd8-9369-b43fefdc43c1', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.payroll.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(19, '95cd2f0f-5884-453b-9ed1-c8104d56e19e', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.expense.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(20, '95cd2f0f-594b-41af-a0f7-2da87977a0bb', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.customfield.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(21, '95cd2f0f-5a12-4802-a6b5-3f490f777de4', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.income.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(22, '95cd2f0f-5b05-4d96-b93c-ada5fd988e74', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.paypal.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(23, '95cd2f0f-5be7-47e4-abe2-4c735484dae1', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.upgrade.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(24, '95cd2f0f-5cc7-4d90-bfd8-9069391556d2', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.mpesa.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(25, '95cd2f0f-64dc-4493-9131-a5a3ddaf6a7e', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.flutterwave.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(26, '95cd2f0f-65b2-47f2-ba4d-5b2b82f8dc46', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.share.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(27, '95cd2f0f-6681-4963-96d7-0c5ad6ee6ff5', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.activitylog.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(28, '95cd2f0f-6771-4d16-a286-6fe86076f454', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.wallet.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(29, '95cd2f0f-7734-4c83-b894-342fecf2a37e', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'query', '{\"connection\":\"mysql\",\"bindings\":[],\"sql\":\"select * from `settings` where `setting_key` = \'core.active_theme\' limit 1\",\"time\":\"0.85\",\"slow\":false,\"file\":\"C:\\\\wamp64\\\\www\\\\loans\\\\Modules\\\\Core\\\\Providers\\\\CoreServiceProvider.php\",\"line\":95,\"hash\":\"4e4729a185999851f188b84505f034f1\",\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(30, '95cd2f0f-7e6d-4f4c-acac-505a87958a9f', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'query', '{\"connection\":\"mysql\",\"bindings\":[],\"sql\":\"select * from `settings` where `setting_key` = \'core.company_name\' limit 1\",\"time\":\"13.59\",\"slow\":false,\"file\":\"C:\\\\wamp64\\\\www\\\\loans\\\\Modules\\\\Core\\\\Providers\\\\CoreServiceProvider.php\",\"line\":31,\"hash\":\"4e4729a185999851f188b84505f034f1\",\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(31, '95cd2f0f-810d-4e4c-8f67-14e019de5320', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'query', '{\"connection\":\"mysql\",\"bindings\":[],\"sql\":\"select * from `settings` where `setting_key` = \'core.company_logo\' limit 1\",\"time\":\"0.72\",\"slow\":false,\"file\":\"C:\\\\wamp64\\\\www\\\\loans\\\\Modules\\\\Core\\\\Providers\\\\CoreServiceProvider.php\",\"line\":32,\"hash\":\"4e4729a185999851f188b84505f034f1\",\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(32, '95cd2f0f-823d-4b4e-8750-9a0f066b056a', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'query', '{\"connection\":\"mysql\",\"bindings\":[],\"sql\":\"select * from `settings` where `setting_key` = \'core.system_version\' limit 1\",\"time\":\"0.60\",\"slow\":false,\"file\":\"C:\\\\wamp64\\\\www\\\\loans\\\\Modules\\\\Core\\\\Providers\\\\CoreServiceProvider.php\",\"line\":33,\"hash\":\"4e4729a185999851f188b84505f034f1\",\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:03'),
(33, '95cd2f13-0033-4519-9fd5-1917e4b463e8', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.setting.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:06'),
(34, '95cd2f13-00ba-4629-b283-818ef8461d74', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.installer.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:06'),
(35, '95cd2f13-0213-446a-903f-3853f32d5b39', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.core.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:06'),
(36, '95cd2f13-0293-46ab-86fa-ed1d02c2f212', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.user.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:06'),
(37, '95cd2f13-0328-487a-a21a-fb7bd0cd0298', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.paynow.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:06'),
(38, '95cd2f13-03af-483e-8864-71cb8574ee98', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.stripe.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:06'),
(39, '95cd2f13-042e-48b7-b7ff-8c09537abcdf', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.dashboard.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:06'),
(40, '95cd2f13-04ea-40d7-a690-598e40c5aa04', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.branch.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:06'),
(41, '95cd2f13-0574-4361-a6b7-445a61842152', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.accounting.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:06'),
(42, '95cd2f13-05f4-4155-93b7-010009f6e31e', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.asset.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:06'),
(43, '95cd2f13-0673-49a6-a9e5-01eb3aa4582c', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.client.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:06'),
(44, '95cd2f13-06f2-42de-a823-460514d996f3', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.savings.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:06'),
(45, '95cd2f13-08f7-43ba-a673-4cd974b78931', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.report.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:06'),
(46, '95cd2f13-09e8-4d20-8679-1d576ad59286', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.loan.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:06'),
(47, '95cd2f13-0a9f-455d-acc1-092cff4e1c76', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.communication.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:06'),
(48, '95cd2f13-0b33-4764-adb4-65da4b79caf3', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.portal.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:06'),
(49, '95cd2f13-0baf-4f5b-949f-ed2b8d1f5d9f', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.api.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:06'),
(50, '95cd2f13-134e-4ff0-a78d-240bcef6982b', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.payroll.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:06'),
(51, '95cd2f13-1412-4e40-9209-b2780d00f192', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.expense.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:06'),
(52, '95cd2f13-14a1-4124-909a-2d2dd53e1040', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.customfield.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:06'),
(53, '95cd2f13-153d-43ee-99b9-1c08e17ea811', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.income.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:06'),
(54, '95cd2f13-15b6-409a-9941-1c304f82dda9', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.paypal.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:06'),
(55, '95cd2f13-162d-4876-bd9c-693852ef6e09', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.upgrade.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:06'),
(56, '95cd2f13-16a4-4523-84c7-20dbff9340dc', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.mpesa.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:06'),
(57, '95cd2f13-171a-4e6b-bef1-71586212704d', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.flutterwave.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:06'),
(58, '95cd2f13-1792-4c2f-86c0-db9eb5c48560', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.share.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:06'),
(59, '95cd2f13-180a-4fdd-adfe-dd74d0c9626c', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.activitylog.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:06'),
(60, '95cd2f13-1881-42bf-bffd-bdee6ba30b8c', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'event', '{\"name\":\"modules.wallet.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:06'),
(61, '95cd2f14-ab37-4cb4-bcaf-93cd279ed6fb', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'view', '{\"name\":\"errors::404\",\"path\":\"\\\\resources\\\\views\\/errors\\/404.blade.php\",\"data\":[\"exception\"],\"composers\":[{\"name\":\"Closure at C:\\\\wamp64\\\\www\\\\loans\\\\vendor\\\\barryvdh\\\\laravel-debugbar\\\\src\\\\LaravelDebugbar.php[211:216]\",\"type\":\"composer\"}],\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:07'),
(62, '95cd2f14-b46f-4944-b525-95f40f776720', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'debugbar', '{\"requestId\":\"X256f931adac34fceb5b2b372d5a980ce\",\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:07'),
(63, '95cd2f14-c295-463b-8b5f-9bda784ad769', '95cd2f14-c37a-4e09-bca9-521ce4f6b9fc', NULL, 1, 'request', '{\"ip_address\":\"::1\",\"uri\":\"\\/assets\\/plugins\\/moment\\/js\\/moment.min.js\",\"method\":\"GET\",\"controller_action\":null,\"middleware\":[],\"headers\":{\"host\":\"localhost\",\"connection\":\"keep-alive\",\"sec-ch-ua\":\"\\\" Not A;Brand\\\";v=\\\"99\\\", \\\"Chromium\\\";v=\\\"98\\\", \\\"Google Chrome\\\";v=\\\"98\\\"\",\"sec-ch-ua-mobile\":\"?0\",\"user-agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/98.0.4758.102 Safari\\/537.36\",\"sec-ch-ua-platform\":\"\\\"Windows\\\"\",\"accept\":\"*\\/*\",\"sec-fetch-site\":\"same-origin\",\"sec-fetch-mode\":\"no-cors\",\"sec-fetch-dest\":\"script\",\"referer\":\"http:\\/\\/localhost\\/loans\\/public\\/client\\/group\\/store\",\"accept-encoding\":\"gzip, deflate, br\",\"accept-language\":\"en-GB,en-US;q=0.9,en;q=0.8\",\"cookie\":\"PHPSESSID=jcggr2jnsjoconv1hepfnv0ojb; remember_web_59ba36addc2b2f9401580f014c7f58ea4e30989d=eyJpdiI6IkI1aDhDOTZHczhNbjBycEsrVDdLZmc9PSIsInZhbHVlIjoiUm5iTWdGcGZvbG9tM215czIzVGx6NHlhdkt6S21sd0FaSWxZWWtOQ2VDVUpLN3V1c21ubnQyaE1ZUUtVVStrYnpHWWVJTm9abWZzWGYyNnRuS0tudkkzY0k1bkVvQmV2ZUpYU3dJN3FMSTNpaHRvTjhsSmV3Tit4eDlNWEpTMmtPV3FFNHlWM1ppMXNQQ1JTb3dyZE1keFNscjJLeDREZG5aenNIVmtNL1lXWTBpcXNwNzZTNnpBbGErUnFuMnkvajVQa2pjejc0V3NDa0l3cGVzTGtuMUFORUdFS3JRT3F6b2lBWUZsZW5wdz0iLCJtYWMiOiI1NGMwZjExZDhkZDhjZDA3MTU0ZjQ3MTM0ZWRiMzkzMjY3NGRiMTRhMmRhM2VkZWU4YWVkY2Q2ODNjY2EyZDE2In0%3D; XSRF-TOKEN=eyJpdiI6IkNadDdYUE9NbWV1a25FMHErbVNDRHc9PSIsInZhbHVlIjoiY2hla1hIV1diaTBkeDR0ZWVFc3NVMTJnM2FkQ3J3UVNWNDIyMDdCOXBMaTQxSXFWa3U3OTBOOU1HN0k1Z0tZTVFXYXgwcnlRVDBPNyt2L3RHbllxNHpMQXJCVko5VkFveU5lQzQyWkxNUk9oVW1sQ1ozL3Q1N0xJZTVtZkpFSFYiLCJtYWMiOiI0MmZlMmIxMjE3ZGZhMjM3ZTEyYTA1YjU0YjljZjM0Y2JlNDFlMjc2OGU0MTdjYTIyMzE5ZmJlNDE5ODZmMzgxIn0%3D; bluchip_sacco_system_session=eyJpdiI6InhDTHhyY1RURDlXUE9yT21SeHlHY1E9PSIsInZhbHVlIjoiTFBVVENwUjR5TU8vWmEwa3dPN3ZFOVpHZE1SWERZcmtINnNyOFgydDF2SnRVTUIzTlp1RFNvV3dDYk8raGxmSlJkMUtjZXlYQXI3R1FkNGUvdzFVL0dSWlBBR281L3M3KzY1VUF0YlNwckxYTCtpUHI4N1VNQ09nRlRScUpNMmciLCJtYWMiOiJlMjMyZDYzMGRjNTc2ZjUyZjgzYjdkYThjODU1NDUxN2JlM2I1N2QzYjBmN2MwZTRlY2YyOTc2YjFjMzUyOWJmIn0%3D\"},\"payload\":[],\"session\":[],\"response_status\":404,\"response\":\"HTML Response\",\"duration\":5037,\"memory\":4,\"hostname\":\"DESKTOP-DK77JF1\"}', '2022-03-12 13:35:07'),
(64, '966bdf0f-a579-4cb1-9f07-0fe9f4ca09ff', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.installer.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(65, '966bdf0f-bd2f-4392-b156-796e91fb3a7c', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.setting.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(66, '966bdf0f-bdad-4a8d-be14-9b1858727fb8', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.events.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(67, '966bdf0f-be0e-4655-99d7-20a4649c2f62', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.core.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(68, '966bdf0f-bea6-4f17-91ef-45f7da762deb', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.user.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(69, '966bdf0f-bf24-4368-b401-1c14ec634ad0', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.paynow.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(70, '966bdf0f-bf90-4af3-9d5a-5d00d2f396ad', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.stripe.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(71, '966bdf0f-bffc-4b2c-a1e4-ad858c9de9eb', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.dashboard.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(72, '966bdf0f-c068-4bd3-879b-2eb4e637e748', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.branch.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(73, '966bdf0f-c0d8-447e-97f6-eb72e1b5f1ef', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.accounting.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(74, '966bdf0f-c146-4986-b3ec-7f8502e3e9b3', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.asset.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(75, '966bdf0f-c1b4-4b07-904d-a423000fa41b', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.client.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(76, '966bdf0f-c232-40c9-97fe-af1669dc687a', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.savings.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(77, '966bdf0f-c2b0-4a16-acd7-9cae432f6256', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.loan.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(78, '966bdf0f-c321-4eb2-83c6-df84dd210cbc', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.report.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(79, '966bdf0f-c396-44dc-85e3-bdf6a18d959c', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.communication.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(80, '966bdf0f-c40d-4a2d-b9dd-17fc93bdb802', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.portal.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(81, '966bdf0f-c47f-4690-bf36-4a738691e3c4', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.api.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(82, '966bdf0f-c511-4305-a004-f4d0e1cf5afa', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.payroll.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(83, '966bdf0f-c58f-48b1-8de4-ebac5d0305c3', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.customfield.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(84, '966bdf0f-c604-4ea3-9d09-aa20094804f0', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.expense.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(85, '966bdf0f-c678-49a8-a316-a259c0dafb3f', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.income.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(86, '966bdf0f-c6ed-48a9-93f8-cd41b69ea183', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.paypal.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(87, '966bdf0f-c763-408a-bc0f-1cffa0e27620', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.upgrade.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(88, '966bdf0f-c7e3-40e5-abc7-9f0cf6324a21', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.mpesa.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(89, '966bdf0f-c85b-4199-a630-ce29b601387f', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.flutterwave.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(90, '966bdf0f-c8d6-43e6-b280-01baf90b274a', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.share.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(91, '966bdf0f-c94e-4f86-9511-8baa9499e695', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.activitylog.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(92, '966bdf0f-c9dc-4d64-91a6-8ba7dcf313df', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.wallet.register\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(93, '966bdf0f-e4be-4e19-b78a-e08664a3d529', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'query', '{\"connection\":\"mysql\",\"bindings\":[],\"sql\":\"select * from `settings` where `setting_key` = \'core.active_theme\' limit 1\",\"time\":\"0.69\",\"slow\":false,\"file\":\"C:\\\\wamp64\\\\www\\\\loans\\\\Modules\\\\Core\\\\Providers\\\\CoreServiceProvider.php\",\"line\":95,\"hash\":\"4e4729a185999851f188b84505f034f1\",\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(94, '966bdf0f-e5e4-41b4-a964-423f2848041e', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'query', '{\"connection\":\"mysql\",\"bindings\":[],\"sql\":\"select * from `settings` where `setting_key` = \'core.company_name\' limit 1\",\"time\":\"0.56\",\"slow\":false,\"file\":\"C:\\\\wamp64\\\\www\\\\loans\\\\Modules\\\\Core\\\\Providers\\\\CoreServiceProvider.php\",\"line\":31,\"hash\":\"4e4729a185999851f188b84505f034f1\",\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(95, '966bdf0f-e7b6-40bb-aa86-79e9fca13ab9', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'query', '{\"connection\":\"mysql\",\"bindings\":[],\"sql\":\"select * from `settings` where `setting_key` = \'core.company_logo\' limit 1\",\"time\":\"0.66\",\"slow\":false,\"file\":\"C:\\\\wamp64\\\\www\\\\loans\\\\Modules\\\\Core\\\\Providers\\\\CoreServiceProvider.php\",\"line\":32,\"hash\":\"4e4729a185999851f188b84505f034f1\",\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(96, '966bdf0f-e877-4b47-a139-71a6bbd41372', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'query', '{\"connection\":\"mysql\",\"bindings\":[],\"sql\":\"select * from `settings` where `setting_key` = \'core.system_version\' limit 1\",\"time\":\"0.51\",\"slow\":false,\"file\":\"C:\\\\wamp64\\\\www\\\\loans\\\\Modules\\\\Core\\\\Providers\\\\CoreServiceProvider.php\",\"line\":33,\"hash\":\"4e4729a185999851f188b84505f034f1\",\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:00'),
(97, '966bdf11-3a4b-4464-b813-cbcd16ba9b4c', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.installer.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:01'),
(98, '966bdf11-3a9d-42d7-9b1c-26d9c737c542', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.setting.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:01'),
(99, '966bdf11-3af2-4a45-ac6f-b7c00af3dc80', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.events.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:01'),
(100, '966bdf11-3b3b-4417-a981-c95e1c908cd6', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.core.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:01'),
(101, '966bdf11-3b86-4000-9216-e0876b6c4492', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.user.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:01'),
(102, '966bdf11-3bc9-4ab6-8504-0c9c2a01d724', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.paynow.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:01'),
(103, '966bdf11-3c0f-479d-b779-50343942a5ad', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.stripe.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:01'),
(104, '966bdf11-3c54-4555-9b37-ca2563729c84', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.dashboard.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:01'),
(105, '966bdf11-3c97-40c6-954f-84413c86f3dc', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.branch.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:01'),
(106, '966bdf11-3cdd-457d-83eb-e84da65af8e5', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.accounting.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:01'),
(107, '966bdf11-3d23-40fd-8080-aecef2d157a1', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.asset.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:01'),
(108, '966bdf11-3d66-4b9f-b563-7cbd375e37ab', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.client.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:01'),
(109, '966bdf11-3dab-4949-9c7a-87e373c6528f', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.savings.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:01'),
(110, '966bdf11-3df1-40e9-bda6-c5162773b49f', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.loan.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:01'),
(111, '966bdf11-3e34-46bc-9683-02e441c6b5eb', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.report.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:01'),
(112, '966bdf11-3ea8-46ce-bbbe-3e22716f65a8', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.communication.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:01'),
(113, '966bdf11-3f41-4847-bb1e-422e7d8bfe02', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.portal.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:01'),
(114, '966bdf11-3f90-4929-bb28-511c79e1de7f', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.api.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:01'),
(115, '966bdf11-3fd6-4aa2-a06e-91208c79f5e1', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.payroll.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:01'),
(116, '966bdf11-4019-4b84-a296-92162e7c9237', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.customfield.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:01'),
(117, '966bdf11-405f-4e70-a9f7-0d6b21b6f2e9', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.expense.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:01'),
(118, '966bdf11-40a4-4a02-ba33-7e2c569e3eb0', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.income.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:01'),
(119, '966bdf11-40e8-460a-b7fc-fa8c14b3bd2b', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.paypal.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:01'),
(120, '966bdf11-412f-48f9-9a4a-ba16ab7be952', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.upgrade.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:01'),
(121, '966bdf11-4179-42c8-85ce-8cca0dbe8daa', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.mpesa.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:01'),
(122, '966bdf11-41c6-443e-b256-a0edd9dea246', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.flutterwave.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:01'),
(123, '966bdf11-420b-40eb-ae97-fe6a58d4df6f', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.share.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:01'),
(124, '966bdf11-4253-4f4a-baf8-ccc463436497', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.activitylog.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:01'),
(125, '966bdf11-4298-4580-9992-eac9b65bb45b', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'event', '{\"name\":\"modules.wallet.boot\",\"payload\":[{\"class\":\"Nwidart\\\\Modules\\\\Laravel\\\\Module\",\"properties\":[]}],\"listeners\":[],\"broadcast\":false,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:01'),
(126, '966bdf11-d022-4289-852c-3243f68dea9f', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'debugbar', '{\"requestId\":\"X5096384f5c037ba22475f726c5b8f908\",\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:01'),
(127, '966bdf11-d155-4cc4-b73f-ebd5438bc0f6', '966bdf11-d2d0-4b83-ba6b-f75dbad6e426', NULL, 1, 'request', '{\"ip_address\":\"::1\",\"uri\":\"\\/accounting\\/chart_of_account\\/create\",\"method\":\"GET\",\"controller_action\":\"Modules\\\\Accounting\\\\Http\\\\Controllers\\\\ChartOfAccountController@create\",\"middleware\":[\"web\",\"auth\",\"2fa\",\"permission:accounting.chart_of_accounts.create\"],\"headers\":{\"host\":\"localhost\",\"connection\":\"keep-alive\",\"cache-control\":\"max-age=0\",\"upgrade-insecure-requests\":\"1\",\"user-agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/101.0.4951.67 Safari\\/537.36\",\"accept\":\"text\\/html,application\\/xhtml+xml,application\\/xml;q=0.9,image\\/avif,image\\/webp,image\\/apng,*\\/*;q=0.8,application\\/signed-exchange;v=b3;q=0.9\",\"sec-fetch-site\":\"same-origin\",\"sec-fetch-mode\":\"navigate\",\"sec-fetch-user\":\"?1\",\"sec-fetch-dest\":\"document\",\"sec-ch-ua\":\"\\\" Not A;Brand\\\";v=\\\"99\\\", \\\"Chromium\\\";v=\\\"101\\\", \\\"Google Chrome\\\";v=\\\"101\\\"\",\"sec-ch-ua-mobile\":\"?0\",\"sec-ch-ua-platform\":\"\\\"Windows\\\"\",\"referer\":\"http:\\/\\/localhost\\/loans\\/public\\/accounting\\/chart_of_account\\/create\",\"accept-encoding\":\"gzip, deflate, br\",\"accept-language\":\"en-US,en;q=0.9\",\"cookie\":\"auth.strategy=laravelPassportPassword; auth._refresh_token.laravelPassportPassword=def50200c7993b7f3db5a34a2f397a759a8da9b87a347cb1ffa5af6c82941d57f947ae412a85eacc26d3a3718b5fa2b2ffc921fc56198eee91d8c3b0004acb7b9a351e2674396f62ec1bea4651f3221ecc892d8e513b5e78aad73df172674a5944c5c686fc7a50303b77c57dedb286b3e055f37a0f2aba706e6e3175806617bea7d4563e9001af68aac54b8d457651d83d927375cf5d5d9af3595b2a4b77aaa00959e33757a3b4c158531644082f3ea16498b7b5433f22f2d1c496fd5631ddd068bf8024adb58ac7a486c4e01b56f2017343295f0b79aaf0d5b4f624354ee15147667262b085930139585a607bf63e19c59f96b690416362d7054518acec2386a475420c8562689143c34562a9d748a76ecd1324932254718f3c4d105a7acca8b6fedf198b82fae6338cc8dcaac36476a61669be3205e72e905c6acc7d91e547eb5f40c07dc09277f879b0ed0d1e58f527f0128bd1e30b1ff5eed1cbca01ef01f3; auth._refresh_token_expiration.laravelPassportPassword=1655754347385; auth._token.laravelPassportPassword=Bearer%20eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiMDI4OWNkMzgwMjQ3ZjUyOTYxYzdhYWRkMDBkY2E1MmZkZDhjNzFmYjY4ZTg3ZjZiZjYwOTJkYTA3Y2Y4N2Y3YTA3MmMxZDVjNTQ4YTlmODMiLCJpYXQiOjE2NTMxNjIzNDcsIm5iZiI6MTY1MzE2MjM0NywiZXhwIjoxNjg0Njk4MzQ3LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.UnfNEgqspT7W8bDvl7aYMj16DtagQgIUFlVYUqsZ5Gn2TilLNbZK1sz5PjlIWrUdzseldkgFU9aVRm6iy-Eu-hZkZuy-sNUbfyxI_5DEdhQT1LZyrfqMwtw4o24qMYa5azNF8yrAwrJCNBvHdZzBHmWbf6ABIUrxpCCDB32RivOzjHFkWp7niENp3Jo2KHiHAl5RCLqOppEG8ssw4b2m2o2SQDeQm-gbm-pWhB5mPyvkTw2HSfTMvopSVb6d-ty-w5fyGW-TVLcrSoyGKiYCSyODMd8P-T9MNDsRpyi8dpAGhRsQGbUxsxWORxIvob5kO4nOiKT3zpOIlyTD6hoT_rBzMTXyBX0bktvz3mb8kFhtkBgMEI0n8oNZv9_N3fqaYq3X7ranX_YhksQXWN4wlFET-HKgcu1pK54_OOXb3N0pLtp8a6Jh71LVoqo8nHzvq1LQBSIB-a0NSNE8u_v3Mg2mO1S8sla3K5FmVnbGGk5tM6wWRckxJKb4BIKVBLybBIFkkvjxptiljWPKfMMrNO-7jZosNo7xazVj2uj4ZMmUFebsd97BbUc6a6ou9TYS2qT3fC3lK2UGtZ3T7xmbrGl0jAqKPZbhDWcvjwpowJBUkFJG9qYrtSM7HzvObg6W-Dg77X4FYRjxmhIY1-q0nu_Q4W9AcGMuKJrybLtQBfE; auth._token_expiration.laravelPassportPassword=1684698347000; auth.redirect=%2Fgroups; XSRF-TOKEN=eyJpdiI6Ik02T2pDN3NBQXpzMDFjQk5sMXRpWXc9PSIsInZhbHVlIjoiTXRRM08zOGU0TUcrd2RoRjVkUHVvR1gyQ2VMeW5QdGVQLzQ0cis5WXFqeGlSSzlPVG1DVnhOWG0zN0s4Uk1MU3RNWldXdjBXMWxWUTE3OGF2Y1ZHYUtiTmtOM1d6NjRqVkxiNWFGM1RkRjlvVklUSHo3b0VWZm1KY2paTWdta0siLCJtYWMiOiIzMDRiNTQ1NzI2M2VlMTcxNGIwNmU1Y2NmOWUwOGE0ZTEzZjZkZjFlZTIwMzI0MmIxOWM1NjdmNWQ5OTZjMmMzIn0%3D; bluchip_sacco_system_session=eyJpdiI6InpaaDU5RVRFQ0ZpWE0yMm0rcThaN2c9PSIsInZhbHVlIjoiNzV6OGlwZG9Xd3dhZ2xjWFNhbXlBT2J6K0psaUFkNmJoc3JidGhhZmpFb3dUVCtKY3Q4Q3B5cEdnaTUzTlJOL0xVVkZ5NjM5OGRROGpKa3Z3T1BzcWxJa2oxVWVQRmMwdkRkZ3dFUlR5TU1JWUhGQW1ac1FXOXRNb3Z4aDl0S2wiLCJtYWMiOiJmMjYzYzkwODQ0OTQ4MTcyMjk0ZmM0MTdiMWE0ODVlY2JmMjc0ODdmMDUzYWZjMjkwZTEwZWQwNDA5ZWFmY2NmIn0%3D\"},\"payload\":[],\"session\":{\"_token\":\"6NV9OZussFDoqIczxvGZg1ACExthDBxsad7SNAhv\",\"url\":{\"intended\":\"http:\\/\\/localhost\\/loans\\/public\\/accounting\\/chart_of_account\\/create\"},\"_previous\":{\"url\":\"http:\\/\\/localhost\\/loans\\/public\\/accounting\\/chart_of_account\\/create\"},\"_flash\":{\"old\":[],\"new\":[]},\"PHPDEBUGBAR_STACK_DATA\":{\"X5096384f5c037ba22475f726c5b8f908\":null}},\"response_status\":302,\"response\":\"Redirected to http:\\/\\/localhost\\/loans\\/public\\/login\",\"duration\":3175,\"memory\":2,\"hostname\":\"DESKTOP-A71730A\"}', '2022-05-30 11:48:01');

-- --------------------------------------------------------

--
-- Table structure for table `telescope_entries_tags`
--

DROP TABLE IF EXISTS `telescope_entries_tags`;
CREATE TABLE IF NOT EXISTS `telescope_entries_tags` (
  `entry_uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tag` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `telescope_entries_tags_entry_uuid_tag_index` (`entry_uuid`,`tag`),
  KEY `telescope_entries_tags_tag_index` (`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `telescope_monitoring`
--

DROP TABLE IF EXISTS `telescope_monitoring`;
CREATE TABLE IF NOT EXISTS `telescope_monitoring` (
  `tag` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `timezones`
--

DROP TABLE IF EXISTS `timezones`;
CREATE TABLE IF NOT EXISTS `timezones` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `zone_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zone_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=426 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `timezones`
--

INSERT INTO `timezones` (`id`, `zone_id`, `country_code`, `zone_name`) VALUES
(1, '1', 'AD', 'Europe/Andorra'),
(2, '2', 'AE', 'Asia/Dubai'),
(3, '3', 'AF', 'Asia/Kabul'),
(4, '4', 'AG', 'America/Antigua'),
(5, '5', 'AI', 'America/Anguilla'),
(6, '6', 'AL', 'Europe/Tirane'),
(7, '7', 'AM', 'Asia/Yerevan'),
(8, '8', 'AO', 'Africa/Luanda'),
(9, '9', 'AQ', 'Antarctica/McMurdo'),
(10, '10', 'AQ', 'Antarctica/Casey'),
(11, '11', 'AQ', 'Antarctica/Davis'),
(12, '12', 'AQ', 'Antarctica/DumontDUrville'),
(13, '13', 'AQ', 'Antarctica/Mawson'),
(14, '14', 'AQ', 'Antarctica/Palmer'),
(15, '15', 'AQ', 'Antarctica/Rothera'),
(16, '16', 'AQ', 'Antarctica/Syowa'),
(17, '17', 'AQ', 'Antarctica/Troll'),
(18, '18', 'AQ', 'Antarctica/Vostok'),
(19, '19', 'AR', 'America/Argentina/Buenos_Aires'),
(20, '20', 'AR', 'America/Argentina/Cordoba'),
(21, '21', 'AR', 'America/Argentina/Salta'),
(22, '22', 'AR', 'America/Argentina/Jujuy'),
(23, '23', 'AR', 'America/Argentina/Tucuman'),
(24, '24', 'AR', 'America/Argentina/Catamarca'),
(25, '25', 'AR', 'America/Argentina/La_Rioja'),
(26, '26', 'AR', 'America/Argentina/San_Juan'),
(27, '27', 'AR', 'America/Argentina/Mendoza'),
(28, '28', 'AR', 'America/Argentina/San_Luis'),
(29, '29', 'AR', 'America/Argentina/Rio_Gallegos'),
(30, '30', 'AR', 'America/Argentina/Ushuaia'),
(31, '31', 'AS', 'Pacific/Pago_Pago'),
(32, '32', 'AT', 'Europe/Vienna'),
(33, '33', 'AU', 'Australia/Lord_Howe'),
(34, '34', 'AU', 'Antarctica/Macquarie'),
(35, '35', 'AU', 'Australia/Hobart'),
(36, '36', 'AU', 'Australia/Currie'),
(37, '37', 'AU', 'Australia/Melbourne'),
(38, '38', 'AU', 'Australia/Sydney'),
(39, '39', 'AU', 'Australia/Broken_Hill'),
(40, '40', 'AU', 'Australia/Brisbane'),
(41, '41', 'AU', 'Australia/Lindeman'),
(42, '42', 'AU', 'Australia/Adelaide'),
(43, '43', 'AU', 'Australia/Darwin'),
(44, '44', 'AU', 'Australia/Perth'),
(45, '45', 'AU', 'Australia/Eucla'),
(46, '46', 'AW', 'America/Aruba'),
(47, '47', 'AX', 'Europe/Mariehamn'),
(48, '48', 'AZ', 'Asia/Baku'),
(49, '49', 'BA', 'Europe/Sarajevo'),
(50, '50', 'BB', 'America/Barbados'),
(51, '51', 'BD', 'Asia/Dhaka'),
(52, '52', 'BE', 'Europe/Brussels'),
(53, '53', 'BF', 'Africa/Ouagadougou'),
(54, '54', 'BG', 'Europe/Sofia'),
(55, '55', 'BH', 'Asia/Bahrain'),
(56, '56', 'BI', 'Africa/Bujumbura'),
(57, '57', 'BJ', 'Africa/Porto-Novo'),
(58, '58', 'BL', 'America/St_Barthelemy'),
(59, '59', 'BM', 'Atlantic/Bermuda'),
(60, '60', 'BN', 'Asia/Brunei'),
(61, '61', 'BO', 'America/La_Paz'),
(62, '62', 'BQ', 'America/Kralendijk'),
(63, '63', 'BR', 'America/Noronha'),
(64, '64', 'BR', 'America/Belem'),
(65, '65', 'BR', 'America/Fortaleza'),
(66, '66', 'BR', 'America/Recife'),
(67, '67', 'BR', 'America/Araguaina'),
(68, '68', 'BR', 'America/Maceio'),
(69, '69', 'BR', 'America/Bahia'),
(70, '70', 'BR', 'America/Sao_Paulo'),
(71, '71', 'BR', 'America/Campo_Grande'),
(72, '72', 'BR', 'America/Cuiaba'),
(73, '73', 'BR', 'America/Santarem'),
(74, '74', 'BR', 'America/Porto_Velho'),
(75, '75', 'BR', 'America/Boa_Vista'),
(76, '76', 'BR', 'America/Manaus'),
(77, '77', 'BR', 'America/Eirunepe'),
(78, '78', 'BR', 'America/Rio_Branco'),
(79, '79', 'BS', 'America/Nassau'),
(80, '80', 'BT', 'Asia/Thimphu'),
(81, '81', 'BW', 'Africa/Gaborone'),
(82, '82', 'BY', 'Europe/Minsk'),
(83, '83', 'BZ', 'America/Belize'),
(84, '84', 'CA', 'America/St_Johns'),
(85, '85', 'CA', 'America/Halifax'),
(86, '86', 'CA', 'America/Glace_Bay'),
(87, '87', 'CA', 'America/Moncton'),
(88, '88', 'CA', 'America/Goose_Bay'),
(89, '89', 'CA', 'America/Blanc-Sablon'),
(90, '90', 'CA', 'America/Toronto'),
(91, '91', 'CA', 'America/Nipigon'),
(92, '92', 'CA', 'America/Thunder_Bay'),
(93, '93', 'CA', 'America/Iqaluit'),
(94, '94', 'CA', 'America/Pangnirtung'),
(95, '95', 'CA', 'America/Atikokan'),
(96, '96', 'CA', 'America/Winnipeg'),
(97, '97', 'CA', 'America/Rainy_River'),
(98, '98', 'CA', 'America/Resolute'),
(99, '99', 'CA', 'America/Rankin_Inlet'),
(100, '100', 'CA', 'America/Regina'),
(101, '101', 'CA', 'America/Swift_Current'),
(102, '102', 'CA', 'America/Edmonton'),
(103, '103', 'CA', 'America/Cambridge_Bay'),
(104, '104', 'CA', 'America/Yellowknife'),
(105, '105', 'CA', 'America/Inuvik'),
(106, '106', 'CA', 'America/Creston'),
(107, '107', 'CA', 'America/Dawson_Creek'),
(108, '108', 'CA', 'America/Fort_Nelson'),
(109, '109', 'CA', 'America/Vancouver'),
(110, '110', 'CA', 'America/Whitehorse'),
(111, '111', 'CA', 'America/Dawson'),
(112, '112', 'CC', 'Indian/Cocos'),
(113, '113', 'CD', 'Africa/Kinshasa'),
(114, '114', 'CD', 'Africa/Lubumbashi'),
(115, '115', 'CF', 'Africa/Bangui'),
(116, '116', 'CG', 'Africa/Brazzaville'),
(117, '117', 'CH', 'Europe/Zurich'),
(118, '118', 'CI', 'Africa/Abidjan'),
(119, '119', 'CK', 'Pacific/Rarotonga'),
(120, '120', 'CL', 'America/Santiago'),
(121, '121', 'CL', 'America/Punta_Arenas'),
(122, '122', 'CL', 'Pacific/Easter'),
(123, '123', 'CM', 'Africa/Douala'),
(124, '124', 'CN', 'Asia/Shanghai'),
(125, '125', 'CN', 'Asia/Urumqi'),
(126, '126', 'CO', 'America/Bogota'),
(127, '127', 'CR', 'America/Costa_Rica'),
(128, '128', 'CU', 'America/Havana'),
(129, '129', 'CV', 'Atlantic/Cape_Verde'),
(130, '130', 'CW', 'America/Curacao'),
(131, '131', 'CX', 'Indian/Christmas'),
(132, '132', 'CY', 'Asia/Nicosia'),
(133, '133', 'CY', 'Asia/Famagusta'),
(134, '134', 'CZ', 'Europe/Prague'),
(135, '135', 'DE', 'Europe/Berlin'),
(136, '136', 'DE', 'Europe/Busingen'),
(137, '137', 'DJ', 'Africa/Djibouti'),
(138, '138', 'DK', 'Europe/Copenhagen'),
(139, '139', 'DM', 'America/Dominica'),
(140, '140', 'DO', 'America/Santo_Domingo'),
(141, '141', 'DZ', 'Africa/Algiers'),
(142, '142', 'EC', 'America/Guayaquil'),
(143, '143', 'EC', 'Pacific/Galapagos'),
(144, '144', 'EE', 'Europe/Tallinn'),
(145, '145', 'EG', 'Africa/Cairo'),
(146, '146', 'EH', 'Africa/El_Aaiun'),
(147, '147', 'ER', 'Africa/Asmara'),
(148, '148', 'ES', 'Europe/Madrid'),
(149, '149', 'ES', 'Africa/Ceuta'),
(150, '150', 'ES', 'Atlantic/Canary'),
(151, '151', 'ET', 'Africa/Addis_Ababa'),
(152, '152', 'FI', 'Europe/Helsinki'),
(153, '153', 'FJ', 'Pacific/Fiji'),
(154, '154', 'FK', 'Atlantic/Stanley'),
(155, '155', 'FM', 'Pacific/Chuuk'),
(156, '156', 'FM', 'Pacific/Pohnpei'),
(157, '157', 'FM', 'Pacific/Kosrae'),
(158, '158', 'FO', 'Atlantic/Faroe'),
(159, '159', 'FR', 'Europe/Paris'),
(160, '160', 'GA', 'Africa/Libreville'),
(161, '161', 'GB', 'Europe/London'),
(162, '162', 'GD', 'America/Grenada'),
(163, '163', 'GE', 'Asia/Tbilisi'),
(164, '164', 'GF', 'America/Cayenne'),
(165, '165', 'GG', 'Europe/Guernsey'),
(166, '166', 'GH', 'Africa/Accra'),
(167, '167', 'GI', 'Europe/Gibraltar'),
(168, '168', 'GL', 'America/Godthab'),
(169, '169', 'GL', 'America/Danmarkshavn'),
(170, '170', 'GL', 'America/Scoresbysund'),
(171, '171', 'GL', 'America/Thule'),
(172, '172', 'GM', 'Africa/Banjul'),
(173, '173', 'GN', 'Africa/Conakry'),
(174, '174', 'GP', 'America/Guadeloupe'),
(175, '175', 'GQ', 'Africa/Malabo'),
(176, '176', 'GR', 'Europe/Athens'),
(177, '177', 'GS', 'Atlantic/South_Georgia'),
(178, '178', 'GT', 'America/Guatemala'),
(179, '179', 'GU', 'Pacific/Guam'),
(180, '180', 'GW', 'Africa/Bissau'),
(181, '181', 'GY', 'America/Guyana'),
(182, '182', 'HK', 'Asia/Hong_Kong'),
(183, '183', 'HN', 'America/Tegucigalpa'),
(184, '184', 'HR', 'Europe/Zagreb'),
(185, '185', 'HT', 'America/Port-au-Prince'),
(186, '186', 'HU', 'Europe/Budapest'),
(187, '187', 'ID', 'Asia/Jakarta'),
(188, '188', 'ID', 'Asia/Pontianak'),
(189, '189', 'ID', 'Asia/Makassar'),
(190, '190', 'ID', 'Asia/Jayapura'),
(191, '191', 'IE', 'Europe/Dublin'),
(192, '192', 'IL', 'Asia/Jerusalem'),
(193, '193', 'IM', 'Europe/Isle_of_Man'),
(194, '194', 'IN', 'Asia/Kolkata'),
(195, '195', 'IO', 'Indian/Chagos'),
(196, '196', 'IQ', 'Asia/Baghdad'),
(197, '197', 'IR', 'Asia/Tehran'),
(198, '198', 'IS', 'Atlantic/Reykjavik'),
(199, '199', 'IT', 'Europe/Rome'),
(200, '200', 'JE', 'Europe/Jersey'),
(201, '201', 'JM', 'America/Jamaica'),
(202, '202', 'JO', 'Asia/Amman'),
(203, '203', 'JP', 'Asia/Tokyo'),
(204, '204', 'KE', 'Africa/Nairobi'),
(205, '205', 'KG', 'Asia/Bishkek'),
(206, '206', 'KH', 'Asia/Phnom_Penh'),
(207, '207', 'KI', 'Pacific/Tarawa'),
(208, '208', 'KI', 'Pacific/Enderbury'),
(209, '209', 'KI', 'Pacific/Kiritimati'),
(210, '210', 'KM', 'Indian/Comoro'),
(211, '211', 'KN', 'America/St_Kitts'),
(212, '212', 'KP', 'Asia/Pyongyang'),
(213, '213', 'KR', 'Asia/Seoul'),
(214, '214', 'KW', 'Asia/Kuwait'),
(215, '215', 'KY', 'America/Cayman'),
(216, '216', 'KZ', 'Asia/Almaty'),
(217, '217', 'KZ', 'Asia/Qyzylorda'),
(218, '218', 'KZ', 'Asia/Qostanay'),
(219, '219', 'KZ', 'Asia/Aqtobe'),
(220, '220', 'KZ', 'Asia/Aqtau'),
(221, '221', 'KZ', 'Asia/Atyrau'),
(222, '222', 'KZ', 'Asia/Oral'),
(223, '223', 'LA', 'Asia/Vientiane'),
(224, '224', 'LB', 'Asia/Beirut'),
(225, '225', 'LC', 'America/St_Lucia'),
(226, '226', 'LI', 'Europe/Vaduz'),
(227, '227', 'LK', 'Asia/Colombo'),
(228, '228', 'LR', 'Africa/Monrovia'),
(229, '229', 'LS', 'Africa/Maseru'),
(230, '230', 'LT', 'Europe/Vilnius'),
(231, '231', 'LU', 'Europe/Luxembourg'),
(232, '232', 'LV', 'Europe/Riga'),
(233, '233', 'LY', 'Africa/Tripoli'),
(234, '234', 'MA', 'Africa/Casablanca'),
(235, '235', 'MC', 'Europe/Monaco'),
(236, '236', 'MD', 'Europe/Chisinau'),
(237, '237', 'ME', 'Europe/Podgorica'),
(238, '238', 'MF', 'America/Marigot'),
(239, '239', 'MG', 'Indian/Antananarivo'),
(240, '240', 'MH', 'Pacific/Majuro'),
(241, '241', 'MH', 'Pacific/Kwajalein'),
(242, '242', 'MK', 'Europe/Skopje'),
(243, '243', 'ML', 'Africa/Bamako'),
(244, '244', 'MM', 'Asia/Yangon'),
(245, '245', 'MN', 'Asia/Ulaanbaatar'),
(246, '246', 'MN', 'Asia/Hovd'),
(247, '247', 'MN', 'Asia/Choibalsan'),
(248, '248', 'MO', 'Asia/Macau'),
(249, '249', 'MP', 'Pacific/Saipan'),
(250, '250', 'MQ', 'America/Martinique'),
(251, '251', 'MR', 'Africa/Nouakchott'),
(252, '252', 'MS', 'America/Montserrat'),
(253, '253', 'MT', 'Europe/Malta'),
(254, '254', 'MU', 'Indian/Mauritius'),
(255, '255', 'MV', 'Indian/Maldives'),
(256, '256', 'MW', 'Africa/Blantyre'),
(257, '257', 'MX', 'America/Mexico_City'),
(258, '258', 'MX', 'America/Cancun'),
(259, '259', 'MX', 'America/Merida'),
(260, '260', 'MX', 'America/Monterrey'),
(261, '261', 'MX', 'America/Matamoros'),
(262, '262', 'MX', 'America/Mazatlan'),
(263, '263', 'MX', 'America/Chihuahua'),
(264, '264', 'MX', 'America/Ojinaga'),
(265, '265', 'MX', 'America/Hermosillo'),
(266, '266', 'MX', 'America/Tijuana'),
(267, '267', 'MX', 'America/Bahia_Banderas'),
(268, '268', 'MY', 'Asia/Kuala_Lumpur'),
(269, '269', 'MY', 'Asia/Kuching'),
(270, '270', 'MZ', 'Africa/Maputo'),
(271, '271', 'NA', 'Africa/Windhoek'),
(272, '272', 'NC', 'Pacific/Noumea'),
(273, '273', 'NE', 'Africa/Niamey'),
(274, '274', 'NF', 'Pacific/Norfolk'),
(275, '275', 'NG', 'Africa/Lagos'),
(276, '276', 'NI', 'America/Managua'),
(277, '277', 'NL', 'Europe/Amsterdam'),
(278, '278', 'NO', 'Europe/Oslo'),
(279, '279', 'NP', 'Asia/Kathmandu'),
(280, '280', 'NR', 'Pacific/Nauru'),
(281, '281', 'NU', 'Pacific/Niue'),
(282, '282', 'NZ', 'Pacific/Auckland'),
(283, '283', 'NZ', 'Pacific/Chatham'),
(284, '284', 'OM', 'Asia/Muscat'),
(285, '285', 'PA', 'America/Panama'),
(286, '286', 'PE', 'America/Lima'),
(287, '287', 'PF', 'Pacific/Tahiti'),
(288, '288', 'PF', 'Pacific/Marquesas'),
(289, '289', 'PF', 'Pacific/Gambier'),
(290, '290', 'PG', 'Pacific/Port_Moresby'),
(291, '291', 'PG', 'Pacific/Bougainville'),
(292, '292', 'PH', 'Asia/Manila'),
(293, '293', 'PK', 'Asia/Karachi'),
(294, '294', 'PL', 'Europe/Warsaw'),
(295, '295', 'PM', 'America/Miquelon'),
(296, '296', 'PN', 'Pacific/Pitcairn'),
(297, '297', 'PR', 'America/Puerto_Rico'),
(298, '298', 'PS', 'Asia/Gaza'),
(299, '299', 'PS', 'Asia/Hebron'),
(300, '300', 'PT', 'Europe/Lisbon'),
(301, '301', 'PT', 'Atlantic/Madeira'),
(302, '302', 'PT', 'Atlantic/Azores'),
(303, '303', 'PW', 'Pacific/Palau'),
(304, '304', 'PY', 'America/Asuncion'),
(305, '305', 'QA', 'Asia/Qatar'),
(306, '306', 'RE', 'Indian/Reunion'),
(307, '307', 'RO', 'Europe/Bucharest'),
(308, '308', 'RS', 'Europe/Belgrade'),
(309, '309', 'RU', 'Europe/Kaliningrad'),
(310, '310', 'RU', 'Europe/Moscow'),
(311, '311', 'UA', 'Europe/Simferopol'),
(312, '312', 'RU', 'Europe/Kirov'),
(313, '313', 'RU', 'Europe/Astrakhan'),
(314, '314', 'RU', 'Europe/Volgograd'),
(315, '315', 'RU', 'Europe/Saratov'),
(316, '316', 'RU', 'Europe/Ulyanovsk'),
(317, '317', 'RU', 'Europe/Samara'),
(318, '318', 'RU', 'Asia/Yekaterinburg'),
(319, '319', 'RU', 'Asia/Omsk'),
(320, '320', 'RU', 'Asia/Novosibirsk'),
(321, '321', 'RU', 'Asia/Barnaul'),
(322, '322', 'RU', 'Asia/Tomsk'),
(323, '323', 'RU', 'Asia/Novokuznetsk'),
(324, '324', 'RU', 'Asia/Krasnoyarsk'),
(325, '325', 'RU', 'Asia/Irkutsk'),
(326, '326', 'RU', 'Asia/Chita'),
(327, '327', 'RU', 'Asia/Yakutsk'),
(328, '328', 'RU', 'Asia/Khandyga'),
(329, '329', 'RU', 'Asia/Vladivostok'),
(330, '330', 'RU', 'Asia/Ust-Nera'),
(331, '331', 'RU', 'Asia/Magadan'),
(332, '332', 'RU', 'Asia/Sakhalin'),
(333, '333', 'RU', 'Asia/Srednekolymsk'),
(334, '334', 'RU', 'Asia/Kamchatka'),
(335, '335', 'RU', 'Asia/Anadyr'),
(336, '336', 'RW', 'Africa/Kigali'),
(337, '337', 'SA', 'Asia/Riyadh'),
(338, '338', 'SB', 'Pacific/Guadalcanal'),
(339, '339', 'SC', 'Indian/Mahe'),
(340, '340', 'SD', 'Africa/Khartoum'),
(341, '341', 'SE', 'Europe/Stockholm'),
(342, '342', 'SG', 'Asia/Singapore'),
(343, '343', 'SH', 'Atlantic/St_Helena'),
(344, '344', 'SI', 'Europe/Ljubljana'),
(345, '345', 'SJ', 'Arctic/Longyearbyen'),
(346, '346', 'SK', 'Europe/Bratislava'),
(347, '347', 'SL', 'Africa/Freetown'),
(348, '348', 'SM', 'Europe/San_Marino'),
(349, '349', 'SN', 'Africa/Dakar'),
(350, '350', 'SO', 'Africa/Mogadishu'),
(351, '351', 'SR', 'America/Paramaribo'),
(352, '352', 'SS', 'Africa/Juba'),
(353, '353', 'ST', 'Africa/Sao_Tome'),
(354, '354', 'SV', 'America/El_Salvador'),
(355, '355', 'SX', 'America/Lower_Princes'),
(356, '356', 'SY', 'Asia/Damascus'),
(357, '357', 'SZ', 'Africa/Mbabane'),
(358, '358', 'TC', 'America/Grand_Turk'),
(359, '359', 'TD', 'Africa/Ndjamena'),
(360, '360', 'TF', 'Indian/Kerguelen'),
(361, '361', 'TG', 'Africa/Lome'),
(362, '362', 'TH', 'Asia/Bangkok'),
(363, '363', 'TJ', 'Asia/Dushanbe'),
(364, '364', 'TK', 'Pacific/Fakaofo'),
(365, '365', 'TL', 'Asia/Dili'),
(366, '366', 'TM', 'Asia/Ashgabat'),
(367, '367', 'TN', 'Africa/Tunis'),
(368, '368', 'TO', 'Pacific/Tongatapu'),
(369, '369', 'TR', 'Europe/Istanbul'),
(370, '370', 'TT', 'America/Port_of_Spain'),
(371, '371', 'TV', 'Pacific/Funafuti'),
(372, '372', 'TW', 'Asia/Taipei'),
(373, '373', 'TZ', 'Africa/Dar_es_Salaam'),
(374, '374', 'UA', 'Europe/Kiev'),
(375, '375', 'UA', 'Europe/Uzhgorod'),
(376, '376', 'UA', 'Europe/Zaporozhye'),
(377, '377', 'UG', 'Africa/Kampala'),
(378, '378', 'UM', 'Pacific/Midway'),
(379, '379', 'UM', 'Pacific/Wake'),
(380, '380', 'US', 'America/New_York'),
(381, '381', 'US', 'America/Detroit'),
(382, '382', 'US', 'America/Kentucky/Louisville'),
(383, '383', 'US', 'America/Kentucky/Monticello'),
(384, '384', 'US', 'America/Indiana/Indianapolis'),
(385, '385', 'US', 'America/Indiana/Vincennes'),
(386, '386', 'US', 'America/Indiana/Winamac'),
(387, '387', 'US', 'America/Indiana/Marengo'),
(388, '388', 'US', 'America/Indiana/Petersburg'),
(389, '389', 'US', 'America/Indiana/Vevay'),
(390, '390', 'US', 'America/Chicago'),
(391, '391', 'US', 'America/Indiana/Tell_City'),
(392, '392', 'US', 'America/Indiana/Knox'),
(393, '393', 'US', 'America/Menominee'),
(394, '394', 'US', 'America/North_Dakota/Center'),
(395, '395', 'US', 'America/North_Dakota/New_Salem'),
(396, '396', 'US', 'America/North_Dakota/Beulah'),
(397, '397', 'US', 'America/Denver'),
(398, '398', 'US', 'America/Boise'),
(399, '399', 'US', 'America/Phoenix'),
(400, '400', 'US', 'America/Los_Angeles'),
(401, '401', 'US', 'America/Anchorage'),
(402, '402', 'US', 'America/Juneau'),
(403, '403', 'US', 'America/Sitka'),
(404, '404', 'US', 'America/Metlakatla'),
(405, '405', 'US', 'America/Yakutat'),
(406, '406', 'US', 'America/Nome'),
(407, '407', 'US', 'America/Adak'),
(408, '408', 'US', 'Pacific/Honolulu'),
(409, '409', 'UY', 'America/Montevideo'),
(410, '410', 'UZ', 'Asia/Samarkand'),
(411, '411', 'UZ', 'Asia/Tashkent'),
(412, '412', 'VA', 'Europe/Vatican'),
(413, '413', 'VC', 'America/St_Vincent'),
(414, '414', 'VE', 'America/Caracas'),
(415, '415', 'VG', 'America/Tortola'),
(416, '416', 'VI', 'America/St_Thomas'),
(417, '417', 'VN', 'Asia/Ho_Chi_Minh'),
(418, '418', 'VU', 'Pacific/Efate'),
(419, '419', 'WF', 'Pacific/Wallis'),
(420, '420', 'WS', 'Pacific/Apia'),
(421, '421', 'YE', 'Asia/Aden'),
(422, '422', 'YT', 'Indian/Mayotte'),
(423, '423', 'ZA', 'Africa/Johannesburg'),
(424, '424', 'ZM', 'Africa/Lusaka'),
(425, '425', 'ZW', 'Africa/Harare');

-- --------------------------------------------------------

--
-- Table structure for table `titles`
--

DROP TABLE IF EXISTS `titles`;
CREATE TABLE IF NOT EXISTS `titles` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `titles`
--

INSERT INTO `titles` (`id`, `name`) VALUES
(1, 'Mr'),
(2, 'Mrs'),
(3, 'Miss');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` int(11) DEFAULT NULL,
  `branch_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `api_token` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  `first_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enable_google2fa` tinyint(4) NOT NULL DEFAULT '0',
  `google2fa_secret` text COLLATE utf8mb4_unicode_ci,
  `otp` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `otp_expiry_date` timestamp NULL DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `photo` text COLLATE utf8mb4_unicode_ci,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_api_token_unique` (`api_token`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `created_by_id`, `branch_id`, `name`, `username`, `email`, `email_verified_at`, `password`, `api_token`, `last_login`, `first_name`, `last_name`, `phone`, `address`, `city`, `gender`, `enable_google2fa`, `google2fa_secret`, `otp`, `otp_expiry_date`, `notes`, `photo`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, NULL, 1, 'Admin', 'admin', 'admin@gmail.com', '2020-09-02 06:59:25', '$2y$10$TzeNVMGsBqn2Mv4d6.lnSeRJpMla2zFjy9VEKz7gL2cJBL0HfncFO', 'k3gqUEHb5MaFHBG6S4O6zx7Wc6Riz70T2CisWvoPbHYM11znvXPZeRTs5z9d', NULL, 'Admin', 'Admin', '077', NULL, NULL, 'male', 0, '3UPQ7XOZGQD5LLNT', NULL, NULL, NULL, NULL, 'qaGy1M2rqgxBp0kEctx6Qtd9V8dz2SOuylthdvOWa3SJgBBnMvibZPAsl8jc', '2020-09-02 06:59:25', '2022-02-26 19:21:32'),
(2, NULL, NULL, '', NULL, 'tjmugova@localhost.com', '2020-10-14 07:36:47', '$2y$10$2ztriAtdb9EaqywPp8oQkuNygIazjqSFeDsm64xto.YXryARIL3ya', NULL, NULL, 'Tererai', 'Mugova', '+263774175438', '933 13th street\r\nGlenview 1', NULL, 'male', 0, NULL, NULL, NULL, 'dd', NULL, '2RTLhsAEAMsqSohkKWh7R1azSUi2hfYCVNkyoN7KksTpVGflDuV3iIU6r85H', '2020-10-14 07:36:47', '2020-10-15 14:23:11'),
(3, NULL, NULL, '', NULL, 'maclaven@localhost.com', '2020-10-14 07:37:30', '$2y$10$JrDBboWv411pvXYf/FnSNOXVs.v/H.NtwYgvAufjcYM35O.9vqcBy', NULL, NULL, 'Maclaven', 'Mugova', '0774175438', '933 13th street, Glenview 1', NULL, 'male', 0, NULL, NULL, NULL, NULL, NULL, NULL, '2020-10-14 07:37:30', '2020-10-14 07:37:30'),
(5, NULL, NULL, '', NULL, 'tjmugova@local.com', '2020-10-15 13:09:08', '$2y$10$8M8FlCRE3xLJlNeryx.VCeVsvW7yaAVBY8DWEmM8KKU4aj5KES7iC', NULL, NULL, 'Tererai', 'Mugova', '+26377417543', 'ff', NULL, 'male', 0, NULL, NULL, NULL, 'ff', NULL, NULL, '2020-10-15 13:09:08', '2020-10-15 13:09:08'),
(7, NULL, NULL, '', NULL, 'tj@localhost.com', '2020-10-21 14:23:51', '$2y$10$5YMugFjnPLUlf/68E.Pz5e45bTkM9R.YkguFZV7sHf9E02RKlD9W6', NULL, NULL, 'Maclaven', 'Mugova', '0774175438', '933 13th street, Glenview 1', NULL, 'male', 0, NULL, NULL, NULL, NULL, NULL, NULL, '2020-10-21 14:23:51', '2020-10-21 14:23:51'),
(8, NULL, NULL, '', NULL, 'ochyscott@gmail.com', '2022-03-15 14:24:52', '$2y$10$2jJocXDJ9bPv4t24It6LK.obBSJc3mKt/0gPG9eIMwWC7vpZtzlJm', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '2022-03-15 14:24:52', '2022-03-15 14:24:52');

-- --------------------------------------------------------

--
-- Table structure for table `wallets`
--

DROP TABLE IF EXISTS `wallets`;
CREATE TABLE IF NOT EXISTS `wallets` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `currency_id` bigint(20) UNSIGNED NOT NULL,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_type` enum('client','group') COLLATE utf8mb4_unicode_ci DEFAULT 'client',
  `client_id` bigint(20) UNSIGNED DEFAULT NULL,
  `group_id` bigint(20) UNSIGNED DEFAULT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` enum('pending','active','inactive','closed','suspended','rejected','approved') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `balance` decimal(65,6) DEFAULT NULL,
  `decimals` int(11) NOT NULL DEFAULT '2',
  `description` text COLLATE utf8mb4_unicode_ci,
  `submitted_on_date` date DEFAULT NULL,
  `submitted_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `approved_on_date` date DEFAULT NULL,
  `approved_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `approved_notes` text COLLATE utf8mb4_unicode_ci,
  `rejected_on_date` date DEFAULT NULL,
  `rejected_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `rejected_notes` text COLLATE utf8mb4_unicode_ci,
  `closed_on_date` date DEFAULT NULL,
  `closed_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `closed_notes` text COLLATE utf8mb4_unicode_ci,
  `activated_on_date` date DEFAULT NULL,
  `activated_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `activated_notes` text COLLATE utf8mb4_unicode_ci,
  `suspended_on_date` date DEFAULT NULL,
  `suspended_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `suspended_notes` text COLLATE utf8mb4_unicode_ci,
  `inactive_on_date` date DEFAULT NULL,
  `inactive_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `inactive_notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wallets_client_id_index` (`client_id`),
  KEY `wallets_branch_id_index` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wallet_transactions`
--

DROP TABLE IF EXISTS `wallet_transactions`;
CREATE TABLE IF NOT EXISTS `wallet_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `wallet_id` bigint(20) UNSIGNED NOT NULL,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payment_detail_id` bigint(20) UNSIGNED DEFAULT NULL,
  `transaction_type` enum('deposit','withdrawal','savings_transfer','loan_transfer') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'deposit',
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(65,6) NOT NULL,
  `credit` decimal(65,6) DEFAULT NULL,
  `debit` decimal(65,6) DEFAULT NULL,
  `balance` decimal(65,6) DEFAULT NULL,
  `reversed` tinyint(4) NOT NULL DEFAULT '0',
  `reversible` tinyint(4) NOT NULL DEFAULT '0',
  `submitted_on` date DEFAULT NULL,
  `created_on` date DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `reference` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gateway_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_gateway_data` text COLLATE utf8mb4_unicode_ci,
  `online_transaction` tinyint(4) NOT NULL DEFAULT '0',
  `status` enum('pending','approved','declined') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wallet_transactions_wallet_id_index` (`wallet_id`),
  KEY `wallet_transactions_branch_id_index` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `widgets`
--

DROP TABLE IF EXISTS `widgets`;
CREATE TABLE IF NOT EXISTS `widgets` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `widgets` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `widgets_user_id_foreign` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `widgets`
--

INSERT INTO `widgets` (`id`, `user_id`, `widgets`, `created_at`, `updated_at`) VALUES
(2, 1, '{\"LoanStatistics\":{\"class\":\"Loan::LoanStatistics\",\"name\":\"Loan Statistics\",\"x\":0,\"y\":0,\"width\":12,\"height\":2},\"LoanStatusOverview\":{\"class\":\"Loan::LoanStatusOverview\",\"name\":\"Loan Status Overview\",\"x\":0,\"y\":2,\"width\":4,\"height\":4},\"LoanCollectionOverview\":{\"class\":\"Loan::LoanCollectionOverview\",\"name\":\"Loan Collection Overview\",\"x\":4,\"y\":2,\"width\":8,\"height\":5}}', '2020-12-09 07:26:10', '2022-05-24 11:48:35');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `clients`
--
ALTER TABLE `clients`
  ADD CONSTRAINT `client_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `client_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `loan_charges`
--
ALTER TABLE `loan_charges`
  ADD CONSTRAINT `loan_charges_created_by_id_foreign` FOREIGN KEY (`created_by_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `loan_charges_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`),
  ADD CONSTRAINT `loan_charges_loan_charge_option_id_foreign` FOREIGN KEY (`loan_charge_option_id`) REFERENCES `loan_charge_options` (`id`),
  ADD CONSTRAINT `loan_charges_loan_charge_type_id_foreign` FOREIGN KEY (`loan_charge_type_id`) REFERENCES `loan_charge_types` (`id`);

--
-- Constraints for table `loan_credit_checks`
--
ALTER TABLE `loan_credit_checks`
  ADD CONSTRAINT `loan_credit_checks_created_by_id_foreign` FOREIGN KEY (`created_by_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
