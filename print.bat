wsl ~/makepdf.sh
C:
cd C:\Users\<Your User Name>\printertopdf
cd pdf
for %%a in (*.pdf) do (..\PDFtoPrinter.exe %%a)
cd ..