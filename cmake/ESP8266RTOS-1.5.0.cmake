IF (_IS_TOOLCHAIN_PROCESSED)
    return()
endif ()
SET(_IS_TOOLCHAIN_PROCESSED True)

# IF (NOT DEFINED ESP8266_SDK_VARIANT OR ESP8266_SDK_VARIANT STREQUAL "")
#     SET(ESP8266_SDK_VARIANT "RTOS")
# endif()
# 
# IF (NOT DEFINED ESP8266_SDK_VERSION OR ESP8266_SDK_VERSION STREQUAL "")
#     SET(ESP8266_SDK_VERSION "1.5.0")
# endif()

set(CMAKE_SYSTEM_NAME "ESP8266-RTOS")
set(CMAKE_SYSTEM_VERSION "1.5.0")

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}")

include(ESP8266Toolchain)
