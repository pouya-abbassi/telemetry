cmake_minimum_required(VERSION 3.20)
set(CMAKE_BUILD_TYPE Release)
set(CMAKE_CXX_COMPILER clang++)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(BUILD_SHARED_LIBS OFF)

project(main
  LANGUAGES CXX
  VERSION 1.0.1
  DESCRIPTION "Bildigo telemetry"
  HOMEPAGE_URL "https://app.bildigo.com")

find_package(Drogon 1.9 REQUIRED)

add_executable(main main.cpp)
target_link_libraries(main PRIVATE Drogon::Drogon)

add_custom_command(TARGET main POST_BUILD
  COMMAND ${CMAKE_STRIP} main)

include(GNUInstallDirs)
install(TARGETS main)
