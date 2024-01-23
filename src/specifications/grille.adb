pragma Ada_2012;
package body Grille is

   ----------------------
   -- ConstruireGrille --
   ----------------------

   function ConstruireGrille(nbl : in Integer; nbc : in Integer) return Type_Grille
   is
      GrilleHashi : Type_Grille;
      Coordonnee: Type_Coordonnee;
   begin
      GrilleHashi.nbl:=nbl;
      GrilleHashi.nbc:=nbc;
      -- Levée d'exception
      if nbl < 1 or else nbl > TAILLE_MAX or else nbc < 1 or else nbc > TAILLE_MAX then
         raise TAILLE_INVALIDE;
      end if;
      -- Création de la grille vide
      for i in 1 .. nbl loop
         for j in 1 .. nbc loop
            Coordonnee := ConstruireCoordonnees(i, j);
            GrilleHashi.g(i, j) := ConstruireCase(Coordonnee);
         end loop;
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
      for i in 1 .. nbLignes(G) loop
         for j in 1 .. nbColonnes(G) loop
            if estIle(ObtenirTypeCase(ObtenirCase(G,ConstruireCoordonnees(i,j)))) then
               return FALSE;
            end if;
         end loop;
      end loop;

      return TRUE; -- Si toutes les cases sont de type mer
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

      compteurIle:Integer:=0;

   begin
     for i in 1 .. nbLignes(G) loop
         for j in 1 .. nbColonnes(G) loop
            if estIle(ObtenirTypeCase(ObtenirCase(G,ConstruireCoordonnees(i,j)))) then
               compteurIle:=compteurIle+1;
            end if;
         end loop;
      end loop;
      return compteurIle;
   end nbIle;

   --------------------
   -- nbIleCompletes --
   --------------------

   function nbIleCompletes (G : in Type_Grille) return Integer is

      compteurIle:Integer:=0;

   begin
     for i in 1 .. nbLignes(G) loop
         for j in 1 .. nbColonnes(G) loop
            if estIle(ObtenirTypeCase(ObtenirCase(G,ConstruireCoordonnees(i,j)))) then
               if estIleComplete(ObtenirIle(ObtenirCase(G,ConstruireCoordonnees(i,j)))) then
                  compteurIle:=compteurIle+1;
                end if;
            end if;
         end loop;
      end loop;
      return compteurIle;
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
      Col, Lig: Integer;
   begin
      -- on récupère les coodonnées de c
      Col:= ObtenirColonne(ObtenirCoordonnee(c));
      Lig := ObtenirLigne(ObtenirCoordonnee(c));

      -- obtenir les col et lig des successeurs en fonction de l'orientation
      if ValeurOrientation(o) = ValeurOrientation(NORD) then
         Lig := Lig - 1;
      elsif ValeurOrientation(o) = ValeurOrientation(SUD) then
         Lig := Lig + 1;
      elsif ValeurOrientation(o) = ValeurOrientation(EST) then
         Col := Col + 1;
      else
         Col := Col - 1;
      end if;

      -- Tester la case existe dans la grille
      if Col>0 and Col <= G.nbc and Lig>0 and Lig <= G.nbl then
         return True;
      else
         return False;
      end if;
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

   function modifierCase
     (G   : in Type_Grille; c : in Type_CaseHashi) return Type_Grille is
      newGrille: Type_Grille;
   begin
      newGrille := G;
      newGrille.g(ObtenirLigne(ObtenirCoordonnee(c)), ObtenirColonne(ObtenirCoordonnee(c))) := c;
      return newGrille;
   end modifierCase;

end Grille;
