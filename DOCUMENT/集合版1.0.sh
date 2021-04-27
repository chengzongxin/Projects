echo "--------- 开始打包 ----------"

# 类型
BUILD_TYPE="Development"
#项目路径
Jobname=${WORKSPACE}/
#项目名称
AppName="T8TMarket"
IpaName="T8TMarket"
#IPA存放路径
IPAPATH=~/Documents/Jenkins/OutputIPA/
#ipa的外部统一存放文件夹
DeployName="${AppName}Deploy"
# ExportOptions.plist 路径
EXPORTOPTIONSPLIST=${Jobname}${AppName}/BuildPlist/ExportOptions.plist
# info.plist路径
project_infoplist_path=${Jobname}${AppName}/Info.plist


#取版本号
bundleShortVersion=$(xcodebuild -showBuildSettings | grep MARKETING_VERSION | tr -d 'MARKETING_VERSION =')

#取build值
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

archiveName="${AppName}.xcarchive"

#测试包只保留当前构建数据
archivePath=${IPAPATH}${DeployName}/${bundleShortVersion}/${BUILD_TYPE}/archive/${AppName}-${bundleVersion}-${DATE}/${archiveName}

echo "--------- 开始构建archive打包 ----------"

xcodebuild archive -workspace ${Jobname}${AppName}.xcworkspace -scheme ${AppName} -archivePath ${archivePath} -configuration $BuildType

echo "---------------archive succeed-------------------------"

#ipa包导出路径
EXPORTPATH=${IPAPATH}${DeployName}/${bundleShortVersion}/${BUILD_TYPE}/${AppName}-${DATE}

if [ ! -d "${EXPORTPATH}" ];then
mkdir -p ${EXPORTPATH}
fi

xcodebuild -exportArchive -archivePath ${archivePath} -exportOptionsPlist ${EXPORTOPTIONSPLIST} -allowProvisioningUpdates -exportPath ${EXPORTPATH}


#要上传的ipa文件路径
IPA_PATH=${EXPORTPATH}/${IpaName}.ipa


if [ ! -d "./${BUILD_TYPE}/" ];then
	mkdir -p ./${BUILD_TYPE}
else 
	if [ $BUILD_TYPE = 'Ad-Hoc' ] ; then 
		#删除测试模式下缓存的IPA
		rm -f ./${BUILD_TYPE}/*
	fi
fi

#最新ipa包路径，用于重新上传（只上传最新包）
LastestIPA_Path=${IPAPATH}${DeployName}/lastest.ipa

cp ${IPA_PATH} ${LastestIPA_Path}




if [ $UploadType = "Pgyer" ];then
	#执行上传至蒲公英的命令
	echo "------------上传到蒲公英--------------"
	#执行上传至蒲公英的命令
	echo "++++++++++++++upload+++++++++++++"
	#蒲公英上的User Key
	uKey="89c4bf450d006edec01f84b6b7ae5447"
	#蒲公英上的API Key
	apiKey="26708a972207e63d4a007f65527876cc"
	#蒲公英上传
	MSG=`git log -1 --pretty=%B`
	
	curl -F "file=@${IPA_PATH}" -F "uKey=${uKey}" -F "_api_key=${apiKey}" -F "updateDescription=【${BuildType}】【${GIT_BRANCH}】 commit msg:${MSG} BuildNum：${BUILD_NUMBER},GIT-SHA:${GIT_COMMIT}" http://www.pgyer.com/apiv1/app/upload
	
elif [ $UploadType = "Fir" ];then
	echo "------------上传到 Fir--------------"
	fir login -T "359d00877e68106a286789a3023e6abf"
	fir publish ${IPA_PATH}
	
fi

