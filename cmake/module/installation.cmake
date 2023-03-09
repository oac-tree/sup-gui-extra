# -----------------------------------------------------------------------------
# Installation
# Credits to https://pabloariasal.github.io/2018/02/19/its-time-to-do-cmake-right,
# https://gitlab.kitware.com/cmake/community/-/wikis/doc/tutorials/Exporting-and-Importing-Targets
# -----------------------------------------------------------------------------

set(INSTALL_CONFIGDIR ${CMAKE_INSTALL_LIBDIR}/cmake/sup-gui-extra)

# exporting targets to a script and installing it
install(EXPORT sup-gui-extra-targets FILE sup-gui-extra-targets.cmake NAMESPACE sup-gui-extra:: DESTINATION ${INSTALL_CONFIGDIR})

# -----------------------------------------------------------------------------
# Exporting
# -----------------------------------------------------------------------------

# Add all targets to the build-tree export set
if(SUP_GUI_EXTRA_BUILD_HIGHLIGHT)
  export(TARGETS ksyntaxhighlighting NAMESPACE sup-gui-extra:: FILE "${PROJECT_BINARY_DIR}/sup-gui-extra-targets.cmake")
endif()

# Export the package for use from the build-tree (goes to $HOME/.cmake)
if(COA_EXPORT_BUILD_TREE)
  set(CMAKE_EXPORT_PACKAGE_REGISTRY ON)
  export(PACKAGE sup-gui-extra)
endif()

# -----------------------------------------------------------------------------
# Creating and installing sup-gui-extra-config.cmake
# -----------------------------------------------------------------------------

include(CMakePackageConfigHelpers)

# to use in the build tree
configure_package_config_file(${CMAKE_CURRENT_LIST_DIR}/../config/sup-gui-extra-config.cmake.in
  ${CMAKE_CURRENT_BINARY_DIR}/sup-gui-extra-config.cmake
  INSTALL_DESTINATION ${INSTALL_CONFIGDIR}
)

# to use in install tree
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/sup-gui-extra-config.cmake DESTINATION ${INSTALL_CONFIGDIR})

# -----------------------------------------------------------------------------
# Create and install sup-gui-extra-config-version.cmake file
# -----------------------------------------------------------------------------
write_basic_package_version_file(${CMAKE_CURRENT_BINARY_DIR}/sup-gui-extra-config-version.cmake VERSION
  ${PROJECT_VERSION} COMPATIBILITY AnyNewerVersion)

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/sup-gui-extra-config-version.cmake DESTINATION ${INSTALL_CONFIGDIR})
