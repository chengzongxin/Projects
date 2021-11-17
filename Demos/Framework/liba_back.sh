# Sets the target folders and the final framework product.
# 如果工程名称和Framework的Target名称不一样的话，要自定义FMKNAME
# 例如: FMK_NAME = "MyFramework"
FMK_NAME=${PROJECT_NAME}

# Install dir will be the final output to the framework.
# The following line create it in the root folder of the current project.
#${SDK_NAME}
#SDK_VERSION=$(echo ${SDK_NAME} | grep -o '.{3}$')
#/${DYLIB_CURRENT_VERSION}
#/${CURRENT_PROJECT_VERSION}

#版本获取
echo "${PROJECT_DIR}/${INFOPLIST_FILE}"
buildNumber=$(/usr/libexec/PlistBuddy -c "Print :CFBundleVersion" "${PROJECT_DIR}/${INFOPLIST_FILE}")
buildNumber="$buildNumber"
echo "buildNumber = $buildNumber"

shortVersion=$(/usr/libexec/PlistBuddy -c "Print :CFBundleShortVersionString" "${PROJECT_DIR}/${INFOPLIST_FILE}")
shortVersion="$shortVersion"
echo "shortVersion = $shortVersion"

#自增build版本
buildVersion=$(echo ${buildNumber} | grep -o -E '\d{1,3}$')
buildVersion=$(($buildVersion + 1))
buildVersion=".$buildVersion"
echo "buildVersion = $buildVersion"

#设置build版本
newBuildNumber="$shortVersion$buildVersion"
echo "newBuildNumber = $newBuildNumber"
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $newBuildNumber" "${PROJECT_DIR}/${INFOPLIST_FILE}"

INSTALL_DIR=${SRCROOT}/Products/${buildNumber}/${FMK_NAME}.framework
# Working dir will be deleted after the framework creation.
WORK_DIR=build
DEVICE_DIR=${WORK_DIR}/Release-iphoneos/${FMK_NAME}.framework
SIMULATOR_DIR=${WORK_DIR}/Release-iphonesimulator/${FMK_NAME}.framework
# -configuration ${CONFIGURATION} "Release"
# Clean and Building both architectures.
xcodebuild -configuration "Release" -target "${FMK_NAME}" -sdk iphoneos clean build
xcodebuild -configuration "Release" -target "${FMK_NAME}" -sdk iphonesimulator clean build
# Cleaning the oldest.
if [ -d "${INSTALL_DIR}" ]
then
rm -rf "${INSTALL_DIR}"
fi
mkdir -p "${INSTALL_DIR}"
cp -R "${DEVICE_DIR}/" "${INSTALL_DIR}/"
cp -R "${SIMULATOR_DIR}/" "${INSTALL_DIR}/"
# Uses the Lipo Tool to merge both binary files (i386 + armv6/armv7) into one Universal final product.
lipo -create "${DEVICE_DIR}/${FMK_NAME}" "${SIMULATOR_DIR}/${FMK_NAME}" -output "${INSTALL_DIR}/${FMK_NAME}"
rm -r "${WORK_DIR}"
rm -rf "${INSTALL_DIR}/_CodeSignature"
rm -rf "${INSTALL_DIR}/Info.plist"

# open "${INSTALL_DIR}"
open "${SRCROOT}/Products"

