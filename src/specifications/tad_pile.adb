pragma Ada_2012;
package body TAD_Pile is

   --------------------
   -- construirePile --
   --------------------

    function construirePile return Type_Pile is
      Nouvelle_Pile : Type_Pile;
   begin
         --Nouvelle_pile.nb_elements:=0;
         return Nouvelle_pile;
   end construirePile;

   -------------
   -- estVide --
   -------------

   function estVide (pile : in Type_Pile) return Boolean is
   begin
      pragma Compile_Time_Warning (Standard.True, "estVide unimplemented");
      return raise Program_Error with "Unimplemented function estVide";
   end estVide;

   -------------
   -- dernier --
   -------------

   function dernier (pile : in Type_Pile) return T is
   begin
      if estVide(pile) then
         raise PILE_VIDE;
      end if;

      return pile.elements(pile.nb_elements);
   end dernier;

   -------------
   -- empiler --
   -------------

   function empiler (pile : in Type_Pile; e : in T) return Type_Pile is
   begin
      pragma Compile_Time_Warning (Standard.True, "empiler unimplemented");
      return raise Program_Error with "Unimplemented function empiler";
   end empiler;

   -------------
   -- depiler --
   -------------

   function depiler (pile : in Type_Pile) return Type_Pile is
   begin
      pragma Compile_Time_Warning (Standard.True, "depiler unimplemented");
      return raise Program_Error with "Unimplemented function depiler";
   end depiler;

end TAD_Pile;
