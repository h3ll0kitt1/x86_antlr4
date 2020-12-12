#include <iostream>
#include <cstring>
#include <bits/stdc++.h>
#include <unordered_set>
#include <benchmark/benchmark.h>

#include "LabelVisitor.hpp"


#include "antlr4-runtime.h"
#include "antlr4_generated_src/antlrcpptest_parser/x86Lexer.h"
#include "antlr4_generated_src/antlrcpptest_parser/x86Listener.h"
#include "antlr4_generated_src/antlrcpptest_parser/x86BaseListener.h"
#include "antlr4_generated_src/antlrcpptest_parser/x86Parser.h"
#include "antlr4_generated_src/antlrcpptest_parser/x86Visitor.h"
#include "antlr4_generated_src/antlrcpptest_parser/x86BaseVisitor.h"

// add some grammar features
// make up check files
// use different sizes of input

void parse_x86(const std::string& filename)
{

    std::ifstream stream (filename, std::ios::in);
    if (!stream.is_open())
        throw std::runtime_error("Failed to open file");
    antlr4::ANTLRInputStream input(stream);
    antlrcpptest::x86Lexer lexer(&input);
    antlr4::CommonTokenStream tokens(&lexer);
    antlrcpptest::x86Parser parser(&tokens);
    antlrcpptest::x86Parser::ProgContext* tree = parser.prog();

    LabelVisitor visitor;
    visitor.visitProg(tree);

}


static void BM_parse_x86(benchmark::State& state)
{
    std::string filename = "input" + std::to_string(state.range(0)) + ".txt";
    for (auto _ : state)
        parse_x86(filename);
}

BENCHMARK(BM_parse_x86)->Arg(0)->Arg(1); //->Arg(2);

BENCHMARK_MAIN();



//int main()
//try
//{
//    {
//        std::string filename = "input.txt";
//        parse_x86(filename);
//        return 0;
//    }
//}
//catch (std::exception &e)
//{
//    std::cerr << "Caught exception: "<< e.what() << std::endl;
//}



