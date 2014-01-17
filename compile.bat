rem Sass 3.2.13 (Media Mark)
call sass --style compressed "src\stylesheets\main.scss" "static\styles.min.css"
call sass --style expanded "src\stylesheets\main.scss" "static\styles.css"

rem CoffeeScript version 1.6.3
call coffee --output "src" --compile "src"