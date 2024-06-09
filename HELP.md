## Convert Markdown to PDF
### On Wsl
- `Install pandoc` :
```shell
sudo apt-get install pandoc
```
- `Copy the markdown file to the Wsl` :
```shell
cp /mnt/c/Users/username/Documents/README.md /home/username
```
- `Convert the markdown file to pdf` :
```shell
pandoc -s README.md -o README.pdf
```

- `To copy the pdf file to the Windows` :
```shell
cp README.pdf /mnt/c/Users/username/Documents
```
- `To open the pdf file in Wsl` :
```shell
zathura README.pdf
```
- `To install zathura` :
```shell
sudo apt-get install zathura
```

- `To forcew a new page` :
```text
\newpage
```

