pragma Ada_2012;
package body Orientation is

   -----------------------
   -- ValeurOrientation --
   -----------------------

   function ValeurOrientation (o : in Type_Orientation) return Integer is
   begin
      return Integer(o);
   end ValeurOrientation;

   ------------------------
   -- orientationInverse --
   ------------------------

   function orientationInverse
     (o : in Type_Orientation) return Type_Orientation
   is
   begin
      if o = NORD then
            return SUD;
         elsif o = SUD then
            return NORD;
         elsif o = EST then
            return OUEST;
         elsif o = OUEST then
            return EST;
         else
            return NORD;
         end if;
   end orientationInverse;

end Orientation;
