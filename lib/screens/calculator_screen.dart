import 'package:calculatorapp/components/form_field.dart';
import 'package:calculatorapp/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalculadoraScreen extends StatefulWidget {
  @override
  _CalculadoraScreenState createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
  TextEditingController controllerWeight = TextEditingController();
  TextEditingController controllerHeight = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerAge = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<bool> isSelected = [true, false];
  double? imcResult;
  String imcMessage = '';
  String imcFormatted = '';
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Image(
              image: NetworkImage(
                  "https://cdn6.aptoide.com/imgs/c/d/b/cdb22543fc41fb41d327919e5dec202e_icon.png")),
        ),
        title: const Text(
          'Calculadora IMC',
          style: textStyleAppBar,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: ToggleButtons(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(200)),
                          children: [
                            _customToggleButton(0, Icons.man_2),
                            _customToggleButton(1, Icons.woman_2),
                          ],
                          isSelected: isSelected,
                          onPressed: (int index) {
                            setState(() {
                              for (int buttonIndex = 0;
                                  buttonIndex < isSelected.length;
                                  buttonIndex++) {
                                isSelected[buttonIndex] =
                                    (buttonIndex == index);
                              }
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Idade',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                        ),
                        textAlign: TextAlign.center,
                        controller: controllerAge,
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    FormFieldComponent(
                      firstController: controllerHeight,
                      firstLabel: 'Altura (cm)',
                      firstKeyboardType: TextInputType.number,
                      secondController: controllerWeight,
                      secondLabel: 'Peso (kg)',
                      secondKeybordType: TextInputType.number,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 90.0, top: 10.0, right: 90.0, bottom: 10.0),
                      child: Container(
                        height: 40,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child: FloatingActionButton.extended(
                          heroTag: 'buttonCalcular',
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          elevation: 0,
                          highlightElevation: 0,
                          label: const Text('CALCULAR'),
                          onPressed: () {
                            calculateImc();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Seu IMC é',
                            style: textStyleReusable,
                          ),
                          Text(
                            imcFormatted.isNotEmpty ? imcFormatted : '...',
                            style: textStyleValueIMC,
                          ),
                          Text(
                            imcMessage,
                            style: textStyleReusable,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Icon(
                            Icons.warning,
                            color: Colors.red,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 50.0, right: 50.0),
                            child: Text(
                              'É importante lembrar que o IMC é uma medida simplificada e não considera fatores como composição corporal, massa muscular e distribuição de gordura. Portanto, é essencial consultar um profissional de saúde para uma avaliação mais abrangente e recomendações específicas.',
                              maxLines: 10,
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : null,
                      ),
                      onPressed: toggleFavorite,
                      iconSize: 48.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  Widget _customToggleButton(int index, IconData icon) {
    return Container(
      width: 91.0,
      height: 58.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isSelected[index] ? Colors.blue : Colors.blue.shade100,
        ),
        onPressed: () {
          setState(() {
            for (int buttonIndex = 0;
                buttonIndex < isSelected.length;
                buttonIndex++) {
              isSelected[buttonIndex] = (buttonIndex == index);
            }
          });
        },
        child: Icon(
          icon,
          color: isSelected[index] ? Colors.white : Colors.blue.shade300,
          size: 24.0,
        ),
      ),
    );
  }

  void calculateImc() {
    double weight = double.parse(controllerWeight.text);
    double height = double.parse(controllerHeight.text) / 100;
    imcResult = weight / (height * height);

    if (height != null && weight != null) {
      setState(() {
        imcResult = imcResult;
        imcFormatted = NumberFormat('#.##').format(imcResult);
        imcMessage = getImcMessage(double.parse(imcFormatted.toString()));
      });
    } else {
      setState(() {
        imcResult = null;
        imcMessage = 'Por favor, insira valores válidos.';
      });
    }
  }

  String getImcMessage(double imc) {
    if (imc < 16) {
      return 'MAGREZA GRAVE';
    } else if (imc < 17) {
      return 'MAGREZA MODERADA';
    } else if (imc < 18.5) {
      return 'MAGREZA LEVE';
    } else if (imc < 25) {
      return 'SAUDÁVEL';
    } else if (imc < 30) {
      return 'SOBREPESO';
    } else if (imc < 35) {
      return 'OBESIDADE GRAU I';
    } else if (imc < 40) {
      return 'OBESIDADE GRAU II \n(SEVERA)';
    } else {
      return 'OBESIDADE GRAU III \n(MÓRBIDA)';
    }
  }
}
