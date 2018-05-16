#!/bin/bash

cd $TMPDIR
mkdir -p $TMPDIR/.removegemnasium
cd $TMPDIR/.removegemnasium
for i in purl stacks sul-embed purl-fetcher content_search course_reserves discovery-dispatcher earthworks exhibits library_hours_rails sul-bento-app sul-directory sul-requests sw-indexer SearchWorks revs dlme arclight-demo vatican_exhibits revs-indexer-service bassi_veratti editstore-updater portfolios mods_display_app mirador_sul; do
  echo $i
  cd $TMPDIR/.removegemnasium
  git clone git@github.com:sul-dlss/$i
  cd $i
  git fetch origin
  git checkout -B remove-gemnasium
  git reset --hard  origin/master

  if grep "gemnasium\.com" README.md > /dev/null
  then
    echo 😢

    # remove line from README; probably overzealous
    # sed -i '' '/gemnasium\.com/d' README.md

    # Better: find and replace string
    sed -i.bak 's/\[!\[Dependency Status](.*)//' README.md

    git add README.md &&
    git commit -m "Remove gemnasium badge" &&
    git push origin remove-gemnasium &&
    hub pull-request -f -m "Remove gemnasium badge"
  else
    echo 👍
  fi
done
