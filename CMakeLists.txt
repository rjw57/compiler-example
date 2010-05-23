# Specify the name of our project and the minimum CMake requirements.
project("compiler" C)
cmake_minimum_required(VERSION 2.6)

# Make use of any extra CMake modules we ship with.
list(APPEND CMAKE_MODULE_PATH
	${CMAKE_SOURCE_DIR}/cmake/vala
)

# Include Vala support.
include(ValaPrecompile)
include(ValaVersion)

# Check Vala is installed.
find_package(Vala)
ensure_vala_version("0.8.0" MINIMUM)

find_package(PkgConfig)

# Check GLib is installed
pkg_check_modules(GLIB REQUIRED glib-2.0)
add_definitions(${GLIB_CFLAGS} ${GLIB_CFLAGS_OTHER})
link_libraries(${GLIB_LIBRARIES})
link_directories(${GLIB_LIBRARY_DIRS})

# Check GObject is installed
pkg_check_modules(GOBJECT REQUIRED gobject-2.0)
add_definitions(${GOBJECT_CFLAGS} ${GOBJECT_CFLAGS_OTHER})
link_libraries(${GOBJECT_LIBRARIES})
link_directories(${GOBJECT_LIBRARY_DIRS})

vala_precompile(HELLOWORLD_C
	"helloworld.vala"
)

add_executable("hello" ${HELLOWORLD_C})

# vim:sw=4:ts=4:autoindent
