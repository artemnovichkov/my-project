PROJECT_ROOT_FOLDER="$(dirname $SRCROOT)"
UNIVERSAL_OUTPUTFOLDER=${BUILD_DIR}/${CONFIGURATION}-universal
FRAMEWORK_NAME="MyFramework"

# Step 1. Build static frameworks

# Make env variable with static linking
xcconfig=$(mktemp /tmp/static.xcconfig.XXXXXX)
trap 'rm -f "$xcconfig"' INT TERM HUP EXIT

echo "MACH_O_TYPE = staticlib" >> $xcconfig

export XCODE_XCCONFIG_FILE="$xcconfig"

# Make sure the output directory exists
mkdir -p "${UNIVERSAL_OUTPUTFOLDER}"

# Next, work out if we're in SIMULATOR or DEVICE
xcodebuild -project "${PROJECT_NAME}.xcodeproj" -target "${FRAMEWORK_NAME}" -configuration ${CONFIGURATION} -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" clean build
xcodebuild -project "${PROJECT_NAME}.xcodeproj" -target "${FRAMEWORK_NAME}" -configuration ${CONFIGURATION} -sdk iphoneos ONLY_ACTIVE_ARCH=NO BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" clean build

# Step 2. Copy the framework structure (from iphoneos build) to the universal folder
cp -R "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${FRAMEWORK_NAME}.framework" "${UNIVERSAL_OUTPUTFOLDER}/"

# Step 3. Copy Swift modules from iphonesimulator build (if it exists) to the copied framework directory
cp -R "${SYMROOT}/Debug-iphonesimulator/${FRAMEWORK_NAME}.framework/Modules/${FRAMEWORK_NAME}.swiftmodule/." "${UNIVERSAL_OUTPUTFOLDER}/${FRAMEWORK_NAME}.framework/Modules/${FRAMEWORK_NAME}.swiftmodule"

# Step 4. Create universal binary file using lipo and place the combined executable in the copied framework directory
lipo -create -output "${UNIVERSAL_OUTPUTFOLDER}/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}" "${SYMROOT}/Debug-iphonesimulator/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${FRAMEWORK_NAME}.framework/${FRAMEWORK_NAME}"

# Step 5. Convenience step to copy the framework to the main project's directory
cp -a "${UNIVERSAL_OUTPUTFOLDER}/${FRAMEWORK_NAME}.framework" "${PROJECT_ROOT_FOLDER}/MyProject/MyProject/Frameworks"
