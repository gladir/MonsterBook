/*
** OBJASM - Utility to create .ASM files out of .OBJ files.
**          Options are:
**
**              -r = Create RASM86 compatible output (.A86 instead of .ASM)
**              -4 = Make compatible with MASM v4.0 (no retf)
**              -a = Add labels for un-named data references
**              -h = Hex output as comments
**              -v = 486 instructions
**             -s# = Minimum string size in data segment
**             -c# = Minimum string size in code segment
**    -f(filename) = Additional information filename (w/paren.)
**
**    Includes 8086/80186/80286/80386/80486
**    and 8087/80287/80387 coprocessor instructions
**    See OBJASM.DOC for a more detailed description.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <alloc.h>
#include "o.h"

				    /*--- Expanded INTEL OMF record types --*/
#define RHEADR  0x6E                /*   R-Module Header Record             */
#define REGINT  0x70                /*   Register Initialization Record     */
#define REDATA  0x72                /*   Relocatable Enumerated Data Record */
#define RIDATA  0x74                /*   Relocatable Iterated Data Record   */
#define OVLDEF  0x76                /*   Overlay Definition Record          */
#define ENDREC  0x78                /*   End Record                         */
#define BLKREC  0x7A                /*   Block Definition Record            */
#define BKLEND  0x7C                /*   Block End Record                   */
#define DEBSYM  0x7E                /*   Debug Symbols Record               */
#define THEADR  0x80                /* x T-Module Header Record             */
#define LHEADR  0x82                /*   L-Module Header Record             */
#define PEDATA  0x84                /*   Physical Enumerated Data (?)       */
#define PIDATA  0x86                /*   Physical Iterated Data (?)         */
#define COMENT  0x88                /* x Comment Record                     */
#define MODEND  0x8A                /* x Module End Record                  */
#define MODENDL 0x8B                /* l Module End Record                  */
#define EXTDEF  0x8C                /* x External Names Definition Record   */
#define TYPDEF  0x8E                /*   Type Definitions Record            */
#define PUBDEF  0x90                /* x Public Names Definition Record     */
#define PUBDEFL 0x91                /* l Public Names Definition Record     */
#define LOCSYM  0x92                /*   Local Symbols Record               */
#define LINNUM  0x94                /*   Line Numbers Record                */
#define LNAMES  0x96                /* x List of Names Record               */
#define SEGDEF  0x98                /* x Segment Definition Record          */
#define SEGDEFL 0x99                /* l Segment Definition Record          */
#define GRPDEF  0x9A                /* x Group Definition Record            */
#define FIXUPP  0x9C                /* x Fix-Up Record                      */
#define FIXUPPL 0x9D                /* l Fix-Up Record                      */
#define LEDATA  0xA0                /* x Logical Enumerated Data            */
#define LEDATAL 0xA1                /* l Logical Enumerated Data            */
#define LIDATA  0xA2                /* x Logical Iterated Data              */
#define LIDATAL 0xA3                /* l Logical Iterated Data              */
#define LIBHED  0xA4                /*   Library Header Record              */
#define LIBNAM  0xA6                /*   Library Module Names Record        */
#define LIBLOC  0xA8                /*   Library Module Locations Record    */
#define LIBDIC  0xAA                /*   Library Dictionary Record          */
#define COMDEF  0xB0                /* m Communal Data Definition Record    */
#define LEXTDEF 0xB4                /* m Local External Definition          */
#define LPUBDEF 0xB6                /* m Local Public Definition            */
#define LPUBDF2 0xB7                /* m Local Public Definition (2nd case?)*/
#define LCOMDEF 0xB8                /* m Local Communal Data Definition     */
#define LIBHDR  0xF0                /* m Library Header Record              */
#define LIBEND  0xF1                /* m Library Trailer Record             */
                                    /* x = Intel OMF used by Microsoft      */
                                    /* m = Microsoft Additions to Intel OMF */
				    /* l = Later extensions by Microsoft    */

int main(int,char *[]);

FILE *o_file;
long o_position;
NODE_T *line_tree,*arg_scope_tree,*loc_scope_tree,*end_scope_tree;
NODE_T *name_tree,*segment_tree,*group_tree,*public_tree,*extern_tree;
NODE_T *sex_tree,*data_tree,*struc_tree,*fix_tree,*hint_tree,*type_tree;
NODE_T *block_tree;SEG_T *seg_rec,seg_search;GRP_T grp_search;
NODE_T *pub_node;PUB_T *pub_rec,*last_pub_rec,pub_search;
NODE_T *hint_node;HINT_T *hint_rec,hint_search;THREAD_T threads[2][4] = {0};
NODE_T *fix_node;FIX_T *fix_rec,fix_search;NAME_T name_search;
int label_count = 0, segment;DWord inst_offset;
int processor_mode = 0,segment_mode,segment_bytes;
char *cseg_name;PUB_T *start_pub = NULL;Word code_string = 40, data_string = 3;
int pass, processor_type_comment_occurred = FALSE,hex_finish,tab_offset = 0;
int compatibility = 0, add_labels = FALSE, hex_output = FALSE;
char extra_filename[65] = {'\0'};

int main(int argc,char *argv[])
{
 char *argp; int name_arg,argi,bad_args; char *fnamep;
 DWord position; int at_eof,rec_type; Word rec_length;
 char temp_name[50],ch; int i486;
 bad_args = FALSE, argi = 1, name_arg = 0, i486 = FALSE;
 while (argi < argc)
 {
  argp = argv[argi];
  if(*argp++ == '-')
  {
   while (*argp)
   {
    switch (*argp)
    {
     case 'a':
      add_labels = TRUE;
      break;
     case '4':
      compatibility = 1;
      break;
     case 'r':
      compatibility = 2;
      break;
     case 'h':
      hex_output = TRUE;
      break;
     case 'v':
      i486 = TRUE;
      break;
     case 'c':
      code_string = atoi(argp+1);
      while ((ch = *(argp+1)) != '\0')
      {
       if(ch < '0' || ch > '9') break;
       argp++;
      }
      break;
      case 's':
       code_string = atoi(argp+1);
       while ((ch = *(argp+1)) != '\0')
       {
	if(ch < '0' || ch > '9') break;
	argp++;
       }
       break;
      case 'f':
       argp++;
       if(*argp != '(')
       {
	bad_args = TRUE;
	break;
       }
       fnamep = extra_filename;
       while ((ch = *(argp+1)) != '\0')
       {
	argp++;
	if(ch == ')')
	{
	 *fnamep = '\0';
	 break;
	}
	*fnamep++ = ch;
       }
       if(ch == '\0') bad_args = TRUE;
       break;
      default:
       bad_args = TRUE;
       break;
    }
    argp++;
   }
  }
   else
  {
   if(name_arg == 0) name_arg = argi; else bad_args = TRUE;
  }
  argi++;
 }
 if(name_arg == 0) bad_args = TRUE;
 if(bad_args)
 {
   fprintf(stderr, "Usage:  %s [-options] [objfilename]\n", argv[0] );
   fprintf(stderr, "where -options are:\n" );
   fprintf(stderr, "           -4 Make MASM 4.0 compatible (no RETF)\n" );
   fprintf(stderr, "           -a Add labels for un-named data references\n");
   fprintf(stderr, "           -h Hex output in comments\n");
   fprintf(stderr, "           -r Make RASM86 compatible\n" );
   fprintf(stderr, "           -v Include 486 instructions\n" );
   fprintf(stderr, "          -c# Minimum string size in a code segment (default=40)\n");
   fprintf(stderr, "          -s# Mimimum string size in a data segment (default=3)\n");
   fprintf(stderr, " -f(filename) Additional information filename (w/paren.)\n");
   fprintf(stderr, "\n" );
   fprintf(stderr, "Additional information file lines:\n");
   fprintf(stderr, "SEG sname CODE                named segment is a code segment\n");
   fprintf(stderr, "SEG sname DATA                named segment is a data segment\n");
   fprintf(stderr, "var=sname:####                creates a local label in segment name\n");
   fprintf(stderr, "sname:####:DB/DW/DD/DF/DQ/DT  directs dis-assembly into data\n");
   fprintf(stderr, "... (for more info, read OBJASM.DOC)\n");
   exit(1);
 }
 switch(compatibility)
 {
   case 0:
    if(i486)
    {
     ex_instr[0x08].text = "invd";
     ex_instr[0x09].text = "wbinvd";
     op_grp[6][7] = "invlpg";
     ex_instr[0xA6].text = "cmpxchg";
     ex_instr[0xA7].text = "cmpxchg";
     ex_instr[0xC0].text = "xadd";
     ex_instr[0xC1].text = "xadd";
     ex_instr[0xC8].text = "bswap";
     ex_instr[0xC9].text = "bswap";
     ex_instr[0xCA].text = "bswap";
     ex_instr[0xCB].text = "bswap";
     ex_instr[0xCC].text = "bswap";
     ex_instr[0xCD].text = "bswap";
     ex_instr[0xCE].text = "bswap";
     ex_instr[0xCF].text = "bswap";
    }
    break;
   case 1:
    instr[0xCB].text = "ret\t; (retf)";
    break;
   case 2:
    instr[0xD7].text = "xlat\tbx";
    instr[0xEB].text = "jmps";
    op_grp[4][5] = "jmpf";
    break;
 }
 strcpy(temp_name,argv[name_arg]);
 if(strchr(temp_name,'.') == NULL) strcat(temp_name,".obj");
 o_file = fopen(temp_name,"rb");
 if(o_file == NULL)
 {
  fprintf(stderr,"%s: Cannot open %s\n",argv[0],temp_name);
  exit(2);
 }
 printf("; OBJASM version 2.0 released on Jan 3, 1991\n");
 init_trees();
 at_eof = FALSE, position = 0;
 while (!at_eof)
 {
  fseek(o_file,position,L_SET);
  rec_type = fgetc(o_file);
  if(rec_type == EOF) at_eof = TRUE;
   else
  {
   rec_length = getw(o_file);
   o_position = position + 3;
   switch(rec_type)
   {
    case THEADR: theadr(); break;
    case LNAMES: lnames(rec_length); break;
    case GRPDEF: grpdef(rec_length); break;
    case SEGDEF: segdef(); break;
    case SEGDEFL: segdef(); break;
    case PUBDEF: pubdef(rec_length,TRUE); break;
    case PUBDEFL: pubdef(rec_length,TRUE); break;
    case LPUBDEF: pubdef(rec_length,FALSE); break;
    case LPUBDF2: pubdef(rec_length,FALSE); break;
    case EXTDEF: extdef(rec_length,TRUE); break;
    case LEXTDEF: extdef(rec_length,FALSE); break;
    case LEDATA: ledata(rec_length,REGULAR); break;
    case LEDATAL: ledata(rec_length,LARGER); break;
    case LIDATA: lidata(rec_length,REGULAR); break;
    case LIDATAL: lidata(rec_length,LARGER); break;
    case FIXUPP: fixupp(rec_length,REGULAR); break;
    case FIXUPPL: fixupp(rec_length,LARGER); break;
    case COMDEF: comdef(rec_length,TRUE); break;
    case LCOMDEF: comdef(rec_length,FALSE); break;
    case MODEND: modend(rec_length,REGULAR); at_eof = TRUE; break;
    case MODENDL: modend( rec_length, LARGER ); at_eof = TRUE; break;
    case TYPDEF: break;
    case COMENT: printf("; [%04X]",position); coment(rec_length); break;
    case LINNUM: linnum(rec_length); break;
    default: printf("Bad record type: [%08lX:%02X:%04X]\n",position,rec_type,rec_length); break;
   }
   position += 3 + rec_length;
  }
 }
 if(strlen(extra_filename) != 0) load_extra(argv[0],extra_filename);
 pass = 1;
 process();
 pass = 2;
 process();
 list_ext();
 list_pub();
 list_struc();
 pass = 3;
 process();
 fclose(o_file);
 return(0);
}
