# Project       : Graphical User Interface for SUP and PSPS
#
# Description   : Common libraries and tools for Operation Application GUIs
#
# Author        : Rafael Silva (EXT)
#
# Copyright (c) : 2010-2023 ITER Organization,
#                 CS 90 046
#                 13067 St. Paul-lez-Durance Cedex
#                 France
# SPDX-License-Identifier: MIT
#
# This file is part of ITER CODAC software.
# For the terms and conditions of redistribution or use of this software
# refer to the file LICENSE located in the top level directory
# of the distribution package.

cmake_minimum_required(VERSION 3.13...3.31)
project(sup-gui-extra-all VERSION 1.8.0 LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 17)

option(COA_EXPORT_BUILD_TREE "Export build tree in /home/user/.cmake registry" OFF)
option(COA_USE_QT6 "Compile with Qt6" ON)
option(SUP_GUI_EXTRA_BUILD_HIGHLIGHT "Build code highlighting library" ON)

set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake/module)
set(CMAKE_CONFIG_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake/config)
include(configuration)

add_subdirectory(src)
add_subdirectory(extern)

include(installation)
