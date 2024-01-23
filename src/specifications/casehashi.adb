pragma Ada_2012;
package body CaseHashi is

   --------------------
   -- ConstruireCase --
   --------------------

   function ConstruireCase (C : in Type_Coordonnee) return Type_CaseHashi is
      TCH: Type_CaseHashi;
   begin
      TCH.C := C;
      TCH.T := MER;
      return TCH;
   end ConstruireCase;

   ---------------------
   -- ObtenirTypeCase --
   ---------------------

   function ObtenirTypeCase (C : in Type_CaseHashi) return Type_TypeCase is
   begin
      return C.T;
   end ObtenirTypeCase;

   -----------------------
   -- ObtenirCoordonnee --
   -----------------------

   function ObtenirCoordonnee (C : in Type_CaseHashi) return Type_Coordonnee is
   begin
      return C.C;
   end ObtenirCoordonnee;

   ----------------
   -- ObtenirIle --
   ----------------

   function ObtenirIle (C : in Type_CaseHashi) return Type_Ile is
   begin
      if estIle(C.T) = False then
         raise TYPE_INCOMPATIBLE;
      end if;
      return C.I;
   end ObtenirIle;

   -----------------
   -- ObtenirPont --
   -----------------

   function ObtenirPont (C : in Type_CaseHashi) return Type_Pont is
   begin
      if EstPont(C.T) = False then
         raise TYPE_INCOMPATIBLE;
      end if;
      return C.P;
   end ObtenirPont;

   -----------------
   -- modifierIle --
   -----------------

   function modifierIle(C : in Type_CaseHashi; I : in Type_Ile) return Type_CaseHashi
   is
      CaseH : Type_CaseHashi;
   begin
      if EstPont(C.T) then
         raise TYPE_INCOMPATIBLE;
      end if;
      CaseH.c := ObtenirCoordonnee(C);
      CaseH.T := NOEUD;
      CaseH.I := I;
      return CaseH;
   end modifierIle;

   ------------------
   -- modifierPont --
   ------------------

   function modifierPont
     (C : in Type_CaseHashi; p : in Type_Pont) return Type_CaseHashi
   is
      NewC : Type_CaseHashi;
   begin
      if EstIle(C.T)  then
         raise TYPE_INCOMPATIBLE;
      end if;
      NewC.c := ObtenirCoordonnee(C);
      NewC.T := ARETE;
      if EstPont(C.T) and then ObtenirPont(C)= UN then
         NewC.p:= DEUX;
      else
         NewC.p := p;
      end if;
      return NewC;
   end modifierPont;


   ---------
   -- "=" --
   ---------

   function "=" (C1 : in Type_CaseHashi; C2 : in Type_CaseHashi) return Boolean
   is
   begin
      if estIle (C1.T) and estIle (C2.T) then
         return ObtenirIle(C1) = ObtenirIle(C2) and ObtenirCoordonnee(C1) = ObtenirCoordonnee(C2);
      elsif estPont(C1.T) and estPont(C2.T) then
         return ObtenirPont(C1) = ObtenirPont(C2) and ObtenirCoordonnee(C1) = ObtenirCoordonnee(C2);
      elsif estMer(C1.T) = estMer(C2.T) then
         return ObtenirCoordonnee(C1) = ObtenirCoordonnee(C2);
      else
         return False;
      end if;
   end "=";

end CaseHashi;
