-- phpMyAdmin SQL Dump
-- version 4.5.5.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 2017-03-26 16:08:56
-- 服务器版本： 5.7.11
-- PHP Version: 5.5.36

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `stock`
--

-- --------------------------------------------------------

--
-- 表的结构 `bigtrade2`
--



-- --------------------------------------------------------

--
-- 表的结构 `statistics`
--

CREATE TABLE `statistics` (
  `id` int(11) NOT NULL,
  `person` varchar(32) NOT NULL,
  `num` int(8) DEFAULT '1',
  `success` int(8) NOT NULL DEFAULT '0',
  `rate` int(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `ten`
--

CREATE TABLE `ten` (
  `id` int(32) NOT NULL,
  `person` varchar(32) NOT NULL,
  `sucNum` int(4) NOT NULL,
  `rate` varchar(16) NOT NULL,
  `name` varchar(16) NOT NULL,
  `code` varchar(8) NOT NULL,
  `pdate` datetime NOT NULL,
  `price` double DEFAULT NULL,
  `sdate` varchar(16) DEFAULT NULL,
  `success` int(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Indexes for dumped tables
--

--
-- Indexes for table `bigtrade`
--


--
-- Indexes for table `statistics`
--
ALTER TABLE `statistics`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ten`
--

ALTER TABLE `ten`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `update` (`person`,`code`,`pdate`,`price`) USING BTREE;
--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `statistics`
--
ALTER TABLE `statistics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `ten`
--
ALTER TABLE `ten`
  MODIFY `id` int(32) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
