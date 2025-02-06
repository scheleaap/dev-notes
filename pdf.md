# PDF manipulation

Convert Markdown to PDF:
```sh
pandoc --pdf-engine=wkhtmltopdf "Cover letter.md" -o "Cover letter.pdf"
```

Concatenate two PDF files:
```sh
convert doc1.pdf doc2.pdf docs.pdf
```

Convert two JPEG files into one PDF:
```sh
convert pic1.jpg pic2.jpg pics.pdf
```
