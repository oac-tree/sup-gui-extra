add_library(coa-icons INTERFACE)
add_library(sup-gui-extra::coa-icons ALIAS coa-icons)

set_target_properties(coa-icons PROPERTIES EXPORT_NAME coa-icons)

set(COA_ICONS_THEME_NAME "coa-icons")

set(COA_ICONS_RCC_FILE coa-icons.rcc)
set(COA_ICONS_RCC_INSTALLDIR ${CMAKE_INSTALL_LIBDIR}/sup-gui-extra)

set(COA_ICONS_RCC ${CMAKE_CURRENT_BINARY_DIR}/${COA_ICONS_RCC_FILE})

qt_add_binary_resources(coa-icons-resources coa-icons.qrc DESTINATION ${COA_ICONS_RCC})
add_dependencies(coa-icons coa-icons-resources)

set_target_properties(coa-icons PROPERTIES RESOURCE "${COA_ICONS_RCC}")

# Header for BUILD_INTERFACE, loads rcc from CMAKE_CURRENT_BINARY_DIR/COA_ICONS_RCC_FILE
configure_file(coa_icons.h.in ${SUP_GUI_EXTRA_AUTOGEN_DIR}/sup/gui-extra/coa_icons.h @ONLY)

target_include_directories(coa-icons INTERFACE
  $<INSTALL_INTERFACE:include>
  $<BUILD_INTERFACE:${SUP_GUI_EXTRA_AUTOGEN_DIR}>)

# Installation
install(TARGETS coa-icons EXPORT sup-gui-extra-targets DESTINATION ${COA_ICONS_RCC_INSTALLDIR})

# For INSTALL_INTERFACE, loads rcc from CMAKE_INSTALL_PREFIX/COA_ICONS_RCC_INSTALLDIR/COA_ICONS_RCC_FILE
# CODE directive is used to ensure CMake interprets ${CMAKE_INSTALL_PREFIX} at install time
install(CODE
  "set(COA_ICONS_RCC \"\${CMAKE_INSTALL_PREFIX}/${COA_ICONS_RCC_INSTALLDIR}/${COA_ICONS_RCC_FILE}\")
  configure_file(\"${CMAKE_CURRENT_SOURCE_DIR}/coa_icons.h.in\" \"${SUP_GUI_EXTRA_AUTOGEN_DIR}/install/coa_icons.h\")"
)
install(FILES ${SUP_GUI_EXTRA_AUTOGEN_DIR}/install/coa_icons.h DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/sup/gui-extra)
