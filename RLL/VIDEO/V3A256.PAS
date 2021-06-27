Unit V3A256;

INTERFACE

{$G+}
{$DEFINE __386__}
{$DEFINE __80386__}
Uses Systex;

{$I HdrVGA.Inc}

IMPLEMENTATION

{$I VGA256.Inc}

Procedure EndDriverVGA256;Assembler;ASM END;

END.