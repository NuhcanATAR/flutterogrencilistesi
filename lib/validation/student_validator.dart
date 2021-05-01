class StudentValidationMixin{


  String validateFirstName(String value){
    if(value.length<2){
      return "İsim En Az İki Karakter Olmalıdır";
    }
  }

  String validateLastName(String value){
    if(value.length<2){
      return "Soyad En Az İki Karakter Olmalıdır";
    }
  }

  String validategrade(String value){
    var grade = int.parse(value);
    if(grade<0 || grade>100){
      return "Not 0-100 arasında olabilir";
    }
  }
}