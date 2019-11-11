
class QuraanModel {
   final int ayah;
   final String arabiffa; 
   final String oromiffa;
   final String tasfiir;
   QuraanModel(this.ayah,this.oromiffa, this.arabiffa,this.tasfiir);
   factory QuraanModel.fromMap(Map<String, dynamic> data) {
      return QuraanModel( 
         data['ayah'], 
         data['oromiffa'],
         data['arabiffa'],
         data['tasfiir']
      ); 
   } 
   Map<String, dynamic> toMap() => {
      "ayah": ayah,
      "oromiffa": oromiffa, 
      "arabiffa": arabiffa,
      "tasfiir": tasfiir
   }; 

   int get getAyah => ayah;
   String get getOromiffa => oromiffa;
   String get getArabiffa => arabiffa;
   String get getTasfiir => tasfiir;
}
