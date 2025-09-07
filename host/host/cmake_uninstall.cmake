# This file is a modified version of the one from the www.vtk.org wiki:
# http://www.vtk.org/Wiki/CMake_FAQ#Can_I_do_.22make_uninstall.22_with_CMake.3F
if (NOT EXISTS "/home/soko/usr/src/bladeRF/host/install_manifest.txt")
    message(FATAL_ERROR "Cannot find install manifest: \"/home/soko/usr/src/bladeRF/host/install_manifest.txt\".\nPossible reasons for this include: 'make install' has not yet been run, the build failed and the manifest was not generated, or the manifest has been removed.")
endif(NOT EXISTS "/home/soko/usr/src/bladeRF/host/install_manifest.txt")

file(READ "/home/soko/usr/src/bladeRF/host/install_manifest.txt" files)
string(REGEX REPLACE "\n" ";" files "${files}")

# Remove trailing semi-colon to remove empty list item. This is intended to avoid 
# violating Policy CMP0007 which results in a scary, albeit harmless, warning to the user
string(REGEX REPLACE ";$" "" files "${files}")
list(REVERSE files)

foreach (file ${files})
    message(STATUS "Uninstalling \"$ENV{DESTDIR}${file}\"")
    if (EXISTS "$ENV{DESTDIR}${file}")
        execute_process(
            COMMAND /usr/bin/cmake -E remove "$ENV{DESTDIR}${file}"
            OUTPUT_VARIABLE rm_out
            RESULT_VARIABLE rm_retval
        )
        if(NOT ${rm_retval} EQUAL 0)
            message(FATAL_ERROR "Problem when removing \"$ENV{DESTDIR}${file}\"")
        endif (NOT ${rm_retval} EQUAL 0)
    else (EXISTS "$ENV{DESTDIR}${file}")
        message(STATUS "File \"$ENV{DESTDIR}${file}\" does not exist.")
    endif (EXISTS "$ENV{DESTDIR}${file}")
endforeach(file)
