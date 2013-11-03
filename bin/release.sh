#!/bin/sh
cd `dirname "$0"`/..
echo rm -rf *
echo git checkout master
echo -n "Which version are you going to publish [0 to skip]? "
VER=`head -n 1`
if [ "$VER" = "0" ]; then :; else
	echo "Publishing version $VER"
	bin/setversion.sh "$VER"
	cp package.json package.json.bak
	sed -e 's@/amber.git.*"@/amber.git#'"$VER"'"@' package.json.bak >package.json
	rm package.json.bak
	echo git commit -a -m "Release version $VER"
	echo git tag -a "$VER"
#	echo bower upload
# bower does not publish explicitly but implictly via semver tag
	echo npm publish
fi
echo -n "Which version are you going to work on? "
VERF=`head -n 1`
VER="${VERF}-pre"
echo "Setting version $VER"
bin/setversion.sh "$VER"
cp package.json package.json.bak
sed -e 's@/amber.git.*"@/amber.git"@' package.json.bak >package.json
rm package.json.bak
echo git commit -a -m "Working on $VERF"
echo git push --tags
