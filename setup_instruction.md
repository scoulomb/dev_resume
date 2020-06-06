# JSON resume

## Why JSON resume

Think to use Hugo first but PDF generation was not possible
So go for JSON resume format
This can generate PDF and website in particular with: https://github.com/hacksalot/HackMyResume (or native JSON resume repo)

## Use json resume server from gist


For a quick preview
Convert to JSON https://www.json2yaml.com/
And https://gist.github.com/scoulomb/9cfbe163ff9b806727f7775a8737bbde
to have it here
https://registry.jsonresume.org/scoulomb

I use the elegant theme see meta field used by gist server.

Note we could deploy our own server doing this:


Next step is to generate HTML locally and do a PDF


## Use hackmyresume for PDF and local website generation

We could use also https://github.com/jsonresume/resumeToPDF/blob/master/README.md

### Convert yaml2json

python3 -c 'import yaml, json, sys; print(json.dumps(yaml.load(open(sys.argv[1])), indent=2))' resume.yaml > resume.json


### Setup PDF https://wkhtmltopdf.org/

sudo apt-get update
sudo apt-get install wkhtmltopdf

### Generate from JSON


git clone https://github.com/scoulomb/dev_resume.git
cd ~/dev_resume
hackmyresume build resume.json TO out/resume.all$

### Use a theme

#### Setup it
sudo npm install -g jsonresume-theme-macchiato # https://www.npmjs.com/package/jsonresume-theme-macchiato
It is setup here /usr/local/lib/node_modules/ cf. https://www.sitepoint.com/beginners-guide-node-package-manager/ 

#### Use it

hackmyresume build resume.json TO out/resume.all -t /usr/local/lib/node_modules/jsonresume-theme-macchiato/

=> very good pdf

#### Use a different theme

npm i jsonresume-theme-elegant

but it is not in lib file so I can not use hackmyresume

Actually we have to instal it gloablly as explained here: https://stackoverflow.com/questions/5926672/where-does-npm-install-packages and done before, so I need to qdd to the command given here:https://www.npmjs.com/package/jsonresume-theme-elegant


sudo npm i -g jsonresume-theme-elegant

Then 

hackmyresume build resume.json TO out/resume.html -t /usr/local/lib/node_modules/jsonresume-theme-elegant/

#### Icon support

This does not work well for image -> 
Actually need a server:https://github.com/mudassir0909/jsonresume-theme-elegant/issues/97
do python3 -m http.server 8000 in out location

and then localhost:8080

=> excellent html (issue for img in pdf and jpg does not generate)

All theme are in npm https://jsonresume.org/themes/

## Image issue 

See comment in yaml for picture field

## We can use theme directly

https://github.com/scoulomb/jsonresume-theme-elegant#contributing
(sudo -i, then exit for running first 2 lines)

## Next dockerize and deployment

HTML can keep guthub registry
For pdf output ok 
Then  can docker
One for generation and pod?
And deploy in OpenShift

