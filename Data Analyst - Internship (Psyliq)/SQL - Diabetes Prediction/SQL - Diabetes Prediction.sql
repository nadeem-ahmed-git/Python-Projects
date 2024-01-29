-- Q1. Retrieve the Patient_id and ages of all patients.
SELECT Patient_id, age 
FROM nadeemdb.diabetes_prediction;

-- Q2. Select all female patients who are older than 40.
SELECT * 
FROM nadeemdb.diabetes_prediction
WHERE gender = 'Female' AND age > 40;

-- Q3. Calculate the average BMI of patients.
SELECT AVG(bmi)
FROM nadeemdb.diabetes_prediction;

-- Q4. List patients in descending order of blood glucose levels.
SELECT Patient_id, blood_glucose_level
FROM nadeemdb.diabetes_prediction
ORDER BY blood_glucose_level DESC;

-- Q5. Find patients who have hypertension and diabetes.
SELECT * 
FROM nadeemdb.diabetes_prediction
WHERE hypertension = 1 AND diabetes = 1;

-- Q6. Determine the number of patients with heart disease.
SELECT COUNT(DISTINCT Patient_id) 
FROM nadeemdb.diabetes_prediction
WHERE heart_disease = 1;

-- Q7. Group patients by smoking history and count how many smokers and non-smokers there are.
SELECT smoking_history, COUNT(DISTINCT Patient_id) 
FROM nadeemdb.diabetes_prediction
GROUP BY smoking_history;

-- Q8. Retrieve the Patient_ids of patients who have a BMI greater than the average BMI.
SELECT Patient_id 
FROM nadeemdb.diabetes_prediction
WHERE bmi > (SELECT AVG(bmi) FROM nadeemdb.diabetes_prediction);

-- Q9. Find the patient with the highest HbA1c level and the patient with the lowest HbA1c level.
-- Highest HbA1c level
SELECT Patient_id, HbA1c_level
FROM nadeemdb.diabetes_prediction
WHERE HbA1c_level = (SELECT MAX(HbA1c_level) FROM nadeemdb.diabetes_prediction);


-- Lowest HbA1c level
SELECT Patient_id, HbA1c_level
FROM nadeemdb.diabetes_prediction
WHERE HbA1c_level = (SELECT MIN(HbA1c_level) FROM nadeemdb.diabetes_prediction);

-- Q10. Calculate the age of patients in years (assuming the current date as of now).
-- There already exists an "age" column in the database and no "date of birth" column to calculate age with current date.

-- Q11. Rank patients by blood glucose level within each gender group.
SELECT gender, Patient_id, blood_glucose_level, 
RANK() OVER (PARTITION BY gender ORDER BY blood_glucose_level DESC) as `Rank`
FROM nadeemdb.diabetes_prediction;

-- Q12. Update the smoking history of patients who are older than 50 to "Ex-smoker."
UPDATE nadeemdb.diabetes_prediction
SET smoking_history = 'Ex-smoker'
WHERE age > 50;

-- Q13. Insert a new patient into the database with sample data.
INSERT INTO nadeemdb.diabetes_prediction (ï»¿EmployeeName, Patient_id, gender, age, hypertension, heart_disease, smoking_history, bmi, HbA1c_level, blood_glucose_level, diabetes)
VALUES ('Salman Khan', 'PT105', 'Male', 60, 1, 0, 'Ex-smoker', 28.5, 6.2, 150, 0);

DESCRIBE nadeemdb.diabetes_prediction; --(Checking for actual name of the 'EmployeeName' column)

-- Q14. Delete all patients with heart disease from the database.
DELETE FROM nadeemdb.diabetes_prediction
WHERE heart_disease = 1;

-- Q15. Find patients who have hypertension but not diabetes using the EXCEPT operator.
SELECT * FROM nadeemdb.diabetes_prediction
WHERE hypertension = 1
EXCEPT
SELECT * FROM nadeemdb.diabetes_prediction
WHERE diabetes = 1;

-- Q16. Define a unique constraint on the "patient_id" column to ensure its values are unique.
ALTER TABLE nadeemdb.diabetes_prediction
ADD CONSTRAINT patient_unique_id UNIQUE (patient_id(10));

-- Q17. Create a view that displays the Patient_ids, ages, and BMI of patients.
-- creating a view displaying the Patient_ids, ages, and BMI of patients
USE nadeemdb;
CREATE VIEW patient_view AS
SELECT patient_id, age, bmi
FROM nadeemdb.diabetes_prediction;

-- Querying this view to return a list of patient IDs, ages,and BMI like aregular table
SELECT * FROM patient_view;
