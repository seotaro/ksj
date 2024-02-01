-- P34 から本庁（市役所、区役所、町役場、村役場）を抽出する。

CREATE TABLE normalized_p34 AS
SELECT p34_001 as code, p34_003 as name, wkb_geometry
FROM p34 
WHERE p34_002='1' 
ORDER BY p34_001