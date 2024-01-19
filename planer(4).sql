-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 19, 2024 at 01:55 PM
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
  `idFilii` int(11) NOT NULL
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
(8, 'Area Office'),
(7, 'Branch Headquarters'),
(2, 'Central Hub'),
(4, 'Corporate Headquarters'),
(6, 'Division Office'),
(9, 'Global Center'),
(5, 'Local Office'),
(1, 'Main Office'),
(3, 'Regional Center');

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
  `idPracownika` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Dumping data for table `Grafik`
--

INSERT INTO `Grafik` (`idGrafiku`, `godzina_rozpoczecia`, `godzina_zakonczenia`, `ilosc_godzin`, `dzien_tygodnia`, `idPracownika`) VALUES
(1, '08:00:00', '15:00:00', 7, 'Poniedziałek', 1),
(2, '10:00:00', '17:00:00', 7, 'Wtorek', 1),
(3, '09:00:00', '18:00:00', 9, 'Poniedziałek', 2),
(4, '08:00:00', '11:00:00', 3, 'Środa', 1),
(5, '08:00:00', '18:00:00', 10, 'Czwartek', 1),
(6, '08:00:00', '18:00:00', 10, 'Piątek', 1),
(7, '08:00:00', '16:00:00', 8, 'Wtorek', 3);

--
-- Triggers `Grafik`
--
DELIMITER $$
CREATE TRIGGER `grafik_8_18` BEFORE INSERT ON `Grafik` FOR EACH ROW BEGIN
    IF NEW.godzina_rozpoczecia < '08:00:00' OR NEW.godzina_rozpoczecia >'18:00:00' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Grafik można dodać jedynie w godzinach 8:00 - 18:00.';
    END IF;

    IF NEW.godzina_zakonczenia < '08:00:00' OR NEW.godzina_zakonczenia > '18:00:00' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Grafik można dodać jedynie w godzinach 8:00 - 18:00.';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `grafik_dni` BEFORE INSERT ON `Grafik` FOR EACH ROW BEGIN
    DECLARE idGrafiku_new INT;

    SELECT idGrafiku
    INTO idGrafiku_new
    FROM Grafik
    WHERE idPracownika = NEW.idPracownika
      AND dzien_tygodnia = NEW.dzien_tygodnia;

    IF idGrafiku_new IS NOT NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nie można dodać dwóch grafików tego samego dnia dla jednej osoby.';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `max_40_h` BEFORE INSERT ON `Grafik` FOR EACH ROW BEGIN
    DECLARE total_hours DECIMAL(5,2);

    SET total_hours = (
        SELECT IFNULL(SUM(ilosc_godzin), 0) + NEW.ilosc_godzin
        FROM Grafik
        WHERE idPracownika = NEW.idPracownika
    );

    IF total_hours > 40 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Pracownik nie może pracować więcej niż 40 godzin tygodniowo.';
    END IF;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Pracownicy`
--

CREATE TABLE `Pracownicy` (
  `idPracownika` int(11) NOT NULL,
  `imie_pracownika` varchar(45) DEFAULT NULL,
  `nazwisko_pracownika` varchar(45) DEFAULT NULL,
  `stanowisko` varchar(45) DEFAULT NULL,
  `idFilii` int(11) NOT NULL,
  `idDzialu` int(11) NOT NULL,
  `haslo` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Dumping data for table `Pracownicy`
--

INSERT INTO `Pracownicy` (`idPracownika`, `imie_pracownika`, `nazwisko_pracownika`, `stanowisko`, `idFilii`, `idDzialu`, `haslo`) VALUES
(1, 'Antoni', 'Kowalczyk', 'Kierownik Projektu', 4, 11, 'Haslo#2022'),
(2, 'Julia', 'Nowak', 'Analityk Finansowy', 7, 9, 'Finanse2023!'),
(3, 'Piotr', 'Wójcik', 'Programista', 2, 14, 'CodeMaster123'),
(4, 'Jan', 'Kowalski', 'Inżynier', 7, 9, 'Pass456'),
(5, 'Magdalena', 'Jankowska', 'Designer', 2, 9, 'Secret123'),
(6, 'Piotr', 'Nowicki', 'Kierownik projektu', 8, 9, 'SecurePass789'),
(7, 'Agnieszka', 'Dąbrowska', 'Specjalista ds. HR', 1, 9, 'HRpass2022'),
(8, 'Tomasz', 'Kaczmarek', 'Analityk biznesowy', 5, 9, 'AnalyzePass123'),
(9, 'Monika', 'Wojciechowska', 'Administrator', 6, 9, 'AdminPass789'),
(10, 'Kamil', 'Zieliński', 'Tester oprogramowania', 3, 9, 'Test123Pass'),
(11, 'Karolina', 'Sikora', 'Architekt systemowy', 9, 9, 'ArchitectPass2022'),
(12, 'Marek', 'Kowalczyk', 'Ekspert ds. finansowych', 1, 9, 'FinancePass456'),
(13, 'Joanna', 'Grabowska', 'Copywriter', 7, 9, 'WritePass123'),
(14, 'Marcin', 'Łukasik', 'Grafik komputerowy', 4, 9, 'GraphicPass789'),
(15, 'Natalia', 'Mazur', 'Projektant UX/UI', 8, 9, 'UXPass2022'),
(16, 'Damian', 'Szymański', 'Inżynier dźwięku', 2, 9, 'AudioPass123'),
(17, 'Iwona', 'Pawlak', 'Specjalista ds. marketingu', 6, 9, 'MarketingPass456');

--
-- Triggers `Pracownicy`
--
DELIMITER $$
CREATE TRIGGER `b15_osob_dzial` BEFORE INSERT ON `Pracownicy` FOR EACH ROW BEGIN
    DECLARE department_count INT;

    SELECT COUNT(*)
    INTO department_count
    FROM Pracownicy
    WHERE idDzialu = NEW.idDzialu;

    IF department_count >= 15 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Dział może składać sie z maksymalnie 15 pracowników.';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Pracownicy_has_Spotkania`
--

CREATE TABLE `Pracownicy_has_Spotkania` (
  `idSpotkania` int(11) NOT NULL,
  `idPracownika` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Dumping data for table `Pracownicy_has_Spotkania`
--

INSERT INTO `Pracownicy_has_Spotkania` (`idSpotkania`, `idPracownika`) VALUES
(1, 1),
(2, 1),
(2, 2);

--
-- Triggers `Pracownicy_has_Spotkania`
--
DELIMITER $$
CREATE TRIGGER `<2_do_spr` BEFORE INSERT ON `Pracownicy_has_Spotkania` FOR EACH ROW BEGIN
    DECLARE uczestnicy_count INT;

    SELECT COUNT(*) INTO uczestnicy_count
    FROM Spotkania
    WHERE idSpotkania = NEW.idSpotkania;

    IF uczestnicy_count < 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Do poprawnego zapisu spotkania wymaganych jest minimum dwóch uczestników.';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `>15` BEFORE INSERT ON `Pracownicy_has_Spotkania` FOR EACH ROW BEGIN
    DECLARE uczestnicy_count INT;

    SELECT COUNT(*) INTO uczestnicy_count
    FROM Pracownicy_has_Spotkania
    WHERE idSpotkania = NEW.idSpotkania;

    IF uczestnicy_count >= 15 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Osiągnięto maksymalną liczbę osób mogącą wziąć udział w spotkaniu.';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `grafik` BEFORE INSERT ON `Pracownicy_has_Spotkania` FOR EACH ROW BEGIN
    DECLARE work_start TIME;
    DECLARE work_end TIME;
    DECLARE meet_t TIME;
    DECLARE workday varchar(45);
    DECLARE w2 varchar(45);

    SELECT godzina_rozpoczecia, godzina_zakonczenia, dzien_tygodnia
    INTO work_start, work_end, workday
    FROM Grafik
    WHERE idPracownika = NEW.idPracownika;
    
    SELECT godzina_spotkania, dzien_tygodnia
    INTO meet_t, w2
    FROM Spotkania
    WHERE idSpotkania = NEW.idSpotkania;

    IF meet_t < work_start OR meet_t > work_end OR workday != w2 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Pracownicy mogą brać udział w spotkaniach jedynie w godzinach swojej pracy.';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `meeting_same_hour` BEFORE INSERT ON `Pracownicy_has_Spotkania` FOR EACH ROW BEGIN
    DECLARE worker_count INT;

    SELECT COUNT(*) INTO worker_count
    FROM Pracownicy_has_Spotkania
    WHERE idPracownika = NEW.idPracownika AND idSpotkania = NEW.idSpotkania;

    IF worker_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ten pracownik jest już zapisany na spotkanie o tej godzinie.';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Sala`
--

CREATE TABLE `Sala` (
  `idSali` int(11) NOT NULL,
  `pojemnosc` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Dumping data for table `Sala`
--

INSERT INTO `Sala` (`idSali`, `pojemnosc`) VALUES
(1, 15),
(2, 13),
(3, 10),
(4, 15),
(5, 14),
(6, 5),
(7, 8),
(8, 11),
(9, 10),
(10, 15),
(11, 5),
(12, 7),
(13, 10),
(14, 4),
(15, 14);

-- --------------------------------------------------------

--
-- Table structure for table `Spotkania`
--

CREATE TABLE `Spotkania` (
  `idSpotkania` int(11) NOT NULL,
  `max_liczba_uczestnikow` int(11) DEFAULT NULL,
  `godzina_spotkania` time DEFAULT NULL,
  `dzien_tygodnia` varchar(45) DEFAULT NULL,
  `idSali` int(11) NOT NULL,
  `idFilii` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Dumping data for table `Spotkania`
--

INSERT INTO `Spotkania` (`idSpotkania`, `max_liczba_uczestnikow`, `godzina_spotkania`, `dzien_tygodnia`, `idSali`, `idFilii`) VALUES
(1, 9, '11:00:00', 'Wtorek', 3, 5),
(2, 8, '10:00:00', 'Poniedziałek', 7, 8),
(3, 4, '09:00:00', 'Wtorek', 6, 8),
(4, 7, '10:00:00', 'Poniedziałek', 8, 2),
(6, 10, '09:00:00', 'Wtorek', 4, 8);

--
-- Triggers `Spotkania`
--
DELIMITER $$
CREATE TRIGGER `godzina_spotkania` BEFORE INSERT ON `Spotkania` FOR EACH ROW BEGIN
    DECLARE godzina_spotkania TIME;
    
    SELECT TIME(NEW.godzina_spotkania) INTO godzina_spotkania;

    IF godzina_spotkania < '08:00:00' OR godzina_spotkania > '18:00:00' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Spotkania mogą odbywać się jedynie w godzinach 8:00 - 18:00.';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `maxpeople>capacity` BEFORE INSERT ON `Spotkania` FOR EACH ROW BEGIN
    DECLARE room_capacity INT;

    SELECT pojemnosc INTO room_capacity
    FROM Sala
    WHERE idSali = NEW.idSali;

    IF NEW.max_liczba_uczestnikow > room_capacity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Sala nie pomieści więcej osób.';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `sala_spotkanie` BEFORE INSERT ON `Spotkania` FOR EACH ROW BEGIN
    DECLARE existing_meeting_id INT;

    SELECT idSpotkania
    INTO existing_meeting_id
    FROM Spotkania
    WHERE idSali = NEW.idSali
      AND godzina_spotkania = NEW.godzina_spotkania
      AND dzien_tygodnia = NEW.dzien_tygodnia;

    IF existing_meeting_id IS NOT NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Sala jest już zajęta o podanej godzinie danego dnia.';
    END IF;
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Działy`
--
ALTER TABLE `Działy`
  ADD PRIMARY KEY (`idDzialu`),
  ADD UNIQUE KEY `idDzialu` (`idDzialu`),
  ADD KEY `idFilii` (`idFilii`);

--
-- Indexes for table `Filie`
--
ALTER TABLE `Filie`
  ADD PRIMARY KEY (`idFilii`),
  ADD UNIQUE KEY `nazwa_Filii` (`nazwa_Filii`);

--
-- Indexes for table `Grafik`
--
ALTER TABLE `Grafik`
  ADD PRIMARY KEY (`idGrafiku`),
  ADD KEY `fk_idPracownika` (`idPracownika`);

--
-- Indexes for table `Pracownicy`
--
ALTER TABLE `Pracownicy`
  ADD PRIMARY KEY (`idPracownika`),
  ADD KEY `idDzialu` (`idDzialu`),
  ADD KEY `idFilii` (`idFilii`);

--
-- Indexes for table `Pracownicy_has_Spotkania`
--
ALTER TABLE `Pracownicy_has_Spotkania`
  ADD PRIMARY KEY (`idPracownika`,`idSpotkania`),
  ADD KEY `idSpotkania` (`idSpotkania`);

--
-- Indexes for table `Sala`
--
ALTER TABLE `Sala`
  ADD PRIMARY KEY (`idSali`);

--
-- Indexes for table `Spotkania`
--
ALTER TABLE `Spotkania`
  ADD PRIMARY KEY (`idSpotkania`),
  ADD KEY `fk_idSali` (`idSali`),
  ADD KEY `fk_idFilii` (`idFilii`);

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
  ADD CONSTRAINT `Grafik_ibfk_1` FOREIGN KEY (`idPracownika`) REFERENCES `Pracownicy` (`idPracownika`),
  ADD CONSTRAINT `fk_idPracownika` FOREIGN KEY (`idPracownika`) REFERENCES `Pracownicy` (`idPracownika`);

--
-- Constraints for table `Pracownicy`
--
ALTER TABLE `Pracownicy`
  ADD CONSTRAINT `Pracownicy_ibfk_2` FOREIGN KEY (`idDzialu`) REFERENCES `Działy` (`idDzialu`),
  ADD CONSTRAINT `Pracownicy_ibfk_3` FOREIGN KEY (`idFilii`) REFERENCES `Filie` (`idFilii`);

--
-- Constraints for table `Pracownicy_has_Spotkania`
--
ALTER TABLE `Pracownicy_has_Spotkania`
  ADD CONSTRAINT `Pracownicy_has_Spotkania_ibfk_1` FOREIGN KEY (`idSpotkania`) REFERENCES `Spotkania` (`idSpotkania`),
  ADD CONSTRAINT `Pracownicy_has_Spotkania_ibfk_2` FOREIGN KEY (`idPracownika`) REFERENCES `Pracownicy` (`idPracownika`);

--
-- Constraints for table `Spotkania`
--
ALTER TABLE `Spotkania`
  ADD CONSTRAINT `fk_idFilii` FOREIGN KEY (`idFilii`) REFERENCES `Filie` (`idFilii`),
  ADD CONSTRAINT `fk_idSali` FOREIGN KEY (`idSali`) REFERENCES `Sala` (`idSali`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
