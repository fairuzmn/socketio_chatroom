-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 14, 2021 at 03:48 AM
-- Server version: 10.4.6-MariaDB
-- PHP Version: 7.3.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `socketio_chat`
--

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `sender` varchar(255) NOT NULL,
  `receiver` varchar(255) NOT NULL,
  `message` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `sender`, `receiver`, `message`) VALUES
(10, 'firefox', 'chrome', 'test'),
(11, 'chrome', 'firefox', 'test'),
(12, 'chrome', 'firefox', 'testaasfdasf'),
(13, 'firefox', 'chrome', 'testasfd'),
(14, 'chrome', 'firefox', 'halo'),
(15, 'firefox', 'chrome', 'testasfd'),
(16, 'firefox', 'chrome', 'testasfd'),
(17, 'firefox', 'chrome', 'testasfd'),
(18, 'firefox', 'chrome', 'testasfd'),
(19, 'firefox', 'chrome', 'testasfd'),
(20, 'firefox', 'chrome', 'halo');

-- --------------------------------------------------------

--
-- Table structure for table `r_chat_room`
--

CREATE TABLE `r_chat_room` (
  `id_room` int(11) NOT NULL,
  `id_user1` int(11) NOT NULL,
  `id_user2` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `r_chat_room`
--

INSERT INTO `r_chat_room` (`id_room`, `id_user1`, `id_user2`) VALUES
(3, 1, 2),
(4, 2, 3),
(5, 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `r_chat_room_dtl`
--

CREATE TABLE `r_chat_room_dtl` (
  `id_dtl` int(11) NOT NULL,
  `id_room` int(11) NOT NULL,
  `id_user_chat` int(11) NOT NULL,
  `id_user_chat_to` int(11) NOT NULL,
  `tgl` timestamp NOT NULL DEFAULT current_timestamp(),
  `chat` text NOT NULL,
  `klik` int(11) DEFAULT 0,
  `id_drgud` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `r_chat_room_dtl`
--

INSERT INTO `r_chat_room_dtl` (`id_dtl`, `id_room`, `id_user_chat`, `id_user_chat_to`, `tgl`, `chat`, `klik`, `id_drgud`) VALUES
(24, 3, 1, 2, '2021-01-13 15:50:25', 'hai ', 0, 0),
(25, 3, 2, 1, '2021-01-13 15:59:31', 'halo', 0, 0),
(26, 3, 2, 1, '2021-01-13 16:00:30', 'hai', 0, 0),
(27, 3, 1, 2, '2021-01-13 16:00:32', 'tes', 0, 0),
(28, 3, 2, 1, '2021-01-13 16:33:04', 'tes', 0, 0),
(29, 3, 1, 2, '2021-01-13 16:52:04', 'halo', 0, 0),
(30, 3, 2, 1, '2021-01-13 16:52:23', 'tes', 0, 0),
(31, 3, 2, 1, '2021-01-13 16:52:26', 'hai', 0, 0),
(32, 3, 1, 2, '2021-01-13 16:52:30', 'iya', 0, 0),
(33, 3, 1, 2, '2021-01-13 17:04:42', 'halo', 0, 0),
(34, 3, 2, 1, '2021-01-13 17:04:50', 'iya', 0, 0),
(35, 3, 1, 2, '2021-01-13 17:14:59', 'halo', 0, 0),
(36, 3, 1, 2, '2021-01-13 17:15:02', 'uy ', 0, 0),
(37, 3, 1, 2, '2021-01-13 17:17:30', 'halo', 0, 0),
(38, 3, 2, 1, '2021-01-13 17:22:24', 'apa', 0, 0),
(39, 3, 2, 1, '2021-01-13 17:23:14', 'tes', 0, 0),
(40, 3, 2, 1, '2021-01-13 17:24:55', 'tes', 0, 0),
(41, 3, 2, 1, '2021-01-13 17:24:57', 'halo', 0, 0),
(42, 3, 1, 2, '2021-01-13 17:28:25', 'tes', 0, 0),
(43, 4, 2, 3, '2021-01-13 17:39:35', 'halo', 0, 0),
(44, 3, 2, 1, '2021-01-13 17:39:48', 'tse', 0, 0),
(45, 4, 2, 3, '2021-01-13 17:39:53', 'apa', 0, 0),
(46, 5, 3, 1, '2021-01-13 17:48:06', 'halo', 0, 0),
(47, 5, 3, 1, '2021-01-13 17:48:09', 'tes', 0, 0),
(48, 3, 2, 1, '2021-01-13 17:51:24', 'res', 0, 0),
(49, 5, 3, 1, '2021-01-13 17:51:29', 'res', 0, 0),
(50, 5, 3, 1, '2021-01-13 17:51:32', 'hah', 0, 0),
(51, 3, 1, 2, '2021-01-13 17:52:34', 'apa', 0, 0),
(52, 5, 1, 3, '2021-01-13 17:52:45', 'halo', 0, 0),
(53, 3, 2, 1, '2021-01-13 17:57:38', 'halo', 0, 0),
(54, 3, 2, 1, '2021-01-13 17:57:49', 'apa', 0, 0),
(55, 3, 2, 1, '2021-01-13 18:01:40', 'tse', 0, 0),
(56, 3, 2, 1, '2021-01-13 18:02:46', 'asdf', 0, 0),
(57, 3, 2, 1, '2021-01-13 18:20:51', 'asf', 0, 0),
(58, 3, 2, 1, '2021-01-13 18:20:56', 'asasf', 0, 0),
(59, 3, 2, 1, '2021-01-13 18:24:19', 'halo', 0, 0),
(60, 3, 1, 2, '2021-01-13 18:24:24', 'hai juga', 0, 0),
(61, 3, 1, 2, '2021-01-13 18:26:51', 'tes', 0, 0),
(62, 3, 2, 1, '2021-01-13 18:27:17', 'asdf', 0, 0),
(63, 3, 2, 1, '2021-01-13 18:27:26', 'asfdasf', 0, 0),
(64, 3, 2, 1, '2021-01-13 18:27:29', 'asdf', 0, 0),
(65, 3, 2, 1, '2021-01-13 18:28:18', 'halo', 0, 0),
(66, 3, 1, 2, '2021-01-13 18:28:23', 'tes', 0, 0),
(67, 3, 1, 2, '2021-01-13 18:28:38', 'p', 0, 0),
(68, 3, 2, 1, '2021-01-13 18:28:42', 'blok', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `password` varchar(50) DEFAULT NULL,
  `last_online` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `name`, `password`, `last_online`) VALUES
(1, 'admin', 'Administrator', 'admin', '2021-01-11 17:51:01'),
(2, 'reza', 'Reza Syaputra', 'reza', '2021-01-13 14:22:11'),
(3, 'virus', 'Virus', 'virus', '2021-01-13 17:26:50');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `r_chat_room`
--
ALTER TABLE `r_chat_room`
  ADD PRIMARY KEY (`id_room`);

--
-- Indexes for table `r_chat_room_dtl`
--
ALTER TABLE `r_chat_room_dtl`
  ADD PRIMARY KEY (`id_dtl`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `r_chat_room`
--
ALTER TABLE `r_chat_room`
  MODIFY `id_room` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `r_chat_room_dtl`
--
ALTER TABLE `r_chat_room_dtl`
  MODIFY `id_dtl` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
