#!/bin/bash

csvstack data/2019-Oct-sample.csv data/2019-Nov-sample.csv > data/combined_data.csv

csvcut -c 2-5,7-8 data/combined_data.csv | csvgrep -c "event_type" -m "purchase" > data/selected_columns_grep_purchase.csv

csvgrep -c "event_type" -m "purchase" data/combined_data.csv | csvcut -c 6 | awk -F '.' 'NR==1{print $1="category",$NF="product_name"} NR>1{print $1,$NF}' > data/category_code_splitted.csv

csvjoin data/selected_columns_grep_purchase.csv data/category_code_splitted.csv > data/cleaned_purchase_data.csv
