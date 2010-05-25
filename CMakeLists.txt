# Specify the name of our project and the minimum CMake requirements.
project("compiler" C CXX)
cmake_minimum_required(VERSION 2.6)

# Make use of any extra CMake modules we ship with.
list(APPEND CMAKE_MODULE_PATH
	${CMAKE_SOURCE_DIR}/cmake/llvm
	${CMAKE_SOURCE_DIR}/cmake/vala
)

# Include Vala support.
include(ValaPrecompile)
include(ValaVersion)
find_package(PkgConfig)

# Check LLVM is installed
find_package(LLVM QUIET REQUIRED COMPONENTS jit native interpreter)
add_definitions(${LLVM_CPP_FLAGS})
link_libraries(${LLVM_LIBRARIES} ${LLVM_LD_FLAGS})
link_directories(${LLVM_LIBRARY_DIRS})
include_directories(${LLVM_INCLUDE_DIRS})

# Check Vala is installed.
find_package(Vala)
ensure_vala_version("0.8.0" MINIMUM)

# Check GLib is installed
pkg_check_modules(GLIB REQUIRED glib-2.0)
add_definitions(${GLIB_CFLAGS} ${GLIB_CFLAGS_OTHER})
link_libraries(${GLIB_LIBRARIES})
link_directories(${GLIB_LIBRARY_DIRS})
include_directories(${GLIB_INCLUDE_DIRS})

# Check GObject is installed
pkg_check_modules(GOBJECT REQUIRED gobject-2.0)
add_definitions(${GOBJECT_CFLAGS} ${GOBJECT_CFLAGS_OTHER})
link_libraries(${GOBJECT_LIBRARIES})
link_directories(${GOBJECT_LIBRARY_DIRS})
include_directories(${GOBJECT_INCLUDE_DIRS})

# Check libgee is installed
pkg_check_modules(GEE REQUIRED gee-1.0)
add_definitions(${GEE_CFLAGS} ${GEE_CFLAGS_OTHER})
link_libraries(${GEE_LIBRARIES})
link_directories(${GEE_LIBRARY_DIRS})
include_directories(${GEE_INCLUDE_DIRS})

vala_precompile(HELLOWORLD_C
	"helloworld.vala"
CUSTOM_VAPIS
	LLVM.vapi
PACKAGES
	posix
	gee-1.0
)

add_executable("hello" ${HELLOWORLD_C})
set_target_properties("hello" PROPERTIES LINKER_LANGUAGE CXX)

# vim:sw=4:ts=4:autoindent
