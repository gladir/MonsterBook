Unit MBIdent;

INTERFACE

Procedure EditIdentification;

IMPLEMENTATION

Uses Registry,Systems,Systex,Restex,Dialex,DialPlus;

Procedure EditIdentification;
Var
 Form:Record
  Society:String;
  UserName:String;
  Address:String;
  City:String;
  Region:String;
  IDCountry:Word;
  PostalCode:String;
  Email:String;
 End;
 Q:RegistryObject;
Begin
 FillClr(Form,SizeOf(Form));
 ROOpenMain(Q);
 _ROReadKey(Q,HKEY_CURRENT_USER,'Registration','Society',Form.Society,False);
 _ROReadKey(Q,HKEY_CURRENT_USER,'Registration','UserName',Form.UserName,False);
 _ROReadKey(Q,HKEY_CURRENT_USER,'Registration','Address',Form.Address,False);
 _ROReadKey(Q,HKEY_CURRENT_USER,'Registration','City',Form.City,False);
 _ROReadKey(Q,HKEY_CURRENT_USER,'Registration','Region',Form.Region,False);
 _ROReadKey(Q,HKEY_CURRENT_USER,'Registration','IDCountry',Form.IDCountry,False);
 _ROReadKey(Q,HKEY_CURRENT_USER,'Registration','PostalCode',Form.PostalCode,False);
 _ROReadKey(Q,HKEY_CURRENT_USER,'Registration','Email',Form.Email,False);
 RODone(Q);
 If Form.UserName=''Then Form.UserName:=StrPas(RegUserName);
 If ExecuteAppDPU(157,Form)Then Begin
  CreateKeyFormat(HKEY_CURRENT_USER,'Registration','Society',tdVarChar,Form.Society);
  CreateKeyFormat(HKEY_CURRENT_USER,'Registration','UserName',tdVarChar,Form.UserName);
  CreateKeyFormat(HKEY_CURRENT_USER,'Registration','Address',tdVarChar,Form.Address);
  CreateKeyFormat(HKEY_CURRENT_USER,'Registration','City',tdVarChar,Form.City);
  CreateKeyFormat(HKEY_CURRENT_USER,'Registration','Region',tdVarChar,Form.Region);
  CreateKeyFormat(HKEY_CURRENT_USER,'Registration','IDCountry',tdWord,Form.IDCountry);
  CreateKeyFormat(HKEY_CURRENT_USER,'Registration','PostalCode',tdVarChar,Form.PostalCode);
  CreateKeyFormat(HKEY_CURRENT_USER,'Registration','Email',tdVarChar,Form.Email);
 End;
End;

END.