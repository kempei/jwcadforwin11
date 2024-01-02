# JWCAD DOS/V 版を dosbox-x 経由で印刷も可能にする方法
Enable JWCAD for DOS on Win11 with printing function.

## JWCAD DOS/V 版を dosbox-x で動作させる
JWCAD DOS/V 版を Windows 11 で動作させることについては、dosbox-x の日本語対応によりシンプルな設定変更で起動が可能になっており、日本語もWindows側のIMEをシームレスに利用できるようになっています。
このリポジトリの doxbox-x.conf が参考になるでしょう。

### 解像度
スクリーンの解像度に合わせて以下の箇所を変更しておくと良いでしょう。`640x480`の比率を維持するように設定します。

```
[sdl]
fullscreen        = true
fullresolution    = 1024x768
```

### 日本語対応のための DOS/V 設定
以下を変更します。

```
machine                   = svga_et4000
dosv             = jp
j3100            = on
```

## 印刷について
JWCAD から直接印刷するために、dosbox-x の印刷機能をそのまま使っても、日本語を含む場合などに ESC/P を正しく解釈せず、うまく印刷されません。しかし、古いプリンタの問題を解決するためのサイト[retroprinter.com](https://www.retroprinter.com/)が公開している[PrinterToPDF](https://github.com/RWAP/PrinterToPDF)を用いることで、JWCADの印刷データを基にPDFを正しく作成することができます。出力されたPDFを印刷すればOKです。これらの一連の流れを簡単なスクリプトにしています。

### dosbox-x.conf の印刷設定
以下のようにファイル出力を設定します。Your Username の部分は Windows のユーザー名とします。

```
parallel1 = file file:escp.prn openwith:C:\Users\<Your Username>\printertopdf\print.bat
```

dosbox-x を終了すると `openwith` のバッチファイルが実行されます。JWCAD の印刷終了時には実行されないのでご注意下さい。

## PrinterToPDF のビルドをWSLで実施する
PrinterToPDF は、[GitHub 上のINSTALLATION](https://github.com/RWAP/PrinterToPDF#:~:text=run%20make.-,INSTALLATION,-make%20install%20installs)を基にビルドします。Windows 上ではそのままビルドできないので、WSL上のDebianで実施します。

### Debian でビルドする際の注意点
依存パッケージの[libharu](https://github.com/libharu/libharu/wiki/Installation)をインストール後、元々の注意点にもあるように、includeを `/usr/include/` から `/usr/local/include` に変更する必要があります。

## PDF の作成シェル
makepdf.sh を PrinterToPDF をビルドしたディレクトリで実行することで、フォント指定もされ、Windows 本体側のフォルダにPDFが転送されます。

## PDF の印刷バッチファイル
doxbox-x から自動的に実行されるように設定している print.bat では、[PDFPrinter](https://github.com/emendelson/pdftoprinter/)を用いて変換されたPDFを全て印刷しています。
予めユーザーフォルダに printertopdf フォルダを作成し、PDFPrinter.exe を配置しておいて下さい。
