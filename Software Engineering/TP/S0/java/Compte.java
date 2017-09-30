package tp0;

public class Compte {
  
  protected double solde;
  protected int numero;
  protected Possesseur posseceur;
  
  public Compte(double s, int n, Possesseur p) {
    solde = s;
    numero = n;
    posseceur = p;
  }
  
  public void add(double a) {
    this.solde+= a;
  }
  
  public void remove(double a) {
     this.solde-=a;
  }
  
  public double getSolde() {
    return this.solde;
  }
  
  public int getNumero() {
    return this.numero;
  }
  
  public Possesseur getPersonne() {
    return this.posseceur;
  }
  
  public void affiche() {
    System.out.println("Etat du compte No "+numero);
    System.out.println("Solde: "+solde);
  }

}
