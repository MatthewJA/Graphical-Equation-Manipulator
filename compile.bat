rem Sass 3.2.12 (Media Mark)
call sass "src\stylesheets\main.scss" --style compressed > "static\styles.min.css"
call sass "src\stylesheets\main.scss" --style expanded > "static\styles.css"

rem CoffeeScript version 1.6.3
call coffee --output "src" --compile "src"