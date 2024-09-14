## Convert Markdown to PDF
### On Wsl
- `Install pandoc` :
```shell
sudo apt-get install pandoc
```
- `Copy markdown file to the Wsl` :
```shell
cp /mnt/c/Users/username/Documents/README.md /home/username
```
- `Convert markdown file to pdf` :
```shell
pandoc README.md -s -o cv.pdf -V geometry:"top=1cm, bottom=1cm, left=1cm, right=1cm"
```
- `Copy the pdf file into Windows` :
```shell
cp README.pdf /mnt/c/Users/username/Documents
```
- `Open pdf file in Wsl` :
```shell
zathura README.pdf
```
- `Install zathura` :
```shell
sudo apt-get install zathura
```

