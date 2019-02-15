#!/usr/bin/env bash
cabal new-build
rm -rf test-db
ghc-pkg init test-db
ghc-pkg --package-db=test-db register dist-newstyle/packagedb/ghc-8.6.3/sample-1.0.0-inplace.conf
for i in $(seq 1 500); do
   cp test-db/sample-1.0.0-inplace.conf "test-db/sample-1.0.0-$i.conf";
   sed -E 's/(id: sample-1.0.0)-inplace/\1-x'"$i"'/' -i "test-db/sample-1.0.0-$i.conf";
done
ghc-pkg --package-db=test-db recache
echo "Unregistering single package:"
time ghc-pkg --package-db=test-db unregister --ipid sample-1.0.0-x1
echo "Unregistering 15 packages:"
time ghc-pkg --package-db=test-db unregister --ipid sample-1.0.0-x2 --ipid sample-1.0.0-x3 --ipid sample-1.0.0-x4 --ipid sample-1.0.0-x5 --ipid sample-1.0.0-x6 --ipid sample-1.0.0-x7 --ipid sample-1.0.0-x8 --ipid sample-1.0.0-x9 --ipid sample-1.0.0-x10 --ipid sample-1.0.0-x11 --ipid sample-1.0.0-x12 --ipid sample-1.0.0-x13 --ipid sample-1.0.0-x14 --ipid sample-1.0.0-x15 --ipid sample-1.0.0-x16
