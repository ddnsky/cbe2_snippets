message(STATUS "gtest-config.cmake proceeded") 
set(gtest_INCLUDE_DIRS ${CMAKE_SOURCE_DIR}/ports/gtest)
set(gtest_LIBRARIES gtest)
add_library(GTest::gtest ALIAS gtest)
add_library(GTest::gtest_main ALIAS gtest_main)
add_library(GTest::gmock ALIAS gmock)
add_library(GTest::gmock_main ALIAS gmock_main)

