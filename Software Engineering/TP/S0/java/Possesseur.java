package tp0;

public class Possesseur {
  
  protected String nom;
  protected String prenom;
  protected int avs;
  
  public Possesseur(String n, String p, int av) {
    nom = n;
    prenom = p;
    avs = av;
  }
  
  public String getNom() {
    return this.nom;
  }
  
  public String getPrenom() {
    return this.prenom;
  }
  
  public int getAVS() {
    return this.avs;
  }
  
  public void affiche() {
    System.out.println("Possesseur: ");
    System.out.println("Nom: "+this.getNom());
    System.out.println("Prenom: "+this.getPrenom());
    System.out.println("Numero AVS: "+this.getAVS());
  }

}
