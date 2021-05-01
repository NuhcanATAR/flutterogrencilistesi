import 'package:flutter/material.dart';
import 'package:flutter_app/models/student.dart';
import 'package:flutter_app/screens/student_add.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List<Student> students = [
    Student.withId(1,"Nuhcan", "ATAR", 25),
    Student.withId(2,"Kerem", "TOPAL", 55),
    Student.withId(3,"Ufuk", "İŞBİLİR", 45)
  ];
  Student selectedStudent=Student.withId(0, "", "", 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ders Uygulama"),
      ),
      body: buildBody(context),
    );
  }



  void mesajGoster(BuildContext context, String mesaj) {
    var alert = AlertDialog(
      title: Text("İşlem Sonucu"),
      content: Text(mesaj),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage("https://i.pinimg.com/originals/51/f6/fb/51f6fb256629fc755b8870c801092942.png"),
                  ),
                  title: Text(students[index].firstName + " " + students[index].lastName),
                  subtitle: Text("Sınavdan Aldıgı Not:" + students[index].grade.toString() + "[" + students[index].getStatus + "]"),
                  trailing: buildStatusIcon(students[index].grade),
                  onTap: () {
                    setState(() {
                      selectedStudent = students[index];
                    });
                    print(selectedStudent.firstName);
                  },
                );
              }),
        ),
        Text("Seçili Öğrenci: " + selectedStudent.firstName),
        Row(
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: RaisedButton(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.add,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("Ekle"),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StudentAdd(students)),
                  );
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: RaisedButton(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.delete,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("Güncelle"),
                  ],
                ),
                onPressed: () {
                  var mesaj = "Güncellendi";
                  mesajGoster(context, mesaj);
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: RaisedButton(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.delete,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("Sil"),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    students.remove(selectedStudent);
                  });

                  var mesaj = "Silindi :"+selectedStudent.firstName;
                  mesajGoster(context, mesaj);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildStatusIcon(int grade) {
    if (grade >= 50) {
      return Icon(Icons.done);
    } else {
      return Icon(Icons.clear);
    }
  }
}
