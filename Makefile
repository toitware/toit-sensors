# Copyright (C) 2025 Toit contributors
# Use of this source code is governed by a Zero-Clause BSD license that can
# be found in the tests/LICENSE file.

all: test

.PHONY: build/CMakeCache.txt
build/CMakeCache.txt:
	$(MAKE) rebuild-cmake

.PHONY: install-pkgs
install-pkgs: rebuild-cmake
	cmake --build build --target install-pkgs

.PHONY: test
test: install-pkgs rebuild-cmake
	cmake --build build --target check

# We rebuild the cmake file all the time.
# We use "glob" in the cmakefile, and wouldn't otherwise notice if a new
# file (for example a test) was added or removed.
# It takes <1s on Linux to run cmake, so it doesn't hurt to run it frequently.
.PHONY: rebuild-cmake
rebuild-cmake:
	mkdir -p build
	# We need to set a build type, otherwise cmake won't run nicely on Windows.
	# The build-type is otherwise unused.
	cmake -B build -DCMAKE_BUILD_TYPE=Debug
