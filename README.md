# README

See details in [setup instructions](setup_instructions.md)

- Step 1: Update JSON resume in `/src/jsonresume` (and add/commit/push your changes or later, also in step 2 can do test before commit )

- Step 2: Generate JSON output, and macchiato PDF, HTML and in a second time elegant HTML (previous JSON needed)

```
cd ~/dev_resume/src  ; sudo docker-compose up --build
```
If we want also elegant theme (elegant HTML is amazing), which has some issue when dockerizing output generation. See setup of deps in [setup instructions](setup_instructions.md) (or apply Dockerfile content and changing theme to `jsonresume-theme-elegant`). Note this generates the html index. 

```
cd ~/dev_resume ; sudo hackmyresume build ./out/resume.json TO ./out/index.html -t /usr/local/lib/node_modules/jsonresume-theme-elegant/
```

For preview with icon use do `python3 -m http.server 8080` in out location

- Step 3: Upload static site

```
./update_static_site.sh 
```

- Step 4: Check results at  https://scoulomb.github.io/ and https://scoulomb.github.io/resume.pdf.


### Status

- OK proc valide 
- we could do optional exploration proposed in [setup instrutions](setup_instructions.md#EXPLO_TAG)

### TODO

- ALign LI?
