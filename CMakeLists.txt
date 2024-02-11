cmake_minimum_required(VERSION 3.23)
project(JustEnoughModCore)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED TRUE)
set(CMAKE_POLICY_DEFAULT_CMP0077 NEW)

file(GLOB SRC "src/*.cpp" "src/*.hpp")

add_subdirectory("JustEnoughMod")

# Libary
add_library(${PROJECT_NAME} SHARED ${SRC} )

target_include_directories(${PROJECT_NAME} PUBLIC "src")

target_link_libraries (${PROJECT_NAME} JustEnoughMod)

