-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 20, 2017 at 08:36 AM
-- Server version: 10.1.25-MariaDB
-- PHP Version: 7.1.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `penjadwalan`
--
CREATE DATABASE IF NOT EXISTS `penjadwalan` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `penjadwalan`;

-- --------------------------------------------------------

--
-- Table structure for table `blok`
--

CREATE TABLE `blok` (
  `id_blok` varchar(255) NOT NULL,
  `semester` int(11) NOT NULL,
  `tahun_ajaran` varchar(10) NOT NULL,
  `angkatan` varchar(4) NOT NULL,
  `nomor` tinyint(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dosen`
--

CREATE TABLE `dosen` (
  `id_dosen` varchar(255) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `nama_lengkap` varchar(255) NOT NULL,
  `status` enum('aktif','tidak aktif','belajar','') NOT NULL,
  `keahlian` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `jadwal`
--

CREATE TABLE `jadwal` (
  `id_jadwal` varchar(255) NOT NULL,
  `id_ruang` varchar(255) NOT NULL,
  `id_blok` varchar(255) NOT NULL,
  `id_kelas` varchar(255) NOT NULL,
  `hari` datetime NOT NULL,
  `minggu_ke` tinyint(4) NOT NULL,
  `pertemuan_ke` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `jenis_pemb`
--

CREATE TABLE `jenis_pemb` (
  `id_jp` varchar(255) NOT NULL COMMENT 'primary key jenis_pembelajaran',
  `nama_jp` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `kelas`
--

CREATE TABLE `kelas` (
  `id_kelas` varchar(255) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `sks` int(11) NOT NULL,
  `id_jp` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ruang`
--

CREATE TABLE `ruang` (
  `id_ruang` varchar(255) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `alamat` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sesi`
--

CREATE TABLE `sesi` (
  `id_sesi` varchar(255) NOT NULL,
  `mulai` datetime NOT NULL,
  `akhir` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `trx_jdw_dosen`
--

CREATE TABLE `trx_jdw_dosen` (
  `id_trx_jd` varchar(255) NOT NULL,
  `id_dosen` varchar(255) NOT NULL,
  `id_jadwal` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `trx_jdw_sesi`
--

CREATE TABLE `trx_jdw_sesi` (
  `id_trx_js` varchar(255) NOT NULL,
  `id_jadwal` varchar(255) NOT NULL,
  `id_sesi` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `blok`
--
ALTER TABLE `blok`
  ADD PRIMARY KEY (`id_blok`);

--
-- Indexes for table `dosen`
--
ALTER TABLE `dosen`
  ADD PRIMARY KEY (`id_dosen`);

--
-- Indexes for table `jadwal`
--
ALTER TABLE `jadwal`
  ADD PRIMARY KEY (`id_jadwal`),
  ADD KEY `id_ruang` (`id_ruang`),
  ADD KEY `id_blok` (`id_blok`),
  ADD KEY `id_kelas` (`id_kelas`);

--
-- Indexes for table `jenis_pemb`
--
ALTER TABLE `jenis_pemb`
  ADD PRIMARY KEY (`id_jp`);

--
-- Indexes for table `kelas`
--
ALTER TABLE `kelas`
  ADD PRIMARY KEY (`id_kelas`),
  ADD UNIQUE KEY `id_jp` (`id_jp`);

--
-- Indexes for table `ruang`
--
ALTER TABLE `ruang`
  ADD PRIMARY KEY (`id_ruang`);

--
-- Indexes for table `sesi`
--
ALTER TABLE `sesi`
  ADD PRIMARY KEY (`id_sesi`);

--
-- Indexes for table `trx_jdw_dosen`
--
ALTER TABLE `trx_jdw_dosen`
  ADD PRIMARY KEY (`id_trx_jd`),
  ADD UNIQUE KEY `id_dosen` (`id_dosen`),
  ADD UNIQUE KEY `id_jadwal` (`id_jadwal`);

--
-- Indexes for table `trx_jdw_sesi`
--
ALTER TABLE `trx_jdw_sesi`
  ADD PRIMARY KEY (`id_trx_js`),
  ADD UNIQUE KEY `id_sesi` (`id_sesi`),
  ADD KEY `id_jadwal` (`id_jadwal`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `jadwal`
--
ALTER TABLE `jadwal`
  ADD CONSTRAINT `fk_jadwal_blok` FOREIGN KEY (`id_blok`) REFERENCES `blok` (`id_blok`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_jadwal_kelas` FOREIGN KEY (`id_kelas`) REFERENCES `kelas` (`id_kelas`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_jadwal_ruang` FOREIGN KEY (`id_ruang`) REFERENCES `ruang` (`id_ruang`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kelas`
--
ALTER TABLE `kelas`
  ADD CONSTRAINT `fk_kelas_jp` FOREIGN KEY (`id_jp`) REFERENCES `jenis_pemb` (`id_jp`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_jdw_dosen`
--
ALTER TABLE `trx_jdw_dosen`
  ADD CONSTRAINT `fk_trx_dosen` FOREIGN KEY (`id_dosen`) REFERENCES `dosen` (`id_dosen`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_trx_jadwal` FOREIGN KEY (`id_jadwal`) REFERENCES `jadwal` (`id_jadwal`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_jdw_sesi`
--
ALTER TABLE `trx_jdw_sesi`
  ADD CONSTRAINT `fk_trx_sesi` FOREIGN KEY (`id_sesi`) REFERENCES `sesi` (`id_sesi`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
