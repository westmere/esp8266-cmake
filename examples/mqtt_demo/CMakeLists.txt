set(CMAKE_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/../../cmake/ESP8266RTOS-1.5.0.cmake")

cmake_minimum_required(VERSION 3.5)

# cmake_policy(SET CMP0048 NEW)
project(mqtt-demo VERSION 0.9.0 LANGUAGES C CXX ASM)

file(WRITE "${CMAKE_BINARY_DIR}/user_config.h"
    "#ifndef __USER_CONFIG_H__\n"
    "#define __USER_CONFIG_H__\n"
    "#define SSID     \"minhha\"\n"
    "#define PASSWORD \"minhha06\"\n"
    "#endif\n"
)
add_library(mqtt-demo-user OBJECT ${PAHO_MQTT_SDK_SOURCES}
        ${ESP8266_SDK_BASE}/examples/mqtt_demo/user/MQTTEcho.c
        ${ESP8266_SDK_BASE}/examples/mqtt_demo/user/user_main.c
)
target_include_directories(mqtt-demo-user PRIVATE    "${CMAKE_BINARY_DIR}")
set_target_properties(mqtt-demo-user PROPERTIES COMPILE_FLAGS "-DMQTT_TASK")
esp8266_add_executable(${CMAKE_PROJECT_NAME} 
        $<TARGET_OBJECTS:mqtt-demo-user>
)
esp8266_add_firmware(firmware ${CMAKE_PROJECT_NAME})
