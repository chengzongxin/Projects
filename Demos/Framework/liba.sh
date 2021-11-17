# Sets the target folders and the final framework product.
FRAMEWORK_NAME=${PROJECT_NAME}
FRAMEWORK_VERSION=1.0
FRAMEWORK_CONFIG=Release

# Install dir will be the final output to the framework.
# The following line create it in the root folder of the current project.
INSTALL_PATH=${PROJECT_DIR}/Products/
INSTALL_DIR=${INSTALL_PATH}/${FRAMEWORK_NAME}.framework

# Working dir will be deleted after the framework creation.
WORK_DIR=build
DEVICE_DIR=${WORK_DIR}/${FRAMEWORK_CONFIG}-iphoneos/${FRAMEWORK_NAME}.framework
SIMULATOR_DIR=${WORK_DIR}/${FRAMEWORK_CONFIG}-iphonesimulator/${FRAMEWORK_NAME}.framework

xcodebuild -configuration "${FRAMEWORK_CONFIG}" -target "${FRAMEWORK_NAME}" -sdk iphoneos

echo "Build simulator"
xcodebuild -configuration "${FRAMEWORK_CONFIG}" -target "${FRAMEWORK_NAME}" -sdk iphonesimulator

# Creates install directory if it not exits.
if [ ! -d "${INSTALL_DIR}" ]
then
mkdir -p "${INSTALL_DIR}"
fi

# Creates headers directory if it not exits.
if [ ! -d "${INSTALL_DIR}/Headers" ]
then
mkdir -p "${INSTALL_DIR}/Headers"
fi

# Remove all files in the headers diectory.
for file in `ls "${INSTALL_DIR}/Headers"`
do
rm "${INSTALL_DIR}/Headers/${file}"
done

# Remove binary library file.
rm -f ${INSTALL_DIR}/${FRAMEWORK_NAME}

# Copies the headers files to the final product folder.
if [ -d "${DEVICE_DIR}/Headers" ]
then
for file in `ls "${DEVICE_DIR}/Headers"`
do
cp "${DEVICE_DIR}/Headers/${file}" "${INSTALL_DIR}/Headers/${file}"
done
fi

# copy nibs to bundle,then copy bundle to final folder
BUNDLE_DIR=${DEVICE_DIR}/${FRAMEWORK_NAME}.bundle

if [ -d "${BUNDLE_DIR}" ];then
if ls ${DEVICE_DIR}/*.nib >/dev/null 2>&1;then
rm -rf ${BUNDLE_DIR}/*.nib
cp -rf ${DEVICE_DIR}/*.nib ${BUNDLE_DIR}
fi
rm -rf "${INSTALL_DIR}/${FRAMEWORK_NAME}.bundle"
cp -R "${BUNDLE_DIR}" "${INSTALL_DIR}/${FRAMEWORK_NAME}.bundle"
fi

echo "Merge with simulator"
# Uses the Lipo Tool to merge both binary files (i386 + armv6/armv7) into one Universal final product.
lipo -create "${DEVICE_DIR}/${FRAMEWORK_NAME}" "${SIMULATOR_DIR}/${FRAMEWORK_NAME}" -output "${INSTALL_DIR}/${FRAMEWORK_NAME}"

open "${INSTALL_PATH}"

# rm -r "${WORK_DIR}"