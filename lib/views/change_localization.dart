import 'package:flutter/material.dart';

class ChangeLocalization extends StatefulWidget {
  @override
  ChangeLocalizationState createState() => ChangeLocalizationState();
}

class ChangeLocalizationState extends State<ChangeLocalization> {
  final newLocalizationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zmiana lokalizacji'),
      ),
      body: Center(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    'Podaj nazwę miasta',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    labelText: 'Miasto',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  controller: newLocalizationController,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red[400]),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Wyszukaj w nowym miejscu',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  onPressed: () {
                    // Zwróć co było wstawione w TextField
                    Navigator.pop(context, newLocalizationController.text);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    newLocalizationController.dispose();
    super.dispose();
  }
}
