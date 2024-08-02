DOWNLOAD:=download
TMP:=tmp
HOSTING:=docs

HOSTING_BUCKET := vector-tile

PREFECTURES := 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47

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

	rm -rf $(TMP)/n03
	mkdir -p $(TMP)/n03
	tile-join -f -e $(TMP)/n03 --no-tile-size-limit $(TMP)/prefecture.mbtiles $(TMP)/normalized_n03.mbtiles

	# アップロード
	gsutil -m -h "Content-Encoding:gzip" -h "Cache-Control:public, max-age=15, no-store" \
		cp -r $(TMP)/n03 gs://$(HOSTING_BUCKET)/n03


# 市区町村役場データ
# https://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-P34.html
download-P34:
	mkdir -p $(DOWNLOAD)/P34
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_01_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_02_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_03_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_04_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_05_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_06_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_07_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_08_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_09_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_10_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_11_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_12_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_13_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_14_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_15_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_16_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_17_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_18_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_19_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_20_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_21_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_22_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_23_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_24_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_25_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_26_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_27_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_28_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_29_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_30_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_31_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_32_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_33_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_34_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_35_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_36_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_37_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_38_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_39_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_40_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_41_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_42_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_43_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_44_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_45_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_46_GML.zip	
	cd $(DOWNLOAD)/P34 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_47_GML.zip
unzip-P34:
	mkdir -p $(TMP)/P34
	unzip -d $(TMP)/P34 "$(DOWNLOAD)/P34/*.zip"

import-P34:
	find tmp -name "*.shp" -print0 | xargs -0 -I {} ogr2ogr -oo ENCODING=CP932 -t_srs EPSG:4326 -f "PostgreSQL" PG:"host=localhost dbname=geomdb user=postgres" -append {} -nln p34

normalize-P34:
	psql -h localhost -U postgres geomdb -f normalize-p34.sql
	ogr2ogr -f GeoJSON $(TMP)/normalized_p34.geojson PG:"host=localhost dbname=geomdb user=postgres" "normalized_p34"



# 燃料給油所データ
# https://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-P07-2016.html
download-P07:
	mkdir -p $(DOWNLOAD)/P07
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_01_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_02_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_03_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_04_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_05_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_06_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_07_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_08_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_09_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_10_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_11_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_12_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_13_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_14_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_15_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_16_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_17_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_18_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_19_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_20_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_21_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_22_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_23_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_24_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_25_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_26_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_27_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_28_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_29_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_30_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_31_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_32_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_33_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_34_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_35_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_36_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_37_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_38_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_39_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_40_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_41_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_42_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_43_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_44_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_45_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_46_GML.zip	
	cd $(DOWNLOAD)/P07 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_47_GML.zip	
unzip-P07:
	mkdir -p $(TMP)/P07
	unzip -d $(TMP)/P07 "$(DOWNLOAD)/P07/*.zip"
shapefile2geojson-P07:
	- psql -U postgres -d geomdb -c "DROP TABLE p07;"

	@for prefecture in $(PREFECTURES); do \
		file=$(TMP)/P07/P07-15_$${prefecture}.shp; \
		echo $${file}; \
		if [ "$${prefecture}" = "01" ]; then \
			ogr2ogr -oo ENCODING=CP932 -s_srs EPSG:4612 -t_srs EPSG:4326 -f "PostgreSQL" PG:"host=localhost dbname=geomdb user=postgres" $${file} -nln p07 -lco "COLUMN_TYPES=p07_002=VARCHAR(255)"; \
			continue; \
		fi; \
		ogr2ogr -oo ENCODING=CP932 -s_srs EPSG:4612 -t_srs EPSG:4326 -f "PostgreSQL" PG:"host=localhost dbname=geomdb user=postgres" -append $${file} -nln p07; \
	done

	ogr2ogr -f GeoJSON $(TMP)/P07-15_all.geojson PG:"host=localhost user=postgres dbname=geomdb" p07

# 避難施設データ
# https://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-P20.html
download-P20:
	mkdir -p $(DOWNLOAD)/P20
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_01_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_02_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_03_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_04_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_05_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_06_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_07_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_08_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_09_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_10_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_11_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_12_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_13_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_14_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_15_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_16_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_17_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_18_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_19_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_20_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_21_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_22_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_23_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_24_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_25_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_26_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_27_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_28_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_29_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_30_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_31_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_32_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_33_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_34_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_35_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_36_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_37_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_38_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_39_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_40_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_41_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_42_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_43_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_44_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_45_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_46_GML.zip	
	cd $(DOWNLOAD)/P20 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_47_GML.zip	
unzip-P20:
	mkdir -p $(TMP)/P20
	unzip -d $(TMP)/P20 "$(DOWNLOAD)/P20/*.zip"
shapefile2geojson-P20:
	- psql -U postgres -d geomdb -c "DROP TABLE p20;"
	find $(TMP)/P20 -name "P20-??_??.shp" -print0 | xargs -0 -I {} ogr2ogr -oo ENCODING=CP932 -t_srs EPSG:4326 -f "PostgreSQL" PG:"host=localhost dbname=geomdb user=postgres" -append {} -nln p20
	ogr2ogr -f GeoJSON $(TMP)/P20-12_all.geojson PG:"host=localhost user=postgres dbname=geomdb" p20



# 都市公園データ
# https://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-P13.html
download-P13:
	mkdir -p $(DOWNLOAD)/P13
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_01_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_02_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_03_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_04_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_05_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_06_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_07_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_08_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_09_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_10_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_11_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_12_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_13_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_14_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_15_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_16_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_17_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_18_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_19_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_20_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_21_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_22_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_23_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_24_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_25_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_26_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_27_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_28_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_29_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_30_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_31_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_32_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_33_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_34_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_35_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_36_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_37_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_38_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_39_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_40_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_41_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_42_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_43_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_44_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_45_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_46_GML.zip	
	cd $(DOWNLOAD)/P13 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P13/P13-11/P13-11_47_GML.zip	
unzip-P13:
	mkdir -p $(TMP)/P13
	unzip -d $(TMP)/P13 "$(DOWNLOAD)/P13/*.zip"
shapefile2geojson-P13:
	- psql -U postgres -d geomdb -c "DROP TABLE p13;"
	
	@for prefecture in $(PREFECTURES); do \
		file=$(TMP)/P13/P13-11_$${prefecture}.shp; \
		echo $${file}; \
		if [ "$${prefecture}" = "01" ]; then \
			ogr2ogr -oo ENCODING=CP932 -s_srs EPSG:4612 -t_srs EPSG:4326 -f "PostgreSQL" PG:"host=localhost dbname=geomdb user=postgres" $${file} -nln p13 -lco "COLUMN_TYPES=p13_001=VARCHAR(255),p13_002=VARCHAR(255),p13_003=VARCHAR(255),p13_005=VARCHAR(255),p13_006=VARCHAR(255)"; \
			continue; \
		fi; \
		ogr2ogr -oo ENCODING=CP932 -s_srs EPSG:4612 -t_srs EPSG:4326 -f "PostgreSQL" PG:"host=localhost dbname=geomdb user=postgres" -append $${file} -nln p13; \
	done
	
	ogr2ogr -f GeoJSON $(TMP)/P13-11_all.geojson PG:"host=localhost user=postgres dbname=geomdb" p13



# 上水道関連施設 ※ 非商用
# https://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-P21.html
download-P21:
	mkdir -p $(DOWNLOAD)/P21
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_01_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_02_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_03_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_04_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_05_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_06_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_07_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_08_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_09_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_10_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_11_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_12_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_13_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_14_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_15_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_16_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_17_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_18_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_19_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_20_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_21_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_22_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_23_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_24_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_25_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_26_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_27_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_28_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_29_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_30_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_31_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_32_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_33_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_34_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_35_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_36_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_37_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_38_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_39_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_40_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_41_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_42_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_43_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_44_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_45_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_46_GML.zip	
	cd $(DOWNLOAD)/P21 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P21/P21-12/P21-12_47_GML.zip	
unzip-P21:
	mkdir -p $(TMP)/P21
	unzip -d $(TMP)/P21 "$(DOWNLOAD)/P21/*.zip"
shapefile2geojson-P21:
	- psql -U postgres -d geomdb -c "DROP TABLE p21b;"
	find $(TMP)/P21 -name "P21-??b_??.shp" -print0 | xargs -0 -I {} ogr2ogr -oo ENCODING=CP932 -s_srs EPSG:4612 -t_srs EPSG:4326 -f "PostgreSQL" PG:"host=localhost dbname=geomdb user=postgres" -append {} -nln p21b
	ogr2ogr -f GeoJSON $(TMP)/P21-12b_all.geojson PG:"host=localhost user=postgres dbname=geomdb" p21b

# 警察署
# https://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-P18.html
download-P18:
	mkdir -p $(DOWNLOAD)/P18
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_01_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_02_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_03_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_04_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_05_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_06_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_07_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_08_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_09_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_10_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_11_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_12_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_13_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_14_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_15_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_16_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_17_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_18_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_19_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_20_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_21_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_22_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_23_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_24_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_25_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_26_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_27_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_28_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_29_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_30_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_31_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_32_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_33_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_34_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_35_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_36_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_37_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_38_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_39_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_40_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_41_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_42_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_43_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_44_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_45_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_46_GML.zip	
	cd $(DOWNLOAD)/P18 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P18/P18-12/P18-12_47_GML.zip	
unzip-P18:
	mkdir -p $(TMP)/P18
	unzip -d $(TMP)/P18 "$(DOWNLOAD)/P18/*.zip"
shapefile2geojson-P18:
	- psql -U postgres -d geomdb -c "DROP TABLE p18policestation;"

	@for prefecture in $(PREFECTURES); do \
		file=$(TMP)/P18/P18-12_$${prefecture}_PoliceStation.shp; \
		echo $${file}; \
		if [ "$${prefecture}" = "01" ]; then \
			ogr2ogr -oo ENCODING=CP932 -s_srs EPSG:4612 -t_srs EPSG:4326 -f "PostgreSQL" PG:"host=localhost dbname=geomdb user=postgres" $${file} -nln p18policestation -lco "COLUMN_TYPES=p18_001=VARCHAR(255),p18_004=VARCHAR(255)"; \
			continue; \
		fi; \
		ogr2ogr -oo ENCODING=CP932 -s_srs EPSG:4612 -t_srs EPSG:4326 -f "PostgreSQL" PG:"host=localhost dbname=geomdb user=postgres" -append $${file} -nln p18policestation; \
	done

	ogr2ogr -f GeoJSON $(TMP)/P18-12_all_PoliceStation.geojson PG:"host=localhost user=postgres dbname=geomdb" p18policestation

# 消防署
# https://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-P17.html
download-P17:
	mkdir -p $(DOWNLOAD)/P17
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_01_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_02_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_03_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_04_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_05_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_06_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_07_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_08_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_09_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_10_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_11_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_12_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_13_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_14_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_15_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_16_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_17_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_18_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_19_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_20_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_21_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_22_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_23_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_24_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_25_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_26_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_27_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_28_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_29_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_30_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_31_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_32_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_33_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_34_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_35_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_36_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_37_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_38_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_39_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_40_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_41_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_42_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_43_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_44_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_45_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_46_GML.zip	
	cd $(DOWNLOAD)/P17 && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P17/P17-12/P17-12_47_GML.zip	
unzip-P17:
	mkdir -p $(TMP)/P17
	unzip -d $(TMP)/P17 "$(DOWNLOAD)/P17/*.zip"
shapefile2geojson-P17:
	- psql -U postgres -d geomdb -c "DROP TABLE p17firestation;"

	@for prefecture in $(PREFECTURES); do \
		file=$(TMP)/P17/P17-12_$${prefecture}_FireStation.shp; \
		echo $${file}; \
		if [ "$${prefecture}" = "01" ]; then \
			ogr2ogr -oo ENCODING=CP932 -s_srs EPSG:4612 -t_srs EPSG:4326 -f "PostgreSQL" PG:"host=localhost dbname=geomdb user=postgres" $${file} -nln p17firestation -lco "COLUMN_TYPES=p17_001=VARCHAR(255),p17_004=VARCHAR(255)"; \
			continue; \
		fi; \
		ogr2ogr -oo ENCODING=CP932 -s_srs EPSG:4612 -t_srs EPSG:4326 -f "PostgreSQL" PG:"host=localhost dbname=geomdb user=postgres" -append $${file} -nln p17firestation; \
	done

	ogr2ogr -f GeoJSON $(TMP)/P17-12_all_FireStation.geojson PG:"host=localhost user=postgres dbname=geomdb" p17firestation

snippets:
	psql -h localhost -U postgres     

	docker ps
	docker exec --interactive --tty {コンテナ名} bash
	docker exec --interactive -u postgres --tty {コンテナ名} bash

	psql -h localhost -U postgres geomdb -f create-tables.sql