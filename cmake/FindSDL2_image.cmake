# FindSDL2_image.cmake
#
# Copyright (c) 2018, Alex Mayfield <alexmax2742@gmail.com>
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of the <organization> nor the
#       names of its contributors may be used to endorse or promote products
#       derived from this software without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# Currently works with the following generators:
# - Unix Makefiles (Linux, MSYS2, Linux MinGW)
# - Ninja (Linux, MSYS2, Linux MinGW)
# - Visual Studio

# Cache variable that allows you to point CMake at a directory containing
# an extracted development library.
set(SDL2_IMAGE_DIR "${SDL2_IMAGE_DIR}" CACHE PATH "Location of SDL2_image library directory")

# Use pkg-config to find library locations in *NIX environments.
find_package(PkgConfig QUIET)
if(PKG_CONFIG_FOUND)
    pkg_search_module(PC_SDL2_IMAGE QUIET SDL2_image)
endif()

# Find the include directory.
if(CMAKE_SIZEOF_VOID_P STREQUAL 8)
    find_path(SDL2_IMAGE_INCLUDE_DIR "SDL_image.h"
        HINTS
        "${SDL2_IMAGE_DIR}/include"
        "${SDL2_IMAGE_DIR}/include/SDL2"
        "${SDL2_IMAGE_DIR}/x86_64-w64-mingw32/include/SDL2"
        ${PC_SDL2_IMAGE_INCLUDE_DIRS})
else()
    find_path(SDL2_IMAGE_INCLUDE_DIR "SDL_image.h"
        HINTS
        "${SDL2_IMAGE_DIR}/include"
        "${SDL2_IMAGE_DIR}/include/SDL2"
        "${SDL2_IMAGE_DIR}/i686-w64-mingw32/include/SDL2"
        ${PC_SDL2_IMAGE_INCLUDE_DIRS})
endif()

# Find the version.  Taken and modified from CMake's FindSDL.cmake.
if(SDL2_IMAGE_INCLUDE_DIR AND EXISTS "${SDL2_IMAGE_INCLUDE_DIR}/SDL_image.h")
    file(STRINGS "${SDL2_IMAGE_INCLUDE_DIR}/SDL_image.h" SDL2_IMAGE_VERSION_MAJOR_LINE REGEX "^#define[ \t]+SDL_IMAGE_MAJOR_VERSION[ \t]+[0-9]+$")
    file(STRINGS "${SDL2_IMAGE_INCLUDE_DIR}/SDL_image.h" SDL2_IMAGE_VERSION_MINOR_LINE REGEX "^#define[ \t]+SDL_IMAGE_MINOR_VERSION[ \t]+[0-9]+$")
    file(STRINGS "${SDL2_IMAGE_INCLUDE_DIR}/SDL_image.h" SDL2_IMAGE_VERSION_PATCH_LINE REGEX "^#define[ \t]+SDL_IMAGE_PATCHLEVEL[ \t]+[0-9]+$")
    string(REGEX REPLACE "^#define[ \t]+SDL_IMAGE_MAJOR_VERSION[ \t]+([0-9]+)$" "\\1" SDL2_IMAGE_VERSION_MAJOR "${SDL2_IMAGE_VERSION_MAJOR_LINE}")
    string(REGEX REPLACE "^#define[ \t]+SDL_IMAGE_MINOR_VERSION[ \t]+([0-9]+)$" "\\1" SDL2_IMAGE_VERSION_MINOR "${SDL2_IMAGE_VERSION_MINOR_LINE}")
    string(REGEX REPLACE "^#define[ \t]+SDL_IMAGE_PATCHLEVEL[ \t]+([0-9]+)$" "\\1" SDL2_IMAGE_VERSION_PATCH "${SDL2_IMAGE_VERSION_PATCH_LINE}")
    set(SDL2_IMAGE_VERSION "${SDL2_IMAGE_VERSION_MAJOR}.${SDL2_IMAGE_VERSION_MINOR}.${SDL2_IMAGE_VERSION_PATCH}")
    unset(SDL2_IMAGE_VERSION_MAJOR_LINE)
    unset(SDL2_IMAGE_VERSION_MINOR_LINE)
    unset(SDL2_IMAGE_VERSION_PATCH_LINE)
    unset(SDL2_IMAGE_VERSION_MAJOR)
    unset(SDL2_IMAGE_VERSION_MINOR)
    unset(SDL2_IMAGE_VERSION_PATCH)
endif()

# Find the library.
if(CMAKE_SIZEOF_VOID_P STREQUAL 8)
    find_library(SDL2_IMAGE_LIBRARY "SDL2_image"
        HINTS
        "${SDL2_IMAGE_DIR}/lib"
        "${SDL2_IMAGE_DIR}/lib/x64"
        "${SDL2_IMAGE_DIR}/x86_64-w64-mingw32/lib"
        ${PC_SDL2_IMAGE_LIBRARY_DIRS})
else()
    find_library(SDL2_IMAGE_LIBRARY "SDL2_image"
        HINTS
        "${SDL2_IMAGE_DIR}/lib"
        "${SDL2_IMAGE_DIR}/lib/x86"
        "${SDL2_IMAGE_DIR}/i686-w64-mingw32/lib"
        ${PC_SDL2_IMAGE_LIBRARY_DIRS})
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(SDL2_image
    FOUND_VAR SDL2_IMAGE_FOUND
    REQUIRED_VARS SDL2_IMAGE_INCLUDE_DIR SDL2_IMAGE_LIBRARY
    VERSION_VAR SDL2_IMAGE_VERSION
)

if(SDL2_IMAGE_FOUND)
    # Imported target.
    add_library(SDL2::image UNKNOWN IMPORTED)
    set_target_properties(SDL2::image PROPERTIES
                          INTERFACE_COMPILE_OPTIONS "${PC_SDL2_IMAGE_CFLAGS_OTHER}"
                          INTERFACE_INCLUDE_DIRECTORIES "${SDL2_IMAGE_INCLUDE_DIR}"
                          INTERFACE_LINK_LIBRARIES SDL2::SDL2
                          IMPORTED_LOCATION "${SDL2_IMAGE_LIBRARY}")

    if(WIN32)
        # On Windows, we need to figure out the location of our library files
        # so we can copy and package them.
        get_filename_component(SDL2_IMAGE_DLL_DIR "${SDL2_IMAGE_LIBRARY}" DIRECTORY)
        if(EXISTS "${SDL2_IMAGE_DLL_DIR}/SDL2_image.dll")
            set(SDL2_IMAGE_DLL_DIR "${SDL2_IMAGE_DLL_DIR}" CACHE INTERNAL "")
        elseif(EXISTS "${SDL2_IMAGE_DLL_DIR}/../bin/SDL2_image.dll")
            get_filename_component(SDL2_IMAGE_DLL_DIR "${SDL2_IMAGE_DLL_DIR}/../bin" REALPATH)
            set(SDL2_IMAGE_DLL_DIR "${SDL2_IMAGE_DLL_DIR}" CACHE INTERNAL "")
        else()
            message(ERROR "Can't find SDL2_image dynamic library directory.")
        endif()
    endif()
endif()
