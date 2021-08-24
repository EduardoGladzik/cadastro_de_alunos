import 'package:cadastro_de_alunos/models/student.dart';
import 'package:cadastro_de_alunos/repositories/student/student_db_repository.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final _registerController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  bool isEdit = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de alunos"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Matricula do aluno",
                  hintText: "Ex: 123",
                  border: OutlineInputBorder()
                ),
                keyboardType: TextInputType.number,
                controller: _registerController,
                enabled: (isEdit) ? true : false,
              ),
              SizedBox(
                height: 12,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nome do aluno",
                  hintText: "Nome completo"
                ),
                keyboardType: TextInputType.name,
                controller: _nameController,
              ),
              SizedBox(
                height: 12,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email do aluno"
                ),
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text("Edição: "),
                  Switch(
                      value: isEdit,
                      onChanged: (bool status) {
                        setState(() {
                          isEdit = !isEdit;
                        });
                      },
                    ),
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: 
                      (isEdit)? null 
                      : () {saveRegister();},
                    child: Text("Cadastrar"),

                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                  onPressed: 
                    (isEdit)? () {}
                    : null,
                  child: Text("Editar"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void saveRegister() async{
    final String name = _nameController.text;
    final String email = _emailController.text;
    String message;

    if(!EmailValidator.validate(email)){
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Mensagem do sistema"),
          content: Text("Email inválido!"),
          actions: [
            TextButton(
            onPressed: (){
              Navigator.of(context).pop(); //close message
            },
            child: Text("OK"))
          ],
        ),
      );
    } else {
      Student student = Student(
        name: name,
        email: email
      );

      var repository = StudentDBRepository();
      int result = await repository.insert(student);

      if(result != 0) {
        //ok
        message = "O aluno $name foi cadastrado com sucesso!";
      } else {
        //not ok
        message = "Não foi possível cadastrar o aluno $name";
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Mensagem do sistema"),
          content: Text(message),
          actions: [
            TextButton(
            onPressed: (){
              Navigator.of(context).pop(); //close message
            },
            child: Text("OK"))
          ],
        ),
      );
    }
  }
}