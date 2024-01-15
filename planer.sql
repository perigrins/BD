-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 15, 2024 at 10:41 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `planer`
--

-- --------------------------------------------------------

--
-- Table structure for table `Działy`
--

CREATE TABLE `Działy` (
  `idDzialu` int(11) NOT NULL,
  `nazwa_Dzialu` varchar(45) DEFAULT NULL,
  `idFilii` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Dumping data for table `Działy`
--

INSERT INTO `Działy` (`idDzialu`, `nazwa_Dzialu`, `idFilii`) VALUES
(1, 'Dział Rozwoju', 5),
(2, 'Dział Marketingu', 3),
(3, 'Dział Zasobów Ludzkich', 8),
(4, 'Dział Finansów', 2),
(5, 'Dział Obsługi Klienta', 7),
(6, 'Dział Technologii Informacyjnych', 4),
(7, 'Dział Sprzedaży', 6),
(8, 'Dział Badań i Rozwoju', 1),
(9, 'Dział Operacyjny', 9),
(10, 'Finance Department', 2),
(11, 'Marketing Department', 3),
(12, 'Product Development Department', 5),
(13, 'HR Operations Department', 8),
(14, 'Customer Experience Department', 7),
(15, 'Sales and Marketing Department', 6),
(16, 'Innovation Department', 1),
(17, 'Technology Department', 4),
(18, 'Operations and Logistics Department', 9),
(19, 'Financial Planning Department', 2);

-- --------------------------------------------------------

--
-- Table structure for table `Filie`
--

CREATE TABLE `Filie` (
  `idFilii` int(11) NOT NULL,
  `nazwa_Filii` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Dumping data for table `Filie`
--

INSERT INTO `Filie` (`idFilii`, `nazwa_Filii`) VALUES
(1, 'Main Office'),
(2, 'Central Hub'),
(3, 'Regional Center'),
(4, 'Corporate Headquarters'),
(5, 'Local Office'),
(6, 'Division Office'),
(7, 'Branch Headquarters'),
(8, 'Area Office'),
(9, 'Global Center');

-- --------------------------------------------------------

--
-- Table structure for table `Grafik`
--

CREATE TABLE `Grafik` (
  `idGrafiku` int(11) NOT NULL,
  `godzina_rozpoczecia` time DEFAULT NULL,
  `godzina_zakonczenia` time DEFAULT NULL,
  `ilosc_godzin` int(11) DEFAULT NULL,
  `dzien_tygodnia` varchar(45) DEFAULT NULL,
  `idPracownika` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Pracownicy`
--

CREATE TABLE `Pracownicy` (
  `idPracownika` int(11) NOT NULL,
  `imie_pracownika` varchar(45) DEFAULT NULL,
  `nazwisko_pracownika` varchar(45) DEFAULT NULL,
  `stanowisko` varchar(45) DEFAULT NULL,
  `idFilii` int(11) DEFAULT NULL,
  `idZespolu` int(11) DEFAULT NULL,
  `idDzialu` int(11) DEFAULT NULL,
  `haslo` varchar(45) DEFAULT NULL,
  `idGrafiku` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Pracownicy_has_Spotkania`
--

CREATE TABLE `Pracownicy_has_Spotkania` (
  `idSpotkania` int(11) NOT NULL,
  `idPracownika` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Sale`
--

CREATE TABLE `Sale` (
  `nr_Sali` int(11) NOT NULL,
  `godzina_spotkania` varchar(45) DEFAULT NULL,
  `dzien_tygodnia` varchar(45) DEFAULT NULL,
  `max_liczba_uczestnikow` int(11) DEFAULT NULL,
  `idFilii` int(11) DEFAULT NULL,
  `idSpotkania` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Spotkania`
--

CREATE TABLE `Spotkania` (
  `idSpotkania` int(11) NOT NULL,
  `nr_Sali` int(11) DEFAULT NULL,
  `idPracownika` int(11) DEFAULT NULL,
  `idZespołu` int(11) DEFAULT NULL,
  `idDzialu` int(11) DEFAULT NULL,
  `idFilii` int(11) DEFAULT NULL,
  `max_liczba_uczestnikow` int(11) DEFAULT NULL,
  `uczestnicy` int(11) DEFAULT NULL,
  `godzina_spotkania` time DEFAULT NULL,
  `dzien_tygodnia` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ZespółProjektowy`
--

CREATE TABLE `ZespółProjektowy` (
  `idZespołu` int(11) NOT NULL,
  `nazwa_Zespołu` varchar(45) DEFAULT NULL,
  `idDzialu` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Dumping data for table `ZespółProjektowy`
--

INSERT INTO `ZespółProjektowy` (`idZespołu`, `nazwa_Zespołu`, `idDzialu`) VALUES
(1, 'Zespół Kreatywny A', 5),
(2, 'Zespół Marketingowy B', 3),
(3, 'Zespół Programistyczny C', 8),
(4, 'Zespół Finansowy D', 2),
(5, 'Zespół Obsługi Klienta E', 7),
(6, 'Zespół IT F', 4),
(7, 'Zespół Sprzedażowy G', 6),
(8, 'Zespół Badawczy H', 1),
(9, 'Zespół Operacyjny I', 9),
(10, 'Zespół Finansowy J', 2),
(11, 'Zespół Marketingowy K', 3),
(12, 'Zespół Rozwoju Produktu L', 5),
(13, 'Zespół HR M', 18),
(14, 'Zespół Obsługi Klienta N', 17),
(15, 'Zespół Sprzedażowo-Marketingowy O', 6),
(16, 'Zespół Innowacyjny P', 1),
(17, 'Zespół Technologiczny Q', 4),
(18, 'Zespół Operacyjno-Logistyczny R', 9),
(19, 'Zespół Planowania Finansowego S', 2),
(20, 'Zespół Wsparcia Technicznego T', 7),
(21, 'Zespół Marketingu Produktu U', 15),
(22, 'Zespół Analityczny V', 3),
(23, 'Zespół Projektowy W', 8),
(24, 'Zespół Finansowo-Księgowy X', 2),
(25, 'Zespół Zarządzania Projektami Y', 7),
(26, 'Zespół Integracji Systemów Z', 6),
(27, 'Zespół Szkoleniowy AA', 4),
(28, 'Zespół Badań Rynkowych AB', 1),
(29, 'Zespół Planowania Strategicznego AC', 9),
(30, 'Zespół Graficzny AD', 5),
(31, 'Zespół Bezpieczeństwa Informatycznego AE', 3),
(32, 'Zespół Wdrożeń Systemów AF', 8),
(33, 'Zespół Księgowy AG', 2),
(34, 'Zespół Analiz Biznesowych AH', 7),
(35, 'Zespół User Experience AI', 6),
(36, 'Zespół Testów Oprogramowania AJ', 1),
(37, 'Zespół Zarządzania Ryzykiem AK', 4),
(38, 'Zespół Integracji Produktów AL', 9),
(39, 'Zespół Customer Success AM', 2),
(40, 'Zespół Marketingu Online AN', 7),
(41, 'Zespół E-commerce AO', 5),
(42, 'Zespół Architektury Systemów AP', 3),
(43, 'Zespół Finansów Korporacyjnych AQ', 8),
(44, 'Zespół Inżynierii Oprogramowania AR', 2),
(45, 'Zespół Customer Insights AS', 7),
(46, 'Zespół Projektów Specjalnych AT', 6),
(47, 'Zespół Logistyki AU', 4),
(48, 'Zespół Implementacji Systemów AV', 1),
(49, 'Zespół Automatyzacji Biznesowej AW', 9),
(50, 'Zespół Wsparcia Klienta AX', 5),
(51, 'Zespół Badawczo-Rozwojowy AY', 3),
(52, 'Zespół Systemów ERP AZ', 8),
(53, 'Zespół Analizy Danych BA', 2),
(54, 'Zespół Eventów i Konferencji BB', 7),
(55, 'Zespół Content Marketing BC', 6),
(56, 'Zespół Systemów CRM BD', 1),
(57, 'Zespół Zarządzania Produktami BE', 4),
(58, 'Zespół Zarządzania Projektami IT BF', 9),
(59, 'Zespół Rozwoju Aplikacji Mobilnych BG', 2),
(60, 'Zespół Obsługi Technicznej BH', 7),
(61, 'Zespół Analizy Ryzyka BI', 5),
(62, 'Zespół Cloud Computing BJ', 13),
(63, 'Zespół Systemów Business Intelligence BK', 8),
(64, 'Zespół Rozwoju Talentów BL', 2),
(65, 'Zespół Inżynierii Ruchu Online BM', 7),
(66, 'Zespół Zarządzania Wiedzą BN', 6),
(67, 'Zespół Kryzysowy BO', 14),
(68, 'Zespół Bezpieczeństwa Produktów BP', 11),
(69, 'Zespół Architektury Rozwiązań BQ', 9),
(70, 'Zespół Wdrażania Innowacji BR', 5);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Działy`
--
ALTER TABLE `Działy`
  ADD PRIMARY KEY (`idDzialu`),
  ADD KEY `idFilii` (`idFilii`);

--
-- Indexes for table `Filie`
--
ALTER TABLE `Filie`
  ADD PRIMARY KEY (`idFilii`);

--
-- Indexes for table `Grafik`
--
ALTER TABLE `Grafik`
  ADD PRIMARY KEY (`idGrafiku`),
  ADD KEY `index_grafik_pracownicy` (`idPracownika`);

--
-- Indexes for table `Pracownicy`
--
ALTER TABLE `Pracownicy`
  ADD PRIMARY KEY (`idPracownika`),
  ADD KEY `idDzialu` (`idDzialu`),
  ADD KEY `idFilii` (`idFilii`),
  ADD KEY `index_pracownicy_grafik` (`idGrafiku`);

--
-- Indexes for table `Pracownicy_has_Spotkania`
--
ALTER TABLE `Pracownicy_has_Spotkania`
  ADD PRIMARY KEY (`idPracownika`,`idSpotkania`),
  ADD KEY `idSpotkania` (`idSpotkania`);

--
-- Indexes for table `Sale`
--
ALTER TABLE `Sale`
  ADD PRIMARY KEY (`nr_Sali`),
  ADD KEY `idSpotkania` (`idSpotkania`),
  ADD KEY `idFilii` (`idFilii`);

--
-- Indexes for table `Spotkania`
--
ALTER TABLE `Spotkania`
  ADD PRIMARY KEY (`idSpotkania`),
  ADD KEY `nr_Sali` (`nr_Sali`);

--
-- Indexes for table `ZespółProjektowy`
--
ALTER TABLE `ZespółProjektowy`
  ADD PRIMARY KEY (`idZespołu`),
  ADD KEY `idDzialu` (`idDzialu`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Działy`
--
ALTER TABLE `Działy`
  ADD CONSTRAINT `Działy_ibfk_1` FOREIGN KEY (`idFilii`) REFERENCES `Filie` (`idFilii`);

--
-- Constraints for table `Grafik`
--
ALTER TABLE `Grafik`
  ADD CONSTRAINT `Grafik_ibfk_1` FOREIGN KEY (`idPracownika`) REFERENCES `Pracownicy` (`idPracownika`);

--
-- Constraints for table `Pracownicy`
--
ALTER TABLE `Pracownicy`
  ADD CONSTRAINT `Pracownicy_ibfk_1` FOREIGN KEY (`idGrafiku`) REFERENCES `Grafik` (`idGrafiku`),
  ADD CONSTRAINT `Pracownicy_ibfk_2` FOREIGN KEY (`idDzialu`) REFERENCES `Działy` (`idDzialu`),
  ADD CONSTRAINT `Pracownicy_ibfk_3` FOREIGN KEY (`idFilii`) REFERENCES `Filie` (`idFilii`);

--
-- Constraints for table `Pracownicy_has_Spotkania`
--
ALTER TABLE `Pracownicy_has_Spotkania`
  ADD CONSTRAINT `Pracownicy_has_Spotkania_ibfk_1` FOREIGN KEY (`idSpotkania`) REFERENCES `Spotkania` (`idSpotkania`),
  ADD CONSTRAINT `Pracownicy_has_Spotkania_ibfk_2` FOREIGN KEY (`idPracownika`) REFERENCES `Pracownicy` (`idPracownika`);

--
-- Constraints for table `Sale`
--
ALTER TABLE `Sale`
  ADD CONSTRAINT `Sale_ibfk_1` FOREIGN KEY (`idSpotkania`) REFERENCES `Spotkania` (`idSpotkania`),
  ADD CONSTRAINT `Sale_ibfk_2` FOREIGN KEY (`idFilii`) REFERENCES `Filie` (`idFilii`);

--
-- Constraints for table `Spotkania`
--
ALTER TABLE `Spotkania`
  ADD CONSTRAINT `Spotkania_ibfk_1` FOREIGN KEY (`nr_Sali`) REFERENCES `Sale` (`nr_Sali`);

--
-- Constraints for table `ZespółProjektowy`
--
ALTER TABLE `ZespółProjektowy`
  ADD CONSTRAINT `ZespółProjektowy_ibfk_1` FOREIGN KEY (`idDzialu`) REFERENCES `Działy` (`idDzialu`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
