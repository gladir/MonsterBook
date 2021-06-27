#include "MATHS.H"

#define FALSE   (0==1)
#define TRUE    (!FALSE)
#define FULL    (EOF-1)

#define L_SET   0
#define L_REL   1
#define L_APND  2

// Les d‚finitions pour balancer l'AVL, structures de l'arbre

#define LEFT        0                   // Left pointer is array element 0
#define RIGHT       1                   // Right ptr is array element 1
#define BALANCED    2                   // Balanced is not right nor left
#define EQUAL       2                   // Value returned for equal compare

#define NAMESIZE    40                  // Max Size of Labels
#define OPSIZE      60                  // Max Size of Operand Text
#define COMSIZE     81                  // Max Size of Hex Comment

#define UNKNOWN     0                   // Symbol 'type' values
#define NEAR        1                   // Symbol is a NEAR label
#define FAR         2                   // Symbol is a FAR label
#define BYTE_PTR    3                   // Symbol is a   1 byte quantity
#define WORD_PTR    4                   // Symbol is a   2 byte quantity
#define DWORD_PTR   5                   // Symbol is a   4 byte quantity
#define FWORD_PTR   6                   // Symbol is a   6 byte quantity
#define QWORD_PTR   7                   // Symbol is an  8 byte quantity
#define TBYTE_PTR   8                   // Symbol is a  10 byte quantity

#define LOCAL       0                   /* Symbol 'domain' values */
#define PUBLIC      1

#define ENUMERATED  0                   /* Data record 'type' values */
#define ITERATED    1

#define LOBYTE  0                       /* Fix-up record forms */
#define OFFSET  1
#define BASE    2
#define POINTER 3
#define HIBYTE  4
#define LOADOFF 5

#define SEGMENT     0
#define GROUP       1
#define EXTERNAL    2
#define FRAME       3
#define LOCATION    4
#define TARGET      5
#define NONE        6


#define NORMAL  0                       /* data_check() return values */
#define LABEL   1
#define FIXUP   2
#define BAD     3                       /* Half aligned */

#define REGULAR 0                       /* Regular Intel OMF record types    */
#define LARGER  1                       /* Extended for > 64k segments by MS */

#define EXT_PER_REC     64              /* Easy number of EXT's per segment */

#define NREG    0                       /* Shorthand register notations */
#define AL      1
#define CL      2
#define DL      3
#define BL      4
#define AH      5
#define CH      6
#define DH      7
#define BH      8

#define AX      9                       /* Or EAX, etc. as may arise */
#define CX      10
#define DX      11
#define BX      12
#define SP      13
#define BP      14
#define SI      15
#define DI      16

 // Registre des identificateurs de Segment

#define ES      17
#define CS      18
#define SS      19
#define DS      20
#define FS      21
#define GS      22

#define MAX_SEG_REGS    6

typedef struct node_s NODE_T;
struct node_s {                         /*--- Structure of a tree node ---*/
    short   balance;                    /* Balance of this tree node      */
    NODE_T  *ptr[2];                    /* Left & Right pointers          */
    int     thread[2];                  /* Indicates thread or pointer    */
    void    *data;
};

struct name_s {                         /*--- Structure of NAME list ---*/
    int     index;                      /* Sequentially assigned number */
    char    name[NAMESIZE+1];           /* Name from LNAMES record      */
};
typedef struct name_s NAME_T;

struct seg_s {                              /*--- Structure of SEGMENT list --*/
    int             index;                  /* Sequentially assigned no.      */
    int             name;                   /* Name index for segment name    */
    NAME_T          *class;                 /* Pointer to Name for seg. class */
    Word            length;                 /* Length of segment (incl. dups) */
    int             code;                   /* Flag indicating code segment   */
    int             bit32;                  /* 32 bit segment                 */
    int             new_mode[MAX_SEG_REGS]; /* Frame Mode                     */
    int             new_index[MAX_SEG_REGS];/* Frame Index                    */
    int             prv_mode[MAX_SEG_REGS]; /* Frame Mode                     */
    int             prv_index[MAX_SEG_REGS];/* Frame Index                    */
};
typedef struct seg_s SEG_T;

struct grp_s {                          /*---- Structure of GROUP list ----*/
    int     index;                      /* Sequentially assigned number    */
    int     name;                       /* Name index for group name       */
};
typedef struct grp_s GRP_T;

struct struc_s {                        /*- Structure of STRUC definitions -*/
    char            *form;              /* Form of structure                */
    int             index;              /* Structure number                 */
};
typedef struct struc_s STRUC_T;

struct pub_s {                          /*--- Structure of PUBLICS list ---*/
    int             seg_idx;            /* Publics are kept in segment     */
    DWord   offset;             /*   index and offset order        */
    char            name[NAMESIZE];     /* Name from PUBDEF record         */
    int             type;               /* UNKNOWN,NEAR,FAR,BYTE_PTR,...   */
    int             domain;             /* 0 = Local, 1 = Public           */
    int             scope;              /* TRUE = public, FALSE = local    */
    STRUC_T         *structure;         /* Label before a dup struc record */
};
typedef struct pub_s PUB_T;

struct ext_s {                          /*-- Structure of EXTERNALS list --*/
    int             index;              /* Sequentially assigned number    */
    char            name[NAMESIZE];     /* Name from EXTDEF record         */
    int             type;               /* UNKNOWN,NEAR,FAR,BYTE_PTR,...   */
    int             pos_abs;            /* TRUE = Could be ABS, FALSE = no */
    int             com_ext;            /* 0 = EXTRN, 1 = COMM             */
    int             var_type;           /* Number from COMDEF record       */
    DWord   size;               /* Number of Bytes (For COMMUNAL)  */
    int             used;               /* Ever accessed?                  */
    int             scope;              /* TRUE = public, FALSE = local    */
};
typedef struct ext_s EXT_T;

struct sex_s {                          /*-- Segment/External usage record --*/
    int     seg_index;                  /* Segment being used in             */
    EXT_T   *ext_rec;                   /* External being used               */
};
typedef struct sex_s SEX_T;

struct dat_s {                          /*- Structure of DATA records list -*/
    int             seg_idx;            /* Data records are kept in         */
    DWord   offset;             /*   segment index and offset order */
    int             type;               /* 0 = Enumerated, 1 = Iterated     */
    int             size;               /* Size of data (db,dw,dq, etc.)    */
    long            file_pos;           /* Position stored in .OBJ file     */
    int             length;             /* Length in bytes of .OBJ data     */
    int             extended;           /* 386 type record                  */
    STRUC_T         *structure;         /* Structure for some DUP records   */
};
typedef struct dat_s DAT_T;

struct fix_s {                          /*- Structure for a FIXUPP record -*/
    int             seg_idx;            /* Fixups are kept in segment      */
    DWord           dat_offset;         /*   index, data offset, and       */
    int             offset;             /*   offset order                  */
    int             relate;             /* Self / Segment Relative         */
    int             form;               /* hibyte/lobyte/base/offset/ptr...*/
    int             a_mode;             /* Mode of Frame                   */
    int             a_index;            /* Index of Frame                  */
    int             b_mode;             /* Mode of Target                  */
    int             b_index;            /* Index of Target                 */
    long            displacement;       /* Added to Result of Frame:Target */
    int             extended;           /* 386 type fixup?                 */
    int             word_sized;         /* BASE/OFFSET/LOADOFF             */
};
typedef struct fix_s FIX_T;

struct thread_s { int mode, index; };
typedef struct thread_s THREAD_T;
struct fixer_s { int num_bytes; char *form,*prefix; };
typedef struct fixer_s FIXER_T;

struct hint_s {
    int             seg_idx;    /* Segment for processing           */
    int             hint_type;  /* 0=Code,1=Data(DB)                */
    DWord   offset;     /* Starting position within segment */
    DWord   length;     /* Length of hint                   */
};
typedef struct hint_s HINT_T;


struct inst_s {                                     /*-- Instruction Table --*/
    int     (*rtn)(Byte, char *, int );   /* Rtn to process byte   */
    int     special;                                /* Data to pass to rtnn  */
    char    *text;                                  /* Data to pass to rtn   */
};
typedef struct inst_s INST_T;

 // Utiliser pour stocker les num‚ros de ligne
typedef struct { long hex_offset; Word line_number; } LINE_T;

typedef struct __local_var {
  Word class;           /* variable class */
  char bInfo1;
  char bInfo2;
  Word wInfo1;
  char vname[33];       /* variable name */
  struct __local_var *next;
} LOCAL_VAR;

typedef enum { VT_VAR, VT_ARG } VTYPE;

typedef struct {
  long hex_offset;  /* beginning at this offset in file */
  LOCAL_VAR *head;   /* pointer to list of lcoals */
} SCOPE_T;

#define EDATA   0                       /* Enumerated data type */
#define IDATA   1                       /* Iterated data type */

extern FILE     *o_file;                /* Input file (.OBJ) */
extern long     o_position;             /* Position in file of current data */
extern NODE_T   *line_tree;             /* line numbers        */
extern NODE_T   *loc_scope_tree;        /* scope for locals    */
extern NODE_T   *arg_scope_tree;        /* scope for arguments */
extern NODE_T   *end_scope_tree;        /* end of scope        */
extern NODE_T   *name_tree;             /* Names by index */
extern NODE_T   *segment_tree;          /* Segments by index */
extern NODE_T   *public_tree;           /* Public values by segment/offset */
extern NODE_T   *extern_tree;           /* Externals by index */
extern NODE_T   *sex_tree;              /* External usage by segment */
extern NODE_T   *data_tree;             /* Data records by segment/offset */
extern NODE_T   *struc_tree;            /* Tree of structures */
extern NODE_T   *fix_tree;              /* Fix up records by segment/offset */
extern NODE_T   *hint_tree;             /* Dis-assembly hints */
extern NODE_T   *group_tree;            /* Not Used */
extern NODE_T   *type_tree;             /* Not Used */
extern NODE_T   *block_tree;            /* Not Used */
extern SEG_T    *seg_rec;
extern NODE_T   *pub_node;              /* Next node of public symbol in list */
extern PUB_T    *pub_rec;               /* Next public symbol in list */
extern PUB_T    *last_pub_rec;          /* Last public symbol encountered */
extern NODE_T   *fix_node;              /* Next node of fixup in list */
extern FIX_T    *fix_rec;               /* Next fixup in list */
extern NODE_T   *hint_node;             /* Next node of hint in list */
extern HINT_T   *hint_rec;              /* Next hint in list */
extern SEG_T seg_search;
extern GRP_T grp_search;
extern PUB_T pub_search;
extern FIX_T fix_search;
extern NAME_T name_search;
extern HINT_T hint_search;
extern int label_count;
extern Word code_string;  /* Stringizing Limit in Code */
extern Word data_string;  /* Stringizing Limit in Data */
extern FIXER_T fix_type[];             /* Fixup types                     */
extern INST_T instr[];                /* Dis-assembly routine table      */
extern INST_T ex_instr[];             /* Extra [0F] Dis-assembly rtn tbl */
extern char *esc_inst[];            /* Floating Point opcode table     */
extern char *op_grp[][8];           /* Special Groups of instructions  */
extern int pass;                               /* Pass number for process() */
extern int processor_type_comment_occurred;    /* COMENT record occurred? */
extern int segment;            /* Segment being "process()'d" */
extern DWord inst_offset;        /* Address being "process()'d" */
extern int processor_mode;     /* 86,286,386,etc              */
extern int segment_mode;       /* processor mode for curr seg */
extern int segment_bytes;      /* Segment WORD size           */
extern char *cseg_name;         /* Code segment name             */
extern char *dseg_name;         /* Data segment name             */
extern PUB_T *start_pub;         /* Starting addr public          */
extern int hex_finish;         /* Finish hex comment?           */
extern int tab_offset;         /* Current output tab stop       */
extern int compatibility;      /* Output type                   */
extern int add_labels;         /* Invent new labels?            */
extern int hex_output;         /* Hex output in comments?       */
extern int over_seg;           /* -1 = No overiding segment yet */

int scope_compare(SCOPE_T*, SCOPE_T*);
int linnum_compare(LINE_T *, LINE_T *);
int name_compare(NAME_T *, NAME_T *);
int pub_compare(PUB_T *,PUB_T *);
int seg_compare(SEG_T *,SEG_T *);
int grp_compare(GRP_T *,GRP_T *);
int fix_compare(FIX_T *,FIX_T *);
int dat_compare(DAT_T *,DAT_T *);
int ext_compare(EXT_T *,EXT_T *);
int struc_compare(STRUC_T *,STRUC_T *);
int hint_compare(HINT_T *,HINT_T *);
NODE_T *pub_insert(int,DWord,char *,int,int);
void sex_insert(int,EXT_T *);
void ext_insert(char *,int,int,DWord,Word,int);
void dat_insert(int,DWord,long,int,int,int);
STRUC_T *struc_insert(char *);
void theadr(void);
void lnames(Word);
void grpdef(Word);
void segdef(void);
void pubdef(Word,int);
void extdef(Word,int);
void ledata(Word,int);
void lidata(Word,int);
void linnum(Word);
void fixupp(Word,int);
void coment(Word);
void comdef(Word,int);
void modend(Word,int);
void typdef(Word);
void pubrpt(void);
void extrpt(void);
void print_ext(EXT_T *);
void list_ext(void);
void list_pub(void);
void list_struc(void);
void list_fix(void);
void process(void);
void load_extra(char *,char *);
void init_trees(void);
int size_to_type(int);
int reg_size_to_type(int);
int type_to_size(int);
char *type_to_text(int);
char *size_to_opcode(int,int *);
Byte GetByte(void);
int get_int(void);
Word get_word(void);
DWord get_long(void);
void get_str(int,char *);
int get_name(char *);
int get_index(int *);
void empty_string(int);
int buff_init(int);
int buff_add(int);
void buff_reseek(void);
void buff_empty(void);
int buff_getc(void);
int buff_regetc(void);
void out_label(char *);
void out_labelc(char *);
void out_opcode(char *);
void out_operand(char *);
void out_comment(char *);
void out_endline(void);
void out_newline(void);
void out_directive(char *);
void out_line(char *,char *,char *,char *);
char *out_hexize(DWord,char *,int);
void fmt_error(char *);
NODE_T *new_tree(void *,int);
NODE_T *start(NODE_T *,int);
NODE_T *traverse(NODE_T *, int);
NODE_T *insert(void *,NODE_T *,int(*)(void *, void *));
void *find(void *, NODE_T *, int(*)(),NODE_T**);
char *search(char *,NODE_T *,int(*)());
void *o_malloc(Word);
void tab_seek(int);
int find_member(char *,STRUC_T *,long *);
PUB_T *check_public(int,int,long,char);
void get_target(char *,FIX_T *,int,long,int,int,int,int *,int);
int get_fix(char *,int,int,int,int,int,int *,int);
char *mode_name(int,int);
void adjust_assumes(void);
void abort_assumes(void);
void fix_advance(void);
int decode_fixup(int,int,int,int,int);
int data_check(Word);
void esc_special(char *,char *,int,int);
void inst_init(void);
int stub(Byte,char *,int);
int one_byte(Byte,char *,int);
int two_byte(Byte,char *,int);
int two_ubyte(Byte,char *,int);
int three_byte(Byte,char *,int);
int five_byte(Byte,char *,int);
int one_a(Byte,char *,int);
int two_a(Byte,char *,int);
int three_a(Byte,char *,int);
int in_out(Byte,char *,int);
int string_byte(Byte,char *,int);
int enter(Byte,char *,int);
int two_bcd(Byte,char *,int);
int disp8(Byte,char *,int);
int disp16(Byte,char *,int);
int wait(Byte,char *,int);
int prefix(Byte,char *,int);
int seg_over(Byte,char *,int);
int opsize_over(Byte,char *,int);
int AdrSizeOver(Byte,char *,int);
int mod_reg(Byte,char *,int);
int esc(Byte,char *,int);
int extra(Byte,char *,int);

#define TC (int(*)(void*,void*)) /* *; */
