#
# Find the ACE client includes and library
#

# This module defines
# ACE_INCLUDE_DIR, where to find ace.h
# ACE_LIBRARY, where to find the ACE library.
# ACE_FOUND, if false, you cannot build anything that requires ACE

set( ACE_FOUND 0 )

if (NOT ACE_INCLUDE_DIR)
  FIND_PATH( ACE_INCLUDE_DIR
    NAMES
      ace/ACE.h
    PATHS
      /usr/include
      /usr/include/ace
      /usr/local/include
      /usr/local/include/ace
      $ENV{ACE_ROOT}
      $ENV{ACE_ROOT}/ace
      $ENV{ACE_ROOT}/include
      ${CMAKE_SOURCE_DIR}/externals/ace
      ${LIBSDIR}/ace/include
  DOC
    "Specify include-directories that might contain ace.h here."
  )
endif()

if (NOT ACE_LIBRARY)
  FIND_LIBRARY( ACE_LIBRARY
    NAMES
      ace ACE
    PATHS
      /usr/lib
      /usr/lib/ace
      /usr/local/lib
      /usr/local/lib/ace
      /usr/local/ace/lib
      $ENV{ACE_ROOT}/lib
      $ENV{ACE_ROOT}
      ${LIBSDIR}/ace/lib
    DOC "Specify library-locations that might contain the ACE library here."
  )

endif()

if ( ACE_LIBRARY )
  if ( ACE_INCLUDE_DIR )
    if (_ACE_VERSION)
      set(ACE_VERSION "${_ACE_VERSION}")
    else (_ACE_VERSION)
      file(STRINGS "${ACE_INCLUDE_DIR}/ace/Version.h" ACE_VERSION_STR REGEX "^#define ACE_VERSION \".*\"")
      string(REGEX REPLACE "^.*ACE_VERSION \"([0-9].[0-9].[0-9a-z]).*$"
         "\\1" ACE_VERSION "${ACE_VERSION_STR}")
    endif (_ACE_VERSION)

    include(EnsureVersion)
    ENSURE_VERSION( "${ACE_EXPECTED_VERSION}" "${ACE_VERSION}" ACE_FOUND)
    message( STATUS "Minimal ACE version: ${ACE_EXPECTED_VERSION}")
    if (NOT ACE_FOUND)
      message(FATAL_ERROR "AzerothCore needs ACE version ${ACE_EXPECTED_VERSION} but found version ${ACE_VERSION}")
    endif()

    message( STATUS "ACE version found: ${ACE_VERSION}")
    message( STATUS "Found ACE library: ${ACE_LIBRARY}")
    message( STATUS "Found ACE headers: ${ACE_INCLUDE_DIR}")
  else ( ACE_INCLUDE_DIR )
    message(FATAL_ERROR "Could not find ACE headers! Please install ACE libraries and headers")
  endif ( ACE_INCLUDE_DIR )
endif ( ACE_LIBRARY )

mark_as_advanced( ACE_FOUND ACE_LIBRARY ACE_INCLUDE_DIR )
