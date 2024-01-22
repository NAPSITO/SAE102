pragma Ada_2012;
package body Ile is

   -------------------
   -- ConstruireIle --
   -------------------

   function ConstruireIle (v : in Integer) return Type_Ile is
   begin
      if v>0 and v<=8 then
         return (v=>v);
      else
         raise VALEUR_ILE_INVALIDE;
      end if;
    end ConstruireIle;

   -------------------
   -- ObtenirValeur --
   -------------------

   function ObtenirValeur (i : in Type_Ile) return Integer is
   begin
     return i.v;
   end ObtenirValeur;

   --------------------
   -- estIleComplete --
   --------------------

   function estIleComplete (i : in Type_Ile) return Boolean is
   begin
      if i.v=0 then
         return TRUE;
      else
         return FALSE;
      end if;
   end estIleComplete;

   -----------------
   -- modifierIle --
   -----------------

   function modifierIle (i : in Type_Ile; p : in Integer) return Type_Ile is
   begin
     if p = 1 or p = 2 then
         if i.v - p >= 0 then
            return (v => i.v - p);
         else
            raise PONT_IMPOSSIBLE;
         end if;
      else
         raise VALEUR_PONT_INVALIDE;
      end if;
   end modifierIle;

end Ile;
