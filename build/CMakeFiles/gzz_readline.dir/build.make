# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.24

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
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
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/grizzlysmit/Projects/C++/gzzReadline

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/grizzlysmit/Projects/C++/gzzReadline/build

# Include any dependencies generated for this target.
include CMakeFiles/gzz_readline.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/gzz_readline.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/gzz_readline.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/gzz_readline.dir/flags.make

CMakeFiles/gzz_readline.dir/source/gzz_rlprivate.c.o: CMakeFiles/gzz_readline.dir/flags.make
CMakeFiles/gzz_readline.dir/source/gzz_rlprivate.c.o: /home/grizzlysmit/Projects/C++/gzzReadline/source/gzz_rlprivate.c
CMakeFiles/gzz_readline.dir/source/gzz_rlprivate.c.o: CMakeFiles/gzz_readline.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/grizzlysmit/Projects/C++/gzzReadline/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/gzz_readline.dir/source/gzz_rlprivate.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/gzz_readline.dir/source/gzz_rlprivate.c.o -MF CMakeFiles/gzz_readline.dir/source/gzz_rlprivate.c.o.d -o CMakeFiles/gzz_readline.dir/source/gzz_rlprivate.c.o -c /home/grizzlysmit/Projects/C++/gzzReadline/source/gzz_rlprivate.c

CMakeFiles/gzz_readline.dir/source/gzz_rlprivate.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/gzz_readline.dir/source/gzz_rlprivate.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/grizzlysmit/Projects/C++/gzzReadline/source/gzz_rlprivate.c > CMakeFiles/gzz_readline.dir/source/gzz_rlprivate.c.i

CMakeFiles/gzz_readline.dir/source/gzz_rlprivate.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/gzz_readline.dir/source/gzz_rlprivate.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/grizzlysmit/Projects/C++/gzzReadline/source/gzz_rlprivate.c -o CMakeFiles/gzz_readline.dir/source/gzz_rlprivate.c.s

CMakeFiles/gzz_readline.dir/source/gzz_readline.c.o: CMakeFiles/gzz_readline.dir/flags.make
CMakeFiles/gzz_readline.dir/source/gzz_readline.c.o: /home/grizzlysmit/Projects/C++/gzzReadline/source/gzz_readline.c
CMakeFiles/gzz_readline.dir/source/gzz_readline.c.o: CMakeFiles/gzz_readline.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/grizzlysmit/Projects/C++/gzzReadline/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/gzz_readline.dir/source/gzz_readline.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/gzz_readline.dir/source/gzz_readline.c.o -MF CMakeFiles/gzz_readline.dir/source/gzz_readline.c.o.d -o CMakeFiles/gzz_readline.dir/source/gzz_readline.c.o -c /home/grizzlysmit/Projects/C++/gzzReadline/source/gzz_readline.c

CMakeFiles/gzz_readline.dir/source/gzz_readline.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/gzz_readline.dir/source/gzz_readline.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/grizzlysmit/Projects/C++/gzzReadline/source/gzz_readline.c > CMakeFiles/gzz_readline.dir/source/gzz_readline.c.i

CMakeFiles/gzz_readline.dir/source/gzz_readline.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/gzz_readline.dir/source/gzz_readline.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/grizzlysmit/Projects/C++/gzzReadline/source/gzz_readline.c -o CMakeFiles/gzz_readline.dir/source/gzz_readline.c.s

# Object files for target gzz_readline
gzz_readline_OBJECTS = \
"CMakeFiles/gzz_readline.dir/source/gzz_rlprivate.c.o" \
"CMakeFiles/gzz_readline.dir/source/gzz_readline.c.o"

# External object files for target gzz_readline
gzz_readline_EXTERNAL_OBJECTS =

libgzz_readline.so.0.0.1: CMakeFiles/gzz_readline.dir/source/gzz_rlprivate.c.o
libgzz_readline.so.0.0.1: CMakeFiles/gzz_readline.dir/source/gzz_readline.c.o
libgzz_readline.so.0.0.1: CMakeFiles/gzz_readline.dir/build.make
libgzz_readline.so.0.0.1: CMakeFiles/gzz_readline.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/grizzlysmit/Projects/C++/gzzReadline/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking C shared library libgzz_readline.so"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/gzz_readline.dir/link.txt --verbose=$(VERBOSE)
	$(CMAKE_COMMAND) -E cmake_symlink_library libgzz_readline.so.0.0.1 libgzz_readline.so.0 libgzz_readline.so

libgzz_readline.so.0: libgzz_readline.so.0.0.1
	@$(CMAKE_COMMAND) -E touch_nocreate libgzz_readline.so.0

libgzz_readline.so: libgzz_readline.so.0.0.1
	@$(CMAKE_COMMAND) -E touch_nocreate libgzz_readline.so

# Rule to build all files generated by this target.
CMakeFiles/gzz_readline.dir/build: libgzz_readline.so
.PHONY : CMakeFiles/gzz_readline.dir/build

CMakeFiles/gzz_readline.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/gzz_readline.dir/cmake_clean.cmake
.PHONY : CMakeFiles/gzz_readline.dir/clean

CMakeFiles/gzz_readline.dir/depend:
	cd /home/grizzlysmit/Projects/C++/gzzReadline/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/grizzlysmit/Projects/C++/gzzReadline /home/grizzlysmit/Projects/C++/gzzReadline /home/grizzlysmit/Projects/C++/gzzReadline/build /home/grizzlysmit/Projects/C++/gzzReadline/build /home/grizzlysmit/Projects/C++/gzzReadline/build/CMakeFiles/gzz_readline.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/gzz_readline.dir/depend
