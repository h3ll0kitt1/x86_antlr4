#include "LabelVisitor.hpp"


//check that used labels were defined previously
antlrcpp::Any LabelVisitor::visitProg(antlrcpptest::x86Parser::ProgContext *ctx)
{
    std::unordered_set<std::string> labels_hashtable;

    for (antlrcpptest::x86Parser::LineContext* line: ctx->line())
    {
        if (line->label())
        {
            labels_hashtable.emplace(line->label()->LABEL()->getText());
        }

        if (line->instruction() && line->instruction()->ctl_flow_instruction() && line->instruction()->ctl_flow_instruction()->label())
        {
            std::string addrlabel = line->instruction()->ctl_flow_instruction()->label()->LABEL()->getText();
            if (labels_hashtable.find(addrlabel) == labels_hashtable.end())
            {
                    throw std::runtime_error("Label does not point to any address");
            }
        }
    }

    return {};

}
