{
 John Dogget - Version 0.0.5 - Novembre 2007
}

unit API_LiberationProcessus;

interface

uses PsAPI,TLHelp32,Windows,Fenetre_Optimisation,Conversion_TailleFichier;

procedure LibererMemoireProcessus(NomProcessus:string);

implementation

procedure LibererMemoireProcessus(NomProcessus:string);
var
  HandleCaptureProcessus:THandle;
  UnProcessus:TProcessEntry32;
  PIDProcessus:THandle;
  HandleProcessus:THandle;
  MemoireProcessus:TProcessMemoryCounters;
  HandleMemoireProcessus:THandle;
begin
  PIDProcessus:=4294967295;
  // On capture une image de l'ensemble des processus en cours
  HandleCaptureProcessus:=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS,0);
  UnProcessus.dwSize:=SizeOf(TProcessEntry32);
  // On parcours la liste des processus
  Process32First(HandleCaptureProcessus,UnProcessus);
  repeat
    // On a trouvé un procedure dont le nom d'executable correspond
    if UnProcessus.szExeFile=NomProcessus then
    begin
      // On retiens son PID pour plus tard
      PIDProcessus:=UnProcessus.th32ProcessID;
      Break;
    end;
  until not Process32Next(HandleCaptureProcessus,UnProcessus);
  // Aucun processus n'as été trouvé
  if PIDProcessus=4294967295 then
  begin
    if Form1.Pnl_ProcessusActif.Caption='Yes' then
    begin
      Form1.Pnl_ProcessusActif.Caption:='No';
      Form1.Pnl_ConsoMemoire.Caption:='N/A';
      Form1.Pnl_EconomieMemoire.Caption:='N/A';
    end;
    // On oublie pas de liberer le handle avant de quitter
    CloseHandle(HandleCaptureProcessus);
    exit;
  end;
  // Le processus à été trouvé, on lui attribut un handle
  HandleProcessus:=OpenProcess(PROCESS_ALL_ACCESS,False,PIDProcessus);
  // On va chercher la mémoire utilisé par le processus
  GetProcessMemoryInfo(HandleProcessus,@MemoireProcessus,SizeOf(TProcessMemoryCounters));
  Form1.Pnl_ProcessusActif.Caption:='Yes';
  Form1.Pnl_ConsoMemoire.Caption:=ConvertirTaille(MemoireProcessus.WorkingSetSize);
  if OptimisationEnCours then
  begin
    // On libere la mémoire du processus
    EmptyWorkingSet(HandleProcessus);
    Form1.Pnl_EconomieMemoire.Caption:=ConvertirTaille(MemoireProcessus.PagefileUsage);
  end
  else
    Form1.Pnl_EconomieMemoire.Caption:='N/A';
  // Ne pas oublier de liberer la mémoire alloué aux handle  
  CloseHandle(HandleCaptureProcessus);
  CloseHandle(HandleProcessus);
end;

end.
