add_library(ksyntaxhighlighting)
add_library(sup-gui-extra::ksyntaxhighlighting ALIAS ksyntaxhighlighting)

#ecm_create_qm_loader(syntax_highlighting_QM_LOADER syntaxhighlighting5_qt)

ecm_setup_version(${KF_VERSION}
    VARIABLE_PREFIX SyntaxHighlighting
    VERSION_HEADER "${CMAKE_CURRENT_BINARY_DIR}/ksyntaxhighlighting_version.h"
)

target_sources(ksyntaxhighlighting PRIVATE
    abstracthighlighter.cpp
    context.cpp
    contextswitch.cpp
#    definitiondownloader.cpp
    highlightingdata.cpp
    foldingregion.cpp
    format.cpp
    htmlhighlighter.cpp
    ansihighlighter.cpp
    keywordlist.cpp
    rule.cpp
    definition.cpp
    repository.cpp
    state.cpp
    syntaxhighlighter.cpp
    theme.cpp
    wildcardmatcher.cpp
    themedata.cpp
    worddelimiters.cpp
    # ${syntax_highlighting_QM_LOADER}
    $<TARGET_OBJECTS:SyntaxHighlightingData>
)
ecm_qt_declare_logging_category(ksyntaxhighlighting
    HEADER ksyntaxhighlighting_logging.h
    IDENTIFIER KSyntaxHighlighting::Log
    CATEGORY_NAME kf.syntaxhighlighting
    OLD_CATEGORY_NAMES org.kde.ksyntaxhighlighting
    DESCRIPTION "Syntax Highlighting"
    EXPORT KSYNTAXHIGHLIGHTING
)

ecm_generate_export_header(ksyntaxhighlighting
    BASE_NAME KSyntaxHighlighting
    GROUP_BASE_NAME KF
    VERSION ${KF_VERSION}
    DEPRECATED_BASE_VERSION 0
    DEPRECATION_VERSIONS 5.87
    EXCLUDE_DEPRECATED_BEFORE_AND_AT ${EXCLUDE_DEPRECATED_BEFORE_AND_AT}
)
set_target_properties(ksyntaxhighlighting PROPERTIES
    VERSION ${SyntaxHighlighting_VERSION}
    SOVERSION ${SyntaxHighlighting_SOVERSION}
    EXPORT_NAME ksyntaxhighlighting
)

target_link_libraries(ksyntaxhighlighting
    PUBLIC
        Qt${QT_MAJOR_VERSION}::Gui
#    PRIVATE
#        Qt${QT_MAJOR_VERSION}::Network
)

set(Forwarding_Header_Names
    AbstractHighlighter
    Definition
#    DefinitionDownloader
    FoldingRegion
    Format
    Repository
    State
    SyntaxHighlighter
    Theme
    WildcardMatcher
)

ecm_generate_headers(CamelCase_HEADERS
    HEADER_NAMES ${Forwarding_Header_Names}
    REQUIRED_HEADERS SyntaxHighlighting_HEADERS
    OUTPUT_DIR ${CMAKE_CURRENT_BINARY_DIR}/ksyntaxhighlighting
)

target_include_directories(ksyntaxhighlighting
    INTERFACE "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/sup/gui-extra/ksyntaxhighlighting>"
    PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}>
)

install(TARGETS ksyntaxhighlighting EXPORT sup-gui-extra-targets DESTINATION ${CMAKE_INSTALL_LIBDIR})

install(FILES
    ${CamelCase_HEADERS}
    ${SyntaxHighlighting_HEADERS}
    ${CMAKE_CURRENT_BINARY_DIR}/ksyntaxhighlighting_export.h
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/sup/gui-extra/ksyntaxhighlighting
)

#if(BUILD_QCH)
#    ecm_add_qch(
#        KF5SyntaxHighlighting_QCH
#        NAME KSyntaxHighlighting
#        BASE_NAME KF5SyntaxHighlighting
#        VERSION ${KF_VERSION}
#        ORG_DOMAIN org.kde
#        SOURCES # using only public headers, to cover only public API
#            ${SyntaxHighlighting_HEADERS}
#        MD_MAINPAGE "${CMAKE_SOURCE_DIR}/README.md"
#        LINK_QCHS
#            Qt5Core_QCH
#            Qt5Gui_QCH
#        INCLUDE_DIRS
#            ${CMAKE_CURRENT_BINARY_DIR}
#        BLANK_MACROS
#            KSYNTAXHIGHLIGHTING_EXPORT
#            KSYNTAXHIGHLIGHTING_DEPRECATED
#        TAGFILE_INSTALL_DESTINATION ${KDE_INSTALL_QTQCHDIR}
#        QCH_INSTALL_DESTINATION ${KDE_INSTALL_QTQCHDIR}
#        COMPONENT Devel
#    )
#endif()
#ecm_generate_pri_file(
#    BASE_NAME KSyntaxHighlighting LIB_NAME
#    KF5SyntaxHighlighting
#    DEPS "gui"
#    FILENAME_VAR PRI_FILENAME
#    INCLUDE_INSTALL_DIR ${KDE_INSTALL_INCLUDEDIR_KF}/KSyntaxHighlighting
#)
#install(FILES ${PRI_FILENAME} DESTINATION ${ECM_MKSPECS_INSTALL_DIR})
