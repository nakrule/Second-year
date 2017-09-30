package tp0;

public class Main {
  
  public static void main(String...args) {
    Etudiant max = new Etudiant ("Queiroz", "Max", 10, "HES-SO", "Son papa");
    Employe pierre = new Employe ("Caille", "Pierre", 11, 3786467);
    
    CompteEpargne compteMax = new CompteEpargne(-2000, 345345, max);
    CompteCourant comptePierre = new CompteCourant (-1000, 4535345, pierre);
    
    compteMax.affiche();
    System.out.println("-----------------------------");
    comptePierre.affiche();
  }

}
