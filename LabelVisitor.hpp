#ifndef LABELVISITOR_HPP
#define LABELVISITOR_HPP

#include "antlr4-runtime.h"
#include "antlr4_generated_src/antlrcpptest_parser/x86BaseVisitor.h"


class  LabelVisitor : antlrcpptest::x86BaseVisitor
{

public:
    antlrcpp::Any visitProg(antlrcpptest::x86Parser::ProgContext *ctx) override;

};


#endif // LABELVISITOR_HPP
