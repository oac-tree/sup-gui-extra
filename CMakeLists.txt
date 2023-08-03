cmake_minimum_required(VERSION 3.13.5)

project(sup-gui-extra-all VERSION 1.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)

option(COA_EXPORT_BUILD_TREE "Export build tree in /home/user/.cmake registry" OFF)
option(COA_USE_QT6 "Compile with Qt6" OFF)
option(SUP_GUI_EXTRA_BUILD_HIGHLIGHT "Build code highlighting library" ON)

set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake/module)
set(CMAKE_CONFIG_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake/config)
include(configuration)

add_subdirectory(src)
add_subdirectory(extern)

include(installation)
