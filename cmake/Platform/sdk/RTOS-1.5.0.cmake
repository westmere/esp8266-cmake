# if(CMAKE_HOST_SYSTEM_NAME MATCHES "Linux")
#     set(ESP8266_SDK_BASE ${USER_HOME}/git/ESP8266_RTOS_SDK CACHE PATH "Path to the ESP8266 SDK")
# elseif(CMAKE_HOST_SYSTEM_NAME MATCHES "Windows")
#     set(ESP8266_SDK_BASE ${USER_HOME}/dev/projects/ESP8266_RTOS_SDK CACHE PATH "Path to the ESP8266 SDK")
# else()
#     message(FATAL_ERROR "Unsupported build platforom.")
# endif()

if(NOT PYTHON)
    set(PYTHON python)
endif()
if(NOT ESPTOOL)
    set(ESPTOOL esptool.py)
endif()
if(NOT APP)
    set(APP 1)
endif()
if(NOT SPI_SIZE_MAP)
    set(SPI_SIZE_MAP 6)
endif()
if(NOT SPI_MODE)
    set(SPI_MODE 0)
endif()
if(NOT SPI_FREQDIV)
    set(SPI_FREQDIV 0)
endif()
set(ESP_APP1_ADDR 0)
set(ESP_APP2_ADDR 0)
set(ADDR 0x01000)
set(ESP_RF_CAL_DEFAULT_ADDR 0x7C000)
set(ESP_RF_CAL_ADDR 0x7B000)
set(ESP_SYS_PARAM_ADDR 0x7E000)
if(${APP} STREQUAL 0)
    set(BOOT_MODE 0)
else()
    set(BOOT_MODE 2)
endif()
if(NOT ESP_LD)
    set(ESP_LD ${ESP8266_SDK_BASE}/ld)
endif()
set(LD_FILE "eagle.app.v6.ld")

if(NOT ${BOOT_MODE} STREQUAL 0)
    if(${SPI_SIZE_MAP} STREQUAL 0)
        set(LD_FILE "eagle.app.v6.new.512.app1.ld")
        set(flash 512)
        MESSAGE(STATUS "SPI flash map:    0= 512KB( 256KB+ 256KB)")
        set(ESP_APP2_ADDR 0x41000)
        set(ESP_RF_CAL_ADDR 0x7B000)
        set(ESP_RF_CAL_DEFAULT_ADDR 0x7C000)
        set(ESP_SYS_PARAM_ADDR 0x7E000)
    elseif(${SPI_SIZE_MAP} STREQUAL 1)
        set(flash 256)
        set(ADDR 0x01000)
    elseif(${SPI_SIZE_MAP} STREQUAL 2)
        MESSAGE(STATUS "SPI flash map:    2=1024KB( 512KB+ 512KB)")
        set(LD_FILE "eagle.app.v6.new.1024.${APP}.ld")
        set(flash 1024)
        set(ESP_APP2_ADDR 0x81000)
        set(ESP_RF_CAL_ADDR 0xFB000)
        set(ESP_RF_CAL_DEFAULT_ADDR 0xFC000)
        set(ESP_SYS_PARAM_ADDR 0xFE000)
    elseif(${SPI_SIZE_MAP} STREQUAL 3)
        MESSAGE(STATUS "SPI flash map:    3=2048KB( 512KB+ 512KB)")
        set(LD_FILE "eagle.app.v6.new.1024.${APP}.ld")
        set(flash 2048)
        set(ESP_APP2_ADDR 0x81000)
        set(ESP_RF_CAL_ADDR 0x1FB000)
        set(ESP_RF_CAL_DEFAULT_ADDR 0x1FC000)
        set(ESP_SYS_PARAM_ADDR 0x1FE000)
    elseif(${SPI_SIZE_MAP} STREQUAL 4)
        MESSAGE(STATUS "SPI flash map:    4=4096KB( 512KB+ 512KB)")
        set(LD_FILE "eagle.app.v6.new.1024.${APP}.ld")
        set(flash 4096)
        set(ESP_APP2_ADDR 0x81000)
        set(ESP_RF_CAL_ADDR 0x3FB000)
        set(ESP_RF_CAL_DEFAULT_ADDR 0x3FC000)
        set(ESP_SYS_PARAM_ADDR 0x3FE000)
    elseif(${SPI_SIZE_MAP} STREQUAL 5)
        MESSAGE(STATUS "SPI flash map:    5=2048KB(1024KB+1024KB)")
        set(LD_FILE "eagle.app.v6.new.2048.ld")
        set(flash 2048)
        set(ESP_APP2_ADDR 0x101000)
        set(ESP_RF_CAL_ADDR 0x1FB000)
        set(ESP_RF_CAL_DEFAULT_ADDR 0x1FC000)
        set(ESP_SYS_PARAM_ADDR 0x1FE000)
    elseif(${SPI_SIZE_MAP} STREQUAL 6)
        MESSAGE(STATUS "SPI flash map:    6=4096KB(1024KB+1024KB)")
        set(LD_FILE "eagle.app.v6.new.2048.ld")
        set(flash 4096)
        set(ESP_APP2_ADDR 0x101000)
        set(ESP_RF_CAL_ADDR 0x3FB000)
        set(ESP_RF_CAL_DEFAULT_ADDR 0x3FC000)
        set(ESP_SYS_PARAM_ADDR 0x3FE000)
    elseif(${SPI_SIZE_MAP} STREQUAL 7)
        MESSAGE(STATUS "SPI flash map:    7=4096KB(2048KB+2048KB) not support ,just for compatible with nodeMCU board")
    elseif(${SPI_SIZE_MAP} STREQUAL 8)
        MESSAGE(STATUS "SPI flash map:    8=8192KB(1024KB+1024KB)")
        set(LD_FILE "eagle.app.v6.new.2048.ld")
        set(flash 8192)
        set(ESP_APP2_ADDR 0x101000)
        set(ESP_RF_CAL_ADDR 0x7FB000)
        set(ESP_RF_CAL_DEFAULT_ADDR 0x7FC000)
        set(ESP_SYS_PARAM_ADDR 0x7FE000)
    elseif(${SPI_SIZE_MAP} STREQUAL 9)
        MESSAGE(STATUS "SPI flash map:    9=16384KB(1024KB+1024KB)")
        set(LD_FILE "eagle.app.v6.new.2048.ld")
        set(flash 16384)
        set(ESP_APP2_ADDR 0x101000)
        set(ESP_RF_CAL_ADDR 0xFFB000)
        set(ESP_RF_CAL_DEFAULT_ADDR 0xFFC000)
        set(ESP_SYS_PARAM_ADDR 0xFFE000)
    endif()
    
    set(ESP_APP1_ADDR 0x01000)
    if(${APP} STREQUAL 1)
        set(ADDR ${ESP_APP1_ADDR})
    else()
        set(ADDR ${ESP_APP2_ADDR})
    endif()
    set(BOOT_NAME "${ESP8266_SDK_BASE}/bin/boot_v1.7.bin")
    set(BIN_NAME "user${APP}.${flash}.${BOOT_MODE}.${SPI_SIZE_MAP}.bin")
else()
    set(ESP_APP1_ADDR 0)
    set(ESP_APP2_ADDR 0)
    set(ADDR 0x20000)
    set(BOOT_NAME "eagle.flash.bin")
    set(BIN_NAME "eagle.irom0text.bin")
endif()

set(ESP8266_RTOS_SDK_INCLUDE
    "${ESP8266_SDK_BASE}/include"
    "${ESP8266_SDK_BASE}/driver_lib/include"
    "${ESP8266_SDK_BASE}/include/json"
    "${ESP8266_SDK_BASE}/extra_include"
    "${ESP8266_SDK_BASE}/include/espressif"
    "${ESP8266_SDK_BASE}/include/lwip"
    "${ESP8266_SDK_BASE}/include/lwip/ipv4"
    "${ESP8266_SDK_BASE}/include/lwip/ipv6"
    "${ESP8266_SDK_BASE}/include/lwip/posix"
    "${ESP8266_SDK_BASE}/include/nopoll"
    "${ESP8266_SDK_BASE}/include/spiffs"
    "${ESP8266_SDK_BASE}/include/ssl"
    "${ESP8266_SDK_BASE}/include/json"
    "${ESP8266_SDK_BASE}/include/freertos"
)

function(esp8266_add_library TARGET)
#     cmake_parse_arguments(
#         PARSED_ARGS # prefix of output variables
#         "" # list of names of the boolean arguments (only defined ones will be true)
#         "NAME" # list of names of mono-valued arguments
#         "" # list of names of multi-valued arguments (output variables are lists)
#         ${ARGN} # arguments of the function to parse, here we take the all original ones
#     )

    file(GLOB driver_lib
        "${ESP8266_SDK_BASE}/driver_lib/driver/*.c"
    )
    add_library(${TARGET} STATIC ${driver_lib} ${ARGN})
    
    target_include_directories(${TARGET} PRIVATE ${ESP8266_RTOS_SDK_INCLUDE})
    
#     get_property(dirs TARGET ${TARGET} PROPERTY INCLUDE_DIRECTORIES)
#     foreach(dir ${dirs})
#         message(STATUS "dir='${dir}'")
#     endforeach()

    find_library(ESP8266_ARDUINO_SDK_LIB_HAL hal ${ARDUINO_ESP8266_DIR}/${ARDUINO_ESP8266_VERSION}/tools/sdk/lib)
    find_library(ESP8266_SDK_LIB_GCC gcc ${ESP8266_SDK_BASE}/lib)
    find_library(ESP8266_SDK_LIB_CIROM cirom ${ESP8266_SDK_BASE}/lib)
    find_library(ESP8266_SDK_LIB_CRYPTO crypto ${ESP8266_SDK_BASE}/lib)
    find_library(ESP8266_SDK_LIB_ESPCONN espconn ${ESP8266_SDK_BASE}/lib)
    find_library(ESP8266_SDK_LIB_MIROM mirom ${ESP8266_SDK_BASE}/lib)
    find_library(ESP8266_SDK_LIB_ESPNOW espnow ${ESP8266_SDK_BASE}/lib)
    find_library(ESP8266_SDK_LIB_FREERTOS freertos ${ESP8266_SDK_BASE}/lib)
    find_library(ESP8266_SDK_LIB_JSON json ${ESP8266_SDK_BASE}/lib)
    find_library(ESP8266_SDK_LIB_LWIP lwip ${ESP8266_SDK_BASE}/lib)
    find_library(ESP8266_SDK_LIB_MAIN main ${ESP8266_SDK_BASE}/lib)
    find_library(ESP8266_SDK_LIB_MESH mesh ${ESP8266_SDK_BASE}/lib)
    find_library(ESP8266_SDK_LIB_MINIC minic ${ESP8266_SDK_BASE}/lib)
    find_library(ESP8266_SDK_LIB_NET80211 net80211 ${ESP8266_SDK_BASE}/lib)
    find_library(ESP8266_SDK_LIB_NOPOLL nopoll ${ESP8266_SDK_BASE}/lib)
    find_library(ESP8266_SDK_LIB_PHY phy ${ESP8266_SDK_BASE}/lib)
    find_library(ESP8266_SDK_LIB_PP pp ${ESP8266_SDK_BASE}/lib)
    find_library(ESP8266_SDK_LIB_PWM pwm ${ESP8266_SDK_BASE}/lib)
    find_library(ESP8266_SDK_LIB_UPGRADE upgrade ${ESP8266_SDK_BASE}/lib)
    find_library(ESP8266_SDK_LIB_SMARTCONFIG smartconfig ${ESP8266_SDK_BASE}/lib)
    find_library(ESP8266_SDK_LIB_AIRKISS airkiss ${ESP8266_SDK_BASE}/lib)
    find_library(ESP8266_SDK_LIB_SPIFFS spiffs ${ESP8266_SDK_BASE}/lib)
    find_library(ESP8266_SDK_LIB_SSC ssc ${ESP8266_SDK_BASE}/lib)
    find_library(ESP8266_SDK_LIB_SSL ssl ${ESP8266_SDK_BASE}/lib)
    find_library(ESP8266_SDK_LIB_OPENSSL openssl ${ESP8266_SDK_BASE}/lib)
    find_library(ESP8266_SDK_LIB_MBEDTLS mbedtls ${ESP8266_SDK_BASE}/lib)
    find_library(ESP8266_SDK_LIB_MQTT mqtt ${ESP8266_SDK_BASE}/lib)
    find_library(ESP8266_SDK_LIB_WPA wpa ${ESP8266_SDK_BASE}/lib)
    find_library(ESP8266_SDK_LIB_WPS wps ${ESP8266_SDK_BASE}/lib)

    target_link_libraries(${TARGET}
#         gcc
        -lhal
#         ${ESP8266_ARDUINO_SDK_LIB_HAL}
        ${ESP8266_SDK_LIB_CRYPTO}
        ${ESP8266_SDK_LIB_ESPCONN}
        ${ESP8266_SDK_LIB_MIROM}
        ${ESP8266_SDK_LIB_ESPNOW}
        ${ESP8266_SDK_LIB_FREERTOS}
        ${ESP8266_SDK_LIB_JSON}
        ${ESP8266_SDK_LIB_LWIP}
        ${ESP8266_SDK_LIB_MAIN}
#         ${ESP8266_SDK_LIB_MESH}
        ${ESP8266_SDK_LIB_MINIC}
        ${ESP8266_SDK_LIB_NET80211}
        ${ESP8266_SDK_LIB_NOPOLL}
        ${ESP8266_SDK_LIB_PHY}
        ${ESP8266_SDK_LIB_PP}
        ${ESP8266_SDK_LIB_PWM}
#         ${ESP8266_SDK_LIB_UPGRADE}
        ${ESP8266_SDK_LIB_SMARTCONFIG}
        ${ESP8266_SDK_LIB_AIRKISS}
        ${ESP8266_SDK_LIB_SPIFFS}
        ${ESP8266_SDK_LIB_SSC}
        ${ESP8266_SDK_LIB_SSL}
        ${ESP8266_SDK_LIB_OPENSSL}
#         ${ESP8266_SDK_LIB_MBEDTLS}
        ${ESP8266_SDK_LIB_MQTT}
        ${ESP8266_SDK_LIB_WPA}
        ${ESP8266_SDK_LIB_WPS}
        ${ESP8266_SDK_LIB_CIROM}
        ${ESP8266_SDK_LIB_GCC}
    )
endfunction(esp8266_add_library)

function(esp8266_add_executable TARGET)
    add_executable(${TARGET} "")
    esp8266_add_library(user ${ARGN})
    target_link_libraries(${TARGET} user)
    set_target_properties(${TARGET} PROPERTIES
        LINK_FLAGS "-L${ESP_LD} -T${LD_FILE}"
    )
    set_target_properties(${TARGET} PROPERTIES
        LINKER_LANGUAGE C
    )
endfunction()

function(esp8266_add_firmware FIRMWARE TARGET)
    if(NOT TARGET ${TARGET})
        return()
    endif()
    
    add_custom_command(OUTPUT RTOS_SDK_FIRMWARE0
                        DEPENDS ${TARGET}
                        VERBATIM
                        COMMAND rm -f eagle.S eagle.dump
                        COMMAND ${CMAKE_OBJDUMP} -x -s ${TARGET} > eagle.dump
                        COMMAND ${CMAKE_OBJDUMP} -S ${TARGET} > eagle.S
                        COMMAND ${CMAKE_OBJCOPY} --only-section .text -O binary ${TARGET} eagle.app.v6.text.bin
                        COMMAND ${CMAKE_OBJCOPY} --only-section .data -O binary ${TARGET} eagle.app.v6.data.bin
                        COMMAND ${CMAKE_OBJCOPY} --only-section .rodata -O binary ${TARGET} eagle.app.v6.rodata.bin
                        COMMAND ${CMAKE_OBJCOPY} --only-section .irom0.text -O binary ${TARGET} eagle.app.v6.irom0text.bin
                        COMMAND ${CMAKE_COMMAND} -E env "PATH=$ENV{PATH}:${TOOLCHAIN_PREFIX}/bin" python ${ESP8266_SDK_BASE}/tools/gen_appbin.py "${TARGET}" ${BOOT_MODE} ${SPI_MODE} ${SPI_FREQDIV} ${SPI_SIZE_MAP}
    )

    if(${APP} STREQUAL 0)
        add_custom_target(${FIRMWARE}
                        ALL
                        VERBATIM
                        DEPENDS RTOS_SDK_FIRMWARE0
                        COMMAND ${CMAKE_COMMAND} -E rename eagle.app.flash.bin ${BOOT_NAME}
                        COMMAND ${CMAKE_COMMAND} -E rename eagle.app.v6.irom0text.bin ${BIN_NAME}
                        COMMAND ${CMAKE_COMMAND} -E remove eagle.app.v6.*
                        COMMAND @${CMAKE_COMMAND} -E echo "No boot needed."
                        COMMAND @${CMAKE_COMMAND} -E echo "Generate ${BOOT_NAME} and ${BIN_NAME} successully in folder bin."
                        COMMAND @${CMAKE_COMMAND} -E echo "${BOOT_NAME}-------->0x00000"
                        COMMAND @${CMAKE_COMMAND} -E echo "${BIN_NAME}---->${ADDR}"
        )
    else()
        if(${SPI_SIZE_MAP} STREQUAL 6 OR ${SPI_SIZE_MAP} STREQUAL 5)
            set(msg "Support boot_v1.4 and +")
        else()
            set(msg "Support boot_v1.2 and +")
        endif()
        add_custom_target(${FIRMWARE}
                        ALL
                        VERBATIM
                        DEPENDS RTOS_SDK_FIRMWARE0
                        COMMAND ${CMAKE_COMMAND} -E rename eagle.app.flash.bin ${BIN_NAME}
                        COMMAND ${CMAKE_COMMAND} -E remove eagle.app.v6.*
                        COMMAND @${CMAKE_COMMAND} -E echo ${msg}
                        COMMAND @${CMAKE_COMMAND} -E echo "${BOOT_NAME}------------>0x00000"
                        COMMAND @${CMAKE_COMMAND} -E echo "${BIN_NAME}--->${ADDR}"
        )
    endif()
    
    file(WRITE "${CMAKE_BINARY_DIR}/temp/esptool.sh"
        "#!/bin/bash\n"
        "if [ \"$1\" ]; then\n"
        " port=$1\n"
        "else\n"
        " echo \"serial port:\"\n"
        " read input\n"
        " if [ \"$input\" ]; then\n"
        "  port=$input\n"
        " else\n"
        "  exit\n"
        " fi\n"
        "fi\n"
        "set -x\n"
        "${PYTHON} ${ESPTOOL} --port $port write_flash 0 ${BOOT_NAME} ${ADDR} ${BIN_NAME} ${ESP_RF_CAL_DEFAULT_ADDR} ${ESP8266_SDK_BASE}/bin/esp_init_data_default.bin ${ESP_RF_CAL_ADDR} ${ESP8266_SDK_BASE}/bin/blank.bin ${ESP_SYS_PARAM_ADDR} ${ESP8266_SDK_BASE}/bin/blank.bin\n"
        "set +x\n"
    )
    file(COPY "${CMAKE_BINARY_DIR}/temp/esptool.sh"
        DESTINATION ${CMAKE_BINARY_DIR} 
        FILE_PERMISSIONS OWNER_READ OWNER_EXECUTE
    )
    add_dependencies(${FIRMWARE} ${TARGET})
endfunction()
