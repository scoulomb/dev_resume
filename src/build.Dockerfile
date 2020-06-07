FROM ubuntu:20.04

RUN apt-get update

# https://askubuntu.com/questions/909277/avoiding-user-interaction-with-tzdata-when-installing-certbot-in-a-docker-contai
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get install npm -y
RUN apt-get install wkhtmltopdf -y

RUN npm install -g hackmyresume jsonresume-theme-macchiato 

RUN apt install python3-pip -y
RUN python3 -m pip install PyYaml

WORKDIR /WORKDIR


CMD ls && \
    python3 --version && \
    python3 -c 'import yaml, json, sys; print(json.dumps(yaml.load(open(sys.argv[1])), indent=2))' ./jsonresume/resume.yaml > /out/resume.json && \
    hackmyresume build /out/resume.json TO /out/resume.pdf /out/resume.html -t /usr/local/lib/node_modules/jsonresume-theme-macchiato/

