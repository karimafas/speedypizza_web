import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speedypizza_web/provider/customers_info.dart';
import 'package:speedypizza_web/theme/style_constants.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomersInfo>(builder: (context, data, index) {
      return Container(
        decoration: BoxDecoration(
          color: darkGrey,
        ),
        height: 150,
        child: Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 20),
          child: Column(
            children: [
              Text("Ricerca per campi...",
                  style: TextStyle(color: Colors.grey)),
              Container(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  width: 200,
                  child: TextFormField(
                    onChanged: (value) {
                      if (value != "") {
                        data.switchIsQuerying(true);
                      } else {
                        data.switchIsQuerying(false);
                      }
                    },
                    controller: data.surnameController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        icon: Icon(Icons.person), labelText: "Cognome"),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
