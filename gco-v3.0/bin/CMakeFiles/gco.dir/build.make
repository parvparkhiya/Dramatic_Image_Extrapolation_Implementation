# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/yogi/Desktop/Computer_Vision/Dramatic_Image_Extrapolation_Implementation/gco-v3.0

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/yogi/Desktop/Computer_Vision/Dramatic_Image_Extrapolation_Implementation/gco-v3.0/bin

# Include any dependencies generated for this target.
include CMakeFiles/gco.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/gco.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/gco.dir/flags.make

CMakeFiles/gco.dir/GCoptimization.cpp.o: CMakeFiles/gco.dir/flags.make
CMakeFiles/gco.dir/GCoptimization.cpp.o: ../GCoptimization.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/yogi/Desktop/Computer_Vision/Dramatic_Image_Extrapolation_Implementation/gco-v3.0/bin/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/gco.dir/GCoptimization.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/gco.dir/GCoptimization.cpp.o -c /home/yogi/Desktop/Computer_Vision/Dramatic_Image_Extrapolation_Implementation/gco-v3.0/GCoptimization.cpp

CMakeFiles/gco.dir/GCoptimization.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/gco.dir/GCoptimization.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/yogi/Desktop/Computer_Vision/Dramatic_Image_Extrapolation_Implementation/gco-v3.0/GCoptimization.cpp > CMakeFiles/gco.dir/GCoptimization.cpp.i

CMakeFiles/gco.dir/GCoptimization.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/gco.dir/GCoptimization.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/yogi/Desktop/Computer_Vision/Dramatic_Image_Extrapolation_Implementation/gco-v3.0/GCoptimization.cpp -o CMakeFiles/gco.dir/GCoptimization.cpp.s

CMakeFiles/gco.dir/GCoptimization.cpp.o.requires:

.PHONY : CMakeFiles/gco.dir/GCoptimization.cpp.o.requires

CMakeFiles/gco.dir/GCoptimization.cpp.o.provides: CMakeFiles/gco.dir/GCoptimization.cpp.o.requires
	$(MAKE) -f CMakeFiles/gco.dir/build.make CMakeFiles/gco.dir/GCoptimization.cpp.o.provides.build
.PHONY : CMakeFiles/gco.dir/GCoptimization.cpp.o.provides

CMakeFiles/gco.dir/GCoptimization.cpp.o.provides.build: CMakeFiles/gco.dir/GCoptimization.cpp.o


CMakeFiles/gco.dir/LinkedBlockList.cpp.o: CMakeFiles/gco.dir/flags.make
CMakeFiles/gco.dir/LinkedBlockList.cpp.o: ../LinkedBlockList.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/yogi/Desktop/Computer_Vision/Dramatic_Image_Extrapolation_Implementation/gco-v3.0/bin/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/gco.dir/LinkedBlockList.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/gco.dir/LinkedBlockList.cpp.o -c /home/yogi/Desktop/Computer_Vision/Dramatic_Image_Extrapolation_Implementation/gco-v3.0/LinkedBlockList.cpp

CMakeFiles/gco.dir/LinkedBlockList.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/gco.dir/LinkedBlockList.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/yogi/Desktop/Computer_Vision/Dramatic_Image_Extrapolation_Implementation/gco-v3.0/LinkedBlockList.cpp > CMakeFiles/gco.dir/LinkedBlockList.cpp.i

CMakeFiles/gco.dir/LinkedBlockList.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/gco.dir/LinkedBlockList.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/yogi/Desktop/Computer_Vision/Dramatic_Image_Extrapolation_Implementation/gco-v3.0/LinkedBlockList.cpp -o CMakeFiles/gco.dir/LinkedBlockList.cpp.s

CMakeFiles/gco.dir/LinkedBlockList.cpp.o.requires:

.PHONY : CMakeFiles/gco.dir/LinkedBlockList.cpp.o.requires

CMakeFiles/gco.dir/LinkedBlockList.cpp.o.provides: CMakeFiles/gco.dir/LinkedBlockList.cpp.o.requires
	$(MAKE) -f CMakeFiles/gco.dir/build.make CMakeFiles/gco.dir/LinkedBlockList.cpp.o.provides.build
.PHONY : CMakeFiles/gco.dir/LinkedBlockList.cpp.o.provides

CMakeFiles/gco.dir/LinkedBlockList.cpp.o.provides.build: CMakeFiles/gco.dir/LinkedBlockList.cpp.o


# Object files for target gco
gco_OBJECTS = \
"CMakeFiles/gco.dir/GCoptimization.cpp.o" \
"CMakeFiles/gco.dir/LinkedBlockList.cpp.o"

# External object files for target gco
gco_EXTERNAL_OBJECTS =

libgco.a: CMakeFiles/gco.dir/GCoptimization.cpp.o
libgco.a: CMakeFiles/gco.dir/LinkedBlockList.cpp.o
libgco.a: CMakeFiles/gco.dir/build.make
libgco.a: CMakeFiles/gco.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/yogi/Desktop/Computer_Vision/Dramatic_Image_Extrapolation_Implementation/gco-v3.0/bin/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking CXX static library libgco.a"
	$(CMAKE_COMMAND) -P CMakeFiles/gco.dir/cmake_clean_target.cmake
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/gco.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/gco.dir/build: libgco.a

.PHONY : CMakeFiles/gco.dir/build

CMakeFiles/gco.dir/requires: CMakeFiles/gco.dir/GCoptimization.cpp.o.requires
CMakeFiles/gco.dir/requires: CMakeFiles/gco.dir/LinkedBlockList.cpp.o.requires

.PHONY : CMakeFiles/gco.dir/requires

CMakeFiles/gco.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/gco.dir/cmake_clean.cmake
.PHONY : CMakeFiles/gco.dir/clean

CMakeFiles/gco.dir/depend:
	cd /home/yogi/Desktop/Computer_Vision/Dramatic_Image_Extrapolation_Implementation/gco-v3.0/bin && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/yogi/Desktop/Computer_Vision/Dramatic_Image_Extrapolation_Implementation/gco-v3.0 /home/yogi/Desktop/Computer_Vision/Dramatic_Image_Extrapolation_Implementation/gco-v3.0 /home/yogi/Desktop/Computer_Vision/Dramatic_Image_Extrapolation_Implementation/gco-v3.0/bin /home/yogi/Desktop/Computer_Vision/Dramatic_Image_Extrapolation_Implementation/gco-v3.0/bin /home/yogi/Desktop/Computer_Vision/Dramatic_Image_Extrapolation_Implementation/gco-v3.0/bin/CMakeFiles/gco.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/gco.dir/depend

