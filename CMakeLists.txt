cmake_minimum_required(VERSION 3.5)

# cmake_policy(SET CMP0048 NEW)
project(ArduinoBuild VERSION 0.9.0 LANGUAGES C CXX ASM)

# set(CMAKE_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/cmake/toolchain.ESP8266.cmake")


# esp8266_add_executable(${CMAKE_PROJECT_NAME}
#     ${CMAKE_CURRENT_LIST_DIR}/examples/project_template/user/user_main.c
# #     ${CMAKE_CURRENT_LIST_DIR}/examples/project_template/user/MQTTFreeRTOS.c
# )

file(GLOB PAHO_MQTT_SDK_SOURCES
    "${PAHO_MQTT_SDK}/MQTTPacket/src/*.c"
    "${PAHO_MQTT_SDK}/MQTTClient-C/src/*.c"
    ${CMAKE_CURRENT_LIST_DIR}/examples/project_template/user/MQTTFreeRTOS.c
)
set(PAHO_MQTT_SDK_INCLUDES  "${PAHO_MQTT_SDK}/MQTTPacket/src"
                            "${PAHO_MQTT_SDK}/MQTTClient-C/src"
)
add_library(paho-mqtt OBJECT ${PAHO_MQTT_SDK_SOURCES}
#                   dmsg.c
)
# get_property(dirs TARGET ESP8266_SDK PROPERTY INCLUDE_DIRECTORIES)
target_include_directories(paho-mqtt PRIVATE    "${PAHO_MQTT_SDK_INCLUDES}"
                                                "${CMAKE_CURRENT_LIST_DIR}/examples/project_template/user"
#                                                 "${dirs}"
)
set_target_properties(paho-mqtt PROPERTIES COMPILE_FLAGS "${CMAKE_C_FLAGS} -DMQTT_TASK -DMQTT_LWIP -include MQTTFreeRTOS.h")

# target_link_libraries(${CMAKE_PROJECT_NAME} paho-mqtt)
esp8266_add_executable(${CMAKE_PROJECT_NAME} 
                    ${CMAKE_CURRENT_LIST_DIR}/examples/project_template/user/user_main.c
                    ${CMAKE_CURRENT_LIST_DIR}/examples/project_template/user/pgmspace.cpp
                    $<TARGET_OBJECTS:paho-mqtt>
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
