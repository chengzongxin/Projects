#项目路径
Jobname=${WORKSPACE}/
#项目名称
AppName="HouseKeeper"
#IPA存放路径
IPAPATH=~/Documents/Jenkins/OutputIPA/
#ipa的外部统一存放文件夹
DeployName="${AppName}Deploy"

if [ $BUILD_TYPE = 'Ad-Hoc' ] ; then 
echo "------------Ad-Hoc 包--------------"
EXPORTOPTIONSPLIST=${Jobname}${AppName}/BuildPlist/ExportOptions_Ad-hoc_M.plist
else 
echo "------------Development 包--------------"
EXPORTOPTIONSPLIST=${Jobname}${AppName}/BuildPlist/ExportOptions_Development_M.plist
fi

# info.plist路径
project_infoplist_path=${Jobname}${AppName}/${AppName}-Info.plist

echo ${project_infoplist_path}
#取版本号
#bundleShortVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleShortVersionString" ${project_infoplist_path})

bundleShortVersion=$(xcodebuild -showBuildSettings | grep MARKETING_VERSION | tr -d 'MARKETING_VERSION =')

#取build值
#bundleVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleVersion" "${project_infoplist_path}")

bundleVersion=$(xcodebuild -showBuildSettings | grep CURRENT_PROJECT_VERSION | tr -d 'CURRENT_PROJECT_VERSION =')
#日期（到哪一天）
DATE_DAY="$(date +%Y%m%d)"
#日期（到秒）
DATE="$(date +%Y%m%d)-$(date +%H%M%S)"

echo ${bundleShortVersion}
echo ${bundleVersion}
echo ${DATE}
echo ${DATE_DAY}

#新构建方式
xcodebuild clean -workspace ${Jobname}${AppName}.xcworkspace -scheme ${AppName} -configuration Release
xcodebuild clean -workspace ${Jobname}${AppName}.xcworkspace -scheme ${AppName} -configuration Debug
#清除缓存文件
#rm -rf /Users/kevin/Library/Developer/Xcode/DerivedData/HouseKeeper*

#测试包只保留当前构建数据
archiveName="${AppName}.xcarchive"

archivePath=archive/${BUILD_TYPE}/${archiveName}

xcodebuild archive -workspace ${Jobname}${AppName}.xcworkspace -scheme ${AppName} -archivePath ${archivePath} -configuration $XCODE_BUILD_CONFIG_ENV

#ipa包导出路径
EXPORTPATH=${IPAPATH}${DeployName}/${bundleShortVersion}/${BUILD_TYPE}/${AppName}-${DATE}

if [ ! -d "${EXPORTPATH}" ];then
mkdir -p ${EXPORTPATH}
fi

xcodebuild -exportArchive -archivePath ${archivePath} -exportOptionsPlist ${EXPORTOPTIONSPLIST} -allowProvisioningUpdates -exportPath ${EXPORTPATH}


#要上传的ipa文件路径
IPA_PATH=${EXPORTPATH}/${AppName}.ipa

#执行上传至蒲公英的命令
echo "++++++++++++++upload+++++++++++++"
#蒲公英上的User Key
uKey="89c4bf450d006edec01f84b6b7ae5447"
#蒲公英上的API Key
apiKey="26708a972207e63d4a007f65527876cc"
#蒲公英上传
MSG=`git log -1 --pretty=%B`
curl -F "file=@${IPA_PATH}" -F "_api_key=${apiKey}" -F "buildInstallType=2" -F "buildPassword=to8to" -F "buildUpdateDescription=【${XCODE_BUILD_CONFIG_ENV}】【${GIT_BRANCH}】Last Commit:${MSG} BUILDNUM：${BUILD_NUMBER},GIT-SHA:${GIT_COMMIT}" https://www.pgyer.com/apiv2/app/upload



