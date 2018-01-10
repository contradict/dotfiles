ANDROID_VER=22.0.1
if [ -d /opt/android/android-studio ]; then
    export PATH=/opt/android/android-studio/bin:${PATH}
fi
if [ -d ${HOME}/Android ]; then
    export PATH=${HOME}/Android/Sdk/platform-tools/:${PATH}
    export PATH=${HOME}/Android/Sdk/tools/:${PATH}
    export PATH=${HOME}/Android/Sdk/build-tools/${ANDROID_VER}/:${PATH}
fi
