package tp0;

public class Employe extends Possesseur {
  
  private int contrat;

  public Employe(String n, String p, int av, int c) {
    super(n, p, av);
    contrat = c;
  }
  
  public int getContrat() {
    return this.contrat;
  }
  
  @Override
  public void affiche() {
    System.out.println("Possesseur: (Employe)");
    System.out.println("Nom: "+this.getNom());
    System.out.println("Prenom: "+this.getPrenom());
    System.out.println("Numero AVS: "+this.getAVS());
    System.out.println("Numero de contrat: "+this.getContrat());
  }

}
