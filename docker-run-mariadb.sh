#spin a mariadb 
docker run -d \
  --name mariadb \
  -e MYSQL_ROOT_PASSWORD=gold \
  -e MYSQL_DATABASE=dungeon \
  -e MYSQL_USER=goblin \
  -e MYSQL_PASSWORD=treasure \
  -v mariadb_data:/var/lib/mysql \
  -p 3306:3306 \
  mariadb:11
