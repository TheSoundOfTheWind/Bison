%output "parser.cc"
%language "c++"
%skeleton "lalr1.cc"
%require "3.0.4"
%defines
%define api.token.constructor
%define api.value.type variant
%define api.token.prefix {TOK_}
%define parse.assert
%locations
%define parse.trace
%define parse.error verbose
%param {driver& drv}

%code requires {
#include <string>
class driver;
}
%code {
#include "driver.hh"
}

%token
 END 0 "end of file"
 ASSIGN ":="
 MINUS "-"
 PLUS "+"
 STAR "*"
 SLASH "/"
 LPAREN "("
 RPAREN ")"
;
%token <std::string> IDENTIFIER "identifier"
%token <int> NUMBER "number"
%type <int> exp
%printer { yyo << $$;} <*>
%start unit
%%

unit: assignments exp { drv.result = $2; };
assignments:
%empty {}
| assignments assignment {};
assignment:
"identifier" ":=" exp { drv.variables[$1] = $3; };
%left "+" "-";
%left "*" "/";
exp:
 "number"
| "identifier" {$$ = drv.variables[$1];}
| exp "+" exp  {$$ = $1 + $3;}
| exp "-" exp  {$$ = $1 - $3;}
| exp "*" exp  {$$ = $1 * $3;}
| exp "/" exp  {$$ = $1 / $3;}
| "(" exp ")"  {$$ = $2;}
%%
void
yy::parser::error (const location_type& l,const std::string& m)
{
    std::cerr << l << ": " << m << '\n';
}