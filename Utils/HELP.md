## Convert Markdown to PDF
### On Wsl
- Install pandoc :
```shell
sudo apt-get install pandoc
```

- Convert md to html :
```shell
pandoc README.md -o README.html
```

- Convert html to pdf :
```shell
google-chrome --headless --no-pdf-header-footer --print-to-pdf=cv.pdf README.html
```

