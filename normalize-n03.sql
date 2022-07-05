-- N03 に都道府県コードを追加する。

CREATE TABLE normalized_n03 AS
SELECT ogc_fid
	, n03_001
	, n03_002
	, n03_003
	, n03_004
	, n03_007
	, LEFT(n03_007, 2)::varchar AS prefecture_code
	, wkb_geometry 
FROM n03
WHERE (n03_007 is not NULL) 