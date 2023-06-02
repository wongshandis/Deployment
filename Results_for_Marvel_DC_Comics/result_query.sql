-- 1) Extract cleaned data
SELECT marvel_characters_info."ID", 
marvel_characters_info."Name", 
marvel_characters_info."Race", 
marvel_characters_info."Publisher"
FROM marvel_characters_info; 
-- save this table as a new table

-- 2) Collating data from different tables 
SELECT cleaned_superheros_info."Name", 
		cleaned_superheros_info."Race" ,
		cleaned_superheros_info."Publisher",
		superheroes_power_matrix."Durability",
		characters_stats."Durability" as "Durability_score"
FROM cleaned_superheros_info
INNER JOIN superheroes_power_matrix
ON cleaned_superheros_info."Name" = superheroes_power_matrix."Name"
INNER JOIN characters_stats
ON cleaned_superheros_info."Name" = characters_stats."Name"
WHERE cleaned_superheros_info."Race" != 'NULL' 
AND superheroes_power_matrix."Durability" != 'FALSE'
AND (cleaned_superheros_info."Publisher" = 'Marvel Comics' OR cleaned_superheros_info."Publisher" = 'DC Comics');


-- RESULT) Top 3 races of Marvel comic
SELECT DISTINCT output_summary."Race", 
COUNT(output_summary."Durability_score" ) AS "Total Marvel Comics"
FROM output_summary
WHERE output_summary."Publisher" = 'Marvel Comics' 
GROUP BY output_summary."Race" 
ORDER by "Total Marvel Comics" DESC
LIMIT 3


-- RESULT) Top 3 races of DC comic
SELECT DISTINCT output_summary."Race", 
COUNT(output_summary."Durability_score" ) AS "Total DC Comics"
FROM output_summary
WHERE output_summary."Publisher" = 'DC Comics' 
GROUP BY output_summary."Race" 
ORDER by "Total DC Comics" DESC
LIMIT 3

