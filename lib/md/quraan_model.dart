
class QuraanModel {
   final int ayah;
   final String arabiffa; 
   final String oromiffa; 
   QuraanModel(this.ayah,this.oromiffa, this.arabiffa); 
   factory QuraanModel.fromMap(Map<String, dynamic> data) {
      return QuraanModel( 
         data['ayah'], 
         data['oromiffa'],
         data['arabiffa'],  
      ); 
   } 
   Map<String, dynamic> toMap() => {
      "ayah": ayah,
      "oromiffa": oromiffa, 
      "arabiffa": arabiffa, 
   }; 

   int get getAyah => ayah;
   String get getOromiffa => oromiffa;
   String get getArabiffa => arabiffa;
}
