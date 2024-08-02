# ksj

初期の地図
国土数値情報からベース拠点を引っ張ってくる

|  データ  |  識別子  |  座標系  |  ShapeFile  |  GeoJSON  |  メモ  |
| ---- | ---- | ---- | ---- | ---- | ---- |
|  [鉄道](https://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-N02-2023.html)  |  N02  |  JGD2011 / （B, L）  |  ○  |  ○  |  GeoJSONはShift-JIS  |
|  [医療機関](https://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-P04-2020.html)  |  P04  |  JGD2011 / （B, L）  |  ○  |  ○  |  TD  |
|  [燃料給油所](https://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-P07-2016.html)  |  P07  |  JGD2011 / （B, L）  |  ○  |  −  |  TD  |
|  [都市公園（2022年度以前）](https://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-P13.html)  |  P13  |  JGD2000 / （B, L）  |  ○  |  −  |  TD  |
|  [消防署](https://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-P17.html)  |  P17  |  JGD2000 / （B, L）  |  ○  |  −  |  prjファイルがない  |
|  [警察署](https://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-P18.html)  |  P18  |  JGD2000 / （B, L）  |  ○  |  −  |  prjファイルがない  |
|  [避難施設](https://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-P20.html)  |  P20  |  JGD2000 / （B, L）  |  ○  |  −  |  TD  |
|  [上水道関連施設](https://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-P21.html)  |  P21  |  JGD2000 / （B, L）  |  ○  |  −  |  TD  |
|  [市区町村役場](https://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-P34.html)  |  P34  |  世界測地系（JGD2000） / （B, L）  |  ○  |  −  |  TD  |
|  TD  |  TD  |  TD  |  TD  |  TD  |  TD  |

※ JGD2011 → EPSG:6668
※ JGD2000 → EPSG:4612

## 医療機関データ ※ 商用利用可能

<https://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-P04-2020.html>
P04-20_GML.zip

shapefile の文字コードがxxx, 文字化け
geojson は UTF-8

## 燃料給油所データ ※ 非商用

<https://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-P07-2016.html>
<https://nlftp.mlit.go.jp/ksj/gml/data/P07/P07-15/P07-15_01_GML.zip>

shapefileのみ
shapefile の文字コードがxxx, 文字化け

## 市区町村役場 ※ 非商用

<https://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-P34.html>
<https://nlftp.mlit.go.jp/ksj/gml/data/P34/P34-14/P34-14_01_GML.zip>

shapefileのみ
shapefile の文字コードがxxx, 文字化け

## 上水道関連施設 ※ 非商用

<https://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-P21.html>
shapefileのみ
shapefile の文字コードがxxx, 文字化け

## 避難施設データ ※ 非商用

<https://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-P20.html>
<https://nlftp.mlit.go.jp/ksj/gml/data/P20/P20-12/P20-12_01_GML.zip>

shapefileのみ

## 都市公園（ポイント）（2022年度以前のデータ） ※ 非商用

<https://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-P13.html>

shapefileのみ
shapefile の文字コードがxxx, 文字化け

## 鉄道（ライン） (中に駅のデータstation.shpあり) ※ 商用利用可能
