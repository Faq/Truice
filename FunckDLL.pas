unit FunckDLL;

interface
  uses Registry, Windows;

  function LoadLocales():string; export;
  procedure ShowHourGlassCursor; export;


implementation



procedure ShowHourGlassCursor;
begin
  SetCursor(LoadCursor(0,IDC_WAIT));
end;

function LoadLocales():string;
begin
 with TRegistry.Create do
  try
    RootKey := HKEY_CURRENT_USER;
    if not OpenKey('SOFTWARE\Truice', false) then exit;
    try
     case ReadInteger('Locales') of
      0: result:= '_loc1';
      1: result:= '_loc2';
      2: result:= '_loc3';
      3: result:= '_loc4';
      4: result:= '_loc5';
      5: result:= '_loc6';
      6: result:= '_loc7';
      7: result:= '_loc8';
     end;
   except
      Result:= '_loc1';
    end;
  finally
    free;
  end;
end;

end.
