{ Cette unit� est utilis� pour fournir des outils de d�veloppements
 pour les Ressources destin� au �MonsterBook� ou �OverCode�.
}

{$I DEF.INC}

Unit ToolRes;

{���������������������������������������������������������������������������}
                                INTERFACE
{���������������������������������������������������������������������������}

Function MakeRLLFile(Path:String;Q:Pointer):Word;

{���������������������������������������������������������������������������}
                              IMPLEMENTATION
{���������������������������������������������������������������������������}

Uses
 Adele,Dialex,Systex,Memories,Systems,Video,Mouse,Dials,Isatex,
 ResTex,ResServD,EdtSearc;

{$I \Source\Chantal\Tools\CRLL.Inc}

{���������������������������������������������������������������������������}
END.