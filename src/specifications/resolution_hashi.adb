pragma Ada_2012;
package body Resolution_Hashi is

    ---------------------------
   -- rechercherUneIleCible --
   ---------------------------

   procedure rechercherUneIleCible
     (G      : in Type_Grille; C : in Type_CaseHashi; O : in Type_Orientation;
      Trouve :    out Boolean; ile : out Type_CaseHashi)
   is
      caseCourante : Type_CaseHashi; -- case courante
      fini         : Boolean;
      Suivant      : Type_CaseHashi;
      TypeSuivant  : Type_TypeCase;
   begin
      --  initialisations
      fini := False;
      -- recherche du successeur
      caseCourante := C;
      while not fini and aUnSuivant (G, caseCourante, O) loop
         -- enregistrement du suivant
         Suivant     := obtenirSuivant (G, caseCourante, O);
         TypeSuivant := ObtenirTypeCase (Suivant);
         -- si c'est la mer je continue
         if estMer (TypeSuivant) then
            caseCourante := Suivant;
         else
            -- si c'est une ile
            if estIle (TypeSuivant) then
               -- si elle est complete c'est fini
               if estIleComplete (ObtenirIle (Suivant)) then
                  Trouve := False;
                  fini   := True;
               else
                  -- si elle n'est pas complete c'est OK
                  Trouve := True;
                  ile    := Suivant;
                  fini   := True;
               end if;
               -- si c'est un pont
            else
               if estPont (TypeSuivant) then
                  -- s'il est de valeur 2 c'est mort
                  if ObtenirPont (Suivant) = DEUX then
                     Trouve := False;
                     fini   := True;
                     -- il est de valeur 1
                  else
                     -- si son predecesseur est
                     -- de valeur 1 on continue
                     if (estPont (ObtenirTypeCase (caseCourante))
                        and then ObtenirPont (caseCourante) = UN)
                       or (EstIle(ObtenirTypeCase(CaseCourante)))
                     then
                        caseCourante := Suivant;
                     else
                        -- a moins que ce soit un croisement dans ce cas on
                        -- arrete
                        Trouve := False;
                        fini   := True;
                     end if;
                  end if;
               end if;
            end if;
         end if;
      end loop;
      -- N'a pas de suivant
      if not aUnSuivant (G, caseCourante, O) then
         Trouve := False;
      end if;
   end rechercherUneIleCible;

   ----------------------------------
   -- construireTableauSuccesseurs --
   ----------------------------------

    procedure construireTableauSuccesseurs
     (G : in Type_Grille; C : Type_CaseHashi; s : out Type_Tab_Successeurs;
      NbPonts : out Integer; NbNoeuds : out Integer) is
      Successeurs : Type_Tab_Successeurs;
      PontsPotentiels : Integer := 0;
      NoeudsPotentiels : Integer := 0;

   begin
      -- Initialize the number of potential successors
      NbPonts := 0;
      NbNoeuds := 0;

      -- Check the north direction
      if aUnSuivant(G, C, NORD) then
         successeurs.N := obtenirSuivant(G, C, NORD);
         if EstIleIncomplete(successeurs.N) then
            NbNoeuds := NbNoeuds + 1;
         elsif successeurs.N.Type_Case = TypeCase.MER then
            NbPonts := NbPonts + 1;
         end if;
      else
         successeurs.N := (Coordonnee => (0, 0), Type_Case => TypeCase.MER, IleComplete => False, NbPonts => 0);
      end if;

      -- Check the south direction
      if aUnSuivant(G, C, SUD) then
         successeurs.S := obtenirSuivant(G, C, SUD);
         if EstIleIncomplete(successeurs.S) then
            NbNoeuds := NbNoeuds + 1;
         elsif successeurs.S.Type_Case = TypeCase.MER then
            NbPonts := NbPonts + 1;
         end if;
      else
         successeurs.S := (Coordonnee => (0, 0), Type_Case => TypeCase.MER, IleComplete => False, NbPonts => 0);
      end if;

      -- Check the east direction
      if aUnSuivant(G, C, EST) then
         successeurs.E := obtenirSuivant(G, C, EST);
         if EstIleIncomplete(successeurs.E) then
            NbNoeuds := NbNoeuds + 1;
         elsif successeurs.E.Type_Case = TypeCase.MER then
            NbPonts := NbPonts + 1;
         end if;
      else
         successeurs.E := (Coordonnee => (0, 0), Type_Case => TypeCase.MER, IleComplete => False, NbPonts => 0);
      end if;

      -- Check the west direction
      if aUnSuivant(G, C, OUEST) then
         successeurs.W := obtenirSuivant(G, C, OUEST);
         if EstIleIncomplete(successeurs.W) then
            NbNoeuds := NbNoeuds + 1;
         elsif successeurs.W.Type_Case = TypeCase.MER then
            NbPonts := NbPonts + 1;
         end if;
      else
         successeurs.W := (Coordonnee => (0, 0), Type_Case => TypeCase.MER, IleComplete => False, NbPonts => 0);
      end if;

      -- Assign the results to the out parameter
      s := successeurs;
      NbPonts := NbPonts;
      NbNoeuds := NbNoeuds;
   end construireTableauSuccesseurs;


   ------------------------
   -- construireLeChemin --
   ------------------------

   procedure construireLeChemin
     (G     : in out Type_Grille; source : in out Type_CaseHashi;
      cible : in out Type_CaseHashi; pont : in Type_Pont;
      o     : in     Type_Orientation)
   is
   begin
      pragma Compile_Time_Warning
        (Standard.True, "construireLeChemin unimplemented");
      raise Program_Error with "Unimplemented procedure construireLeChemin";
   end construireLeChemin;

   -------------------
   -- ResoudreHashi --
   -------------------

   procedure ResoudreHashi (G : in out Type_Grille; Trouve : out Boolean) is
   begin
      pragma Compile_Time_Warning
        (Standard.True, "ResoudreHashi unimplemented");
      raise Program_Error with "Unimplemented procedure ResoudreHashi";
   end ResoudreHashi;

end Resolution_Hashi;
