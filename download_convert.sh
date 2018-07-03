#!/usr/bin/env bash

# https://skr3.nlm.nih.gov/SemMedDB/download/download.html
wget -N "https://skr3.nlm.nih.gov/SemMedDB/download/semmedVER31_R_PREDICATION_to12312017.sql.gz"

# prepend colnames
cp col_names.txt semmedVER31_R_PREDICATION_to12312017.csv

# convert mysqldump to csv
zcat semmedVER31_R_PREDICATION_to12312017.sql.gz| python3 mysqldump_to_csv.py >> semmedVER31_R_PREDICATION_to12312017.csv


# download umls metathesarous files
wget -N "https://download.nlm.nih.gov/umls/kss/2018AA/umls-2018AA-full.zip"
# I then manually unzipped this file, then extracted the contained files, then put all of the RRF files in one folder ("2018AA-full")

# then ran the following in the umls folder
# zcat MRCONSO.RRF.a* | gzip > MRCONSO.RRF.gz && rm MRCONSO.RRF.a*
# zcat MRSAT.RRF.a* | gzip > MRSAT.RRF.gz && rm MRSAT.RRF.a*
# zcat MRCONSO.RRF.gz| grep -F "|ENG|" | gzip > rm MRCONSO_ENG.RRF.gz

# download unii fda data and unzip
wget -N "http://fdasis.nlm.nih.gov/srs/download/srs/UNII_Data.zip"
