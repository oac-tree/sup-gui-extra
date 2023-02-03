set(KF_VERSION "5.102.0")

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

find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Widgets Core Gui PrintSupport Test Network)

add_subdirectory(src)
add_subdirectory(data)
#add_subdirectory(examples)
