import 'package:flutter/material.dart';
 
void main() {
  runApp(const Calculadora());
}
 
class Calculadora extends StatefulWidget {
  const Calculadora({super.key});
 
  @override
  State<Calculadora> createState() => _CalculadoraState();
}
 
class _CalculadoraState extends State<Calculadora> {
  String display = '0';
  String expressao = '';
 
  double num1 = 0;
  String operacao = '';
  bool limpar = false;
 
  void clicar(String valor) {
    setState(() {
 
      // LIMPAR
      if (valor == 'C') {
        display = '0';
        expressao = '';
        num1 = 0;
        operacao = '';
        return;
      }
 
      // OPERADORES
      if (valor == '+' || valor == '-' || valor == '×' || valor == '÷') {
        num1 = double.parse(display);
        operacao = valor;
 
        expressao = '$display $valor';
 
        limpar = true;
        return;
      }
 
      // RESULTADO
      if (valor == '=') {
        double num2 = double.parse(display);
        double resultado = 0;
 
        if (operacao == '+') resultado = num1 + num2;
        if (operacao == '-') resultado = num1 - num2;
        if (operacao == '×') resultado = num1 * num2;
        if (operacao == '÷') resultado = num1 / num2;
 
        expressao = '$expressao $display';
        display = resultado.toString();
 
        limpar = true;
        return;
      }
 
      // NÚMEROS
      if (limpar) {
        display = valor;
        limpar = false;
      } else {
        if (display == '0') {
          display = valor;
        } else {
          display += valor;
        }
      }
    });
  }
 
  Widget botao(String texto, Color cor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: cor,
          ),
          onPressed: () => clicar(texto),
          child: Text(
            texto,
            style: const TextStyle(
              fontSize: 26,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
 
            // EXPRESSÃO (NOVA PARTE)
            Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.only(top: 40, right: 20),
              child: Text(
                expressao,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.grey,
                ),
              ),
            ),
 
            // DISPLAY PRINCIPAL
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(20),
                child: Text(
                  display,
                  style: const TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
 
            Row(children: [
              botao('7', Colors.white),
              botao('8', Colors.white),
              botao('9', Colors.white),
              botao('÷', Colors.orange),
            ]),
 
            Row(children: [
              botao('4', Colors.white),
              botao('5', Colors.white),
              botao('6', Colors.white),
              botao('×', Colors.orange),
            ]),
 
            Row(children: [
              botao('1', Colors.white),
              botao('2', Colors.white),
              botao('3', Colors.white),
              botao('-', Colors.orange),
            ]),
 
            Row(children: [
              botao('0', Colors.white),
              botao('C', Colors.red),
              botao('=', Colors.green),
              botao('+', Colors.orange),
            ]),
          ],
        ),
      ),
    );
  }
}