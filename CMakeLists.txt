CMAKE_MINIMUM_REQUIRED( VERSION 3.7 FATAL_ERROR )

project( parse LANGUAGES CXX )

#delete
list( APPEND CMAKE_PREFIX_PATH "/home/user/lib/antlr4/runtime/Cpp/run/lib/cmake/" )

find_package( antlr4-runtime REQUIRED )
find_package( antlr4-generator REQUIRED )
find_package( benchmark REQUIRED )

#change to dir location
set(ANTLR4_JAR_LOCATION /usr/local/lib/antlr-4.9-complete.jar)

# # generate lexer
# antlr4_generate(
#   antlrcpptest_lexer
#   ${CMAKE_CURRENT_SOURCE_DIR}/x86Lexer.g4
#   LEXER
#   FALSE
#   FALSE
#   "antlrcpptest"
#   )

# # generate parser
# antlr4_generate(
#   antlrcpptest_parser
#   ${CMAKE_CURRENT_SOURCE_DIR}/x86Parser.g4
#   PARSER
#   FALSE
#   TRUE
#   "antlrcpptest"
#   "${ANTLR4_TOKEN_FILES_antlrcpptest_lexer}"
#   "${ANTLR4_TOKEN_DIRECTORY_antlrcpptest_lexer}"
#   )


 # generate parser and lexer from one grammar file
antlr4_generate(
   antlrcpptest_parser
   ${CMAKE_CURRENT_SOURCE_DIR}/x86.g4
   BOTH
   TRUE
   TRUE
   "antlrcpptest"
   #"${ANTLR4_TOKEN_FILES_antlrcpptest_lexer}"
   #"${ANTLR4_TOKEN_DIRECTORY_antlrcpptest_lexer}"
   )


include_directories( ${PROJECT_BINARY_DIR} ${ANTLR4_INCLUDE_DIR} ${ANTLR4_INCLUDE_DIR_antlrcpptest_parser} )

#add generated source files
#add_executable( Parsertest main.cpp ${ANTLR4_SRC_FILES_antlrcpptest_lexer} ${ANTLR4_SRC_FILES_antlrcpptest_parser} )

add_executable( Parsertest main.cpp ${ANTLR4_SRC_FILES_antlrcpptest_parser} LabelVisitor.cpp LabelVisitor.hpp )

#add required runtime library
add_dependencies( Parsertest antlr4_shared )

target_link_libraries( Parsertest PRIVATE benchmark::benchmark)
target_link_libraries( Parsertest PRIVATE antlr4_shared )

