sudo docker-compose --file ./src/docker-compose.yaml up  --build
sudo hackmyresume build ./out/resume.json TO ./out/index.html -t /usr/local/lib/node_modules/jsonresume-theme-elegant/
# exit sudo to use regular gitconfig (username)
./update_static_site.sh 
