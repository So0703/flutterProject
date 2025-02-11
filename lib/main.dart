import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cepController = TextEditingController();
  String _result = '';

  Future<void> _searchCEP() async {
    final response = await http.get(Uri.parse('https://viacep.com.br/ws/${_cepController.text}/json/'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        _result = 'CEP: ${data['cep']}\n'
            'Logradouro: ${data['logradouro']}\n'
            'Complemento: ${data['complemento']}\n'
            'Bairro: ${data['bairro']}\n'
            'Localidade: ${data['localidade']}\n'
            'UF: ${data['uf']}';
      });
    } else {
      setState(() {
        _result = 'CEP não encontrado';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de CEP - Sabrina Midori Onishi - 27/11/2024'), // Barra superior com nome do aluno e data
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cepController,
              decoration: const InputDecoration(labelText: 'CEP'),
            ),
            ElevatedButton(
              onPressed: _searchCEP,
              child: const Text('Consultar'),
            ),
            const SizedBox(height: 16),
            Text(_result),
          ],
        ),
      ),
    );
  }
}
