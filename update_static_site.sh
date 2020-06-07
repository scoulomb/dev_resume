cd ~/dev_resume
git clone https://github.com/scoulomb/scoulomb.github.io.git static_site
cp -R out/* static_site
cd static_site; git add --all; git ci -m "update static site"
git push
cd ..; rm -rf static_site
echo 'check results at https://scoulomb.github.io/ and https://scoulomb.github.io/resume.pdf'
