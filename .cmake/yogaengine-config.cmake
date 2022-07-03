message(STATUS "yogaengine-config.cmake proceeded") 
set(yogaengine_INCLUDE_DIRS ${CMAKE_SOURCE_DIR}/ports/yogaengine)
set(yogaengine_LIBRARIES yogaengine)

#set_target_properties(yogaengine PROPERTIES
        #IMPORTED_LOCATION "${CMAKE_BINARY_DIR}/ports/yogaengine"
        #INTERFACE_INCLUDE_DIRECTORIES "${CMAKE_SOURCE_DIR}/ports/yogaengine"
        #)

