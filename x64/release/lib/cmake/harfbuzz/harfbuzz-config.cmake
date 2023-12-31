set(_harfbuzz_libdir "C:/gtk-build/gtk/x64/release/lib")
set(_harfbuzz_includedir "C:/gtk-build/gtk/x64/release/include")

# Extract version information from libtool.
set(_harfbuzz_version_info "60821:0:60821")
string(REPLACE ":" ";" _harfbuzz_version_info "${_harfbuzz_version_info}")
list(GET _harfbuzz_version_info 0
  _harfbuzz_current)
list(GET _harfbuzz_version_info 1
  _harfbuzz_revision)
list(GET _harfbuzz_version_info 2
  _harfbuzz_age)
unset(_harfbuzz_version_info)

if ("" MATCHES "static")
  set(_harfbuzz_lib_prefix "lib")
  set(_harfbuzz_lib_suffix ".a")
else ()
  if (APPLE)
    set(_harfbuzz_lib_prefix "${CMAKE_SHARED_LIBRARY_PREFIX}")
    set(_harfbuzz_lib_suffix ".0${CMAKE_SHARED_LIBRARY_SUFFIX}")
  elseif (UNIX)
    set(_harfbuzz_lib_prefix "${CMAKE_SHARED_LIBRARY_PREFIX}")
    set(_harfbuzz_lib_suffix "${CMAKE_SHARED_LIBRARY_SUFFIX}.0.${_harfbuzz_current}.${_harfbuzz_revision}")
  elseif (WIN32)
    set(_harfbuzz_lib_prefix "${CMAKE_IMPORT_LIBRARY_PREFIX}")
    set(_harfbuzz_lib_suffix "${CMAKE_IMPORT_LIBRARY_SUFFIX}")
  else ()
    # Unsupported.
    set(harfbuzz_FOUND 0)
  endif ()
endif ()

# Add the libraries.
add_library(harfbuzz::harfbuzz SHARED IMPORTED)
set_target_properties(harfbuzz::harfbuzz PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES "${_harfbuzz_includedir}/harfbuzz"
  IMPORTED_LOCATION "${_harfbuzz_libdir}/${_harfbuzz_lib_prefix}harfbuzz${_harfbuzz_lib_suffix}")

add_library(harfbuzz::icu SHARED IMPORTED)
set_target_properties(harfbuzz::icu PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES "${_harfbuzz_includedir}/harfbuzz"
  INTERFACE_LINK_LIBRARIES "harfbuzz::harfbuzz"
  IMPORTED_LOCATION "${_harfbuzz_libdir}/${_harfbuzz_lib_prefix}harfbuzz-icu${_harfbuzz_lib_suffix}")

add_library(harfbuzz::subset SHARED IMPORTED)
set_target_properties(harfbuzz::subset PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES "${_harfbuzz_includedir}/harfbuzz"
  INTERFACE_LINK_LIBRARIES "harfbuzz::harfbuzz"
  IMPORTED_LOCATION "${_harfbuzz_libdir}/${_harfbuzz_lib_prefix}harfbuzz-subset${_harfbuzz_lib_suffix}")

# Only add the gobject library if it was built.
set(_harfbuzz_have_gobject "true")
if (_harfbuzz_have_gobject)
  add_library(harfbuzz::gobject SHARED IMPORTED)
  set_target_properties(harfbuzz::gobject PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "${_harfbuzz_includedir}/harfbuzz"
    INTERFACE_LINK_LIBRARIES "harfbuzz::harfbuzz"
    IMPORTED_LOCATION "${_harfbuzz_libdir}/${_harfbuzz_lib_prefix}harfbuzz-gobject${_harfbuzz_lib_suffix}")
endif ()

# Clean out variables we used in our scope.
unset(_harfbuzz_lib_prefix)
unset(_harfbuzz_lib_suffix)
unset(_harfbuzz_current)
unset(_harfbuzz_revision)
unset(_harfbuzz_age)
unset(_harfbuzz_includedir)
unset(_harfbuzz_libdir)
