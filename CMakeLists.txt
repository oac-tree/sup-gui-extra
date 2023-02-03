cmake_minimum_required(VERSION 3.13.5)
project(sup-gui-extra-all VERSION 0.4.99 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)

option(SUP_GUI_EXTRA_BUILD_HIGHLIGHT "Build code highlighting library" ON)

set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake/modules)
include(configuration)

add_subdirectory(extern)
