#! /bin/bash
USERDIR=/mnt/c/Users/<Your Username>
cd ~/
rm -Rf pdfwork/*
rm -Rf ${USERDIR}/printertopdf/pdf
printerToPDF -o pdfwork -f PrinterToPdf/font2/Epson-Standard.C16 -m 12 /mnt/c/DOSBox-X/escp.prn
for f in `ls pdfwork/pdf/*.pdf`
do
	size=$(stat -c %s $f)
	if [ $size -eq 147289 ]
	then
		rm $f
	fi
done
cp -r pdfwork/pdf ${USERDIR}/printertopdf/
rm /mnt/c/DOSBox-X/escp.prn

