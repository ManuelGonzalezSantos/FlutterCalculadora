import 'package:flutter/material.dart';

void main() {
  runApp(const Appzinha());
}

class Appzinha extends StatefulWidget {
  const Appzinha({super.key});

  @override
  State<Appzinha> createState() => _AppzinhaState();
}

class _AppzinhaState extends State<Appzinha> {
  String tela = '0';
  String conta = '';

  double valor1 = 0;
  String sinal = '';
  bool apagar = false;

  void mexer(String numero) {
    setState(() {

      if (numero == 'C') {
        tela = '0';
        conta = '';
        valor1 = 0;
        sinal = '';
        return;
      }

      if (numero == '+' ||
          numero == '-' ||
          numero == '×' ||
          numero == '÷') {

        valor1 = double.parse(tela);
        sinal = numero;

        conta = '$tela $numero';

        apagar = true;
        return;
      }

      if (numero == '=') {

        double valor2 = double.parse(tela);
        double total = 0;

        if (sinal == '+') total = valor1 + valor2;
        if (sinal == '-') total = valor1 - valor2;
        if (sinal == '×') total = valor1 * valor2;
        if (sinal == '÷') total = valor1 / valor2;

        conta = '$conta $tela';

        tela = total.toString();

        apagar = true;
        return;
      }

      if (apagar) {

        tela = numero;
        apagar = false;

      } else {

        if (tela == '0') {
          tela = numero;
        } else {
          tela += numero;
        }

      }
    });
  }

  Widget quadrado(String txt, Color corzinha) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ElevatedButton(

          style: ElevatedButton.styleFrom(
            backgroundColor: corzinha,
          ),

          onPressed: () {
            mexer(txt);
          },

          child: Text(
            txt,
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

            Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.only(
                top: 40,
                right: 20,
              ),

              child: Text(
                conta,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.grey,
                ),
              ),
            ),

            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(20),

                child: Text(
                  tela,
                  style: const TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            Row(
              children: [
                quadrado('7', Colors.white),
                quadrado('8', Colors.white),
                quadrado('9', Colors.white),
                quadrado('÷', Colors.orange),
              ],
            ),

            Row(
              children: [
                quadrado('4', Colors.white),
                quadrado('5', Colors.white),
                quadrado('6', Colors.white),
                quadrado('×', Colors.orange),
              ],
            ),

            Row(
              children: [
                quadrado('1', Colors.white),
                quadrado('2', Colors.white),
                quadrado('3', Colors.white),
                quadrado('-', Colors.orange),
              ],
            ),

            Row(
              children: [
                quadrado('0', Colors.white),
                quadrado('C', Colors.red),
                quadrado('=', Colors.green),
                quadrado('+', Colors.orange),
              ],
            ),
          ],
        ),
      ),
    );
  }
}