pragma Ada_2012;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use ada.Integer_Text_IO;
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
   -- construireTableauS --
   ----------------------------------

   procedure construireTableauSuccesseurs
     (G : in     Type_Grille; C : in Type_CaseHashi; s : out Type_Tab_Successeurs;
      NbPonts :    out Integer; NbNoeuds : out Integer) is
      PontsPotentiels : Integer := 0;
      NoeudsPotentiels : Integer := 0;

   begin
      NbPonts := 0;
      NbNoeuds := 0;

      if aUnSuivant(G, C, NORD) then
         s.NORD := obtenirSuivant(G, C, NORD);
         if estIleComplete(ObtenirIle(s.NORD)) = False then
            NbNoeuds := NbNoeuds + 1;
         elsif estMer(ObtenirTypeCase(s.NORD)) then
            NbPonts := NbPonts + 1;
         end if;
      else
         s.NORD := ConstruireCase(C => ConstruireCoordonnees(0,0));
      end if;

      if aUnSuivant(G, C, SUD) then
         s.SUD := obtenirSuivant(G, C, SUD);
         if estIleComplete(ObtenirIle(s.SUD)) = False then
            NbNoeuds := NbNoeuds + 1;
         elsif estMer(ObtenirTypeCase(s.SUD)) then
            NbPonts := NbPonts + 1;
         end if;
      else
         s.SUD := ConstruireCase(C => ConstruireCoordonnees(0,0));
      end if;

      if aUnSuivant(G, C, EST) then
         s.EST := obtenirSuivant(G, C, EST);
         if estIleComplete(ObtenirIle(s.EST)) = False then
            NbNoeuds := NbNoeuds + 1;
         elsif estMer(ObtenirTypeCase(s.EST)) then
            NbPonts := NbPonts + 1;
         end if;
      else
         s.EST := ConstruireCase(C => ConstruireCoordonnees(0,0));
      end if;

      if aUnSuivant(G, C, OUEST) then
         s.OUEST := obtenirSuivant(G, C, OUEST);
         if estIleComplete(ObtenirIle(s.OUEST)) then
            NbNoeuds := NbNoeuds + 1;
         elsif estMer(ObtenirTypeCase(s.OUEST)) then
            NbPonts := NbPonts + 1;
         end if;
      else
         s.OUEST := ConstruireCase(C => ConstruireCoordonnees(0,0));
      end if;

      s := s;
      NbPonts := NbPonts;
      NbNoeuds := NbNoeuds;
   end construireTableauSuccesseurs;

   ------------------------
   -- ConvertirEnTypePont --
   ------------------------

   function ConvertirEnTypePont(Valeur : Integer) return Pont.Type_Pont is
   begin
      if Valeur = 0 then
         return Pont.POTENTIEL;
      elsif Valeur = 1 then
         return Pont.UN;
      else
         return Pont.DEUX;
      end if;
   end ConvertirEnTypePont;

   ------------------------
   -- construireLeChemin --
   ------------------------

   procedure construireLeChemin
     (G     : in out Type_Grille; source : in out Type_CaseHashi;
      cible : in out Type_CaseHashi; pont : in Type_Pont;
      o     : in     Type_Orientation)
     --Debug : in     Boolean := True) -- Ajout du paramètre optionnel
   is
      caseActuelle, caseSuivante : Type_CaseHashi;
      ileSource, ileCible : Type_Ile;
      Debug:Boolean:=False;
   begin
      caseActuelle := source;

      while caseActuelle /= cible and aUnSuivant(G, caseActuelle, o) loop
         caseSuivante := obtenirSuivant(G, caseActuelle, o);

         if not estIle(ObtenirTypeCase(caseSuivante)) then
            caseSuivante := modifierPont(caseSuivante, pont);
            G := modifierCase(G, caseSuivante);
         end if;

         caseActuelle := caseSuivante;
      end loop;

      -- Affichage du chemin si l'option de débogage est activée

      if Debug then
         Put_Line("Debug: Chemin construit de ligne "); -- & Type_Coordonnee'Image(ObtenirCoordonnee(source)) &
         --" à " & Type_Coordonnee'Image(ObtenirCoordonnee(cible)));
         Put(ObtenirLigne(ObtenirCoordonnee(source)), 2);
         Put(" à ");
         Put(ObtenirLigne(ObtenirCoordonnee(cible)), 2);
         Put(" et de colonne ");
         Put(ObtenirColonne(ObtenirCoordonnee(source)), 2);
         Put(" à ");
         Put(ObtenirColonne(ObtenirCoordonnee(cible)), 2);
         New_Line;
      end if;

      -- Mise à jour des îles si nécessaire
      Put("Modification valeur île cible et île source :");
      Put(" Source -> ");
      Put(ObtenirValeur(ObtenirIle(source)) - obtenirValeur(pont), 1);
      Put(" Cible -> ");
      Put(ObtenirValeur(ObtenirIle(cible)) - obtenirValeur(pont), 1);
      New_Line;

      if ObtenirValeur(ObtenirIle(cible)) >= obtenirValeur(pont) then
         ileCible := modifierIle(ObtenirIle(cible), obtenirValeur(pont));
         cible := modifierIle(cible, ileCible);
         G:=modifierCase(G, cible);
      end if;
      if ObtenirValeur(ObtenirIle(source)) >= obtenirValeur(pont) then
         ileSource := modifierIle(ObtenirIle(source), obtenirValeur(pont));
         source := modifierIle(source, ileSource);
         G:=modifierCase(G, source);
      end if;
   end construireLeChemin;


   -------------------
   -- ResoudreHashi --
   -------------------

   procedure ResoudreHashi (G : in out Type_Grille; Trouve : out Boolean) is

      caseParcours : Type_CaseHashi;    -- Variables pour parcourir la grille et stocker l'île cible
      --ileTrouveBool : Boolean;                    -- Indicateur pour savoir si une île cible a été trouvée

      procedure RelierIle (caseParcours : in out Type_CaseHashi; o : in Type_Orientation) is

         ileCible : Type_CaseHashi;
         ileTrouveBool : Boolean;

      begin
         if ObtenirValeur(ObtenirIle(caseParcours)) = 1 then
            -- Si l'île a une valeur de 1, recherche automatiquement une île cible
            rechercherUneIleCible(G, caseParcours, o, ileTrouveBool, ileCible);
            if ileTrouveBool then
               construireLeChemin(G, caseParcours, ileCible, UN, o);
            end if;
         elsif ObtenirValeur(ObtenirIle(caseParcours)) > 1 then
            -- Si l'île a une valeur supérieure à 1, utilise la logique précédente
            rechercherUneIleCible(G, caseParcours, o, ileTrouveBool, ileCible);
            if ileTrouveBool then
               construireLeChemin(G, caseParcours, ileCible, UN, o);
            end if;
         end if;
      end RelierIle;

   begin
      Trouve := False;    -- Initialisation du drapeau de résolution

      for i in 1..nbLignes(G) loop
         for j in 1..nbColonnes(G) loop
            caseParcours := ObtenirCase(G, ConstruireCoordonnees(i, j));   -- Récupération de la case courante

            if estIle(ObtenirTypeCase(caseParcours)) then   -- Vérification si la case est une île non vide
               RelierIle(caseParcours, NORD);
               RelierIle(caseParcours, SUD);
               RelierIle(caseParcours, EST);
               RelierIle(caseParcours, OUEST);
            end if;

            --AfficherCase(caseParcours);
            --modifierCase(G, caseParcours);
            New_Line;
            --AfficherGrille(G);
         end loop;
         --end loop;
      end loop;

      if estComplete(G) then   -- Vérification de la complétion du puzzle
         Trouve := True;       -- La résolution est terminée
      else
         Trouve := False;
      end if;
   end ResoudreHashi;

end Resolution_Hashi;
