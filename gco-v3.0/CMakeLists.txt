project(gco)
cmake_minimum_required(VERSION 2.8)

if (NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Release")
endif()

set (CMAKE_CXX_STANDARD 11)

set(lib_srcs
    GCoptimization.cpp
    GCoptimization.h
    LinkedBlockList.cpp
    LinkedBlockList.h
    block.h
    energy.h
    graph.h
    )

set(example_srcs
    example.cpp)
set(CMAKE_BUILD_TYPE Debug)
set(alpha_exp_srcs alpha_exp.cpp)
set(alpha_exp_final_srcs alpha_exp_final.cpp)

add_library(gco ${lib_srcs})
add_executable(example ${example_srcs})
add_executable(alpha_exp ${alpha_exp_srcs})
add_executable(alpha_exp_final ${alpha_exp_final_srcs})
target_link_libraries(alpha_exp gco)
target_link_libraries(alpha_exp_final gco)
target_link_libraries(example gco)

install(TARGETS gco
        ARCHIVE DESTINATION "${CMAKE_INSTALL_PREFIX}/lib"
        LIBRARY DESTINATION "${CMAKE_INSTALL_PREFIX}/lib"
        COMPONENT library)
install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        DESTINATION "${CMAKE_INSTALL_PREFIX}/include"
        FILES_MATCHING PATTERN "*.h" PATTERN "*.inl")

