# sudo ln -s `pwd`/validate-js.sh /usr/bin/validate-js.sh
curl -s -F js=@$1 http://jslint.webvm.net/ |
sed 's,^,'"$1:"','
