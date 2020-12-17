CMAKE_MINIMUM_REQUIRED(VERSION 3.7 FATAL_ERROR)

project(parse LANGUAGES CXX)

find_package(antlr4-runtime REQUIRED)
find_package(antlr4-generator REQUIRED)
find_package(benchmark REQUIRED)

# change to dir location
set(ANTLR4_JAR_LOCATION /usr/local/lib/antlr-4.9-complete.jar)

# generate parser and lexer from one grammar file
antlr4_generate(
    antlrcpptest_parser
    ${CMAKE_CURRENT_LIST_DIR}/x86.g4
    BOTH
    TRUE
    TRUE
    "antlrcpptest"
)

add_executable(
    Parsertest
    main.cpp
    ${ANTLR4_SRC_FILES_antlrcpptest_parser}
    LabelVisitor.cpp
    LabelVisitor.hpp
)

target_link_libraries(Parsertest PRIVATE benchmark::benchmark)

target_include_directories(Parsertest PRIVATE ${PROJECT_BINARY_DIR})
target_include_directories(Parsertest PRIVATE ${ANTLR4_INCLUDE_DIR})
target_include_directories(Parsertest PRIVATE ${ANTLR4_INCLUDE_DIR_antlrcpptest_parser})
target_link_libraries(Parsertest PRIVATE antlr4_shared)
