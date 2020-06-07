# README

See details in [setup instrutions](setup_instructions.md)

- Step 1: Update JSON resume in `/src/jsonresume` (and add/commit/push your changes or after step 3)

- Step 2: Generate output 

```
cd ~/dev_resume/src  ; sudo docker-compose up --build
```
If we want also elegant theme, which has some issue when dockerizing output generation. See setup of deps [setup instrutions](setup_instructions.md). Note this generates the index.

```
cd ~/dev_resume ; sudo hackmyresume build ./out/resume.json TO ./out/index.html -t /usr/local/lib/node_modules/jsonresume-theme-elegant/
```

- Step 3: Uplaod static site

```
./update_static_site.sh 
```


