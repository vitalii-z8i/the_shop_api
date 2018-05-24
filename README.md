# The Shop API
An API for an abstract web-shop for ruby workshop


## Featured Analytics:

- Calculate Top N Hottest products by View/Purchase rate in % (`GET /products/popular`);
- Calculate Products By View/Purchase based on Created Date: (E.g. Newer product, bought 10 times in 7 days goes before Old one, that bought 20 times in last month) (`GET /products/hottest`);
- Calculate top categories by sum of products View/Purchase rate (`GET /categories/popular`);
