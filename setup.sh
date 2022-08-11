#!/bin/bash
export IP_Address=$(Ipconfig getifaddr en0)
Connected_Device=$(xcrun xctrace list devices | grep -v 'Simulator' | grep -oE '.*iP.*?[^\(]+' | head -1 | xargs | awk '{$1=$1;print}')
echo "Setting proxy for ${Connected_Device} to ${IP_Address}"
xcodebuild test-without-building -only-testing:ProxyChangerUITests/ProxyChangerUITests/testChangeProxy -project ProxyChanger.xcodeproj -scheme "ProxyChanger" -destination "platform=iOS,name=${Connected_Device}" -derivedDataPath "./DerivedData"

if [ $? != 0 ]
then
    # Perhaps it's never build before，let's try a new build
    xcodebuild build-for-testing -project ProxyChanger.xcodeproj -scheme "ProxyChanger" -destination "platform=iOS,name=${Connected_Device}" -derivedDataPath "./DerivedData"
    xcodebuild test-without-building -only-testing:ProxyChangerUITests/ProxyChangerUITests/testChangeProxy -project ProxyChanger.xcodeproj -scheme "ProxyChanger" -destination "platform=iOS,name=${Connected_Device}" -derivedDataPath "./DerivedData"
fi
