cmake_minimum_required(VERSION 3.16)

set(KF_VERSION "5.106.0")
# project(KSyntaxHighlighting VERSION ${KF_VERSION})

#find_package(ECM 5.102.0 REQUIRED NO_MODULE)
#set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake/modules)
# set(ECM_MODULE_DIR ${CMAKE_CURRENT_LIST_DIR}/cmake/modules)
# set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake/modules;${CMAKE_CURRENT_LIST_DIR}/cmake/kde-modules)

if(POLICY CMP0063)
    cmake_policy(SET CMP0063 NEW)
endif()

# include(${CMAKE_CURRENT_LIST_DIR}/cmake/modules/QtVersionOption.cmake)
# if (QT_MAJOR_VERSION EQUAL "6")
    # find_package(Qt6Core)
    # set(ENABLE_BSYMBOLICFUNCTIONS ${QT_FEATURE_reduce_relocations})
# else ()
    # set(ENABLE_BSYMBOLICFUNCTIONS ON)
# endif()
# include(${CMAKE_CURRENT_LIST_DIR}/cmake/modules/QtVersionOption.cmake)
add_definitions(-DQT_NO_CAST_TO_ASCII
                -DQT_NO_CAST_FROM_ASCII
                -DQT_NO_URL_CAST_FROM_STRING
                -DQT_NO_CAST_FROM_BYTEARRAY
                -DQT_USE_QSTRINGBUILDER
                -DQT_NO_NARROWING_CONVERSIONS_IN_CONNECT
               )

#include(KDEInstallDirs)
#include(KDECMakeSettings)
#include(KDEFrameworkCompilerSettings NO_POLICY_SCOPE)
#include(KDEGitCommitHooks)

# include(FeatureSummary)
# include(GenerateExportHeader)
include(ECMSetupVersion)
# include(${CMAKE_CURRENT_LIST_DIR}/cmake/modules/ECMSetupVersion.cmake)
include(ECMGenerateHeaders)
# include(${CMAKE_CURRENT_LIST_DIR}/cmake/modules/ECMGenerateHeaders.cmake)
#include(ECMGeneratePriFile)
# include(CMakePackageConfigHelpers)
#include(ECMPoQmTools)
include(ECMQtDeclareLoggingCategory)
# include(${CMAKE_CURRENT_LIST_DIR}/cmake/modules/ECMQtDeclareLoggingCategory.cmake)
include(ECMMarkNonGuiExecutable)
# include(${CMAKE_CURRENT_LIST_DIR}/cmake/modules/ECMMarkNonGuiExecutable.cmake)
#include(ECMAddQch)
#include(ECMOptionalAddSubdirectory)
include(ECMGenerateExportHeader)
# include(${CMAKE_CURRENT_LIST_DIR}/cmake/modules/ECMGenerateExportHeader.cmake)
#include(ECMDeprecationSettings)
#include(ECMQmlModule)
#include(${CMAKE_CURRENT_LIST_DIR}/cmake/modules/ECMQmlModule.cmake)

set(EXCLUDE_DEPRECATED_BEFORE_AND_AT 0 CACHE STRING "Control the range of deprecated API excluded from the build [default=0].")

#
# Dependencies
#
# set(REQUIRED_QT_VERSION 5.15.2)
# find_package(Qt${QT_MAJOR_VERSION} ${REQUIRED_QT_VERSION} NO_MODULE REQUIRED COMPONENTS Core Network Test)

# option(KSYNTAXHIGHLIGHTING_USE_GUI "Build components depending on QtGui" ON)
# if(KSYNTAXHIGHLIGHTING_USE_GUI)
#     find_package(Qt${QT_MAJOR_VERSION} ${REQUIRED_QT_VERSION} NO_MODULE REQUIRED COMPONENTS Gui)
# endif()
# find_package(Qt${QT_MAJOR_VERSION} ${REQUIRED_QT_VERSION} NO_MODULE QUIET OPTIONAL_COMPONENTS PrintSupport Widgets Quick)
# set_package_properties(Qt${QT_MAJOR_VERSION} PROPERTIES URL "http://qt-project.org/")
# set_package_properties(Qt${QT_MAJOR_VERSION}Widgets PROPERTIES PURPOSE "Example application.")
# set_package_properties(Qt${QT_MAJOR_VERSION}PrintSupport PROPERTIES PURPOSE "Example application.")
# set_package_properties(Qt${QT_MAJOR_VERSION}Quick PROPERTIES PURPOSE "QtQuick bindings.")

# QXmlPatters was removed in Qt6
# if (QT_MAJOR_VERSION STREQUAL "5")
#     find_package(Qt5 ${REQUIRED_QT_VERSION} NO_MODULE QUIET OPTIONAL_COMPONENTS XmlPatterns)
#     set_package_properties(Qt5XmlPatterns PROPERTIES PURPOSE "Compile-time validation of syntax definition files.")
# endif()

# find_package(Perl REQUIRED)
# set_package_properties(Perl PROPERTIES PURPOSE "Auto-generate PHP syntax definition files.")

#
# allow to install the "differently" licensed syntax xml files instead of putting them in a QRC and link them in
#
option(QRC_SYNTAX "Bundle the syntax definition files inside the library as resources" ON)
# add_feature_info(SYNTAX_RESOURCE ${QRC_SYNTAX} "Bundle the syntax definition files inside the library as resources")

#
# allow to turn of lookup for syntax files and themes via QStandardPaths
#
option(NO_STANDARD_PATHS "Skip lookup of syntax and theme definitions in QStandardPaths locations" OFF)
# add_feature_info(FEATURE_NO_STANDARD_PATHS ${NO_STANDARD_PATHS} "Skip lookup of syntax and theme definitions in QStandardPaths locations")

#
# API documentation
#
# option(BUILD_QCH "Build API documentation in QCH format (for e.g. Qt Assistant, Qt Creator & KDevelop)" OFF)
# add_feature_info(QCH ${BUILD_QCH} "API documentation in QCH format (for e.g. Qt Assistant, Qt Creator & KDevelop)")

#
# Translations
#
#ecm_install_po_files_as_qm(poqm)

# tell the framework if it shall use the syntax files from the resource
if (QRC_SYNTAX)
    add_definitions(-DHAS_SYNTAX_RESOURCE)
endif()

# skip standard paths?
if (NO_STANDARD_PATHS)
    add_definitions(-DNO_STANDARD_PATHS)
endif()

#ecm_set_disabled_deprecation_versions(
#    QT 5.15.2
#)

#
# Actually build the stuff
#
# include_directories(${CMAKE_CURRENT_BINARY_DIR})
add_subdirectory(src/indexer)
add_subdirectory(data)
add_subdirectory(src/lib)
# add_subdirectory(src)
# if(TARGET Qt${QT_MAJOR_VERSION}::Gui)
#     add_subdirectory(examples)
# #    if (BUILD_TESTING)
# #        add_subdirectory(autotests)
# #    endif()
# endif()

#
# CMake package config file generation
#
#set(CMAKECONFIG_INSTALL_DIR "${KDE_INSTALL_CMAKEPACKAGEDIR}/KF5SyntaxHighlighting")

#if (BUILD_QCH)
#    ecm_install_qch_export(
#        TARGETS KF5SyntaxHighlighting_QCH
#        FILE KF5SyntaxHighlightingQchTargets.cmake
#        DESTINATION "${CMAKECONFIG_INSTALL_DIR}"
#        COMPONENT Devel
#    )
#    set(PACKAGE_INCLUDE_QCHTARGETS "include(\"\${CMAKE_CURRENT_LIST_DIR}/KF5SyntaxHighlightingQchTargets.cmake\")")
#endif()

#configure_package_config_file(
#    "${CMAKE_CURRENT_SOURCE_DIR}/KF5SyntaxHighlightingConfig.cmake.in"
#    "${CMAKE_CURRENT_BINARY_DIR}/KF5SyntaxHighlightingConfig.cmake"
#    INSTALL_DESTINATION "${CMAKECONFIG_INSTALL_DIR}"
#)

#install(FILES
#        "${CMAKE_CURRENT_BINARY_DIR}/KF5SyntaxHighlightingConfig.cmake"
#        "${CMAKE_CURRENT_BINARY_DIR}/KF5SyntaxHighlightingConfigVersion.cmake"
#        DESTINATION "${CMAKECONFIG_INSTALL_DIR}"
#        COMPONENT Devel)

#if(TARGET KF5SyntaxHighlighting)
#    install(EXPORT KF5SyntaxHighlightingTargets
#        DESTINATION "${CMAKECONFIG_INSTALL_DIR}"
#        FILE KF5SyntaxHighlightingTargets.cmake
#        NAMESPACE KF5::)
#endif()

#install(FILES "${CMAKE_CURRENT_BINARY_DIR}/ksyntaxhighlighting_version.h"
#        DESTINATION "${KDE_INSTALL_INCLUDEDIR_KF}/KSyntaxHighlighting"
#        COMPONENT Devel)

#feature_summary(WHAT ALL INCLUDE_QUIET_PACKAGES FATAL_ON_MISSING_REQUIRED_PACKAGES)

# add target to update kate-editor.org syntax page + update site
#add_custom_target(update_kate_editor_org
#    COMMAND "${PERL_EXECUTABLE}" "${CMAKE_CURRENT_SOURCE_DIR}/utils/update-kate-editor-org.pl" "${CMAKE_SOURCE_DIR}" "${CMAKE_BINARY_DIR}")

#kde_configure_git_pre_commit_hook(CHECKS CLANG_FORMAT)
