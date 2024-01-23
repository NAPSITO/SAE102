pragma Ada_2012;
package body TAD_Pile is

   --------------------
   -- construirePile --
   --------------------

   function construirePile return Type_Pile is
      Nouvelle_pile : Type_Pile;
   begin
         --Nouvelle_pile.nb_elements:=0;
         return Nouvelle_pile;
   end construirePile;

   -------------
   -- estVide --
   -------------

   function estVide (pile : in Type_Pile) return Boolean is
   begin
      return pile.nb_elements = 0;
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

   function empiler (pile : in out Type_Pile; e : in T) return Type_Pile is
   begin
      if pile.nb_elements = TAILLE_MAX then
         raise PILE_PLEINE;
      else
         pile.nb_elements := pile.nb_elements + 1;
         pile.elements(pile.nb_elements) := e;
         return pile;
      end if;
   end empiler;

   -------------
   -- depiler --
   -------------

   function depiler (pile : in out Type_Pile) return Type_Pile is
   begin
      if estVide(pile) then
         raise PILE_VIDE;
      else
         pile.nb_elements:=pile.nb_elements-1;
         return pile;
      end if;
   end depiler;

end TAD_Pile;
