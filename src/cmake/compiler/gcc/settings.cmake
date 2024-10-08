#
# Copyright (C) 2020+     Project "Sol" <https://gitlab.com/opfesoft/sol>, released under the GNU GPLv2 license: https://gitlab.com/opfesoft/sol/-/blob/master/deps/gpl-2.0.md; you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
# Copyright (C) 2016-2020 AzerothCore <www.azerothcore.org>
# Copyright (C) 2008-2019 TrinityCore <https://www.trinitycore.org/>
#

# Set build-directive (used in core to tell which buildtype we used)
target_compile_definitions(acore-compile-option-interface
  INTERFACE
    -D_BUILD_DIRECTIVE="${CMAKE_BUILD_TYPE}")

target_compile_definitions(acore-compile-option-interface
  INTERFACE
    -DHAVE_SSE2
    -D__SSE2__)
message(STATUS "GCC: SFMT enabled, SSE2 flags forced")

if( WITH_WARNINGS )
  target_compile_options(acore-warning-interface
  INTERFACE
    -W
    -Wall
    -Wextra
    -Winit-self
    -Wfatal-errors)
  message(STATUS "GCC: All warnings enabled")
endif()

if( WITH_COREDEBUG )
  target_compile_options(acore-compile-option-interface
  INTERFACE
    -g3)
  message(STATUS "GCC: Debug-flags set (-g3)")
endif()
