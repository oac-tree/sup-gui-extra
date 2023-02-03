cmake_minimum_required(VERSION 3.16)

set(KF_VERSION "5.102.0")
project(KSyntaxHighlighting VERSION ${KF_VERSION})

option(QRC_SYNTAX "Bundle the syntax definition files inside the library as resources" ON)
# tell the framework if it shall use the syntax files from the resource
if (QRC_SYNTAX)
    add_definitions(-DHAS_SYNTAX_RESOURCE)
endif()

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
set(ECM_MODULE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

include(KDEFrameworkCompilerSettings NO_POLICY_SCOPE)
include(ECMGenerateHeaders)
include(ECMGenerateExportHeader)
include(ECMQtDeclareLoggingCategory)
include(ECMSetupVersion)
include(ECMMarkNonGuiExecutable)

find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Widgets Core Gui PrintSupport Test Network XmlPatterns)

# QXmlPatters was removed in Qt6
if (QT_MAJOR_VERSION STREQUAL "5")
    find_package(Qt5 NO_MODULE QUIET OPTIONAL_COMPONENTS XmlPatterns)
    set_package_properties(Qt5XmlPatterns PROPERTIES PURPOSE "Compile-time validation of syntax definition files.")
endif()

add_subdirectory(data)
add_subdirectory(src)
#add_subdirectory(examples)
