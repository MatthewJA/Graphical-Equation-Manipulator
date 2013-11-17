rem CoffeeScript version 1.6.3 
call coffee -c src\algebra.coffee
call coffee -c tests\algebraTests.coffee

call move src\algebra.js algebra.js