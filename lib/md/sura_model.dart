
class SuraModel {
   final int id;
   final String oromo; 
   final String arabic; 
   SuraModel(this.id,this.oromo, this.arabic); 
   factory SuraModel.fromMap(Map<String, dynamic> data) {
      return SuraModel( 
         data['id'], 
         data['oromo'],
         data['arabic'],  
      ); 
   } 
   Map<String, dynamic> toMap() => {
      "id": id,
      "oromo": oromo, 
      "arabic": arabic, 
   }; 

   int get getId => id;
   String get getOromo => oromo;
   String get getArabic => arabic;
}
