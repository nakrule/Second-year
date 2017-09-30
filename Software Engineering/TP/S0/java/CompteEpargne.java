package tp0;

public class CompteEpargne extends Compte {
  
  final double decouvert = 1000;
  
  public CompteEpargne(double s, int n, Possesseur p) {
    super(s, n, p);
  }
  
 @Override
  public void remove(double a) {
    if (this.solde-a<-decouvert)
      this.solde-=a;
  }
 
 @Override
 public void affiche() {
   System.out.println("Etat du compte No "+this.numero);
   System.out.print("Solde: "+this.solde);
   if (this.solde<-1000)
     System.out.println(" (blocked)");
   else
     System.out.println();
   this.posseceur.affiche();
 }
}
