grammar x86;

prog: 
	line+ EOF;

line: 
        (label ':'  instruction) | (label ':') | instruction ;

instruction: 
	unary_instruction | binary_instruction | ctl_flow_instruction |ret_instruction | push_instruction | nop_instruction;

unary_instruction: 
	unary_mnem reg_mem;

binary_instruction: 
	binary_mnem  two_operands;

ctl_flow_instruction:
	ctl_flow_mnem (reg_mem_imm_32 | label);

ret_instruction:
	'ret'  imm16?;

push_instruction:
	'push' reg_mem_16 | 'push' reg_mem_imm_32; 

nop_instruction:
	'nop';

unary_mnem: 
	'neg' | 'not' | 'div' | 'inc' | 'dec' | 'mul' | 'pop';

binary_mnem: 
	'add' | 'mov' | 'sub' | 'or' | 'and' | 'xor' | 'cmp' | 'test';

ctl_flow_mnem:
	'call' | 'jmp' | 'jne' | 'je' | 'jz';

reg_mem:
	reg_mem_8 | reg_mem_16 | reg_mem_32;

reg_mem_8:
	reg8 | mem8;
	
reg_mem_16:	
	reg16 |	mem16;

reg_mem_32:	
	reg32 |	mem32;	

two_operands:
	(reg8 COMMA reg_mem_imm_8) | (mem8 COMMA reg_imm_8) | (reg16 COMMA reg_mem_imm_16) | (mem16 COMMA reg_imm_16) |
	(reg32 COMMA reg_mem_imm_32) | (mem32 COMMA reg_imm_32); 

reg_mem_imm_8:
	reg_mem_8 | imm8;

reg_imm_8:
	reg8 | imm8;

reg_mem_imm_16:
	reg_mem_16 | imm16;

reg_imm_16:
	reg16 |imm16;

reg_mem_imm_32:
	imm32 | reg_mem_32;

reg_imm_32:
	imm32 | reg32;


digits:
	DIGIT;

imm8:
	 digits8 'h' | '0x' digits8;

digits8:
	(HEX HEX) | HEX;

imm16: 
	digits16 'h' | '0x' digits16;

digits16:
	(HEX HEX HEX HEX) | (HEX HEX HEX) | (HEX HEX) | HEX;	

imm32: 
	'0x' digits32 | digits32 'h';

digits32:
	(HEX HEX HEX HEX HEX HEX HEX HEX) | (HEX HEX HEX HEX HEX HEX HEX) | (HEX HEX HEX HEX HEX HEX) | (HEX HEX HEX HEX HEX) | (HEX HEX HEX HEX) | (HEX HEX HEX) | (HEX HEX) | HEX ;

DIGIT:
	'1' | '2' | '4' | '8';

HEX:
	[0-9a-f];

label:
	LABEL;


COMMA: ',';

LABEL: [a-zA-Z]+;



reg8:	'al'|'ah'|'bl'|	'bh'|'cl'|'ch'|	'dl'|'dh';
reg16:  'ax'|'bx'	|'cx'|'dx'|'si'	|'di'|'sp'|'bp'	;
reg32:  'eax'|'ebx'|'ecx'	|'edx'|	'esi'|'edi'|'esp'|'ebp'	;

mem8:
	'byte' 'ptr' '[' memory  ']';

mem16:
	'word' 'ptr' '[' memory ']';


mem32:
	('dword' 'ptr')? '[' memory ']';

memory: 
	reg32 | imm32 | multiplication | (reg32 SIGN imm32) | (imm32 SIGN reg32) |  (reg32 SIGN multiplication) | 
	(multiplication  SIGN  reg32) | (imm32 SIGN multiplication) |(multiplication SIGN imm32) |
	(reg32 SIGN multiplication SIGN imm32) | (reg32 SIGN imm32 SIGN multiplication) | (multiplication SIGN reg32 SIGN imm32) |
	(multiplication SIGN imm32 SIGN reg32) | (imm32 SIGN multiplication SIGN reg32) | (imm32 SIGN reg32 SIGN multiplication) ;	

SIGN:
	'+' | '-';


multiplication:
	(reg32 ASTERICS DIGIT) | (DIGIT ASTERICS reg32); 

ASTERICS:
	'*';



WS : [ \t\r\n]+ -> skip ;

