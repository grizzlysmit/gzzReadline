# Specify the minimum version.
cmake_minimum_required(VERSION 3.9)

# Specify the project info.
project(gzz_readline
        VERSION 0.0.1
        DESCRIPTION "Extension to Gnu Readline to get a prompt with a default value"
        LANGUAGES "C")


# Declare the library target.
add_library(${PROJECT_NAME} SHARED
    source/gzz_rlprivate.c
    source/gzz_readline.c
)

#add_dependencies(gzz_readline libreadline.so.0)

target_link_libraries(gzz_readline libreadline.so.0)

# Configure the directories to search for header files.
target_include_directories(${PROJECT_NAME} PRIVATE source)

# Set the version property.
set_target_properties(${PROJECT_NAME} PROPERTIES VERSION ${PROJECT_VERSION})

# Set the shared object version property to the project's major version.
set_target_properties(${PROJECT_NAME} PROPERTIES SOVERSION ${PROJECT_VERSION_MAJOR})

# Set the public header property to the one with the actual API.
set_target_properties(${PROJECT_NAME} PROPERTIES PUBLIC_HEADER source/gzz_readline.h)

# Set the private header property to the one with the actual API.
#set_target_properties(${PROJECT_NAME} PROPERTIES PRIVATE_HEADER source/gzz_rlprivate.h)

# For access to standard installation directory variables (CMAKE_INSTALL_xDIR).
include(GNUInstallDirs)

# Set library shared object and API header file to install.
install(TARGETS ${PROJECT_NAME}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

# Create the pkg-config file from the template.
configure_file(source/${PROJECT_NAME}.pc.in ${PROJECT_NAME}.pc @ONLY)

# Set pkg-config file to install.
install(FILES ${CMAKE_BINARY_DIR}/${PROJECT_NAME}.pc
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig
)

# generate postinst file in ${CMAKE_BINARY_DIR} from template                        #
CONFIGURE_FILE("${CMAKE_SOURCE_DIR}/contrib/postinst.in" "postinst" @ONLY IMMEDIATE)


    # generate a DEB when cpack is run
    SET(CPACK_GENERATOR "DEB")
    SET(CPACK_PACKAGE_NAME ${CMAKE_PROJECT_NAME})
    SET(CPACK_PACKAGE_ICON "${CMake_SOURCE_DIR}/images/grizzly.png")
    SET(CPACK_SET_DESTDIR TRUE)
    SET(CPACK_DEBIAN_PACKAGE_MAINTAINER "grizzlysmit@smit.id.au")
    SET(CPACK_PACKAGE_VERSION_MAJOR "0")
    SET(CPACK_PACKAGE_VERSION_MINOR "0")
    SET(CPACK_PACKAGE_VERSION_PATCH "1")
    #include(GNUInstallDirs)
    add_custom_command(OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/changelog.gz"

        COMMAND gzip -cn9 "${CMAKE_CURRENT_SOURCE_DIR}/changelog" ">" "${CMAKE_CURRENT_BINARY_DIR}/changelog.gz"
        WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
        DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/changelog"
        COMMENT "Compressing changelog"
    )

    add_custom_target(changelog ALL DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/changelog.gz")

    install(FILES "${CMAKE_CURRENT_BINARY_DIR}/changelog.gz"
        DESTINATION "${CMAKE_INSTALL_DOCDIR}"
    )
    set(CPACK_DEBIAN_PACKAGE_CONTROL_EXTRA "${CMAKE_CURRENT_BINARY_DIR}/changelog.gz")
    
    SET(CPACK_PACKAGE_DESCRIPTION_FILE "${CMAKE_SOURCE_DIR}/docs/CPack.Description.txt")
    SET(CPACK_RESOURCE_FILE_README "${CMAKE_SOURCE_DIR}/docs/README.md")
    SET(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_SOURCE_DIR}/docs/LICENCE")
    SET(CPACK_DEBIAN_PACKAGE_DEPENDS "libreadline8, libreadline-dev")
    SET(CPACK_PACKAGE_VENDOR "Grizzly")
    # make postinst run after install                                                #
    SET(CPACK_DEBIAN_PACKAGE_CONTROL_EXTRA "${CMAKE_BINARY_DIR}/postinst;")
    
    
    include(CPack)
