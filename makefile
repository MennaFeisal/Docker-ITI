#!/bin/bash

z=`pwd`

cd mysql/
docker build -t mennamohammed/mysql .

cd $z
cd wordpress/
docker build -t mennamohammed/downloader .

cd $z
cd phpfpm/
docker build -t mennamohammed/phpfpm .

cd $z
cd nginx/
docker build -t mennamohammed/nginx .

cd $z


docker run -d  --name mysql mennamohammed/mysql
docker run -i -t  --name downloader mennamohammed/downloader
docker run -d  --name app1 --volumes-from downloader --link mysql:db mennamohammed/phpfpm
docker run -d  --name app2 --volumes-from downloader --link mysql:db mennamohammed/phpfpm
docker run -d -p 8060:80 --name nginx --volumes-from downloader --link app1:app1 --link app2:app2 mennamohammed/nginx













