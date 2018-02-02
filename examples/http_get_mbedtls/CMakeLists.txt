set(CMAKE_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/../../cmake/ESP8266Toolchain.cmake")
set(ESP8266_SDK_VARIANT "OPENRTOS")
cmake_minimum_required(VERSION 3.5)

# cmake_policy(SET CMP0048 NEW)
project(http-get-mbedtls-demo VERSION 0.9.0 LANGUAGES C CXX ASM)

file(WRITE "${CMAKE_BINARY_DIR}/user_config.h"
    "#ifndef __USER_CONFIG_H__\n"
    "#define __USER_CONFIG_H__\n"
    "#define SSID     \"minhha\"\n"
    "#define PASSWORD \"minhha06\"\n"
    "#endif\n"
)
# add_library(http-get-mbedtls OBJECT ${PAHO_MQTT_SDK_SOURCES}
#         http_get_mbedtls.c
#         cert.c
# )
# target_include_directories(http-get-mbedtls PRIVATE    "${CMAKE_BINARY_DIR}")
# # set_target_properties(http-get-mbedtls PROPERTIES COMPILE_FLAGS "-DMQTT_TASK")
# esp8266_add_executable(${CMAKE_PROJECT_NAME} 
#         $<TARGET_OBJECTS:http-get-mbedtls>
# )
# esp8266_add_firmware(firmware ${CMAKE_PROJECT_NAME})
# esp8266_process_library(gcc)


find_library(LIB_ORG gcc ${ESP8266_SDK_BASE}/lib)
    
add_library(libgcc STATIC IMPORTED)
add_custom_command(TARGET libgcc
    PRE_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy ${LIB_ORG} ${CMAKE_BINARY_DIR})
# add_custom_target(libgcc_target DEPENDS lib_file)
# set_target_properties(${TARGET} PROPERTIES IMPORTED_LOCATION "${lib_file}")
set_property(TARGET libgcc PROPERTY IMPORTED_LOCATION ${lib_file})
add_dependencies(libgcc ${lib_file})
add_executable(${CMAKE_PROJECT_NAME} null.c)
target_link_libraries(${CMAKE_PROJECT_NAME} libgcc)
