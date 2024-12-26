# Copyright (c) 2023.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#
#     * Neither the name of the contributors may be used to endorse or promote products derived
#       from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

# Find package module for PoissonRecon library.
#
# The following variables are set by this module:
#
#   PoissonRecon_FOUND: TRUE if PoissonRecon is found.
#   PoissonRecon: Imported target to link against.
#
# The following variables control the behavior of this module:
#
# PoissonRecon_INCLUDE_DIR_HINTS: List of additional directories in which to
#                                 search for PoissonRecon includes.
# PoissonRecon_LIBRARY_DIR_HINTS: List of additional directories in which to
#                                 search for PoissonRecon libraries.

set(PoissonRecon_INCLUDE_DIR_HINTS "" CACHE PATH "PoissonRecon include directory")
set(PoissonRecon_LIBRARY_DIR_HINTS "" CACHE PATH "PoissonRecon library directory")

unset(PoissonRecon_FOUND)
unset(PoissonRecon_INCLUDE_DIRS)
unset(PoissonRecon_LIBRARIES)

list(APPEND PoissonRecon_CHECK_INCLUDE_DIRS
    ${PoissonRecon_INCLUDE_DIR_HINTS}
    /usr/include
    /usr/local/include
    /opt/include
    /opt/local/include
)

list(APPEND PoissonRecon_CHECK_LIBRARY_DIRS
    ${PoissonRecon_LIBRARY_DIR_HINTS}
    /usr/lib
    /usr/local/lib
    /opt/lib
    /opt/local/lib
)

find_path(PoissonRecon_INCLUDE_DIRS
    NAMES
    PoissonRecon/FEMTree.h
    PATHS
    ${PoissonRecon_CHECK_INCLUDE_DIRS})
find_library(PoissonRecon_LIBRARIES
    NAMES
    PoissonRecon
    PATHS
    ${PoissonRecon_CHECK_LIBRARY_DIRS})

if(PoissonRecon_INCLUDE_DIRS)
    set(PoissonRecon_FOUND TRUE)
endif()

if(PoissonRecon_FOUND)
    message(STATUS "Found PoissonRecon")
    message(STATUS "  Includes : ${PoissonRecon_INCLUDE_DIRS}")
    message(STATUS "  Libraries : ${PoissonRecon_LIBRARIES}")
else()
    if(PoissonRecon_FIND_REQUIRED)
        message(FATAL_ERROR "Could not find PoissonRecon")
    endif()
endif()

add_library(PoissonRecon INTERFACE IMPORTED)
target_include_directories(
    PoissonRecon INTERFACE ${PoissonRecon_INCLUDE_DIRS})
target_link_libraries(
    PoissonRecon INTERFACE ${PoissonRecon_LIBRARIES})
