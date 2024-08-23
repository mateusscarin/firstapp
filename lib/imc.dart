import 'package:flutter/material.dart';

void main() => runApp(const Imc());

class Imc extends StatefulWidget {
  const Imc({super.key});

  @override
  ImcState createState() => ImcState();
}

class ImcState extends State<Imc> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _weight = TextEditingController();
  TextEditingController _height = TextEditingController();

  String _result = "";

  @override
  void initState() {
    super.initState();
    limpaCampos();
  }

  void limpaCampos() {
    _height.text = '';
    _weight.text = '';

    setState(() {
      _result = '';
    });
  }

  void imcCalculator() {
    double h = double.parse(_height.text);
    double w = double.parse(_weight.text);
    double imc = w / (h * h);
    String msg = 'Problemas ao definir IMC!';
    if (imc < 18.5) {
      msg = 'Abaixo do peso';
    } else if (imc < 25) {
      msg = 'Peso ideal (parabéns)';
    } else if (imc < 30) {
      msg = 'Levemente acima do peso';
    } else if (imc < 35) {
      msg = 'Obesidade grau I';
    } else if (imc < 40) {
      msg = 'Obesidade grau II (severa)';
    } else {
      msg = 'Obesidade grau III (mórbida)';
    }
    setState(() {
      _result = msg;
    });
  }

  Widget buildCalcularButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            imcCalculator();
          }
        },
        child: Text('Calcular IMC',
            style: TextStyle(color: Color.fromRGBO(13, 78, 255, 1))),
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
        backgroundColor: Color.fromARGB(255, 154, 171, 239),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20.0), child: buildForm()));
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Calculadora de IMC'),
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
              label: "Informe sua altura (m):",
              error: "Altura deve ser informada!",
              controller: _height),
          buildTextFormField(
              label: "Informe seu peso (kg):",
              error: "Peso deve ser informado!",
              controller: _weight),
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
