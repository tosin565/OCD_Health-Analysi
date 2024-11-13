SELECT *
FROM ocd_patient_dataset

--Count & PCT Gender that have OCD. Avg Obession & Compulsions Score by Gender
SELECT Gender, CAST(CAST(COUNT(patient_id) AS DECIMAL (10,2)) * 100 
/(SELECT CAST(COUNT(patient_id) AS DECIMAL (10,2))
FROM ocd_patient_dataset) AS DECIMAL (10,2)) PCT ,
COUNT(patient_id) No_of_patients,
CAST(AVG(CAST(Y_BOCS_Score_Obsessions AS DECIMAL (10,2))) AS DECIMAL (10,2)) Avg_of_Y_Obs,
CAST(AVG(CAST(Y_BOCS_Score_Compulsions AS DECIMAL (10,2))) AS DECIMAL (10,2)) Avg_of_Comp
FROM ocd_patient_dataset
GROUP BY Gender
ORDER BY  PCT
 
--Count Patients by Ethnicities and their respective Obsession Avg Score
SELECT Ethnicity, COUNT(patient_id) No_of_patients, 
CAST(AVG(CAST(Y_BOCS_Score_Obsessions AS DECIMAL (10,2))) AS DECIMAL (10,2)) Avg_of_Y_Obs,
CAST(AVG(CAST(Y_BOCS_Score_Compulsions AS DECIMAL (10,2))) AS DECIMAL (10,2)) Avg_of_Comp
FROM ocd_patient_dataset
GROUP BY Ethnicity
ORDER BY 2

-- Number of People diagnosed Monthly
SELECT YEAR(OCD_Diagnosis_Date) AS Year_diagnosis,
MONTH(OCD_Diagnosis_Date) AS Month_diagnosis,
COUNT(patient_id) No_of_patients
FROM ocd_patient_dataset
GROUP BY YEAR(OCD_Diagnosis_Date), MONTH(OCD_Diagnosis_Date)
ORDER BY 1

--What is the most common Obsession Type and it respective Avg Obsession Score
SELECT Obsession_Type, COUNT(Patient_ID) No_of_Patient,
CAST(AVG(CAST(Y_BOCS_Score_Obsessions AS DECIMAL (10,2))) AS DECIMAL (10,2)) Avg_of_Y_BOCS 
FROM ocd_patient_dataset
GROUP BY Obsession_Type
ORDER BY No_of_Patient

--What is the most common Compulsion Type and it respective Avg Compulsions Score
SELECT Compulsion_Type, COUNT(Patient_ID) No_of_Patient,
CAST(AVG(CAST(Y_BOCS_Score_Compulsions AS DECIMAL (10,2))) AS DECIMAL (10,2)) Avg_of_Y_BOCS 
FROM ocd_patient_dataset
GROUP BY Compulsion_Type
ORDER BY No_of_Patient

--Percentage & Total No of Family History
SELECT CASE 
WHEN family_history_of_OCD = 0 THEN 'Not Historical'
ELSE 'Historical'
END Family_History,
CAST(CAST(SUM(patient_id) AS DECIMAL(10,2)) * 100/
(SELECT CAST(SUM(patient_id) AS DECIMAL(10,2)) FROM ocd_patient_dataset) AS DECIMAL(10,2)) PCT,
COUNT(Patient_ID) No_of_Patient
FROM ocd_patient_dataset
GROUP BY CASE 
WHEN family_history_of_OCD = 0 THEN 'Not Historical'
ELSE 'Historical'
END
ORDER BY PCT DESC

--Percentage & Total No of Depression
SELECT CASE 
WHEN Depression_Diagnosis = 0 THEN 'Not Depress'
ELSE 'Depress'
END Depression,
CAST(CAST(COUNT(patient_id) AS DECIMAL(10,2)) * 100/
(SELECT CAST(COUNT(patient_id) AS DECIMAL(10,2)) FROM ocd_patient_dataset) AS DECIMAL(10,2)) PCT,
COUNT(Patient_ID) No_of_Patient
FROM ocd_patient_dataset
GROUP BY CASE 
WHEN Depression_Diagnosis = 0 THEN 'Not Depress'
ELSE 'Depress'
END
ORDER BY PCT DESC

--Compulsions Score Category, by Percentage, Avg Obsession & No of Patient
SELECT
	CASE 
WHEN Y_BOCS_Score_Compulsions BETWEEN 0 AND 7 THEN 'Sub-Clinical'
WHEN Y_BOCS_Score_Compulsions BETWEEN 8 AND 15 THEN 'Mild'
WHEN Y_BOCS_Score_Compulsions BETWEEN 16 AND 23 THEN 'Moderate'
WHEN Y_BOCS_Score_Compulsions BETWEEN 24 AND 31 THEN 'Severe'
ELSE 'Extreme'
END AS Y_BOCS_SCORE_Comp_Category,
CAST(CAST(COUNT(patient_id) AS DECIMAL(10,2)) * 100/
(SELECT CAST(COUNT(patient_id) AS DECIMAL(10,2)) FROM ocd_patient_dataset) AS DECIMAL(10,2)) PCT,
COUNT(Patient_ID) No_of_Patient,
CAST(AVG(CAST(Y_BOCS_Score_Compulsions AS DECIMAL (10,2))) AS DECIMAL (10,2)) Avg_of_Y_BOCS 
FROM ocd_patient_dataset
GROUP BY CASE 
WHEN Y_BOCS_Score_Compulsions BETWEEN 0 AND 7 THEN 'Sub-Clinical'
WHEN Y_BOCS_Score_Compulsions BETWEEN 8 AND 15 THEN 'Mild'
WHEN Y_BOCS_Score_Compulsions BETWEEN 16 AND 23 THEN 'Moderate'
WHEN Y_BOCS_Score_Compulsions BETWEEN 24 AND 31 THEN 'Severe'
ELSE 'Extreme'
END
ORDER BY PCT DESC

--Obsession Score Category, by Percentage, Avg Obsession & No of Patient
SELECT
	CASE 
WHEN Y_BOCS_Score_Obsessions BETWEEN 0 AND 7 THEN 'Sub-Clinical'
WHEN Y_BOCS_Score_Obsessions BETWEEN 8 AND 15 THEN 'Mild'
WHEN Y_BOCS_Score_Obsessions BETWEEN 16 AND 23 THEN 'Moderate'
WHEN Y_BOCS_Score_Obsessions BETWEEN 24 AND 31 THEN 'Severe'
ELSE 'Extreme'
END AS Y_BOCS_SCORE_Comp_Category,
CAST(CAST(COUNT(patient_id) AS DECIMAL(10,2)) * 100/
(SELECT CAST(COUNT(patient_id) AS DECIMAL(10,2)) FROM ocd_patient_dataset) AS DECIMAL(10,2)) PCT,
COUNT(Patient_ID) No_of_Patient,
CAST(AVG(CAST(Y_BOCS_Score_Obsessions AS DECIMAL (10,2))) AS DECIMAL (10,2)) Avg_of_Y_BOCS 
FROM ocd_patient_dataset
GROUP BY CASE 
WHEN Y_BOCS_Score_Obsessions BETWEEN 0 AND 7 THEN 'Sub-Clinical'
WHEN Y_BOCS_Score_Obsessions BETWEEN 8 AND 15 THEN 'Mild'
WHEN Y_BOCS_Score_Obsessions BETWEEN 16 AND 23 THEN 'Moderate'
WHEN Y_BOCS_Score_Obsessions BETWEEN 24 AND 31 THEN 'Severe'
ELSE 'Extreme'
END
ORDER BY PCT DESC

--Age Category, by Percentage & No of Patient
SELECT
	CASE 
WHEN Age BETWEEN 0 AND 18 THEN 'Children/Teen'
WHEN Age BETWEEN 19 AND 35 THEN 'Young Adult'
WHEN Age BETWEEN 36 AND 60 THEN 'Adult'
ELSE 'Elder'
END AS Age_Category,
CAST(CAST(SUM(patient_id) AS DECIMAL(10,2)) * 100/
(SELECT CAST(SUM(patient_id) AS DECIMAL(10,2)) FROM ocd_patient_dataset) AS DECIMAL(10,2)) PCT,
COUNT(Patient_ID) No_of_Patient
FROM ocd_patient_dataset
GROUP BY CASE 
WHEN Age BETWEEN 0 AND 18 THEN 'Children/Teen'
WHEN Age BETWEEN 19 AND 35 THEN 'Young Adult'
WHEN Age BETWEEN 36 AND 60 THEN 'Adult'
ELSE 'Elder'
END
ORDER BY PCT DESC










