Unit D3v400;

INTERFACE

{$G+}
{$DEFINE __386__}
{$DEFINE __80386__}
Uses Systex;

{$I Headr400.Inc}

IMPLEMENTATION

{$I Drv400.Inc}

Procedure EndDriver400;Assembler;ASM END;

END.