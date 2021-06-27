{Truncate.PAS}

{Sample code for the Truncate procedure.}

{ For Windows: }
{ uses WinCrt; }

var
  f: file of Integer;
  i,j: Integer;
begin
  Assign(f,'TEST.INT');
  Rewrite(f);
  for i := 1 to 6 do
    Write(f,i);
  Writeln('File before truncation:');
  Reset(f);
  while not Eof(f) do
  begin
    Read(f,i);
    Writeln(i);
  end;
  Reset(f);
  for i := 1 to 3 do
    Read(f,j); { Read ahead 3 records }
  Truncate(f); { Cut file off here }
  Writeln;
  Writeln('File after truncation:');
  Reset(f);
  while not Eof(f) do
  begin
    Read(f,i);
    Writeln(i);
  end;
  Close(f);
  Erase(f);
end.



