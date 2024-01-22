pragma Ada_2012;
package body Pont is

   -------------------
   -- obtenirValeur --
   -------------------

   function obtenirValeur (p : in Type_Pont) return Integer is
   begin
      return Integer(p);
   end obtenirValeur;

   ------------------
   -- estPotentiel --
   ------------------

   function estPotentiel (p : in Type_Pont) return Boolean is
   begin
      if p=POTENTIEL or p=UN then
         return TRUE;
      else
         return FALSE;
      end if;
   end estPotentiel;

   ------------------
   -- EstInstancie --
   ------------------

   function EstInstancie (p : in Type_Pont) return Boolean is
   begin
      if p=UN or p=DEUX then
         return TRUE;
      else
         return FALSE;
      end if;
   end EstInstancie;

   ---------
   -- "=" --
   ---------

   function "=" (p1 : in Type_Pont; p2 : in Type_Pont) return Boolean is
   begin
      if obtenirValeur(p1)=obtenirValeur(p2) then
         return TRUE;
      else
         return FALSE;
      end if;
   end "=";

end Pont;
