# JSON resume

## Why JSON resume

Think to use Hugo first but PDF generation was not possible
So go for JSON resume format
This can generate PDF and website in particular using: https://github.com/hacksalot/HackMyResume 

JSON resume project has also native generator.

## Use json resume server from gist


For a quick preview
Convert resume.yaml file to JSON 
We can use https://www.json2yaml.com/
And copy it here (gist name should be resume.json) https://gist.github.com/scoulomb/9cfbe163ff9b806727f7775a8737bbde
to have it here: https://registry.jsonresume.org/scoulomb

I use the elegant theme see meta field used by gist server.

Note we could deploy our own server doing this:

Next step is to generate HTML locally and generate a PDF from YAML file.


## Use hackmyresume for PDF and local website generation

We could use native repo instead, for instance for PDF: https://github.com/jsonresume/resumeToPDF/blob/master/README.md

### Insstall hack my resume

```
sudo apt-get install npm
sudo npm install -g hackmyresume

```

### Convert yaml2json

```shell
python3 -c 'import yaml, json, sys; print(json.dumps(yaml.load(open(sys.argv[1])), indent=2))' resume.yaml > resume.json

```

### Setup PDF https://wkhtmltopdf.org/

```shell
sudo apt-get update
sudo apt-get install wkhtmltopdf
```

### Generate from JSON

```shell
git clone https://github.com/scoulomb/dev_resume.git
cd ~/dev_resume
hackmyresume build resume.json TO out/resume.all$
```

### Use a theme

#### Setup it

```shell
sudo npm install -g jsonresume-theme-macchiato # https://www.npmjs.com/package/jsonresume-theme-macchiato
```

It is setup here `/usr/local/lib/node_modules/` cf. https://www.sitepoint.com/beginners-guide-node-package-manager/ 

#### Use it

```
hackmyresume build resume.json TO out/resume.all -t /usr/local/lib/node_modules/jsonresume-theme-macchiato/
```

=> very good pdf

I will keep only the PDF

```
hackmyresume build resume.json TO out/resume.pdf -t /usr/local/lib/node_modules/jsonresume-theme-macchiato/
```

#### Use a different theme to generate elegant website locally

```
npm i jsonresume-theme-elegant
```

but it is not in lib file so I can not use hackmyresume

Actually we have to instal it gloablly as explained [here](https://stackoverflow.com/questions/5926672/where-does-npm-install-packages) and done before, so I need to add to the command given [in npm js](https://www.npmjs.com/package/jsonresume-theme-elegant) `-g` option.
 
```
sudo npm i -g jsonresume-theme-elegant
```

Then 

```
hackmyresume build resume.json TO out/resume.html -t /usr/local/lib/node_modules/jsonresume-theme-elegant/
```


#### Icon support

This does not work well for image -> 
Actually need a server:https://github.com/mudassir0909/jsonresume-theme-elegant/issues/97
do `python3 -m http.server 8080` in out location

and then `localhost:8080`

=> excellent html (issue for img in pdf and jpg does not generate)

All theme are in npm https://jsonresume.org/themes/

#### Image issue 

See comment in yaml for picture field

## We can use theme directly

https://github.com/scoulomb/jsonresume-theme-elegant#contributing
(sudo -i, then exit for running first 2 lines)

## Analyse

```
hackmyresume ANALYZE resume.json 
```

## Dockerize output generation

### Docker

For HTML generation we have an issue with elegant theme

```
npm WARN deprecated core-js@2.6.11: core-js@<3 is no longer maintained and not recommended for usage due to the number of issues. Please, upgrade your dependencies to the actual version of core-js@3.
npm WARN deprecated request@2.88.2: request has been deprecated, see https://github.com/request/request/issues/3142
/usr/local/bin/hackmyresume -> /usr/local/lib/node_modules/hackmyresume/dist/cli/index.js

> core-js@2.6.11 postinstall /usr/local/lib/node_modules/jsonresume-theme-elegant/node_modules/core-js
> node -e "try{require('./postinstall')}catch(e){}"

```

Old core JS version does not support multiple package setup based on core js?
But elegant tested in its own docker does not work

Fix is there: https://github.com/zloirock/core-js/issues/781
Actually  I can not update the JSON core dependency and it is too old...

So I will generate JSON and PDF, HTML macchiato with docker
And generate elegant HTML manually (but it implies locall setup). Note this generates the index.

```
sudo docker-compose --file ./src/docker-compose.yaml up  --build
cd ~/dev_resume ; sudo hackmyresume build ./out/resume.json TO ./out/index.html -t /usr/local/lib/node_modules/jsonresume-theme-elegant/
```

<!-- 
Initially was doing 
cd ~/dev_resume/src  ; sudo docker-compose up --build
but was forced to use file below
-->

Note I did not use copy but volume mapping to have a generator image always valid.

######### EXPLO TAG

[here can deep dive but ok] 

### Push it to docker hub and remote docker compose yaml

It is not but would enable to ensure we always have the generator available.

## Deploy 

### Deploy in Kubernetes/Openshift online nginx

and domain name scoulom.dev (google domain)

- Solution 1: Generate new image each time we have new ouput and deploy it with travis in OpenShift
- Solution 2: Keep same image running and have side car container pulling last output from git in an emptyDir

For instance solution 2 deployed with compose:
```
sudo docker-compose --file ./src/docker-compose_nginx.yaml up  --build
```

Go to a browser and target 8080

Found correct path by doing: `k run tutu --image=nginx;  k exec -it tutu -- /bin/sh`

Then we could deploy in minikube locally with emptydir or hostpath

I will not go further because I discovered github page.

### Use githubpages

With  github page, having a repo named scoulomb.github.io
Can host a static website.

Thus

```
./update_static_site.sh # chmod ux if needed
```


Note:
- to delete out need sudo because of docker
- I use yaml for edtition beacuse better than JSON, hackmyresume generates yaml but can not take json as input
