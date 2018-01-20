set(CMAKE_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/../../cmake/ESP8266Toolchain.cmake")

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
add_library(demo OBJECT ${PAHO_MQTT_SDK_SOURCES}
        ${ESP8266_SDK_BASE}/examples/mqtt_demo/user/MQTTEcho.c
        ${ESP8266_SDK_BASE}/examples/mqtt_demo/user/user_main.c
)
target_include_directories(demo PRIVATE    "${CMAKE_BINARY_DIR}")
set_target_properties(demo PROPERTIES COMPILE_FLAGS "-DMQTT_TASK")
esp8266_add_executable(${CMAKE_PROJECT_NAME} 
        $<TARGET_OBJECTS:demo>
)
esp8266_add_firmware(${CMAKE_PROJECT_NAME}_firmware ${CMAKE_PROJECT_NAME})

# 
# target_link_libraries(firmware
#     user_code
# )
# 
# set_target_properties(firmware PROPERTIES
#     LINKER_LANGUAGE C
# )
