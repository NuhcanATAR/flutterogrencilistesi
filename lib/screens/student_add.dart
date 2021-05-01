import 'package:flutter/material.dart';
import 'package:flutter_app/models/student.dart';
import 'package:flutter_app/validation/student_validator.dart';

class StudentAdd extends StatefulWidget {
  List<Student> students;
  StudentAdd(List<Student> students){
    this.students = students;
  }
  @override
  State<StatefulWidget> createState() {
    return _StudentAddState(students);
  }
}

class _StudentAddState extends State with StudentValidationMixin { /* with başka bir validator dosyasını buna inherit etmeye yarar with e ise mixin olarak isim veriliyor */
  List<Student> students;
  var student = Student.withOutInfo();
  var formKey = GlobalKey<FormState>();

  _StudentAddState(List<Student> students){
    this.students = students;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ders Uygulama(Öğrenci Ekle)"),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child:Form(
          key: formKey,
        child: Column(
          children: <Widget>[
            buildFirstNameField(),
            buildLastNameField(),
            buildGradeField(),
            buildSubmitButton(),
          ],
         ),
        ),
      ),
    );
  }

  Widget buildFirstNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Öğrenci Adı",
        hintText: "Örn: Engin",
      ),
      validator: validateFirstName,
      onSaved: (String value){
        student.firstName = value;
      },
    );
  }

  Widget buildLastNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Öğrenci Soyadı",
        hintText: "Örn: Demiroğ",
      ),
      validator: validateLastName,
      onSaved: (String value){
        student.lastName = value;
      },
    );
  }

  Widget buildGradeField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Öğrenci Notu",
        hintText: "Örn: 0-100",
      ),
      validator: validategrade,
      onSaved: (String value){
        student.grade = int.parse(value);
      },
    );
  }

  Widget buildSubmitButton() {
    return RaisedButton(
      child: Text("Kaydet"),
      onPressed: (){
        if(formKey.currentState.validate()){
          formKey.currentState.save();
          students.add(student);
          saveStudent();
          Navigator.pop(context);
        }
      },
    );
  }

  void saveStudent() {
    print(student.firstName);
    print(student.lastName);
    print(student.grade);
  }


}
