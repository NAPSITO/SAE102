-- bibliothèques d'entrée sortie
with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
-- Tests
with tests_TAD_Pile; use tests_TAD_Pile;
with Resolution_Hashi; use Resolution_Hashi;

procedure test_reso is
begin
   ConstruireLeChemin(G : in out Type_Grille; Source : in out Type_CaseHashi;
      Cible : in out Type_CaseHashi; Pont : in Type_Pont;
      O : in Type_Orientation);

end test_reso;
