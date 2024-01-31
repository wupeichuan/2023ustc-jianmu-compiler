%option noyywrap
%{
/*****************声明和选项设置  begin*****************/
#include <stdio.h>
#include <stdlib.h>

#include "syntax_tree.h"
#include "syntax_analyzer.h"

int lines;
int pos_start=1;
int pos_end=1;

void pass_node(char *text){
     yylval.node = new_syntax_tree_node(text);
}

/*****************声明和选项设置  end*****************/

%}


%%
 /* to do for students */
 /* two cases for you, pass_node will send flex's token to bison */
\+ 	{pos_start = pos_end; pos_end += 1; pass_node(yytext); return ADD;}
\- 	{pos_start = pos_end; pos_end += 1; pass_node(yytext); return SUB;}
\*   {pos_start = pos_end; pos_end += 1; pass_node(yytext); return MUL;}
\/   {pos_start = pos_end; pos_end += 1; pass_node(yytext); return DIV;}
\<   {pos_start = pos_end; pos_end += 1; pass_node(yytext); return LESS;}
"<="   {pos_start = pos_end; pos_end += 2; pass_node(yytext); return ELESS;}
\>   {pos_start = pos_end; pos_end += 1; pass_node(yytext); return MORE;}
">="   {pos_start = pos_end; pos_end += 2; pass_node(yytext); return EMORE;}
"=="   {pos_start = pos_end; pos_end += 2; pass_node(yytext); return LOGEQUAL;}
"!="   {pos_start = pos_end; pos_end += 2; pass_node(yytext); return LOGINEQUAL;}
\=   {pos_start = pos_end; pos_end += 1; pass_node(yytext); return EQUAL;}
\;   {pos_start = pos_end; pos_end += 1; pass_node(yytext); return SEMICOLON;}
\,   {pos_start = pos_end; pos_end += 1; pass_node(yytext); return COMMA;}
\(   {pos_start = pos_end; pos_end += 1; pass_node(yytext); return LPAREN;}
\)   {pos_start = pos_end; pos_end += 1; pass_node(yytext); return RPAREN;}
\[   {pos_start = pos_end; pos_end += 1; pass_node(yytext); return LBRACK;}
\]   {pos_start = pos_end; pos_end += 1; pass_node(yytext); return RBRACK;}
\{   {pos_start = pos_end; pos_end += 1; pass_node(yytext); return LCURL;}
\}   {pos_start = pos_end; pos_end += 1; pass_node(yytext); return RCURL;}

else {pos_start = pos_end; pos_end += 4; pass_node(yytext); return ELSE;}
if {pos_start = pos_end; pos_end += 2; pass_node(yytext); return IF;}
int {pos_start = pos_end; pos_end += 3; pass_node(yytext); return INT;}
return {pos_start = pos_end; pos_end += 6; pass_node(yytext); return RETURN;}
void {pos_start = pos_end; pos_end += 4; pass_node(yytext); return VOID;}
while {pos_start = pos_end; pos_end += 5; pass_node(yytext); return WHILE;}
float {pos_start = pos_end; pos_end += 5; pass_node(yytext); return FLOAT;}

[a-zA-Z]+ {pos_start = pos_end; pos_end += strlen(yytext); pass_node(yytext); return ID;}
[0-9]+ {pos_start = pos_end; pos_end += strlen(yytext); pass_node(yytext); return INTEGER;}
[0-9]+\.|[0-9]*\.[0-9]+ {pos_start = pos_end; pos_end += strlen(yytext); pass_node(yytext); return FLOATPOINT;}
\/\*([^\*]|(\*)*[^\*\/])*(\*)*\*\/ {
     for(int i = 0;i < strlen(yytext);i++)
	{
	    pos_end++;
         if( yytext[i] == '\n' )
         {
          lines += 1;pos_end = 1;
         }
     }
     break;
    
     }
[ \f\n\r\t\v] {pos_start = pos_end;pos_end+=strlen(yytext);}
[\n]+ {pos_start = 1;pos_end = 1;lines+=strlen(yytext);}
. { pos_start = pos_end; pos_end++; return ERROR; } 

 /****请在此补全所有flex的模式与动作  end******/
%%
