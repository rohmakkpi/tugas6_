import 'package:flutter/material.dart';
import 'package:tugas6/main.dart';
import 'package:tugas6/widgets/convert.dart';
import 'package:tugas6/widgets/input.dart';
import 'package:tugas6/widgets/result.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<homePage> createState() => _homePage();
}

class _homePage extends State<homePage> {
  double _inputUser = 0;
  double _kelvin = 0;
  double _reamur = 0;

  final etInput = TextEditingController();

  String _newValue = "Kelvin";
  double _result = 0;
  String changeValue = "";

  List<String> listViewItem = <String>[];

  var listItem = ["Kelvin", "Reamur"];

  @override
  void dispose() {
    etInput.dispose();
    super.dispose();
  }

  void konversiSuhu() {
    setState(() {
      _inputUser = double.parse(etInput.text);
      if (_newValue == "Kelvin")
        _result = _inputUser + 273;
      else
        _result = (4 / 5) * _inputUser;
    });

    listViewItem.add(_result.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          margin: const EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              input(etInput: etInput),
              DropdownButton<String>(
                items: listItem.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                value: _newValue,
                onChanged: (String? changeValue) {
                  setState(() {
                    _newValue = changeValue!;
                    konversiSuhu();
                  });
                },
              ),
              Result(result: _result),
              convert(konvertHandler: konversiSuhu),
              Container(child: const Text("Riwayat Konversi")),
              Expanded(
                child: ListView(
                  children: listViewItem.map((String value) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 15),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          )),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  void onChangeDropDown(String? changeValue) {
    setState(() {
      _newValue = changeValue!;
    });
  }

  DropdownMenuItem<String> myDropDownMenuItem(String value) {
    return DropdownMenuItem<String>(value: value, child: Text(value));
  }

}