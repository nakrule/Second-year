package tp0;

public class Etudiant extends Possesseur {
  
  private String school;
  private String reference;

  public Etudiant(String n, String p, int av, String s, String r) {
    super(n, p, av);
    school = s;
    reference = r;
  }
  
  public String getSchool() {
    return this.school;
  }
  
  public String getReference() {
    return this.reference;
  }
  
  @Override
  public void affiche() {
    System.out.println("Possesseur: (Etudiant)");
    System.out.println("Nom: "+this.getNom());
    System.out.println("Prenom: "+this.getPrenom());
    System.out.println("Numero AVS: "+this.getAVS());
    System.out.println("Numero de contrat: "+this.getSchool());
    System.out.println("Referent: "+this.reference);
  }

}
