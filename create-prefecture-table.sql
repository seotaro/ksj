-- N03 から都道府県だけ抜き出す。

DROP TABLE prefecture;

CREATE TABLE prefecture AS
SELECT ogc_fid
	, LEFT('0' || ogc_fid, 2)::varchar AS code
	, n03_001 AS name
	, wkb_geometry 
FROM n03
WHERE (n03_002 is NULL) 
	AND (n03_003 is NULL)
	AND (n03_004 is NULL)
	AND (n03_007 is NULL)
