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

	rm -rf $(TMP)/n03
	mkdir -p $(TMP)/n03
	tile-join -f -e $(TMP)/n03 --no-tile-size-limit $(TMP)/prefecture.mbtiles $(TMP)/normalized_n03.mbtiles

	# アップロード
	gsutil -m -h "Content-Encoding:gzip" -h "Cache-Control:public, max-age=15, no-store" \
		cp -r $(TMP)/n03 gs://$(HOSTING_BUCKET)/n03


# 市区町村役場データ
# https://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-P34.html
download-p34:
	mkdir -p $(DOWNLOAD)
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_01_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_02_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_03_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_04_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_05_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_06_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_07_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_08_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_09_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_10_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_11_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_12_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_13_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_14_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_15_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_16_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_17_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_18_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_19_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_20_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_21_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_22_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_23_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_24_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_25_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_26_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_27_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_28_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_29_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_30_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_31_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_32_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_33_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_34_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_35_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_36_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_37_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_38_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_39_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_40_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_41_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_42_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_43_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_44_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_45_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_46_GML.zip	
	cd $(DOWNLOAD) && curl -O https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_47_GML.zip

unzip-P34:
	unzip -d tmp "download/*.zip"

import-P34:
	find tmp -name "*.shp" -print0 | xargs -0 -I {} ogr2ogr -oo ENCODING=CP932 -f "PostgreSQL" PG:"host=localhost dbname=geomdb user=postgres" -append {} -nln p34

