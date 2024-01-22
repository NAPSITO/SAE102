pragma Ada_2012;
package body Grille is

   ----------------------
   -- ConstruireGrille --
   ----------------------

   function ConstruireGrille
     (nbl : in Integer; nbc : in Integer) return Type_Grille
   is
      GrilleHashi : Type_Grille;
   begin
      -- Levée d'exception
      if nbl < 1 or nbl > TAILLE_MAX or nbc < 1 or nbc > TAILLE_MAX then
         raise TAILLE_INVALIDE;
      end if;
      -- Création de la grille vide
      GrilleHashi.nbl := 1;
      while GrilleHashi.nbl <= nbl loop
         GrilleHashi.nbc := 1;
         while GrilleHashi.nbc <= nbc loop
            GrilleHashi.g (GrilleHashi.nbl, GrilleHashi.nbc) :=
              ConstruireCase
                (ConstruireCoordonnees (GrilleHashi.nbl, GrilleHashi.nbc));
            GrilleHashi.nbc := GrilleHashi.nbc + 1;
         end loop;
         GrilleHashi.nbl := GrilleHashi.nbl + 1;
      end loop;
      return GrilleHashi;
   end ConstruireGrille;
   --------------
   -- nbLignes --
   --------------

   function nbLignes (g : Type_Grille) return Integer is
   begin
      return g.nbl;
   end nbLignes;

   ----------------
   -- nbColonnes --
   ----------------

   function nbColonnes (g : Type_Grille) return Integer is
   begin
      return g.nbc;
   end nbColonnes;

   -------------------
   -- estGrilleVide --
   -------------------

   function estGrilleVide (G : in Type_Grille) return Boolean is
   begin
      if G.nbl = 0 and G.nbc = 0 then
         return True;
      else
         return False;
      end if;
   end estGrilleVide;

   -----------------
   -- estComplete --
   -----------------

   function estComplete (G : in Type_Grille) return Boolean is
   begin
      return NbIle(G)=NbIleCompletes(G) and not EstGrilleVide(G);
   end estComplete;

   -----------
   -- nbIle --
   -----------

   function nbIle (G : in Type_Grille) return Integer is
      i, j        : Integer;
      nbIleGrille : Integer;
   begin
      nbIleGrille := 0;
      i           := 1;
      while i <= G.nbl loop
         j := 1;
         while j <= G.nbc loop
            if ObtenirTypeCase (G.g (i, j)) = NOEUD then
               nbIleGrille := nbIleGrille + 1;
            end if;
            j := j + 1;
         end loop;
         i := i + 1;
      end loop;
      return nbIleGrille;
   end nbIle;

   --------------------
   -- nbIleCompletes --
   --------------------

   function nbIleCompletes (G : in Type_Grille) return Integer is
      i, j      : Integer;
      nbIleFull : Integer;
   begin
      nbIleFull := 0;
      i         := 1;
      while i <= G.nbl loop
         j := 1;
         while j <= G.nbc loop
            if ObtenirTypeCase (G.g (i, j)) = NOEUD then
               if ObtenirValeur (ObtenirIle (G.g (i, j))) = 0 then
                  nbIleFull := nbIleFull + 1;
               end if;
            end if;
            j := j + 1;
         end loop;
         i := i + 1;
      end loop;
      return nbIleFull;
   end nbIleCompletes;

   -----------------
   -- ObtenirCase --
   -----------------

   function ObtenirCase
     (G : in Type_Grille; Co : in Type_Coordonnee) return Type_CaseHashi
   is
      CaseH : Type_CaseHashi;
   begin
      CaseH := G.g (ObtenirLigne (Co), ObtenirColonne (Co));
      return CaseH;
   end ObtenirCase;

   ----------------
   -- aUnSuivant --
   ----------------

   function aUnSuivant
     (G : in Type_Grille; c : in Type_CaseHashi; o : Type_Orientation)
      return Boolean
   is
      Col, Ligne : Integer;
      i          : Integer;
   begin

      if ValeurOrientation (o) = ValeurOrientation (NORD) then
         Col := ObtenirColonne (ObtenirCoordonnee (c));
         i   := G.nbl + 1;
         while i <= 0 loop
            i := i - 1;
            if ObtenirTypeCase (G.g (i, Col)) = NOEUD then
               return True;
            else
               return False;
            end if;
         end loop;
      end if;

      if ValeurOrientation (o) = ValeurOrientation (SUD) then
         Col := ObtenirColonne (ObtenirCoordonnee (c));
         i   := 0;
         while i <= G.nbl loop
            i := i + 1;
            if ObtenirTypeCase (G.g (i, Col)) = NOEUD then
               return True;
            else
               return False;
            end if;
         end loop;
      end if;

      if ValeurOrientation (o) = ValeurOrientation (EST) then
         Ligne := ObtenirLigne (ObtenirCoordonnee (c));
         i     := 0;
         while i <= G.nbc loop
            i := i + 1;
            if ObtenirTypeCase (G.g (Ligne, i)) = NOEUD then
               return True;
            else
               return False;
            end if;
         end loop;
      end if;

      if ValeurOrientation (o) = ValeurOrientation (OUEST) then
         Ligne := ObtenirLigne (ObtenirCoordonnee (c));
         i     := G.nbc + 1;
         while i <= 0 loop
            i := i - 1;
            if ObtenirTypeCase (G.g (Ligne, i)) = NOEUD then
               return True;
            else
               return False;
            end if;
         end loop;
      end if;
      return False;
   end aUnSuivant;

   --------------------
   -- obtenirSuivant --
   --------------------

   function obtenirSuivant
     (G : in Type_Grille; c : in Type_CaseHashi; o : Type_Orientation)
      return Type_CaseHashi
   is
      Co      : Type_Coordonnee;
      Ligne   : Integer;
      Colonne : Integer;
   begin
      if not aUnSuivant (G, c, o) then
         raise PAS_DE_SUIVANT;
      end if;
      -- calcul
      Ligne   := ObtenirLigne (ObtenirCoordonnee (c));
      Colonne := ObtenirColonne (ObtenirCoordonnee (c));
      if o = NORD then
         Ligne := Ligne - 1;
      elsif o = SUD then
         Ligne := Ligne + 1;
      elsif o = EST then
         Colonne := Colonne + 1;
      else -- OUEST then
         Colonne := Colonne - 1;
      end if;
      Co := ConstruireCoordonnees (Ligne, Colonne);
      return ObtenirCase (G, Co);
   end obtenirSuivant;

   ------------------
   -- modifierCase --
   ------------------

   procedure modifierCase (G : in out Type_Grille; c : in Type_CaseHashi) is
   begin
      G.g(ObtenirLigne(ObtenirCoordonnee(c)), ObtenirColonne(ObtenirCoordonnee(c))) := c;
   end modifierCase;

end Grille;
