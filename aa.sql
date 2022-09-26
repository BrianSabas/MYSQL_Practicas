-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Porfolio
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Porfolio
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Porfolio` DEFAULT CHARACTER SET utf8 ;
USE `Porfolio` ;

-- -----------------------------------------------------
-- Table `Porfolio`.`DOMICILIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Porfolio`.`DOMICILIO` (
  `id` INT NOT NULL,
  `localidad` VARCHAR(60) NOT NULL,
  `direccion` VARCHAR(90) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Porfolio`.`PERSONA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Porfolio`.`PERSONA` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NULL,
  `sobreMi` VARCHAR(200) NULL,
  `correo` VARCHAR(60) NOT NULL,
  `idDomicilio` INT NOT NULL,
  PRIMARY KEY (`id`, `idDomicilio`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_persona_domicilio1_idx` (`idDomicilio` ASC) VISIBLE,
  CONSTRAINT `fk_persona_domicilio1`
    FOREIGN KEY (`idDomicilio`)
    REFERENCES `Porfolio`.`DOMICILIO` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Porfolio`.`EXPLABORAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Porfolio`.`EXPLABORAL` (
  `id` INT NOT NULL,
  `nombreEmpresa` VARCHAR(45) NOT NULL,
  `esTrabajoActual` TINYINT NOT NULL,
  `fechaInicio` DATE NOT NULL,
  `fechaFin` DATE NULL,
  `descripcion` VARCHAR(200) NULL,
  `idPersona` INT NOT NULL,
  PRIMARY KEY (`id`, `idPersona`),
  INDEX `fk_expLaboral_persona_idx` (`idPersona` ASC) VISIBLE,
  CONSTRAINT `fk_expLaboral_persona`
    FOREIGN KEY (`idPersona`)
    REFERENCES `Porfolio`.`PERSONA` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Porfolio`.`EDUCACION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Porfolio`.`EDUCACION` (
  `id` INT NOT NULL,
  `carreraTerminada` TINYINT NOT NULL,
  `nombreCarrera` VARCHAR(70) NULL,
  `educacionSecundariaTerminada` TINYINT NOT NULL,
  `establecimientoSecundario` VARCHAR(70) NULL,
  `idPersona` INT NOT NULL,
  PRIMARY KEY (`id`, `idPersona`),
  INDEX `fk_educacion_persona1_idx` (`idPersona` ASC) VISIBLE,
  CONSTRAINT `fk_educacion_persona1`
    FOREIGN KEY (`idPersona`)
    REFERENCES `Porfolio`.`PERSONA` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Porfolio`.`USUARIOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Porfolio`.`USUARIOS` (
  `id` INT NOT NULL,
  `nombreUsuario` VARCHAR(20) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `contraseña` VARCHAR(30) NOT NULL,
  `idPersona` INT NOT NULL,
  PRIMARY KEY (`id`, `idPersona`),
  INDEX `fk_usuarios_persona1_idx` (`idPersona` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_persona1`
    FOREIGN KEY (`idPersona`)
    REFERENCES `Porfolio`.`PERSONA` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Porfolio`.`TECNOLOGIAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Porfolio`.`TECNOLOGIAS` (
  `id` INT NOT NULL,
  `nombresTecnologias` VARCHAR(85) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Porfolio`.`PROYECTOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Porfolio`.`PROYECTOS` (
  `id` INT NOT NULL,
  `nombreProyecto` VARCHAR(40) NULL,
  `sobreProyecto` VARCHAR(230) NOT NULL,
  `idTecnologias` INT NOT NULL,
  `idPersona` INT NOT NULL,
  PRIMARY KEY (`id`, `idTecnologias`, `idPersona`),
  INDEX `fk_proyectos_tecnologias1_idx` (`idTecnologias` ASC) VISIBLE,
  INDEX `fk_proyectos_persona1_idx` (`idPersona` ASC) VISIBLE,
  CONSTRAINT `fk_proyectos_tecnologias1`
    FOREIGN KEY (`idTecnologias`)
    REFERENCES `Porfolio`.`TECNOLOGIAS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proyectos_persona1`
    FOREIGN KEY (`idPersona`)
    REFERENCES `Porfolio`.`PERSONA` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
