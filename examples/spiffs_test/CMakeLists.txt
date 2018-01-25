set(CMAKE_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/../../cmake/ESP8266Toolchain.cmake")

cmake_minimum_required(VERSION 3.5)

# cmake_policy(SET CMP0048 NEW)
project(esp8266-spiffs_test VERSION 0.1.0 LANGUAGES C CXX ASM)

file(WRITE "${CMAKE_BINARY_DIR}/user_config.h"
    "#ifndef __USER_CONFIG_H__\n"
    "#define __USER_CONFIG_H__\n"
    "#define SSID     \"minhha\"\n"
    "#define PASSWORD \"minhha06\"\n"
    "#endif\n"
)
file(GLOB SOURCES ${ESP8266_SDK_BASE}/examples/spiffs_test/user/*.c)
            
add_library(demo OBJECT ${SOURCES})
target_include_directories(demo PRIVATE
                                "${ESP8266_SDK_BASE}/examples/spiffs_test/include"
                                "${CMAKE_BINARY_DIR}"
)
# set_target_properties(demo PROPERTIES COMPILE_FLAGS "-DMQTT_TASK")
esp8266_add_executable(${CMAKE_PROJECT_NAME} 
        $<TARGET_OBJECTS:demo>
)
esp8266_add_firmware(firmware ${CMAKE_PROJECT_NAME})
