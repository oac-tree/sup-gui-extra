
add_executable(minimal main.cpp)
target_link_libraries(minimal Qt${QT_MAJOR_VERSION}::Widgets KF5SyntaxHighlighting)
