rem Sass 3.2.12 (Media Mark)
call sass "src/stylesheets/main.scss" --style compressed > "static/styles.min.css"
call sass "src/stylesheets/main.scss" --style expanded > "static/styles.css"