pragma Ada_2012;
package body TypeCase is

   --------------------
   -- ValeurTypeCase --
   --------------------

   function ValeurTypeCase (t : in Type_TypeCase) return Integer is
   begin
     return Integer(t);
   end ValeurTypeCase;

   ------------
   -- estIle --
   ------------

   function estIle (t : in Type_TypeCase) return Boolean is
   begin
      if t = NOEUD then
         return True;
      else
         return False;
      end if;
   end estIle;

   -------------
   -- estPont --
   -------------

   function estPont (t : in Type_TypeCase) return Boolean is
   begin
      if t = ARETE then
         return True;
      else
         return False;
      end if;
   end estPont;

   ------------
   -- estMer --
   ------------

   function estMer (t : in Type_TypeCase) return Boolean is
   begin
      if t = MER then
         return True;
      else
         return False;
      end if;
   end estMer;

end TypeCase;
