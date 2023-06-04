-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 04, 2023 at 02:43 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `critterhaven_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(30) NOT NULL,
  `client_id` int(30) NOT NULL,
  `inventory_id` int(30) NOT NULL,
  `price` double NOT NULL,
  `quantity` int(30) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`id`, `client_id`, `inventory_id`, `price`, `quantity`, `date_created`) VALUES
(53, 1, 3, 349, 2, '2023-06-03 11:37:56'),
(54, 1, 2, 499, 1, '2023-06-04 08:41:39');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(30) NOT NULL,
  `category` varchar(250) NOT NULL,
  `description` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `category`, `description`, `status`, `date_created`) VALUES
(1, 'Pet Grooming', 'This category includes services related to grooming and hygiene of pets, such as bathing, hair trimming, nail clipping, and ear cleaning. Grooming helps to keep pets clean, healthy, and looking their best. Professional groomers often provide these services to ensure pets&#039; comfort and well-being.&lt;br&gt;', 1, '2023-06-01 12:34:34'),
(2, 'Pet Beds', '&lt;p&gt;The Pet Beds category features a selection of comfortable and cozy beds for pets. These beds are designed to provide a warm and secure resting place for pets, ensuring they have a dedicated space to relax and sleep. Our range of pet beds includes various sizes, shapes, and styles to accommodate pets of different breeds and sizes. Whether it&#039;s a plush cushion, a luxurious orthopedic bed, or a stylish and modern design, our pet beds prioritize both comfort and aesthetics, making them the perfect addition to any pet-friendly home.&lt;br&gt;&lt;/p&gt;', 0, '2023-06-01 12:35:52');

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `id` int(30) NOT NULL,
  `firstname` varchar(250) NOT NULL,
  `lastname` varchar(250) NOT NULL,
  `gender` varchar(20) NOT NULL,
  `contact` varchar(15) NOT NULL,
  `email` varchar(250) NOT NULL,
  `password` text NOT NULL,
  `default_delivery_address` text NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`id`, `firstname`, `lastname`, `gender`, `contact`, `email`, `password`, `default_delivery_address`, `date_created`) VALUES
(1, 'Ollej', 'Mangune', 'Male', '09772653938', 'mangune.jello@auf.edu.ph', '5f4dcc3b5aa765d61d8327deb882cf99', 'Angeles City', '2023-06-01 12:31:14');

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `id` int(30) NOT NULL,
  `product_id` int(30) NOT NULL,
  `quantity` double NOT NULL,
  `price` float NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`id`, `product_id`, `quantity`, `price`, `date_created`, `date_updated`) VALUES
(1, 1, 1000, 800, '2023-06-01 12:46:33', NULL),
(2, 2, 1000, 499, '2023-06-01 12:46:48', NULL),
(3, 3, 1000, 349, '2023-06-01 12:52:15', NULL),
(4, 4, 1000, 250, '2023-06-01 12:56:05', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(30) NOT NULL,
  `client_id` int(30) NOT NULL,
  `delivery_address` text NOT NULL,
  `payment_method` varchar(100) NOT NULL,
  `order_type` tinyint(1) NOT NULL COMMENT '1= pickup,2= deliver',
  `amount` double NOT NULL,
  `status` tinyint(2) NOT NULL DEFAULT 0,
  `paid` tinyint(1) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_by` int(30) DEFAULT NULL,
  `message_status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `client_id`, `delivery_address`, `payment_method`, `order_type`, `amount`, `status`, `paid`, `date_created`, `date_updated`, `updated_by`, `message_status`) VALUES
(1, 1, '', '', 0, 0, 0, 0, '2023-06-01 14:05:55', NULL, NULL, 0),
(2, 1, '', '', 0, 0, 0, 0, '2023-06-01 14:05:57', NULL, NULL, 0),
(3, 1, '', '', 0, 0, 0, 0, '2023-06-01 14:07:14', NULL, NULL, 0),
(4, 1, '', '', 0, 0, 0, 0, '2023-06-01 14:08:56', NULL, NULL, 0),
(5, 1, 'Angeles City', 'card', 2, 250, 0, 0, '2023-06-01 14:09:25', NULL, NULL, 0),
(6, 1, 'Angeles City', 'Online Payment', 2, 250, 0, 1, '2023-06-01 14:16:11', NULL, NULL, 0),
(7, 1, 'Angeles City', 'Online Payment', 2, 250, 0, 1, '2023-06-01 14:16:11', NULL, NULL, 0),
(8, 1, 'Angeles City', 'Online Payment', 2, 349, 0, 1, '2023-06-01 14:18:21', NULL, NULL, 0),
(9, 1, 'Angeles City', 'Online Payment', 2, 349, 0, 1, '2023-06-01 14:18:21', NULL, NULL, 0),
(10, 1, 'Angeles City', 'card', 2, 499, 0, 0, '2023-06-01 14:19:08', NULL, NULL, 0),
(11, 1, 'Angeles City', 'card', 2, 800, 0, 0, '2023-06-01 14:21:16', NULL, NULL, 0),
(12, 1, 'Angeles City', 'card', 2, 349, 0, 0, '2023-06-01 14:25:10', NULL, NULL, 0),
(13, 1, 'Angeles City', 'card', 2, 599, 0, 0, '2023-06-01 14:28:12', NULL, NULL, 0),
(14, 1, 'Angeles City', 'card', 2, 848, 0, 0, '2023-06-01 14:31:12', NULL, NULL, 0),
(15, 1, 'Angeles City', 'card', 2, 499, 0, 0, '2023-06-01 14:33:27', NULL, NULL, 0),
(16, 1, 'Angeles City', 'card', 2, 499, 0, 0, '2023-06-01 14:37:33', NULL, NULL, 0),
(17, 1, 'Angeles City', 'card', 2, 499, 0, 0, '2023-06-01 14:54:51', NULL, NULL, 0),
(18, 1, 'Angeles City', '', 2, 0, 0, 0, '2023-06-01 14:58:52', NULL, NULL, 0),
(19, 1, 'Angeles City', 'card', 2, 800, 0, 0, '2023-06-01 15:10:36', NULL, NULL, 0),
(20, 1, 'Angeles City', 'card', 2, 800, 0, 0, '2023-06-01 15:14:19', NULL, NULL, 0),
(21, 1, 'Angeles City', 'card', 2, 800, 0, 0, '2023-06-01 15:18:48', NULL, NULL, 0),
(22, 1, 'Angeles City', 'card', 2, 349, 0, 0, '2023-06-01 15:22:27', NULL, NULL, 0),
(23, 1, 'Angeles City', 'card', 2, 0, 0, 0, '2023-06-01 15:27:37', NULL, NULL, 0),
(24, 1, 'Angeles City', 'card', 2, 2148, 0, 0, '2023-06-01 15:39:13', NULL, NULL, 0),
(25, 1, 'Angeles City', 'card', 2, 250, 0, 0, '2023-06-01 17:10:57', NULL, NULL, 0),
(26, 1, 'Angeles City', 'card', 2, 349, 0, 0, '2023-06-02 16:47:01', NULL, NULL, 0),
(27, 1, 'Angeles City', 'card', 2, 349, 0, 0, '2023-06-02 17:05:38', NULL, NULL, 0),
(28, 1, 'Angeles City', 'card', 2, 499, 0, 0, '2023-06-02 17:25:12', NULL, NULL, 0),
(29, 1, 'Angeles City', 'card', 2, 349, 2, 1, '2023-06-03 09:00:49', '2023-06-03 09:13:28', NULL, 0),
(30, 1, 'Angeles City', 'card', 2, 2495, 0, 1, '2023-06-03 09:38:29', NULL, NULL, 0),
(31, 1, 'Angeles City', 'card', 2, 499, 0, 1, '2023-06-03 10:16:21', NULL, NULL, 0),
(32, 1, 'Angeles City', 'card', 2, 349, 0, 1, '2023-06-03 10:33:14', NULL, NULL, 0),
(33, 1, 'Angeles City', 'card', 2, 499, 0, 1, '2023-06-03 10:39:39', NULL, NULL, 0),
(34, 1, 'Angeles City', 'card', 2, 499, 0, 1, '2023-06-03 10:41:23', NULL, NULL, 0),
(35, 1, 'Angeles City', 'card', 2, 349, 0, 1, '2023-06-03 10:49:56', NULL, NULL, 0),
(36, 1, 'Angeles City', 'card', 2, 349, 0, 1, '2023-06-03 11:31:23', NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `order_list`
--

CREATE TABLE `order_list` (
  `id` int(30) NOT NULL,
  `order_id` int(30) NOT NULL,
  `product_id` int(30) NOT NULL,
  `quantity` int(30) NOT NULL,
  `price` double NOT NULL,
  `total` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_list`
--

INSERT INTO `order_list` (`id`, `order_id`, `product_id`, `quantity`, `price`, `total`) VALUES
(1, 1, 3, 2, 349, 698),
(2, 1, 4, 1, 250, 250),
(3, 3, 2, 1, 499, 499),
(4, 3, 3, 1, 349, 349),
(5, 4, 3, 1, 349, 349),
(6, 5, 4, 1, 250, 250),
(7, 6, 4, 1, 250, 250),
(8, 8, 3, 1, 349, 349),
(9, 10, 2, 1, 499, 499),
(10, 11, 1, 1, 800, 800),
(11, 12, 3, 1, 349, 349),
(12, 13, 3, 1, 349, 349),
(13, 13, 4, 1, 250, 250),
(14, 14, 3, 1, 349, 349),
(15, 14, 2, 1, 499, 499),
(16, 15, 2, 1, 499, 499),
(17, 16, 2, 1, 499, 499),
(18, 17, 2, 1, 499, 499),
(19, 18, 3, 1, 349, 349),
(20, 19, 1, 1, 800, 800),
(21, 20, 1, 1, 800, 800),
(22, 21, 1, 1, 800, 800),
(23, 22, 3, 1, 349, 349),
(24, 24, 1, 1, 800, 800),
(25, 24, 2, 1, 499, 499),
(26, 24, 3, 1, 349, 349),
(27, 24, 4, 2, 250, 500),
(28, 25, 4, 1, 250, 250),
(29, 26, 3, 1, 349, 349),
(30, 27, 3, 1, 349, 349),
(31, 28, 2, 1, 499, 499),
(32, 29, 3, 1, 349, 349),
(33, 30, 2, 5, 499, 2495),
(34, 31, 2, 1, 499, 499),
(35, 32, 3, 1, 349, 349),
(36, 33, 2, 1, 499, 499),
(37, 34, 2, 1, 499, 499),
(38, 35, 3, 1, 349, 349),
(39, 36, 3, 1, 349, 349);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(30) NOT NULL,
  `category_id` int(30) NOT NULL,
  `sub_category_id` int(30) NOT NULL,
  `title` varchar(250) NOT NULL,
  `brand` text NOT NULL,
  `description` text NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `category_id`, `sub_category_id`, `title`, `brand`, `description`, `status`, `date_created`) VALUES
(1, 1, 4, 'Deluxe Pet Grooming Brush', 'Paws & Co.', '&lt;p&gt;The Deluxe Pet Grooming Brush by Paws &amp;amp; Co. is a versatile tool designed to keep your pet\\&#039;s coat looking pristine. The brush features a combination of fine bristles and rounded pins that effectively remove loose fur, dirt, and tangles, leaving the coat smooth and shiny. The ergonomic handle ensures a comfortable grip during grooming sessions. Suitable for dogs and cats of all sizes and coat types, this brush promotes healthy circulation and stimulates natural oil production, resulting in a lustrous and well-groomed coat.&lt;br&gt;&lt;/p&gt;', 0, '2023-06-01 12:43:19'),
(2, 1, 4, 'Professional Dematting Comb', 'GroomPro', '&lt;p&gt;The Professional Dematting Comb by GroomPro is an essential tool for managing mats and tangles in your pet\\&#039;s coat. This comb features sharp stainless steel blades with rounded edges, specifically designed to gently remove tough tangles and mats without causing discomfort to your pet. The comfortable, non-slip handle provides control and precision while grooming. Suitable for long-haired dogs and cats, this dematting comb helps maintain a tangle-free and healthy coat, preventing matting and promoting a well-groomed appearance.&lt;br&gt;&lt;/p&gt;', 1, '2023-06-01 12:44:19'),
(3, 1, 3, 'Gentle and Natural Shampoo', 'Vitality', '&lt;p&gt;The Gentle and Natural Shampoo by Vitality is a mild and nourishing formula specifically created for pets with sensitive skin. Enriched with natural ingredients like oatmeal and aloe vera, this shampoo gently cleanses the pet\\&#039;s coat, while soothing and moisturizing the skin. It effectively removes dirt and odors, leaving behind a fresh and clean scent. Suitable for dogs and cats of all breeds, this gentle shampoo provides a gentle bathing experience that won\\&#039;t irritate or dry out the skin.&lt;br&gt;&lt;/p&gt;', 1, '2023-06-01 12:50:55'),
(4, 1, 3, 'Organic Dog Conditioner', 'Saint Roche', '&lt;p&gt;The Organic Dog Conditioner by Saint Roche is a luxurious treatment for your pet\\&#039;s coat. Formulated with a blend of nourishing oils and botanical extracts, this conditioner deeply hydrates and replenishes dry and damaged fur. It helps to detangle knots, leaving the coat soft, silky, and easy to manage. This conditioner also provides a protective layer that helps prevent future damage and promotes a healthy, glossy appearance. Suitable for all coat types and safe for regular use.&lt;br&gt;&lt;/p&gt;', 0, '2023-06-01 12:55:11');

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` int(30) NOT NULL,
  `order_id` int(30) NOT NULL,
  `total_amount` double NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `order_id`, `total_amount`, `date_created`) VALUES
(1, 1, 0, '2023-06-01 14:05:55'),
(2, 3, 0, '2023-06-01 14:07:14'),
(3, 4, 0, '2023-06-01 14:08:56'),
(4, 5, 250, '2023-06-01 14:09:25'),
(5, 6, 250, '2023-06-01 14:16:11'),
(6, 8, 349, '2023-06-01 14:18:21'),
(7, 10, 499, '2023-06-01 14:19:08'),
(8, 11, 800, '2023-06-01 14:21:16'),
(9, 12, 349, '2023-06-01 14:25:10'),
(10, 13, 599, '2023-06-01 14:28:12'),
(11, 14, 848, '2023-06-01 14:31:12'),
(12, 15, 499, '2023-06-01 14:33:27'),
(13, 16, 499, '2023-06-01 14:37:33'),
(14, 17, 499, '2023-06-01 14:54:51'),
(15, 18, 0, '2023-06-01 14:58:52'),
(16, 19, 800, '2023-06-01 15:10:36'),
(17, 20, 800, '2023-06-01 15:14:19'),
(18, 21, 800, '2023-06-01 15:18:48'),
(19, 22, 349, '2023-06-01 15:22:27'),
(20, 24, 2148, '2023-06-01 15:39:13'),
(21, 25, 250, '2023-06-01 17:10:57'),
(22, 26, 349, '2023-06-02 16:47:01'),
(23, 27, 349, '2023-06-02 17:05:38'),
(24, 28, 499, '2023-06-02 17:25:12'),
(25, 29, 349, '2023-06-03 09:00:49'),
(26, 30, 2495, '2023-06-03 09:38:29'),
(27, 31, 499, '2023-06-03 10:16:21'),
(28, 32, 349, '2023-06-03 10:33:14'),
(29, 33, 499, '2023-06-03 10:39:39'),
(30, 34, 499, '2023-06-03 10:41:23'),
(31, 35, 349, '2023-06-03 10:49:56'),
(32, 36, 349, '2023-06-03 11:31:23');

-- --------------------------------------------------------

--
-- Table structure for table `sub_categories`
--

CREATE TABLE `sub_categories` (
  `id` int(30) NOT NULL,
  `parent_id` int(30) NOT NULL,
  `sub_category` varchar(250) NOT NULL,
  `description` text NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sub_categories`
--

INSERT INTO `sub_categories` (`id`, `parent_id`, `sub_category`, `description`, `status`, `date_created`) VALUES
(2, 2, 'Orthopedic Pet Beds', '&lt;p&gt;The Orthopedic Pet Beds subcategory offers a specialized selection of beds designed to provide optimal support and comfort for pets, particularly those with joint or mobility issues. These beds are crafted with high-quality orthopedic foam that conforms to the pet&#039;s body, relieving pressure points and promoting better sleep. The orthopedic design helps alleviate discomfort and provides additional support for pets with arthritis, senior pets, or those recovering from surgery or injury. Our range of orthopedic pet beds prioritizes the well-being and comfort of pets, ensuring they enjoy a restful and rejuvenating sleep, making it an ideal choice for pet owners looking to enhance their pet&#039;s quality of life.&lt;br&gt;&lt;/p&gt;', 0, '2023-06-01 12:37:02'),
(3, 1, 'Shampoos and Conditioners', '&lt;p&gt;The Pet Shampoos and Conditioners subcategory offers a variety of specially formulated products for bathing and conditioning pets. Our range includes gentle and nourishing shampoos that effectively cleanse the pet&#039;s coat, remove dirt and odors, while being gentle on their skin. Additionally, we provide a selection of conditioning products designed to moisturize and soften the pet&#039;s fur, leaving it shiny, smooth, and manageable. These shampoos and conditioners are formulated with pet-safe ingredients, ensuring they are suitable for pets of all breeds and coat types. Pamper your pet with our high-quality grooming products, designed to keep their coat healthy, clean, and beautifully conditioned.&lt;br&gt;&lt;/p&gt;', 1, '2023-06-01 12:40:07'),
(4, 1, 'Brushes and Combs', '&lt;p&gt;he Pet Grooming Brushes and Combs subcategory features a range of grooming tools designed to keep your pet&#039;s coat looking its best. We offer various brushes and combs suitable for different coat types and lengths. Our selection includes slicker brushes for removing loose fur and tangles, bristle brushes for distributing natural oils and enhancing shine, and deshedding tools for managing excessive shedding. Additionally, we provide specialized combs for detangling, dematting, and maintaining a well-groomed appearance. With our grooming brushes and combs, you can easily groom your pet and promote a healthy coat while fostering a bond between you and your furry friend.&lt;br&gt;&lt;/p&gt;', 1, '2023-06-01 12:40:20');

-- --------------------------------------------------------

--
-- Table structure for table `system_info`
--

CREATE TABLE `system_info` (
  `id` int(30) NOT NULL,
  `meta_field` text NOT NULL,
  `meta_value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `system_info`
--

INSERT INTO `system_info` (`id`, `meta_field`, `meta_value`) VALUES
(1, 'name', 'CritterHaven'),
(2, 'short_name', 'CH'),
(3, 'logo', 'uploads/1685688360_ch-logo.png'),
(4, 'cover', 'uploads/1685688420_Theme_Dog_Friendly_Landscaping.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(50) NOT NULL,
  `firstname` varchar(250) NOT NULL,
  `lastname` varchar(250) NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `avatar` text DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `type` tinyint(1) NOT NULL DEFAULT 0,
  `date_added` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `username`, `password`, `avatar`, `last_login`, `type`, `date_added`, `date_updated`) VALUES
(1, 'Calvin Kent', 'Pamandanan', 'admin', '5f4dcc3b5aa765d61d8327deb882cf99', '', '2023-05-31 10:00:00', 1, '2023-06-01 12:25:14', '2023-06-01 12:26:29');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `inventory_id` (`inventory_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `updated_by` (`updated_by`);

--
-- Indexes for table `order_list`
--
ALTER TABLE `order_list`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `sub_category_id` (`sub_category_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Indexes for table `system_info`
--
ALTER TABLE `system_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `order_list`
--
ALTER TABLE `order_list`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `sub_categories`
--
ALTER TABLE `sub_categories`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `system_info`
--
ALTER TABLE `system_info`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`id`);

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `order_list`
--
ALTER TABLE `order_list`
  ADD CONSTRAINT `order_list_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `order_list_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`id`);

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

--
-- Constraints for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD CONSTRAINT `sub_categories_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
