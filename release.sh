# Script to release to NPM and publish tag

git remote rm origin
git remote add origin https://SwiftDevOps:${GH_TOKEN}@github.com/IBM-Swift/generator-swiftserver
VERSION=`node -e "console.log(require('./package.json').version);"`
echo "Creating release ${VERSION}" 
git tag $VERSION && git push origin $VERSION || true
# Merge back into develop and push those changes
git fetch origin && git checkout develop && git merge origin/master && git push origin develop
# npm publish 

# Deleting the old release branch
BRANCH_TO_DELETE=updateTo$VERSION
echo Deleting $BRANCH_TO_DELETE 
curl -u SwiftDevOps:${GH_TOKEN} -X DELETE -H "Accept: application/vnd.github.loki-preview+json" "https://api.github.com/repos/IBM-Swift/generator-swiftserver/branches/$BRANCH_TO_DELETE/protection"
git push origin :$BRANCH_TO_DELETE
