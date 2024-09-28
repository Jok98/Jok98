## Convert Markdown to PDF
### On Wsl
- Install pandoc :
```shell
sudo apt-get install pandoc
```
- Install weasyprint :
```shell
sudo apt-get install weasyprint
```
- Convert markdown file to pdf :
```shell
 pandoc README.md -s -o cv.pdf --pdf-engine=weasyprint -V geometry:"top=0cm, bottom=1cm, left=1cm, right=1cm" --metadata title="cv"
```

