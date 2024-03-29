CREATE TABLE Calc (
   ID      WORD,
   Mode    WORD,
   Command VARCHAR,
   Params  VARCHAR
);

CREATE INDEX;

INSERT INTO Calc VALUES (    1, 0x8003,'@ABS',                     'N' );
INSERT INTO Calc VALUES (    2, 0x8003, '@ACOS',                    'N' );
INSERT INTO Calc VALUES (  117, 0x8003, '@ACOSH',                   'N' );
INSERT INTO Calc VALUES (  173, 0x8003, '@ACOT',                    'N' );
INSERT INTO Calc VALUES (  159, 0x8003, '@ACOTH',                   'N' );
INSERT INTO Calc VALUES (    3, 0x8003, '@ACTUEL',                  '' );
INSERT INTO Calc VALUES (    4, 0x8003, '@ALEAT',                   '' );
INSERT INTO Calc VALUES (    5, 0x8003, '@AMORANN',                 'NNNN' );
INSERT INTO Calc VALUES (    6, 0x8003, '@AMORDEG',                 'NNNN' );
INSERT INTO Calc VALUES (    7, 0x8003, '@AMORLIN',                 'NNN' );
INSERT INTO Calc VALUES (    8, 0x8003, '@AMORT',                   'NC' );
INSERT INTO Calc VALUES (    9, 0x8003, '@ANNEE',                   'N' );
INSERT INTO Calc VALUES (   10, 0x8003, '@ARRONDI',                 'NN' );
INSERT INTO Calc VALUES (  160, 0x8003, '@ASECH',                   'N' );
INSERT INTO Calc VALUES (   11, 0x8003, '@ASIN',                    'N' );
INSERT INTO Calc VALUES (  126, 0x8003, '@ASINH',                   'N' );
INSERT INTO Calc VALUES (   12, 0x8003, '@ATAN',                    'N' );
INSERT INTO Calc VALUES (   13, 0x8003, '@ATAN2',                   'NN' );
INSERT INTO Calc VALUES (   14, 0x8003, '@AUJOURDHUI',              '' );
INSERT INTO Calc VALUES (   15, 0x8003, '@BCOMPTE',                 'CNC' );
INSERT INTO Calc VALUES (   16, 0x8003, '@BMAX',                    'CNC' );
INSERT INTO Calc VALUES (   17, 0x8003, '@BMIN',                    'CNC' );
INSERT INTO Calc VALUES (   18, 0x8003, '@BMOYENNE',                'CNC' );
INSERT INTO Calc VALUES (   19, 0x8003, '@BSOMME',                  'CNC' );
INSERT INTO Calc VALUES (   20, 0x8003, '@BSTD',                    'CNC' );
INSERT INTO Calc VALUES (   21, 0x8003, '@BSTDS',                   'CNC' );
INSERT INTO Calc VALUES (   22, 0x8003, '@BVAR',                    'CNC' );
INSERT INTO Calc VALUES (   23, 0x8003, '@BVARS',                   'CNC' );
INSERT INTO Calc VALUES (   24, 0x8003, '@C',                       'C' );
INSERT INTO Calc VALUES (   25, 0x8003, '@CAR',                     'N' );
INSERT INTO Calc VALUES (   26, 0x8003, '@CELLINDEX',               'SCNN' );
INSERT INTO Calc VALUES (   27, 0x8003, '@CELL',                    'SC' );
INSERT INTO Calc VALUES (   84, 0x8003, '@CELLPOINTER',             'S' );
INSERT INTO Calc VALUES (   27, 0x8003, '@CELLULE',                 'SC' );
INSERT INTO Calc VALUES (   28, 0x8003, '@CHAINE',                  'NN' );
INSERT INTO Calc VALUES (   25, 0x8003, '@CHAR',                    'N' );
INSERT INTO Calc VALUES (   29, 0x8003, '@CHERCHE',                 'SSN' );
INSERT INTO Calc VALUES (   30, 0x8003, '@CHOIX',                   'NV' );
INSERT INTO Calc VALUES (   30, 0x8003, '@CHOOSE',                  'NV' );
INSERT INTO Calc VALUES (   45, 0x8003, '@CLEAN',                   '' );
INSERT INTO Calc VALUES (   31, 0x8003, '@CODE',                    'S' );
INSERT INTO Calc VALUES (   32, 0x8003, '@COL',                     'C' );
INSERT INTO Calc VALUES (   32, 0x8003, '@COLS',                    'C' );
INSERT INTO Calc VALUES (   33, 0x8003, '@COMPTE',                  'C' );
INSERT INTO Calc VALUES (   34, 0x8003, '@CONSH',                   'NCN' );
INSERT INTO Calc VALUES (   35, 0x8003, '@CONSV',                   'NCN' );
INSERT INTO Calc VALUES (   36, 0x8003, '@COS',                     'N' );
INSERT INTO Calc VALUES (  183, 0x8003, '@COSH',                    'N' );
INSERT INTO Calc VALUES (  187, 0x8003, '@COT',                     'N' );
INSERT INTO Calc VALUES (  162, 0x8003, '@COTH',                    'N' );
INSERT INTO Calc VALUES (   33, 0x8003, '@COUNT',                   'C' );
INSERT INTO Calc VALUES (   42, 0x8003, '@CTERM',                   'NNN' );
INSERT INTO Calc VALUES (  107, 0x8003, '@CURVALUE',                'SS' );
INSERT INTO Calc VALUES (   37, 0x8003, '@DATE',                    'NNN' );
INSERT INTO Calc VALUES (   38, 0x8003, '@DATEVALUE',               'V' );
INSERT INTO Calc VALUES (   38, 0x8003, '@DATVAL',                  'V' );
INSERT INTO Calc VALUES (   18, 0x8003, '@DAVG',                    'CNC' );
INSERT INTO Calc VALUES (   62, 0x8003, '@DAY',                     'N' );
INSERT INTO Calc VALUES (   15, 0x8003, '@DCOUNT',                  'CNC' );
INSERT INTO Calc VALUES (    6, 0x8003, '@DDB',                     'NNNN' );
INSERT INTO Calc VALUES (   39, 0x8003, '@DEBUT',                   'SN' );
INSERT INTO Calc VALUES (   40, 0x8003, '@DEG',                     'N' );
INSERT INTO Calc VALUES (   40, 0x8003, '@DEGREES',                 'N' );
INSERT INTO Calc VALUES (   88, 0x8003, '@DEGTORAD',                'N' );
INSERT INTO Calc VALUES (   19, 0x8003, '@DSUM',                    'CNC' );
INSERT INTO Calc VALUES (   22, 0x8003, '@DVAR',                    'CNC' );
INSERT INTO Calc VALUES (   41, 0x8003, '@DUREE',                   'NNN' );
INSERT INTO Calc VALUES (   42, 0x8003, '@DUREECOMP',               'NNN' );
INSERT INTO Calc VALUES (   43, 0x8003, '@EGAL',                    'SS' );
INSERT INTO Calc VALUES (   44, 0x8003, '@ENT',                     'N' );
INSERT INTO Calc VALUES (   45, 0x8003, '@EPURE',                   'S' );
INSERT INTO Calc VALUES (   46, 0x8003, '@ERR',                     '' );
INSERT INTO Calc VALUES (   47, 0x8003, '@ESTCHAINE',               'V' );
INSERT INTO Calc VALUES (   48, 0x8003, '@ESTERR',                  'V' );
INSERT INTO Calc VALUES (   49, 0x8003, '@ESTND',                   'V' );
INSERT INTO Calc VALUES (   50, 0x8003, '@ESTNUM',                  'V' );
INSERT INTO Calc VALUES (   43, 0x8003, '@EXACT',                   'SS' );
INSERT INTO Calc VALUES (   51, 0x8003, '@EXP',                     'N' );
INSERT INTO Calc VALUES (  171, 0x8003, '@FACT',                    'N' );
INSERT INTO Calc VALUES (  172, 0x8003, '@FACTLN',                  'N' );
INSERT INTO Calc VALUES (   52, 0x8003, '@FALSE',                   '' );
INSERT INTO Calc VALUES (   52, 0x8003, '@FAUX',                    '' );
INSERT INTO Calc VALUES (   53, 0x8003, '@FICHIEREXISTE',           'S' );
INSERT INTO Calc VALUES (   53, 0x8003, '@FILEEXISTS',              'S' );
INSERT INTO Calc VALUES (   54, 0x8003, '@FIN',                     'SN' );
INSERT INTO Calc VALUES (   29, 0x8003, '@FIND',                    'SSN' );
INSERT INTO Calc VALUES (  108, 0x8003, '@FV',                      'NNN' );
INSERT INTO Calc VALUES (  113, 0x8003, '@FVAL',                    'NNNNN' );
INSERT INTO Calc VALUES (   55, 0x8003, '@HEURE',                   'V' );
INSERT INTO Calc VALUES (   56, 0x8003, '@HEURVAL',                 'V' );
INSERT INTO Calc VALUES (   57, 0x8003, '@HEXANUM',                 'S' );
INSERT INTO Calc VALUES (   57, 0x8003, '@HEXTONUM',                'S' );
INSERT INTO Calc VALUES (   34, 0x8003, '@HLOOKUP',                 'NCN' );
INSERT INTO Calc VALUES (   55, 0x8003, '@HOUR',                    'V' );
INSERT INTO Calc VALUES (   93, 0x8003, '@IF',                      'BVV' );
INSERT INTO Calc VALUES (   58, 0x8003, '@INDEX',                   'CNN' );
INSERT INTO Calc VALUES (   44, 0x8003, '@INT',                     'N' );
INSERT INTO Calc VALUES (   59, 0x8003, '@INTERET',                 'NNNNNN' );
INSERT INTO Calc VALUES (   59, 0x8003, '@IPAYMT',                  'NNNNNN' );
INSERT INTO Calc VALUES (  102, 0x8003, '@IRATE',                   'NNNNN' );
INSERT INTO Calc VALUES (    8, 0x8003, '@IRR',                     'NC' );
INSERT INTO Calc VALUES (   60, 0x8003, '@ISAAF',                   'S' );
INSERT INTO Calc VALUES (   61, 0x8003, '@ISAPP',                   'S' );
INSERT INTO Calc VALUES (   48, 0x8003, '@ISERR',                   'V' );
INSERT INTO Calc VALUES (   49, 0x8003, '@ISNA',                    'V' );
INSERT INTO Calc VALUES (   50, 0x8003, '@ISNUMBER',                'V' );
INSERT INTO Calc VALUES (   47, 0x8003, '@ISSTRING',                'V' );
INSERT INTO Calc VALUES (   62, 0x8003, '@JOUR',                    'N' );
INSERT INTO Calc VALUES (   39, 0x8003, '@LEFT',                    'SN' );
INSERT INTO Calc VALUES (   66, 0x8003, '@LENGTH',                  'S' );
INSERT INTO Calc VALUES (   63, 0x8003, '@LIGNES',                  'C' );
INSERT INTO Calc VALUES (   64, 0x8003, '@LN',                      'N' );
INSERT INTO Calc VALUES (   65, 0x8003, '@LOG',                     'N' );
INSERT INTO Calc VALUES (   66, 0x8003, '@LONG',                    'S' );
INSERT INTO Calc VALUES (   73, 0x8003, '@LOWER',                   'S' );
INSERT INTO Calc VALUES (   67, 0x8003, '@MAJUSC',                  'S' );
INSERT INTO Calc VALUES (   68, 0x8003, '@MAX',                     'C' );
INSERT INTO Calc VALUES (  177, 0x8003, '@MEDIAN',                  'C' );
INSERT INTO Calc VALUES (   69, 0x8003, '@MEMAVAIL',                '' );
INSERT INTO Calc VALUES (   69, 0x8003, '@MEMDISPO',                '' );
INSERT INTO Calc VALUES (   70, 0x8003, '@MEMMEMSAVAIL',            '' );
INSERT INTO Calc VALUES (   70, 0x8003, '@MEMMEMSDISPO',            '' );
INSERT INTO Calc VALUES (   71, 0x8003, '@MID',                     'SNN' );
INSERT INTO Calc VALUES (   71, 0x8003, '@MILIEU',                  'SNN' );
INSERT INTO Calc VALUES (   72, 0x8003, '@MIN',                     'C' );
INSERT INTO Calc VALUES (   73, 0x8003, '@MINUSC',                  'S' );
INSERT INTO Calc VALUES (   74, 0x8003, '@MINUTE',                  'N' );
INSERT INTO Calc VALUES (   75, 0x8003, '@MOD',                     'NN' );
INSERT INTO Calc VALUES (   76, 0x8003, '@MOIS',                    'N' );
INSERT INTO Calc VALUES (   77, 0x8003, '@MOYENNE',                 'C' );
INSERT INTO Calc VALUES (   78, 0x8003, '@N',                       'C' );
INSERT INTO Calc VALUES (   79, 0x8003, '@NA',                      '' );
INSERT INTO Calc VALUES (   79, 0x8003, '@ND',                      '' );
INSERT INTO Calc VALUES (   80, 0x8003, '@NOMPROPRE',               'S' );
INSERT INTO Calc VALUES (    3, 0x8003, '@NOW',                     '' );
INSERT INTO Calc VALUES (   81, 0x8003, '@NPER',                    'NNNNN' );
INSERT INTO Calc VALUES (  109, 0x8003, '@NPV',                     'NCN' );
INSERT INTO Calc VALUES (   82, 0x8003, '@NUMAHEX',                 'S' );
INSERT INTO Calc VALUES (   82, 0x8003, '@NUMTOHEX',                'S' );
INSERT INTO Calc VALUES (   89, 0x8003, '@PAYMT',                   'NNNNN' );
INSERT INTO Calc VALUES (   83, 0x8003, '@PI',                      '' );
INSERT INTO Calc VALUES (   90, 0x8003, '@PMT',                     '' );
INSERT INTO Calc VALUES (   84, 0x8003, '@POINTCELL',               'S' );
INSERT INTO Calc VALUES (   85, 0x8003, '@PPAYMT',                  'NNNNNN' );
INSERT INTO Calc VALUES (   85, 0x8003, '@PRINCIPAL',               'NNNNNN' );
INSERT INTO Calc VALUES (   86, 0x8003, '@PRODSCAL',                'CC' );
INSERT INTO Calc VALUES (   80, 0x8003, '@PROPER',                  'S' );
INSERT INTO Calc VALUES (  105, 0x8003, '@PV',                      'NNN' );
INSERT INTO Calc VALUES (  104, 0x8003, '@PVAL',                    'NNNNN' );
INSERT INTO Calc VALUES (   87, 0x8003, '@RACINE',                  'N' );
INSERT INTO Calc VALUES (   88, 0x8003, '@RAD',                     'N' );
INSERT INTO Calc VALUES (   88, 0x8003, '@RADIANS',                 'N' );
INSERT INTO Calc VALUES (   40, 0x8003, '@RADTODEG',                'N' );
INSERT INTO Calc VALUES (    4, 0x8003, '@RAND',                    '' );
INSERT INTO Calc VALUES (  101, 0x8003, '@RATE',                    'NNN' );
INSERT INTO Calc VALUES (   89, 0x8003, '@REMB',                    'NNNNN' );
INSERT INTO Calc VALUES (   90, 0x8003, '@REMBOUR',                 'NNN' );
INSERT INTO Calc VALUES (   91, 0x8003, '@REPEAT',                  'SN' );
INSERT INTO Calc VALUES (   91, 0x8003, '@REPETE',                  'SN' );
INSERT INTO Calc VALUES (   98, 0x8003, '@REPLACE',                 'SNNS' );
INSERT INTO Calc VALUES (   54, 0x8003, '@RIGHT',                   'SN' );
INSERT INTO Calc VALUES (   10, 0x8003, '@ROUND',                   'N' );
INSERT INTO Calc VALUES (   63, 0x8003, '@ROWS',                    'C' );
INSERT INTO Calc VALUES (   24, 0x8003, '@S',                       'C' );
INSERT INTO Calc VALUES (  185, 0x8003, '@SECH',                    'N' );
INSERT INTO Calc VALUES (   92, 0x8003, '@SECOND',                  'N' );
INSERT INTO Calc VALUES (   92, 0x8003, '@SECONDE',                 'N' );
INSERT INTO Calc VALUES (   93, 0x8003, '@SI',                      'BVV' );
INSERT INTO Calc VALUES (   94, 0x8003, '@SIN',                     'N' );
INSERT INTO Calc VALUES (  184, 0x8003, '@SINH',                    'N' );
INSERT INTO Calc VALUES (    7, 0x8003, '@SLN',                     'NNN' );
INSERT INTO Calc VALUES (   95, 0x8003, '@SOMME',                   'C' );
INSERT INTO Calc VALUES (   87, 0x8003, '@SQRT',                    'N' );
INSERT INTO Calc VALUES (  163, 0x8003, '@STD',                     'C' );
INSERT INTO Calc VALUES (   97, 0x8003, '@STDS',                    'C' );
INSERT INTO Calc VALUES (   28, 0x8003, '@STRING',                  'NN' );
INSERT INTO Calc VALUES (   98, 0x8003, '@SUBSTITUE',               'SNNS' );
INSERT INTO Calc VALUES (   95, 0x8003, '@SUM',                     'C' );
INSERT INTO Calc VALUES (   86, 0x8003, '@SUMPRODUCT',              'CC' );
INSERT INTO Calc VALUES (   99, 0x8003, '@SUPPRESPACE',             'S' );
INSERT INTO Calc VALUES (    5, 0x8003, '@SYD',                     'NNNN' );
INSERT INTO Calc VALUES (  100, 0x8003, '@TAN',                     'N' );
INSERT INTO Calc VALUES (  186, 0x8003, '@TANH',                    'N' );
INSERT INTO Calc VALUES (  101, 0x8003, '@TAUX',                    'NNN' );
INSERT INTO Calc VALUES (  102, 0x8003, '@TAUXINT',                 'NNNNN' );
INSERT INTO Calc VALUES (  103, 0x8003, '@TEMPS',                   'NNN' );
INSERT INTO Calc VALUES (   41, 0x8003, '@TERM',                    'NNN' );
INSERT INTO Calc VALUES (  103, 0x8003, '@TIME',                    'NNN' );
INSERT INTO Calc VALUES (   56, 0x8003, '@TIMEVALUE',               'V' );
INSERT INTO Calc VALUES (   14, 0x8003, '@TODAY',                   '' );
INSERT INTO Calc VALUES (   99, 0x8003, '@TRIM',                    'S' );
INSERT INTO Calc VALUES (  114, 0x8003, '@TRUE',                    '' );
INSERT INTO Calc VALUES (   67, 0x8003, '@UPPER',                   'S' );
INSERT INTO Calc VALUES (  104, 0x8003, '@VACT',                    'NNNNN' );
INSERT INTO Calc VALUES (  105, 0x8003, '@VALACT',                  'NNN' );
INSERT INTO Calc VALUES (  106, 0x8003, '@VALEUR',                  'S' );
INSERT INTO Calc VALUES (  107, 0x8003, '@VALEUROPTION',            'SS' );
INSERT INTO Calc VALUES (  108, 0x8003, '@VALFUT',                  'NNN' );
INSERT INTO Calc VALUES (  106, 0x8003, '@VALUE',                   'S' );
INSERT INTO Calc VALUES (  109, 0x8003, '@VAN',                     'NCN' );
INSERT INTO Calc VALUES (  110, 0x8003, '@VAR',                     'C' );
INSERT INTO Calc VALUES (  111, 0x8003, '@VARS',                    'C' );
INSERT INTO Calc VALUES (  112, 0x8003, '@VERSION',                 '' );
INSERT INTO Calc VALUES (  113, 0x8003, '@VFUT',                    'NNNNN' );
INSERT INTO Calc VALUES (   35, 0x8003, '@VLOOKUP',                 'NCN' );
INSERT INTO Calc VALUES (  114, 0x8003, '@VRAI',                    '' );
INSERT INTO Calc VALUES (    9, 0x8003, '@YEAR',                    'N' );
INSERT INTO Calc VALUES (    1, 0x8300, 'ABS',                      'N' );
INSERT INTO Calc VALUES (  115, 0x8300, 'ACCRINT',                  'NNNNNNN' );
INSERT INTO Calc VALUES (  116, 0x8300, 'ACCRINTM',                 'NNNNN' );
INSERT INTO Calc VALUES (    2, 0x8300, 'ACOS',                     'N' );
INSERT INTO Calc VALUES (  117, 0x8300, 'ACOSH',                    'N' );
INSERT INTO Calc VALUES (  159, 0x8300, 'ACOTH',                    'N' );
INSERT INTO Calc VALUES (  161, 0x8300, 'ACSCH',                    'N' );
INSERT INTO Calc VALUES (  118, 0x8300, 'ADRESSE',                  'NNNBS' );
INSERT INTO Calc VALUES (    4, 0x8300, 'ALEA',                     '' );
INSERT INTO Calc VALUES (  119, 0x8300, 'ALEA.ENTRE.BORNES',        'NN' );
INSERT INTO Calc VALUES (  120, 0x8300, 'AMORDEGRC',                'NNNNNN' );
INSERT INTO Calc VALUES (    7, 0x8300, 'AMORLIN',                  'NNN' );
INSERT INTO Calc VALUES (  121, 0x8300, 'AMORLINC',                 'NNNNNNN' );
INSERT INTO Calc VALUES (  122, 0x8300, 'ANNEE',                    'N' );
INSERT INTO Calc VALUES (   10, 0x8300, 'ARRONDI',                  'NN' );
INSERT INTO Calc VALUES (  123, 0x8300, 'ARRONDI.AU.MULTIPLE',      'NN' );
INSERT INTO Calc VALUES (  124, 0x8300, 'ARRONDI.INF',              'NN' );
INSERT INTO Calc VALUES (  125, 0x8300, 'ARRONDI.SUP',              'NN' );
INSERT INTO Calc VALUES (  160, 0x8300, 'ASECH',                    'N' );
INSERT INTO Calc VALUES (   11, 0x8300, 'ASIN',                     'N' );
INSERT INTO Calc VALUES (  126, 0x8300, 'ASINH',                    'N' );
INSERT INTO Calc VALUES (   12, 0x8300, 'ATAN',                     'N' );
INSERT INTO Calc VALUES (   13, 0x8300, 'ATAN2',                    'NN' );
INSERT INTO Calc VALUES (  127, 0x8300, 'ATANH',                    'N' );
INSERT INTO Calc VALUES (  128, 0x8300, 'AUJOURDHUI',               '' );
INSERT INTO Calc VALUES (  129, 0x8300, 'AVERAGEA',                 'C' );
INSERT INTO Calc VALUES (  130, 0x8300, 'BDECARTYPE',               'CCN' );
INSERT INTO Calc VALUES (  131, 0x8300, 'BDECARTYPEP',              'CCN' );
INSERT INTO Calc VALUES (  132, 0x8300, 'BDLIRE',                   'CCN' );
INSERT INTO Calc VALUES (  133, 0x8300, 'BDMAX',                    'CCN' );
INSERT INTO Calc VALUES (  134, 0x8300, 'BDMIN',                    'CCN' );
INSERT INTO Calc VALUES (  135, 0x8300, 'BDMOYENNE',                'CCN' );
INSERT INTO Calc VALUES (  136, 0x8300, 'BDNB',                     'CCN' );
INSERT INTO Calc VALUES (  137, 0x8300, 'BDNBVAL',                  'CCN' );
INSERT INTO Calc VALUES (  138, 0x8300, 'BDPRODUIT',                'CCN' );
INSERT INTO Calc VALUES (  139, 0x8300, 'BDSOMME',                  'CCN' );
INSERT INTO Calc VALUES (  140, 0x8300, 'BDVAR',                    'CCN' );
INSERT INTO Calc VALUES (  141, 0x8300, 'BDVARP',                   'CCN' );
INSERT INTO Calc VALUES (  141, 0x8300, 'BESSELI',                  'NN' );
INSERT INTO Calc VALUES (  142, 0x8300, 'BESSELJ',                  'NN' );
INSERT INTO Calc VALUES (  143, 0x8300, 'BESSELK',                  'NN' );
INSERT INTO Calc VALUES (  143, 0x8300, 'BESSELY',                  'NN' );
INSERT INTO Calc VALUES (  144, 0x8300, 'BETAINVERSE',              'NN' );
INSERT INTO Calc VALUES (  145, 0x8300, 'BIN2DEC',                  'b' );
INSERT INTO Calc VALUES (  146, 0x8300, 'BIN2HEX',                  'bN' );
INSERT INTO Calc VALUES (  147, 0x8300, 'BIN2OCT',                  'bN' );
INSERT INTO Calc VALUES (  145, 0x8300, 'BINDEC',                   'b' );
INSERT INTO Calc VALUES (  146, 0x8300, 'BINHEX',                   'bN' );
INSERT INTO Calc VALUES (  147, 0x8300, 'BINOCT',                   'bN' );
INSERT INTO Calc VALUES (  148, 0x8300, 'BOITEDIALOGUESOLVEURFINIR','NN' );
INSERT INTO Calc VALUES (  149, 0x8300, 'BOITEDIALOGUESOLVEUROK',   'NNN' );
INSERT INTO Calc VALUES (   25, 0x8300, 'CAR',                      'N' );
INSERT INTO Calc VALUES (   27, 0x8300, 'CELLULE',                  'SC' );
INSERT INTO Calc VALUES (  150, 0x8300, 'CENTILE',                  'CN' );
INSERT INTO Calc VALUES (  150, 0x8300, 'CENTREE.REDUITE',          'NNN' );
INSERT INTO Calc VALUES (   29, 0x8300, 'CHERCHE',                  'SSN' );
INSERT INTO Calc VALUES (  151, 0x8300, 'CHOISIR',                  'NN' );
INSERT INTO Calc VALUES (  152, 0x8300, 'CNOM',                     'S' );
INSERT INTO Calc VALUES (   31, 0x8300, 'CODE',                     'S' );
INSERT INTO Calc VALUES (  153, 0x8300, 'COEFFICIENT.ASYMETRIE',    'NN' );
INSERT INTO Calc VALUES (  154, 0x8300, 'COEFFICIENT.CORRELATION',  'CC' );
INSERT INTO Calc VALUES (  155, 0x8300, 'COEFFICIENT.DETERMINATION','CC' );
INSERT INTO Calc VALUES (  156, 0x8300, 'COLONNE',                  'C' );
INSERT INTO Calc VALUES (  157, 0x8300, 'COLONNES',                 'C' );
INSERT INTO Calc VALUES (  158, 0x8300, 'COMBIN',                   'NN' );
INSERT INTO Calc VALUES (   36, 0x8300, 'COS',                      'N' );
INSERT INTO Calc VALUES (  162, 0x8300, 'COTH',                     'N' );
INSERT INTO Calc VALUES (   40, 0x8300, 'DEGRES',                   'N' );
INSERT INTO Calc VALUES (  192, 0x8200, 'DIMANCHEDEPAQUES',         'N' );
INSERT INTO Calc VALUES (   54, 0x8300, 'DROITE',                   'SN' );
INSERT INTO Calc VALUES (  163, 0x8300, 'ECARTYPEP',                'C' );
INSERT INTO Calc VALUES (  178, 0x8300, 'EST.IMPAIR',               'N' );
INSERT INTO Calc VALUES (  179, 0x8300, 'EST.PAIR',                 'N' );
INSERT INTO Calc VALUES (   43, 0x8300, 'EXACT',                    'SS' );
INSERT INTO Calc VALUES (   52, 0x8300, 'FAUX',                     '' );
INSERT INTO Calc VALUES (   39, 0x8300, 'GAUCHE',                   'SN' );
INSERT INTO Calc VALUES (   55, 0x8300, 'HEURE',                    'V' );
INSERT INTO Calc VALUES (  168, 0x8300, 'INFO',                     'S' );
INSERT INTO Calc VALUES (   59, 0x8300, 'INTPER',                   'NNNNNN' );
INSERT INTO Calc VALUES (  179, 0x8300, 'ISEVEN',                   'N' );
INSERT INTO Calc VALUES (  178, 0x8300, 'ISODD',                    'N' );
INSERT INTO Calc VALUES (  189, 0x8300, 'JOUR',                     'S' );
INSERT INTO Calc VALUES (  188, 0x8300, 'JOURSEM',                  'S' );
INSERT INTO Calc VALUES (  169, 0x8300, 'LIGNE',                    'C' );
INSERT INTO Calc VALUES (   64, 0x8300, 'LN',                       'N' );
INSERT INTO Calc VALUES (  180, 0x8300, 'LNGAMMA',                  'N' );
INSERT INTO Calc VALUES (  170, 0x8300, 'LOG',                      'NN' );
INSERT INTO Calc VALUES (   65, 0x8300, 'LOG10',                    'N' );
INSERT INTO Calc VALUES (  165, 0x8300, 'LOI.BINOMIALE',            'NNNB' );
INSERT INTO Calc VALUES (  182, 0x8300, 'LOI.GAMMA',                'NNNB' );
INSERT INTO Calc VALUES (  181, 0x8300, 'LOI.GAMMA.INVERSE',        'NNN' );
INSERT INTO Calc VALUES (  174, 0x8300, 'LOI.KHIDEUX',              'NN' );
INSERT INTO Calc VALUES (  167, 0x8300, 'LOI.NORMALE.STANDARD',     'N' );
INSERT INTO Calc VALUES (  166, 0x8300, 'LOI.POISSON',              'NNB' );
INSERT INTO Calc VALUES (  175, 0x8300, 'LOI.STUDENT',              'NNN' );
INSERT INTO Calc VALUES (   67, 0x8300, 'MAJUSCULE',                'S' );
INSERT INTO Calc VALUES (   68, 0x8300, 'MAX',                      'C' );
INSERT INTO Calc VALUES (  177, 0x8300, 'MEDIANE',                  'C' );
INSERT INTO Calc VALUES (   72, 0x8300, 'MIN',                      'C' );
INSERT INTO Calc VALUES (   73, 0x8300, 'MINUSCULE',                'S' );
INSERT INTO Calc VALUES (   75, 0x8300, 'MOD',                      'NN' );
INSERT INTO Calc VALUES (  191, 0x8300, 'MOIS',                     'S' );
INSERT INTO Calc VALUES (   77, 0x8300, 'MOYENNE',                  'C' );
INSERT INTO Calc VALUES (   95, 0x8300, 'NB',                       'C' );
INSERT INTO Calc VALUES (   66, 0x8300, 'NBVAL',                    'S' );
INSERT INTO Calc VALUES (   80, 0x8300, 'NOMPROPRE',                'S' );
INSERT INTO Calc VALUES (   83, 0x8300, 'PI',                       '' );
INSERT INTO Calc VALUES (  176, 0x8300, 'PRODUIT',                  'C' );
INSERT INTO Calc VALUES (   87, 0x8300, 'RACINE',                   'N' );
INSERT INTO Calc VALUES (   88, 0x8300, 'RADIANS',                  'N' );
INSERT INTO Calc VALUES (   91, 0x8300, 'REPT',                     'SN' );
INSERT INTO Calc VALUES (   93, 0x8300, 'SI',                       'BVV' );
INSERT INTO Calc VALUES (   94, 0x8300, 'SIN',                      'N' );
INSERT INTO Calc VALUES (   95, 0x8300, 'SOMME',                    'C' );
INSERT INTO Calc VALUES (  190, 0x8300, 'STXT',                     'SNN' );
INSERT INTO Calc VALUES (   99, 0x8300, 'SUPPRESPACE',              'S' );
INSERT INTO Calc VALUES (    5, 0x8300, 'SYD',                      'NNNN' );
INSERT INTO Calc VALUES (  100, 0x8300, 'TAN',                      'N' );
INSERT INTO Calc VALUES (  103, 0x8300, 'TEMPS',                    'NNN' );
INSERT INTO Calc VALUES (   44, 0x8300, 'TRONQUE',                  'N' );
INSERT INTO Calc VALUES (  104, 0x8300, 'VA',                       'NNNNN' );
INSERT INTO Calc VALUES (  109, 0x8300, 'VAN',                      'NCN' );
INSERT INTO Calc VALUES (  164, 0x8300, 'VAR.P',                    'C' );
INSERT INTO Calc VALUES (  113, 0x8300, 'VC',                       'NNNNN' );
INSERT INTO Calc VALUES (  114, 0x8300, 'VRAI',                      '' );
