#!/usr/bin/env bash

for i in {1..5}
do
  id=$(echo $(curl -X POST http://localhost:9292/api/v1/categories \
    -H 'Cache-Control: no-cache' \
    -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
    -F "category[name]=Category$i") | cut -d':' -f 2 | cut -d',' -f 1)

  for j in {1..50}
  do
    price=$(( $RANDOM % 10000 ));
    curl -X POST http://localhost:9292/api/v1/products \
      -H 'Cache-Control: no-cache' \
      -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
      -F "product[name]=Product$i-$j" \
      -F "product[category_id]=$id" \
      -F "product[price]=$price"
      echo "\n";
  done
done