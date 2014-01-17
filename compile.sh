sass --style compressed "src\stylesheets\main.scss" "static\styles.min.css"
sass --style expanded "src\stylesheets\main.scss" "static\styles.css"
coffee --output "src" --compile "src"