import 'package:flutter/material.dart';

void main() => runApp(const Salary());

class Salary extends StatefulWidget {
  const Salary({super.key});

  @override
  SalaryState createState() => SalaryState();
}

class SalaryState extends State<Salary> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _salary = TextEditingController();

  String _result = "";

  @override
  void initState() {
    super.initState();
    limpaCampos();
  }

  void limpaCampos() {
    _salary.text = '';

    setState(() {
      _result = '';
    });
  }

  void salaryCalculator() {
    double s = double.parse(_salary.text);
    double taxa = 0.0;
    if (s < 280.01) {
      taxa = 0.2;
    } else if (s < 700.01) {
      taxa = 0.15;
    } else if (s < 1500.01) {
      taxa = 0.10;
    } else {
      taxa = 0.05;
    }
    double reajuste = s * taxa;
    setState(() {
      _result = "Salário atual: ${s.toStringAsFixed(2)}\n"
          "Percentual de aumento: ${(taxa * 100).toString()}% \n"
          "Valor do aumento: ${reajuste.toStringAsFixed(2)}\n"
          "Novo salário: ${(s + reajuste).toStringAsFixed(2)}\n";
    });
  }

  Widget buildCalcularButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            salaryCalculator();
          }
        },
        child: Text('Calcular reajuste',
            style: TextStyle(color: Color.fromARGB(255, 64, 59, 40))),
      ),
    );
  }

  Widget buildTextResult() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: Text(
        _result,
        textAlign: TextAlign.left,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Color.fromARGB(255, 255, 229, 173),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20.0), child: buildForm()));
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text("Organizações Boer's"),
      backgroundColor: Colors.white70,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            limpaCampos();
          },
        )
      ],
    );
  }

  Form buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildTextFormField(
              label: "Informe seu salário atual (R\$):",
              error: "Salário deve ser informado!",
              controller: _salary),
          buildCalcularButton(),
          buildTextResult(),
        ],
      ),
    );
  }

  TextFormField buildTextFormField(
      {required TextEditingController controller,
      required String error,
      required String label}) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      controller: controller,
      validator: (text) {
        return text!.isEmpty ? error : null;
      },
    );
  }
}
