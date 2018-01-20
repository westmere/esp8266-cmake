# esp8266-cmake
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \\
-DESP8266_SDK_VARIANT="RTOS"    \\
-DESP8266_SDK_VERSION="2.0.0"   \\
-DESPTOOL=esptool.py  \\
-DESP8266_SDK_BASE=ESP8266_RTOS_SDK \\
-DCMAKE_BUILD_TYPE=Release \\
-G "Eclipse CDT4 - Unix Makefiles" \\
-DCMAKE_ECLIPSE_VERSION=4.6 \\
esp8266-cmake/examples/mqtt_demo
