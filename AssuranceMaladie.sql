-- MySQL Script generated by MySQL Workbench
-- Mon Oct  5 11:13:08 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema AssuranceMaladie
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `AssuranceMaladie` ;

-- -----------------------------------------------------
-- Schema AssuranceMaladie
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `AssuranceMaladie` DEFAULT CHARACTER SET utf8 ;
USE `AssuranceMaladie` ;

-- -----------------------------------------------------
-- Table `AssuranceMaladie`.`Addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AssuranceMaladie`.`Addresses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(255) NOT NULL,
  `addressNumber` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `postcode` INT(4) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AssuranceMaladie`.`Famillies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AssuranceMaladie`.`Famillies` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `Addresses_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Famillies_Addresses1`
    FOREIGN KEY (`Addresses_id`)
    REFERENCES `AssuranceMaladie`.`Addresses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AssuranceMaladie`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AssuranceMaladie`.`Customers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `birthdate` DATE NOT NULL,
  `avs` VARCHAR(255) NOT NULL,
  `phoneNumber` INT NOT NULL,
  `Famillies_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Customers_Famillies1`
    FOREIGN KEY (`Famillies_id`)
    REFERENCES `AssuranceMaladie`.`Famillies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AssuranceMaladie`.`Brokers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AssuranceMaladie`.`Brokers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `phoneNumbre` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AssuranceMaladie`.`Folders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AssuranceMaladie`.`Folders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Customers_id` INT NOT NULL,
  `creationDate` TIMESTAMP NOT NULL,
  `closeDate` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Folders_Customers1`
    FOREIGN KEY (`Customers_id`)
    REFERENCES `AssuranceMaladie`.`Customers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AssuranceMaladie`.`Invoices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AssuranceMaladie`.`Invoices` (
  `number` INT NOT NULL AUTO_INCREMENT,
  `totalPrice` DECIMAL NOT NULL,
  `limitPayementDate` DATETIME NOT NULL,
  `payementDate` DATETIME NULL,
  PRIMARY KEY (`number`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AssuranceMaladie`.`Doctors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AssuranceMaladie`.`Doctors` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `phoneNumber` INT NOT NULL,
  `type` ENUM("Medecin", "Medecin de famille") NOT NULL DEFAULT 'Medecin',
  `agreed` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AssuranceMaladie`.`TreatmentType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AssuranceMaladie`.`TreatmentType` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AssuranceMaladie`.`Treatments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AssuranceMaladie`.`Treatments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Doctors_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `startDate` DATETIME NOT NULL,
  `endDate` DATETIME NULL,
  `TreatmentType_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Treatments_Doctors1`
    FOREIGN KEY (`Doctors_id`)
    REFERENCES `AssuranceMaladie`.`Doctors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Treatments_TreatmentType1`
    FOREIGN KEY (`TreatmentType_id`)
    REFERENCES `AssuranceMaladie`.`TreatmentType` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AssuranceMaladie`.`Drugs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AssuranceMaladie`.`Drugs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `price` DECIMAL NOT NULL,
  `reimbursement` DECIMAL NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AssuranceMaladie`.`Brokers_has_Brokers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AssuranceMaladie`.`Brokers_has_Brokers` (
  `Brokers_id` INT NOT NULL,
  `Brokers_id1` INT NOT NULL,
  PRIMARY KEY (`Brokers_id`, `Brokers_id1`),
  CONSTRAINT `fk_Brokers_has_Brokers_Brokers1`
    FOREIGN KEY (`Brokers_id`)
    REFERENCES `AssuranceMaladie`.`Brokers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Brokers_has_Brokers_Brokers2`
    FOREIGN KEY (`Brokers_id1`)
    REFERENCES `AssuranceMaladie`.`Brokers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AssuranceMaladie`.`Treatments_has_Drugs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AssuranceMaladie`.`Treatments_has_Drugs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Treatments_id` INT NOT NULL,
  `Drugs_id` INT NOT NULL,
  `act` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Treatments_has_Drugs_Treatments1`
    FOREIGN KEY (`Treatments_id`)
    REFERENCES `AssuranceMaladie`.`Treatments` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Treatments_has_Drugs_Drugs1`
    FOREIGN KEY (`Drugs_id`)
    REFERENCES `AssuranceMaladie`.`Drugs` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AssuranceMaladie`.`Brokers_has_Folders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AssuranceMaladie`.`Brokers_has_Folders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Brokers_id` INT NOT NULL,
  `Folders_id` INT NOT NULL,
  `StartFollowDate` DATETIME NOT NULL,
  `EndFollowDate` DATETIME NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Brokers_has_Folders_Brokers1`
    FOREIGN KEY (`Brokers_id`)
    REFERENCES `AssuranceMaladie`.`Brokers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Brokers_has_Folders_Folders1`
    FOREIGN KEY (`Folders_id`)
    REFERENCES `AssuranceMaladie`.`Folders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AssuranceMaladie`.`Models`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AssuranceMaladie`.`Models` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `insuranceAccident` DECIMAL NOT NULL,
  `product` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AssuranceMaladie`.`Primes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AssuranceMaladie`.`Primes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `franchise` ENUM("300", "500", "1000", "1500", "2000", "2500") NOT NULL,
  `reduction` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AssuranceMaladie`.`Assurances`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AssuranceMaladie`.`Assurances` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `price` DECIMAL NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AssuranceMaladie`.`Customers_has_InsuranceModels`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AssuranceMaladie`.`Customers_has_InsuranceModels` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Customers_id` INT NOT NULL,
  `Models_id` INT NOT NULL,
  `rest` DECIMAL NOT NULL,
  `insuranceAccident` TINYINT NOT NULL DEFAULT 0,
  `Franchises_id` INT NOT NULL,
  `Assurances_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Customers_has_InsuranceModels_Customers1`
    FOREIGN KEY (`Customers_id`)
    REFERENCES `AssuranceMaladie`.`Customers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customers_has_InsuranceModels_InsuranceModels1`
    FOREIGN KEY (`Models_id`)
    REFERENCES `AssuranceMaladie`.`Models` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customers_has_InsuranceModels_Franchises1`
    FOREIGN KEY (`Franchises_id`)
    REFERENCES `AssuranceMaladie`.`Primes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customers_has_InsuranceModels_Assurances1`
    FOREIGN KEY (`Assurances_id`)
    REFERENCES `AssuranceMaladie`.`Assurances` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AssuranceMaladie`.`Treatments_has_Invoices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AssuranceMaladie`.`Treatments_has_Invoices` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Treatments_id` INT NOT NULL,
  `Invoices_number` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Treatments_has_Invoices_Treatments1`
    FOREIGN KEY (`Treatments_id`)
    REFERENCES `AssuranceMaladie`.`Treatments` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Treatments_has_Invoices_Invoices1`
    FOREIGN KEY (`Invoices_number`)
    REFERENCES `AssuranceMaladie`.`Invoices` (`number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AssuranceMaladie`.`Folders_has_Treatments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AssuranceMaladie`.`Folders_has_Treatments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Folders_id` INT NOT NULL,
  `Treatments_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Folders_has_Treatments_Folders1`
    FOREIGN KEY (`Folders_id`)
    REFERENCES `AssuranceMaladie`.`Folders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Folders_has_Treatments_Treatments1`
    FOREIGN KEY (`Treatments_id`)
    REFERENCES `AssuranceMaladie`.`Treatments` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AssuranceMaladie`.`Hospitals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AssuranceMaladie`.`Hospitals` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `Addresses_id` INT NOT NULL,
  `price` DECIMAL NULL,
  `Hospitalscol` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Hospitals_Addresses1`
    FOREIGN KEY (`Addresses_id`)
    REFERENCES `AssuranceMaladie`.`Addresses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AssuranceMaladie`.`Rooms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AssuranceMaladie`.`Rooms` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `type` ENUM("Private", "Public") NULL DEFAULT 'Public',
  `Hospitals_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Rooms_Hospitals1`
    FOREIGN KEY (`Hospitals_id`)
    REFERENCES `AssuranceMaladie`.`Hospitals` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AssuranceMaladie`.`Hospital_doctor_work`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AssuranceMaladie`.`Hospital_doctor_work` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `startDate` DATETIME NULL,
  `endDate` DATETIME NULL,
  `Doctors_id` INT NOT NULL,
  `Hospitals_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Doctors_has_Hospitals_Doctors1`
    FOREIGN KEY (`Doctors_id`)
    REFERENCES `AssuranceMaladie`.`Doctors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Doctors_has_Hospitals_Hospitals1`
    FOREIGN KEY (`Hospitals_id`)
    REFERENCES `AssuranceMaladie`.`Hospitals` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AssuranceMaladie`.`Treatments_has_Hospitals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AssuranceMaladie`.`Treatments_has_Hospitals` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Treatments_id` INT NOT NULL,
  `Hospitals_id` INT NOT NULL,
  `Rooms_id` INT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Treatments_has_Hospitals_Treatments1`
    FOREIGN KEY (`Treatments_id`)
    REFERENCES `AssuranceMaladie`.`Treatments` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Treatments_has_Hospitals_Hospitals1`
    FOREIGN KEY (`Hospitals_id`)
    REFERENCES `AssuranceMaladie`.`Hospitals` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Treatments_has_Hospitals_Rooms1`
    FOREIGN KEY (`Rooms_id`)
    REFERENCES `AssuranceMaladie`.`Rooms` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
