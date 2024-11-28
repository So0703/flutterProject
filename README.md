# Aula - Introdução ao Flutter

## O que é Flutter?

Flutter é um kit de desenvolvimento de interface de usuário, de código aberto, criado pelo Google, que possibilita a criação de aplicativos compilados nativamente. Atualmente pode compilar para Android, iOS, Windows, Mac, Linux, Google Fuchsia e web.

## Por que Flutter?

- **Produtividade**: Flutter é uma ferramenta que permite o desenvolvimento de aplicativos de forma rápida e fácil.
- **Performance**: Flutter é um framework que permite a criação de aplicativos com alta performance.
- **Multiplataforma**: Com Flutter é possível criar aplicativos para Android, iOS, Windows, Mac, Linux, Google Fuchsia e web.
- **Comunidade**: Flutter possui uma comunidade ativa e engajada.

## Como instalar o Flutter?

Para instalar o Flutter, siga os passos abaixo:

1. Acesse o site oficial do Flutter: [https://flutter.dev/](https://flutter.dev/)
2. Clique no botão **Get Started**.
3. Selecione o sistema operacional que você está utilizando.
4. Siga as instruções de instalação.

## Como criar um projeto Flutter?

No Android Studio, você pode criar um projeto Flutter seguindo os passos abaixo:

1. Clique em **File**.
2. Clique em **New**.
3. Clique em **New Flutter Project**.
4. Selecione **Flutter Application**.
5. Clique em **Next**.
6. Informe o nome do projeto.
7. Clique em **Finish**.

Você também pode criar um projeto Flutter utilizando o terminal. Para isso, siga os passos abaixo:

1. Abra o terminal.
2. Execute o comando `flutter create nome_projeto`.
3. Acesse a pasta do projeto `cd nome_projeto`.
4. Execute o comando `flutter run`.

## Estrutura de um projeto Flutter

A estrutura de um projeto Flutter é composta por diversos arquivos e pastas. Abaixo estão listadas algumas pastas e arquivos importantes:

- **android**: Contém os arquivos do projeto Android.
- **ios**: Contém os arquivos do projeto iOS.
- **lib**: Contém os arquivos Dart do projeto. É nessa pasta que você irá desenvolver o aplicativo.
- **pubspec.yaml**: Arquivo que contém as dependências do projeto.

No Android Studio ele normalmente configura a IDE para começar na pasta android ou iOS, para alterar isso selecione na parte superior esquerda "Project" e selecione a opção "Project Files", isso vai exibir a estrutura de pastas do projeto.

## Configurando um dispositivo virtual no Android Studio

Para configurar um dispositivo virtual no Android Studio, siga os passos abaixo:

1. Clique em **Tools**.
2. Clique em **AVD Manager**.
3. Clique em **Create Virtual Device**.
4. Selecione o dispositivo que você deseja emular.
5. Clique em **Next**.
6. Selecione a imagem do sistema que você deseja emular.
7. Clique em **Next**.
8. Clique em **Finish**.

Com o dispositivo criado e configurado podemos iniciar a aplicação e testar.
O primeiro build pode demorar um pouco, mas depois disso o Flutter Hot Reload vai fazer o trabalho de atualizar o app em tempo real.

## Exemplo de um aplicativo Flutter

Abaixo está um exemplo de um aplicativo Flutter que exibe um texto na tela do dispositivo:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Center(
      child: Text(
        'Olá, mundo!',
        textDirection: TextDirection.ltr,
      ),
    ),
  ));
}
```

Para executar o aplicativo, basta copiar o código acima e colar no arquivo `main.dart` do projeto Flutter.

![print_app1](print_app1.png)

<video width="100%" height="350" controls>
  <source src="exemplo_primeiro_app.mp4" type="video/mp4">
</video>

## Criando um App simples de consulta de CEP

Para criar um aplicativo simples de consulta de CEP, siga os passos abaixo:

1. Crie um novo projeto Flutter.
2. Adicione a dependência `http` no arquivo `pubspec.yaml`. Você pode adicionar a dependência da seguinte forma:

```yaml
dependencies:
  http: ^1.2.1
```

Também é possível adicionar a dependência via terminal com o comando `flutter pub add http`.

3. Crie uma nova tela para a consulta de CEP.
4. Adicione um campo de texto para o usuário informar o CEP.
5. Adicione um botão para realizar a consulta.

Abaixo está um exemplo de um aplicativo Flutter que realiza a consulta de CEP:

```dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {
  final TextEditingController _cepController = TextEditingController(); // Controlador do campo de texto - é utilizado para acessar o valor do campo de texto
  String _result = ''; // Variável para armazenar o resultado da consulta

  Future<void> _searchCEP() async {
    final response = await http.get(Uri.parse('https://viacep.com.br/ws/${_cepController.text}/json/')); // Consulta de CEP chamando a API do ViaCEP

    if (response.statusCode == 200) { // Verifica se a requisição foi bem sucedida
      _result = response.body; // Armazena o resultado da consulta
      // Transforma o JSON retornado pela API em um Map
      final Map<String, dynamic> data = jsonDecode(response.body);
      _result = 'CEP: ${data['cep']}\n'
        'Logradouro: ${data['logradouro']}\n'
        'Complemento: ${data['complemento']}\n'
        'Bairro: ${data['bairro']}\n'
        'Localidade: ${data['localidade']}\n'
        'UF: ${data['uf']}'; // Formata o resultado da consulta, ao receber essa informação a tela exibe esses dados usando o Text()
    } else {
      _result = 'CEP não encontrado'; // CEP não encontrado
    }
  }

  @override // Método que constrói a interface do aplicativo
  Widget build(BuildContext context) { // Recebe o contexto do aplicativo
    return Scaffold( // Retorna um Scaffold que é a estrutura básica de uma tela
      appBar: AppBar( // Barra superior da tela
        title: const Text('Consulta de CEP'), // Título da tela
      ),
      body: Padding( // Corpo da tela
        padding: const EdgeInsets.all(16.0), // Espaçamento
        child: Column( // Coluna de widgets
          children: [
            TextField( // Campo de texto para o CEP
              controller: _cepController,
              decoration: const InputDecoration(labelText: 'CEP'),
            ),
            ElevatedButton( // Botão para realizar a consulta
              onPressed: _searchCEP, // Função que é chamada ao pressionar o botão
              child: const Text('Consultar'), // Texto do botão
            ),
            const SizedBox(height: 16), // Espaçamento
            Text(_result), // Resultado da consulta
          ],
        ),
      ),
    );
  }
}
```

Observem que o Flutter utiliza um conceito de Widgets, que são os componentes visuais do aplicativo. No exemplo acima, utilizamos os seguintes Widgets:

- `MaterialApp`: Widget que define a estrutura básica de um aplicativo Material Design.
- `Scaffold`: Widget que implementa a estrutura básica de uma tela.
- `AppBar`: Widget que implementa a barra superior de uma tela.
- `Padding`: Widget que adiciona um espaçamento ao redor de um widget filho.
- `Column`: Widget que organiza os widgets filhos em uma coluna.
- `TextField`: Widget que implementa um campo de texto.
- `ElevatedButton`: Widget que implementa um botão elevado.
- `Text`: Widget que exibe um texto na tela.

E esses Widgets vão sendo combinados para criar a interface do aplicativo. O Flutter possui uma grande variedade de Widgets que podem ser utilizados para criar aplicativos.

## Atividade

Entregar um repositório no  Github com o projeto criado para a consulta de CEP. Adicione na barra superior da tela o nome do aluno e a data de entrega.
O título deve ficar por exemplo: "Consulta de CEP - Nome do Aluno - 12/06/2024".