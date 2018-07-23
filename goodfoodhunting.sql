CREATE DATABASE goodfoodhunting;

CREATE TABLE dishes(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(100),
  image_url VARCHAR(400)
);

INSERT INTO dishes (name, image_url) VALUES ('birthday cake', 'http://wanna-joke.com/wp-content/uploads/2014/11/funny-clint-cake-cunt.jpg'
);

INSERT INTO dishes (name, image_url) VALUES ('yorkshire pudding', 'https://144f2a3a2f948f23fc61-ca525f0a2beaec3e91ca498facd51f15.ssl.cf3.rackcdn.com/uploads/food_portal_data/recipes/recipe/hero_article_image/1300/84158451f08bc14ae1a3/compressed_Giant-yorkshire-puddingV2.jpg');

INSERT INTO dishes (name, image_url) VALUES ('trifle', 'https://be35832fa5168a30acd6-5c7e0f2623ae37b4a933167fe83d71b5.ssl.cf3.rackcdn.com/1556/strawberry-elderflower-trifle__square.jpg');

INSERT INTO dishes (name, image_url) VALUES ('salmon mousse', 'https://cdn.24.co.za/files/Cms/General/d/2060/c4b54631e1d8477e887c22d3f98a2620.jpg');



CREATE TABLE comments(
  id SERIAL4 PRIMARY KEY,
  -- NOT NULL means values must not be false.
  content TEXT NOT NULL,
  dish_id INTEGER NOT NULL,
  -- gives you more safety incase of problems or things breaking on site, add more rules. 
  FOREIGN KEY (dish_id) REFERENCES dishes (id) ON DELETE RESTRICT
  -- FOREIGN KEY refers to content from a DIFFERENT table. 
);


CREATE TABLE users (
  id SERIAL4 PRIMARY KEY,
  email VARCHAR(300),
  password_digest VARCHAR(400)
);
--  we never set the password digest because it's a set method. 
  -- doesn't need foreign keys because the users arent' dependent on the other tables. 


ALTER TABLE dishes ADD COLUMN user_id INTEGER;


CREATE TABLE likes (
  id SERIAL4 PRIMARY KEY, -- need to add in not null etc
  user_id INTEGER,
  dish_id INTEGER
);

ALTER TABLE comments ADD COLUMN user_id INTEGER;



INSERT INTO comments (content, dish_id) VALUES ('yum', 2);
-- INSERT INTO 

-- TERMINAL COMMANDS FOR CHECKING THEN CREATING TABLE THEN DROPPING TABLE
-- psql (9.5.13)
-- Type "help" for help.

-- goodfoodhunting=# /dt
-- goodfoodhunting-# \dt
--         List of relations
--  Schema |  Name  | Type  | Owner  
-- --------+--------+-------+--------
--  public | dishes | table | thomas
-- (1 row)

-- goodfoodhunting-# \dt
--         List of relations
--  Schema |  Name  | Type  | Owner  
-- --------+--------+-------+--------
--  public | dishes | table | thomas
-- (1 row)

-- goodfoodhunting-# CREATE TABLE comments(
-- goodfoodhunting(#   id SERIAL4 PRIMARY KEY,
-- goodfoodhunting(#   content TEXT,
-- goodfoodhunting(#   dish_id INTEGER
-- goodfoodhunting(# );
-- ERROR:  syntax error at or near "/"
-- LINE 1: /dt
--         ^
-- goodfoodhunting=# CREATE TABLE comments(
-- goodfoodhunting(#   id SERIAL4 PRIMARY KEY,
-- goodfoodhunting(#   content TEXT,
-- goodfoodhunting(#   dish_id INTEGER
-- goodfoodhunting(# );
-- CREATE TABLE
-- goodfoodhunting=# \dt
--          List of relations
--  Schema |   Name   | Type  | Owner  
-- --------+----------+-------+--------
--  public | comments | table | thomas
--  public | dishes   | table | thomas
-- (2 rows)

-- goodfoodhunting=# CREATE TABLE comments(
-- goodfoodhunting(#   id SERIAL4 PRIMARY KEY,
-- goodfoodhunting(#   -- NOT NULL means values must not be false.
-- goodfoodhunting(#   content TEXT NOT NULL,
-- goodfoodhunting(#   dish_id INTEGER NOT NULL,
-- goodfoodhunting(#   FOREIGN KEY (dish_id) REFERENCES dishes (id) ON DELETE RESTRICT

-- goodfoodhunting=# select id, name from dishes;
--  id |       name        
-- ----+-------------------
--   2 | yorkshire pudding
--   3 | trifle
--   4 | salmon mousse
--   5 | 
--   6 | 
--   7 | 
--   8 | 
--  10 | pancakes
--  11 | black puddoing
-- (9 rows)

-- goodfoodhunting=# insert into comments (content, dish_id) values ('yum', 2);
-- INSERT 0 1
-- goodfoodhunting=# select * from comments;
--  id | content | dish_id 
-- ----+---------+---------
--   1 | yum     |       2
-- (1 row)

-- goodfoodhunting=# delete from dishes where id=12;
-- ERROR:  update or delete on table "dishes" violates foreign key constraint "comments_dish_id_fkey" on table "comments"
-- DETAIL:  Key (id)=(2) is still referenced from table "comments".
-- goodfoodhunting=# insert into comments (content, dish_id) values ('yum', 2);
-- INSERT 0 1
-- goodfoodhunting=# 






