-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema Wellness
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Wellness
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Wellness` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `Wellness` ;

-- -----------------------------------------------------
-- Table `Wellness`.`DailyMealPlan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Wellness`.`DailyMealPlan` (
  `Name` VARCHAR(45) NOT NULL,
  `CalorieCount` INT(11) NOT NULL,
  `ProteinCount` INT(11) NOT NULL,
  `CarbsCount` INT(11) NOT NULL,
  `#MealsPerDay` INT(11) NOT NULL,
  PRIMARY KEY (`Name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Wellness`.`DailyMealPlan_has_Meal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Wellness`.`DailyMealPlan_has_Meal` (
  `DailyMealPlan_Name` VARCHAR(45) NOT NULL,
  `Meal_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`DailyMealPlan_Name`, `Meal_Name`),
  INDEX `fk_DailyMealPlan_has_Meal_Meal1_idx` (`Meal_Name` ASC) VISIBLE,
  CONSTRAINT `dailymealplan_has_meal_ibfk_1`
    FOREIGN KEY (`DailyMealPlan_Name`)
    REFERENCES `Wellness`.`dailymealplan` (`name`),
  CONSTRAINT `fk_DailyMealPlan_has_Meal_Meal1`
    FOREIGN KEY (`Meal_Name`)
    REFERENCES `Wellness`.`meal` (`name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Wellness`.`Exercise`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Wellness`.`Exercise` (
  `Name` VARCHAR(45) NOT NULL,
  `MuscleTargeted` VARCHAR(45) NOT NULL,
  `HowTo` VARCHAR(45) NOT NULL,
  `EquipmentNeeded` VARCHAR(45) NOT NULL,
  `Type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Wellness`.`Ingredients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Wellness`.`Ingredients` (
  `ID` INT(11) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `FoodType` VARCHAR(45) NOT NULL,
  `Cooked` TINYINT(4) NOT NULL,
  `ServingSize` INT(11) NOT NULL,
  `CalorieCount` INT(11) NOT NULL,
  `ProteinC` INT(11) NOT NULL,
  `FatC` INT(11) NOT NULL,
  `CarbsC` INT(11) NOT NULL,
  `Meal_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`, `Meal_Name`),
  INDEX `fk_Ingredients_Meal1_idx` (`Meal_Name` ASC) VISIBLE,
  CONSTRAINT `fk_Ingredients_Meal1`
    FOREIGN KEY (`Meal_Name`)
    REFERENCES `Wellness`.`meal` (`name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Wellness`.`Meal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Wellness`.`Meal` (
  `Name` VARCHAR(45) NOT NULL,
  `CookTime` INT(11) NOT NULL,
  `CalorieCount` INT(11) NOT NULL,
  `ProteinCount` INT(11) NOT NULL,
  `FatCount` INT(11) NOT NULL,
  `PrepTime` INT(11) NOT NULL,
  `Difficulty` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Wellness`.`Supplement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Wellness`.`Supplement` (
  `Name` VARCHAR(45) NOT NULL,
  `Type` VARCHAR(45) NOT NULL,
  `WhenToTake` VARCHAR(45) NOT NULL,
  `UsageInstruction` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Wellness`.`SupplementPlan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Wellness`.`SupplementPlan` (
  `Name` VARCHAR(45) NOT NULL,
  `SuppCount` INT(11) NOT NULL,
  `ProteinTotal` INT(11) NOT NULL,
  `CaffeineTotal` INT(11) NOT NULL,
  `CreatineTotal` INT(11) NOT NULL,
  PRIMARY KEY (`Name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Wellness`.`SupplementPlan_has_Supplement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Wellness`.`SupplementPlan_has_Supplement` (
  `SupplementPlan_Name` VARCHAR(45) NOT NULL,
  `Supplement_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`SupplementPlan_Name`, `Supplement_Name`),
  INDEX `fk_SupplementPlan_has_Supplement_Supplement1_idx` (`Supplement_Name` ASC) VISIBLE,
  INDEX `fk_SupplementPlan_has_Supplement_SupplementPlan1_idx` (`SupplementPlan_Name` ASC) VISIBLE,
  CONSTRAINT `fk_SupplementPlan_has_Supplement_Supplement1`
    FOREIGN KEY (`Supplement_Name`)
    REFERENCES `Wellness`.`supplement` (`name`),
  CONSTRAINT `fk_SupplementPlan_has_Supplement_SupplementPlan1`
    FOREIGN KEY (`SupplementPlan_Name`)
    REFERENCES `Wellness`.`supplementplan` (`name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Wellness`.`WellnessPlan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Wellness`.`WellnessPlan` (
  `Name` VARCHAR(45) NOT NULL,
  `Goal` VARCHAR(45) NOT NULL,
  `WorkoutPlan` VARCHAR(45) NOT NULL,
  `SupplementPlan_Name` VARCHAR(45) NOT NULL,
  `DailyMealPlan_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Name`, `WorkoutPlan`, `SupplementPlan_Name`, `DailyMealPlan_Name`),
  INDEX `fk_WellnessPlan_WorkoutPlan1_idx` (`WorkoutPlan` ASC) VISIBLE,
  INDEX `fk_WellnessPlan_SupplementPlan1_idx` (`SupplementPlan_Name` ASC) VISIBLE,
  INDEX `fk_WellnessPlan_DailyMealPlan1_idx` (`DailyMealPlan_Name` ASC) VISIBLE,
  CONSTRAINT `fk_WellnessPlan_DailyMealPlan1`
    FOREIGN KEY (`DailyMealPlan_Name`)
    REFERENCES `Wellness`.`dailymealplan` (`name`),
  CONSTRAINT `fk_WellnessPlan_SupplementPlan1`
    FOREIGN KEY (`SupplementPlan_Name`)
    REFERENCES `Wellness`.`supplementplan` (`name`),
  CONSTRAINT `fk_WellnessPlan_WorkoutPlan1`
    FOREIGN KEY (`WorkoutPlan`)
    REFERENCES `Wellness`.`workoutplan` (`workoutplan`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Wellness`.`Workout`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Wellness`.`Workout` (
  `MuscleGroup` INT(11) NOT NULL,
  `LengthTime` VARCHAR(45) NOT NULL,
  `ExcerciseCount` VARCHAR(45) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `WorkoutPlan` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Name`, `WorkoutPlan`),
  INDEX `fk_Workout_WorkoutPlan1_idx` (`WorkoutPlan` ASC) VISIBLE,
  CONSTRAINT `fk_Workout_WorkoutPlan1`
    FOREIGN KEY (`WorkoutPlan`)
    REFERENCES `Wellness`.`workoutplan` (`workoutplan`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Wellness`.`WorkoutPlan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Wellness`.`WorkoutPlan` (
  `WorkoutPlan` VARCHAR(45) NOT NULL,
  `#WOPerDay` VARCHAR(45) NOT NULL,
  `Goal` VARCHAR(45) NOT NULL,
  `IntensityRating` VARCHAR(45) NOT NULL,
  `Length` VARCHAR(45) NOT NULL,
  `Author` VARCHAR(45) NOT NULL,
  `EquipNeeded` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`WorkoutPlan`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Wellness`.`Workout_has_Exercise`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Wellness`.`Workout_has_Exercise` (
  `Exercise_Name` VARCHAR(45) NOT NULL,
  `Workout_Name` VARCHAR(45) NOT NULL,
  `Workout_WorkoutPlan` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Exercise_Name`, `Workout_Name`, `Workout_WorkoutPlan`),
  INDEX `fk_Exercise_has_Workout_Workout1_idx` (`Workout_Name` ASC, `Workout_WorkoutPlan` ASC) VISIBLE,
  INDEX `fk_Exercise_has_Workout_Exercise1_idx` (`Exercise_Name` ASC) VISIBLE,
  CONSTRAINT `fk_Exercise_has_Workout_Exercise1`
    FOREIGN KEY (`Exercise_Name`)
    REFERENCES `Wellness`.`exercise` (`name`),
  CONSTRAINT `fk_Exercise_has_Workout_Workout1`
    FOREIGN KEY (`Workout_Name` , `Workout_WorkoutPlan`)
    REFERENCES `Wellness`.`workout` (`name` , `workoutplan`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
