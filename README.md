# README

See details in [setup instructions](setup_instructions.md)

- Step 1: Update JSON resume in `/src/jsonresume` (and add/commit/push your changes or later, also we could run step 2 for preview before commit )

- Step 2: Generate JSON output, and macchiato PDF, HTML and in a second time elegant HTML (previous JSON needed)

```
sudo docker-compose --file ./src/docker-compose.yaml up  --build
```
If we want also elegant theme (elegant HTML is amazing), which has some issue when dockerizing output generation. See setup of deps in [setup instructions](setup_instructions.md) (or apply Dockerfile content and changing theme to `jsonresume-theme-elegant`). Note this generates the html index in current setup. 

```
sudo hackmyresume build ./out/resume.json TO ./out/index.html -t /usr/local/lib/node_modules/jsonresume-theme-elegant/
```

For preview with icon display do `python3 -m http.server 8080` in out location

If Elegant theme is used it reduces benefits ofdockerization :(

We gather this command in 

```
./generate.sh # (`chmod u+x ./generate.sh` if needed)
```

- Step 3: Upload static site

```
./update_static_site.sh # (`chmod u+x ./update_static_site.sh` if needed)
```

Step 2 and 3 can be replaced by `./generate_and_deploy.sh` (`chmod u+x ./generate_and_deploy.sh` if needed)

- Step 4: Check results at  https://scoulomb.github.io/ and https://scoulomb.github.io/resume.pdf. (`ctrl+F5` to refresh)

<!--

### Status

- OK proc valide 
- we could do optional exploration proposed in [setup instrutions](setup_instructions.md#EXPLO_TAG) => dockerhub
- automate readme -> DONE and related to readme so only there
- link OK (yaml, output pdf and web and gravatar)
- open browser => NO
- 19jul ok; may need to clean github.io with the time as long update or do amend?
- full ci/cd blocked by elegant theme
### TODO

- ALign LI?

UPDATE OK
-->
