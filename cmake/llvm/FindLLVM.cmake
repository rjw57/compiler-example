# Find LLVM - Find the LLVM includes and library.

# A macro to run llvm config
macro(_llvm_config _var_name)
	# Firstly, locate the LLVM config executable
	find_program(_llvm_config_exe 
		NAMES llvm-config
		DOC "llvm-config executable location"
	)

	# If no llvm-config executable was found, set the output variable to not
	# found.
	if(NOT _llvm_config_exe)
		set(${_var_name} "${_var_name}-NOTFOUND")
	else(NOT _llvm_config_exe)
		# Otherwise, run llvm-config
		execute_process(
			COMMAND ${_llvm_config_exe} ${ARGN}
			OUTPUT_VARIABLE ${_var_name}
			RESULT_VARIABLE _llvm_config_retval
			OUTPUT_STRIP_TRAILING_WHITESPACE
		)
		if(RESULT_VARIABLE)
			message(SEND_ERROR
				"Error running llvm-config with arguments: ${ARGN}")
		endif(RESULT_VARIABLE)
	endif(NOT _llvm_config_exe)
endmacro(_llvm_config)

set(_llvm_components jit interpreter native)

_llvm_config(LLVM_C_FLAGS --cflags ${_llvm_components})
_llvm_config(LLVM_CXX_FLAGS --cxxflags ${_llvm_components})
_llvm_config(LLVM_CPP_FLAGS --cppflags ${_llvm_components})
_llvm_config(LLVM_LIBRARY_DIRS --libdir ${_llvm_components})
_llvm_config(LLVM_INCLUDE_DIRS --includedir ${_llvm_components})
_llvm_config(LLVM_LIBRARIES --libs ${_llvm_components})

# handle the QUIETLY and REQUIRED arguments and set LLVM_FOUND to TRUE if 
# all listed variables are TRUE
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LLVM
	DEFAULT_MSG LLVM_INCLUDE_DIRS LLVM_LIBRARY_DIRS)

# vim:sw=4:ts=4:autoindent
