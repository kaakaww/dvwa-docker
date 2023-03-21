
DROP DATABASE IF EXISTS ${db_name};
CREATE DATABASE ${db_name};
DROP USER IF EXISTS '${db_user}'@'%';
CREATE USER '${db_user}'@'%' IDENTIFIED by '${db_password}';
GRANT ALL PRIVILEGES on ${db_name}.* to '${db_user}'@'%';
FLUSH PRIVILEGES;

USE ${db_name};
CREATE TABLE users (user_id int(6),first_name varchar(15),last_name varchar(15), user varchar(15), password varchar(32),avatar varchar(70), last_login TIMESTAMP, failed_login INT(3), PRIMARY KEY (user_id));

INSERT INTO users VALUES
	('1','admin','admin','admin',MD5('password'),'/var/www/html/config/hackable/users/admin.jpg', NOW(), '0'),
	('2','Gordon','Brown','gordonb',MD5('abc123'),'/var/www/html/config/hackable/users/gordonb.jpg', NOW(), '0'),
	('3','Hack','Me','1337',MD5('charley'),'/var/www/html/config/hackable/users/1337.jpg', NOW(), '0'),
	('4','Pablo','Picasso','pablo',MD5('letmein'),'/var/www/html/config/hackable/users/pablo.jpg', NOW(), '0'),
	('5','Bob','Smith','smithy',MD5('password'),'/var/www/html/config/hackable/users/smithy.jpg', NOW(), '0');


CREATE TABLE guestbook (comment_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT, comment varchar(300), name varchar(100), PRIMARY KEY (comment_id));

INSERT INTO guestbook VALUES ('1','This is a test comment.','test');