import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class home extends StatefulWidget {
  home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  TextEditingController txtcep = new TextEditingController();
  String? resultado;

  _consultaCEP() async {
    String cep = txtcep.text;
    String url = "https://viacep.com.br/ws/$cep/json/";

    http.Response response;
    response = await http.get(Uri.parse(url));

    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String Cidade = retorno["Cidade"];
    String Complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];
    String uf = retorno["uf"];
    setState(() {
      resultado =
          "\n\n ${logradouro} \n\n ${Cidade} \n\n ${Complemento} \n\n ${bairro} \n\n ${localidade} \n\n ${uf}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consulta CEP'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "CEP",
              ),
              controller: txtcep,
            ),
            Text(
              "Resultado: ${resultado}",
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
            ElevatedButton(
              onPressed: _consultaCEP,
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                onPrimary: Colors.white,
              ),
              child: const Text(
                "Consultar",
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
