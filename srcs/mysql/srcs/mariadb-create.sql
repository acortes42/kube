FLUSH PRIVILEGES;
CREATE DATABASE wordpress;
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION;
FLUSH PRIVILEGES;