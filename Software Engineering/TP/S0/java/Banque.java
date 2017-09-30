package tp0;

public class Banque {
  
  private String name;
  Compte[] comptes;
  int nextcompte;
  
  public Banque (String n) {
    name = n;
    comptes = new Compte[10];
    nextcompte=0;
  }
  
  public void addCompte(Compte c) {
    comptes[nextcompte]=c;
    nextcompte++;
  }

}
