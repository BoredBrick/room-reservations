-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 08, 2023 at 01:25 PM
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
-- Database: `room_reservations`
--

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `capacity` int(2) NOT NULL,
  `building` varchar(30) NOT NULL,
  `hasProjector` double NOT NULL,
  `hasWhiteboard` double NOT NULL,
  `hasWifi` double NOT NULL,
  `imagePath` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `name`, `capacity`, `building`, `hasProjector`, `hasWhiteboard`, `hasWifi`, `imagePath`) VALUES
(57, 'IKTLab', 20, 'BB218', 1, 1, 1, 'e502b0f8-ec21-4f64-8aa7-12fb8da5b1ca_IKTlab.png'),
(58, 'ElektronikLab', 12, 'BC313', 1, 1, 0, '3e3e9a38-3de0-459f-b7ef-268ff2ed5b04_Elektro.png'),
(59, 'AutotronikLab', 12, 'BC123', 1, 1, 0, '251ea0cf-9d7c-432d-8097-4f68d649230b_auto.png'),
(61, 'ElektroMagLab', 2, 'BB321', 0, 0, 0, 'a7b8af75-c607-4f3d-acaa-305041e66dba_elektromag.png'),
(62, 'DeleteRoom', 50, 'FakeBuild', 0, 1, 1, '');

-- --------------------------------------------------------

--
-- Table structure for table `room_reservations`
--

CREATE TABLE `room_reservations` (
  `reservation_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `room_reservations`
--

INSERT INTO `room_reservations` (`reservation_id`, `user_id`, `room_id`, `start_time`, `end_time`) VALUES
(13, 17, 57, '2023-05-11 06:30:00', '2023-05-11 07:00:00'),
(15, 17, 57, '2023-05-11 06:20:00', '2023-05-11 06:25:00');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(60) NOT NULL,
  `isAdmin` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `username`, `password`, `isAdmin`) VALUES
(17, 'danielcaban@email.com', 'Danči', '$2a$10$/Ge3A6S2r6uGuupaXEbvxeXXw6RLfrmygkbcJMfYKp36bmGpR8bqq', 1),
(18, 'olga.spagetova@email.com', 'Špagetka', '$2a$10$NIbo1Iv7IFAdo19l6NBErOm8rHvGNjdz8Q5h/5OXnsIcdPd4zDsDa', 0),
(19, 'romanhrachovina@email.com', 'Hraško', '$2a$10$nJTrO2LHX3iXRVkbLW.17.lAEKrv3GPhkN4rugVBC0ljAyqbtzFRy', 1),
(20, 'helenasyrovatakova@email.com', 'Syrovka', '$2a$10$9i8FTDMkBN70RDzQ7E6zIOTRt1n1zvsnrZz0/OsewJgaFUHBo45ke', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `room_reservations`
--
ALTER TABLE `room_reservations`
  ADD PRIMARY KEY (`reservation_id`),
  ADD UNIQUE KEY `unique_room_booking` (`room_id`,`start_time`,`end_time`),
  ADD KEY `fk_user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `room_reservations`
--
ALTER TABLE `room_reservations`
  MODIFY `reservation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `room_reservations`
--
ALTER TABLE `room_reservations`
  ADD CONSTRAINT `fk_room_id` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`),
  ADD CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

DELIMITER $$
--
-- Events
--
$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
