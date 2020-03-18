#!/bin/sh

# cacheRepo
FrameWork="ZLPhotoBrowser"
Version="2.7.7"
CacheSpecsFile=${Version:0:3}.podspec.json
CacheSpecs=~/Library/Caches/CocoaPods/Pods/Specs/Release/$FrameWork

echo "CacheSpecs is $CacheSpecs"
echo "CacheSpecsFile is $CacheSpecsFile"

open $CacheSpecs
mkdir ~/Desktop/temp
cd ~/Desktop/temp
# find
find  ~/.cocoapods/repos/master/Specs/*/*/*/$FrameWork/$Version/* -exec cp {} ~/Desktop/temp \;
# rename
echo "rename "
mv *.json $CacheSpecsFile
cp *.json $CacheSpecs
