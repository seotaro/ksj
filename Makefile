DOWNLOAD:=download
TMP:=tmp
HOSTING:=docs

HOSTING_BUCKET := vector-tile

n03:
	# インポート
	psql -U postgres geomdb -f drop-tables.sql
	ogr2ogr -makevalid -oo ENCODING=CP932 -t_srs EPSG:4326 -f "PostgreSQL" PG:"host=localhost user=postgres dbname=geomdb" $(DOWNLOAD)/N03-20220101_GML/N03-22_220101.shp -nln "n03" -nlt PROMOTE_TO_MULTI

	# 
	psql -U postgres geomdb -f normalize-n03.sql
	psql -U postgres geomdb -f create-prefecture-table.sql

	# エクスポート
	rm -rf $(TMP)
	mkdir -p $(TMP)
	ogr2ogr -f GeoJSON $(TMP)/prefecture.geojson PG:"host=localhost user=postgres dbname=geomdb" "prefecture"
	ogr2ogr -f GeoJSON $(TMP)/normalized_n03.geojson PG:"host=localhost user=postgres dbname=geomdb" "normalized_n03"

	# タイル
	tippecanoe -f --minimum-zoom=0 --maximum-zoom=15 -l prefecture --no-feature-limit --no-tile-size-limit -o $(TMP)/prefecture.mbtiles $(TMP)/prefecture.geojson
	tippecanoe -f --minimum-zoom=0 --maximum-zoom=15 -l n03 --no-feature-limit --no-tile-size-limit -o $(TMP)/normalized_n03.mbtiles $(TMP)/normalized_n03.geojson
	
	rm -rf $(HOSTING)/n03
	mkdir -p $(HOSTING)/n03
	tile-join -f -e $(HOSTING)/n03 --no-tile-size-limit $(TMP)/prefecture.mbtiles $(TMP)/normalized_n03.mbtiles

	# gsutil -m -h "Content-Encoding:gzip" -h "Cache-Control:public, max-age=15, no-store" \
	# 	cp -r $(TMP)/tile gs://$(HOSTING_BUCKET)/n03
