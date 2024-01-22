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
     (G : in Type_Grille; C : in Type_CaseHashi; s : out Type_Tab_Successeurs;
      NbPonts : out Integer; NbNoeuds : out Integer) is
      successeurs : Type_Tab_Successeurs;
      PontsPotentiels : Integer := 0;
      NoeudsPotentiels : Integer := 0;

   begin
      NbPonts := 0;
      NbNoeuds := 0;

      if aUnSuivant(G, C, NORD) then
         successeurs.NORD := obtenirSuivant(G, C, NORD);
         if estIleComplete(ObtenirIle(successeurs.NORD)) = False then
            NbNoeuds := NbNoeuds + 1;
         elsif estMer(ObtenirTypeCase(successeurs.NORD)) then
            NbPonts := NbPonts + 1;
         end if;
      else
         successeurs.NORD := (Coordonnee => ConstruireCoordonnees(0, 0), Type_Case => modifierIle(ObtenirValeur(),-1), IleComplete => False, NbPonts => 0);
      end if;

      if aUnSuivant(G, C, SUD) then
         successeurs.SUD := obtenirSuivant(G, C, SUD);
         if estIleComplete(ObtenirIle(successeurs.SUD)) = False then
            NbNoeuds := NbNoeuds + 1;
         elsif estMer(ObtenirTypeCase(successeurs.SUD)) then
            NbPonts := NbPonts + 1;
         end if;
      else
         successeurs.SUD := (Coordonnee => (0, 0), Type_Case => TypeCase.MER, IleComplete => False, NbPonts => 0);
      end if;

      if aUnSuivant(G, C, EST) then
         successeurs.EST := obtenirSuivant(G, C, EST);
         if estIleComplete(ObtenirIle(successeurs.EST)) = False then
            NbNoeuds := NbNoeuds + 1;
         elsif estMer(ObtenirTypeCase(successeurs.EST)) then
            NbPonts := NbPonts + 1;
         end if;
      else
         successeurs.EST := (Coordonnee => (0, 0), Type_Case => TypeCase.MER, IleComplete => False, NbPonts => 0);
      end if;

      if aUnSuivant(G, C, OUEST) then
         successeurs.OUEST := obtenirSuivant(G, C, OUEST);
         if estIleComplete(ObtenirIle(successeurs.OUEST)) then
            NbNoeuds := NbNoeuds + 1;
         elsif estMer(ObtenirTypeCase(successeurs.OUEST)) then
            NbPonts := NbPonts + 1;
         end if;
      else
         successeurs.OUEST := (Coordonnee => (0, 0), Type_Case => TypeCase.MER, IleComplete => False, NbPonts => 0);
      end if;

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
