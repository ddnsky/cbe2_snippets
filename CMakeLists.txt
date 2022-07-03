cmake_minimum_required(VERSION 3.2.2)
project(mgtProject LANGUAGES C CXX)  

cmake_policy(SET CMP0063 NEW)
cmake_policy(SET CMP0077 NEW)
cmake_policy(SET CMP0079 NEW)

set(CMAKE_POLICY_DEFAULT_CMP0077 NEW)

set(CMAKE_WARN_DEPRECATED OFF CACHE BOOL "" FORCE) # remove gtest warnings about cmake version
set(CMAKE_INSTALL_PREFIX  ${CMAKE_BINARY_DIR} CACHE PATH "stage dir" FORCE)
set(CMAKE_FIND_ROOT_PATH ${CMAKE_INSTALL_PREFIX})
set(CMAKE_STAGING_PREFIX ${CMAKE_BINARY_DIR})
set(CBE_BUILD_TARGET ON)

set(CMAKE_MESSAGE_LOG_LEVEL ERROR) #ERROR|WARNING|NOTICE|STATUS|VERBOSE|DEBUG|TRACE
set(CMAKE_SKIP_INSTALL_RULES ON )
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/packages/mgt/cmake")
#list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}")

#set(OpenGL_GL_PREFERENCE LEGACY)
set(OpenGL_GL_PREFERENCE GLVND)
#set(BINUTILS_INCLUDE_DIR usr/include)

#set(CMAKE_BUILD_TYPE Release)
set(MGT_ENABLE_STACK_TRACING OFF CACHE BOOL "" FORCE)
set(MGT_DISABLE_HW_RENDERING_API OFF)
set(MGT_DEBUG_PEDANTIC OFF)
set(MGT_DEBUG ON)
#add_definitions( -DDEPRECATED_PATH_DRAW )
#add_definitions( -DGRAPHICS_USE_EARCUT_TESSELATOR)
#add_definitions( -DGRAPHICS_USE_BSP_TESSELATOR)

add_definitions( -DMGT_GRAPHICS_EXTRIM_MODE )
add_definitions( -DUI_LAYOUT_USE_YOGA )
add_definitions( -DUI_USE_PEDANTIC_MODE )

set(BUILD_SHARED_LIBS OFF)
set(BUILD_EXAMPLES OFF)
set(BUILD_TESTS OFF)

#set(MGT_COMPILER_EXTRA_WARNINGS ON)
if (MGT_COMPILER_EXTRA_WARNINGS)
set(EXTRACF "")

#set(EXTRACF "${EXTRACF} -Wno-gnu-anonymous-struct")
#set(EXTRACF "${EXTRACF} -Wno-nested-anon-types")
#set(EXTRACF "${EXTRACF} -Wno-shadow-field-in-constructor")
#set(EXTRACF "${EXTRACF} -Wno-newline-eof")

set(EXTRACF "${EXTRACF} -Wno-float-equal")
set(EXTRACF "${EXTRACF} -Wno-old-style-cast")
set(EXTRACF "${EXTRACF} -Wno-implicit-float-conversion")
set(EXTRACF "${EXTRACF} -Wno-implicit-int-conversion")

set(EXTRACF "${EXTRACF} -Wno-non-virtual-dtor")
set(EXTRACF "${EXTRACF} -Wno-implicit-fallthrough")
set(EXTRACF "${EXTRACF} -Wno-double-promotion")
set(EXTRACF "${EXTRACF} -Wno-deprecated-copy")

set(EXTRACF "${EXTRACF} -Wno-missing-prototypes")
set(EXTRACF "${EXTRACF} -Wno-zero-as-null-pointer-constant")
set(EXTRACF "${EXTRACF} -Wno-missing-field-initializers")
set(EXTRACF "${EXTRACF} -Wno-shorten-64-to-32")
set(EXTRACF "${EXTRACF} -Wno-missing-variable-declarations")
set(EXTRACF "${EXTRACF} -Wno-string-conversion")
set(EXTRACF "${EXTRACF} -Wno-unused-parameter")
set(EXTRACF "${EXTRACF} -Wno-inconsistent-missing-destructor-override")
set(EXTRACF "${EXTRACF} -Wno-suggest-destructor-override")
set(EXTRACF "${EXTRACF} -Wno-deprecated-copy-dtor")
set(EXTRACF "${EXTRACF} -Wno-float-conversion")
set(EXTRACF "${EXTRACF} -Wno-comma")
set(EXTRACF "${EXTRACF} -Wno-missing-noreturn")

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${EXTRACF}")
unset(EXTRACF)
endif()
#add_compile_options(-fno-rtti)
#add_compile_options(-fno-exceptions)
#option(ANDROID_NATIVE_APP_GLUE  "Using android_native_app_glue.c" ON)

if (MGT_DEBUG_PEDANTIC)
  set(MGT_DEBUG ON)
  add_definitions( -DMGT_DEBUG_PEDANTIC )
endif()
if(MGT_DEBUG)
  add_definitions( -DMGT_DEBUG )
endif()
if (MGT_DISABLE_HW_RENDERING_API)
  add_definitions( -DMGT_DISABLE_HW_RENDERING_API )
endif()

set(BUILD_TESTING OFF) #for abseil


#add_subdirectory(ports/zlib)
#add_subdirectory(ports/libpng)
#add_subdirectory(ports/libjpeg)
#set(JPEG_INCLUDE_DIRS ${CMAKE_SOURCE_DIR}/ports/libjpeg)
#set(JPEG_INCLUDE_DIR ${JPEG_INCLUDE_DIRS})
#set(JPEG_LIBRARY libjpeg)
#add_library(JPEG::JPEG ALIAS jpeg)

set(Sanitizers_DIR ${CMAKE_SOURCE_DIR}/.cmake)
add_subdirectory(ports/googletest)
set(GTest_DIR ${CMAKE_SOURCE_DIR}/.cmake)


set(EXPAT_BUILD_DOCS OFF)
set(EXPAT_BUILD_TOOLS OFF)
set(EXPAT_BUILD_EXAMPLES OFF)
add_subdirectory(ports/expat/expat)

#add_subdirectory(ports/rapidjson)
#set(RapidJSON_INCLUDE_DIR "${CMAKE_SOURCE_DIR}/ports/rapidjson/include") 
#set(RapidJSON_INCLUDE_DIRS "${CMAKE_SOURCE_DIR}/ports/rapidjson/include") 
#find_package(RapidJSON)
#set(RapidJSONTarget RapidJSON::RapidJSON)
#add_library(RapidJSON::RapidJSON ALIAS RapidJSON)
#set_target_properties(RapidJSON::RapidJSON PROPERTIES
        #IMPORTED_LOCATION "${CMAKE_BINARY_DIR}/ports/rapidjson"
        #INTERFACE_INCLUDE_DIRECTORIES "${CMAKE_SOURCE_DIR}/ports/rapidjson/include"
        #)
add_library(RapidJSON INTERFACE)
add_library(RapidJSON::RapidJSON ALIAS RapidJSON)
target_include_directories(RapidJSON INTERFACE "${CMAKE_SOURCE_DIR}/ports/rapidjson/include")        
#set_target_properties(RapidJSON PROPERTIES
        #INTERFACE_INCLUDE_DIRECTORIES "${CMAKE_SOURCE_DIR}/ports/rapidjson/include"
        #)

add_subdirectory(ports/glm)
set(glm_DIR ${CMAKE_SOURCE_DIR}/.cmake)

add_subdirectory(ports/yogaengine)
set(yogaengine_DIR ${CMAKE_SOURCE_DIR}/.cmake) 

add_subdirectory(ports/abseil-cpp)
set(absl_DIR ${CMAKE_SOURCE_DIR}/.cmake)


#include_directories(ports/glm)
include(PlatformDetection REQUIRED)

add_subdirectory(packages/mgt) 

target_link_libraries(mgt_cpl PUBLIC RapidJSON)

set(mgt_DIR ${CMAKE_SOURCE_DIR}/packages/mgt) 
set(mgt_bpl_DIR ${CMAKE_SOURCE_DIR}/.cmake)
set(mgt_ui_DIR ${CMAKE_SOURCE_DIR}/.cmake)
set(mgt_cpl_DIR ${CMAKE_SOURCE_DIR}/.cmake)

add_library(MGT::bpl ALIAS mgt_bpl)
add_library(MGT::ui ALIAS mgt_ui)
add_library(MGT::cpl ALIAS mgt_cpl)
add_library(MGT::graphics ALIAS mgt_graphics)

if (NOT BUILD_TESTS)
        set(__PROJECT_NAME ${PROJECT_NAME})
        set(PROJECT_NAME mgt_graphics)
        add_subdirectory(packages/mgt/graphics/tests)   
        set(PROJECT_NAME ${__PROJECT_NAME})
        unset(__PROJECT_NAME)
endif()

if (NOT BUILD_EXAMPLES)
        add_subdirectory(packages/mgt/graphics/examples)
        add_subdirectory(packages/mgt/ui/examples)
endif()

# notepad

set(POC_CPP_PATH "packages/mgt/examples/notepad")

add_subdirectory(${POC_CPP_PATH})

configure_file("${POC_CPP_PATH}/icons/png/save.png"   "${CMAKE_BINARY_DIR}/${POC_CPP_PATH}/icons/png/save.png" COPYONLY)
configure_file("${POC_CPP_PATH}/icons/png/folder.png" "${CMAKE_BINARY_DIR}/${POC_CPP_PATH}/icons/png/folder.png" COPYONLY)
configure_file("${POC_CPP_PATH}/icons/png/about.png"  "${CMAKE_BINARY_DIR}/${POC_CPP_PATH}/icons/png/about.png" COPYONLY)
configure_file("${POC_CPP_PATH}/icons/png/logo.png"   "${CMAKE_BINARY_DIR}/${POC_CPP_PATH}/icons/png/logo.png" COPYONLY)
if(MSVC)
   set_target_properties(poc_cpp PROPERTIES LINK_FLAGS_DEBUG "/SUBSYSTEM:CONSOLE")
   set_target_properties(poc_cpp PROPERTIES COMPILE_DEFINITIONS_DEBUG "_CONSOLE")
endif(MSVC)


add_subdirectory("packages/mgt/examples/widget_gallery")

if (0)
endif()
