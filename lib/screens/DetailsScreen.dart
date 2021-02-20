import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:speedypizza_web/provider/cart.dart';
import 'package:speedypizza_web/navigation/routing_constants.dart';
import 'package:speedypizza_web/theme/style_constants.dart';
import 'package:speedypizza_web/components/SpeedyButton.dart';
import 'package:speedypizza_web/globals/globals.dart' as globals;
import 'package:speedypizza_web/components/FadeIn.dart';
import 'ArchiveScreen.dart';

TextEditingController geoController = new TextEditingController();

class DetailsArgs {
  final String phone;
  final bool fromCart;
  final bool fromCustomers;
  final bool fromHome;

  DetailsArgs(this.phone, this.fromCart, this.fromCustomers, this.fromHome);
}

String convertToTitleCase(String text) {
  if (text == null) {
    return null;
  }

  if (text.length <= 1) {
    return text.toUpperCase();
  }

  // Split string into multiple words
  final List<String> words = text.split(' ');

  // Capitalize first letter of each words
  final capitalizedWords = words.map((word) {
    final String firstLetter = word.substring(0, 1).toUpperCase();
    final String remainingLetters = word.substring(1);

    return '$firstLetter$remainingLetters';
  });

  // Join/Merge all words back to one String
  return capitalizedWords.join(' ');
}

extension CapitalizedStringExtension on String {
  String toTitleCase() {
    return convertToTitleCase(this);
  }
}

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';

  String get allInCaps => this.toUpperCase();
}

class DetailsScreen extends StatelessWidget {
  final DetailsArgs args;

  const DetailsScreen({Key key, this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("Dettagli cliente"),
      ),
      body: DetailsBody(
          phone: args.phone,
          fromCart: args.fromCart,
          fromCustomers: args.fromCustomers,
      fromHome: args.fromHome),
    );
  }
}

DateFormat dateFormat = DateFormat("dd-MM-yyyy");

Future<void> getOrderNumber() async {
  var result = await FirebaseFirestore.instance
      .collection("ordernumbers")
      .where("date", isEqualTo: dateFormat.format(DateTime.now()))
      .get();
  result.docs.forEach((result) {
    if (result.data()["ordernumber"] != null) {
      globals.orderNumber = result.data()["ordernumber"] + 1;
    }
  });

  if (globals.orderNumber == null) {
    globals.orderNumber = 1;
  }
}

class DetailsBody extends StatefulWidget {
  const DetailsBody({Key key, this.phone, this.fromCart, this.fromCustomers, this.fromHome})
      : super(key: key);
  final String phone;
  final bool fromCart;
  final bool fromCustomers;
  final bool fromHome;

  @override
  _DetailsBodyState createState() => _DetailsBodyState();
}

class _DetailsBodyState extends State<DetailsBody> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController surnameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController doornoController = new TextEditingController();
  TextEditingController floorController = new TextEditingController();
  TextEditingController discountController = new TextEditingController(text: "0");
  TextEditingController creditController = new TextEditingController(text: "0");
  TextEditingController notesController = new TextEditingController();
  TextEditingController areaController = new TextEditingController();

  void navigate() {
    if (_formKey.currentState.validate()) {
      FirebaseFirestore.instance.collection("customers").doc(widget.phone).set({
        "surname": surnameController.text.toLowerCase(),
        "phone": int.parse(phoneController.text),
        "address": addressController.text,
        "doorno": doornoController.text,
        "floor": floorController.text,
        "discount": discountController.text,
        "credit": creditController.text,
        "notes": notesController.text,
        "area" : areaController.text,
      });

      globals.surname = surnameController.text.inCaps;
      globals.phone = phoneController.text;
      globals.address = addressController.text;
      globals.doorno = doornoController.text;
      globals.floor = floorController.text;
      globals.discount = discountController.text;
      globals.credit = creditController.text;
      globals.notes = notesController.text;
      globals.area = areaController.text;

      if (widget.fromCart) {
        Navigator.pushReplacementNamed(context, ReviewScreenRoute);
      }
      if (widget.fromCustomers) {
        Navigator.pushReplacementNamed(context, CustomersRoute);
      }
      if (widget.fromHome){
        runOneByOne<void>([
          () => Provider.of<Cart>(context, listen: false).clear(),
          () => getOrderNumber(),
          () => Navigator.pushNamed(context, OrderScreenRoute)
        ]);
      }
    }

    Provider.of<Cart>(context, listen: false).switchIsReopeningOrder(false);
    Provider.of<Cart>(context, listen: false).calculateTotal();
  }

  @override
  void initState() {
    phoneController.text = widget.phone;

    FirebaseFirestore.instance
        .collection("customers")
        .where("phone", isEqualTo: int.parse(widget.phone))
        .get()
        .then((value) {
      value.docs.forEach((result) {
        if (result.data()["surname"] != null) {
          surnameController.text = result.data()["surname"].toString().toLowerCase().toTitleCase();
          floorController.text = result.data()["floor"].toString();
          doornoController.text = result.data()["doorno"].toString();
          addressController.text = result.data()["address"].toString().toLowerCase().toTitleCase();
          areaController.text = result.data()["area"].toString().toLowerCase().toTitleCase();
          discountController.text = result.data()["discount"].toString();
          notesController.text = result.data()["notes"].toString();
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          children: [
            SlideYFadeInBottom(
              0.5,
              Text("Dati cliente",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  )),
            ),
            SizedBox(height: 30),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 350, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: SlideYFadeInBottom(
                      0.4,
                      SizedBox(
                        width: 250,
                        child: TextFormField(
                          autofocus: true,
                          onFieldSubmitted: (string) => navigate(),
                          controller: surnameController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Inserisci un cognome.";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                          cursorColor: Colors.deepPurple,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            icon: const Icon(Icons.person),
                            filled: true,
                            labelText: "Cognome",
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 25),
                  Flexible(
                    child: SizedBox(
                      width: 250,
                      child: SlideYFadeInBottom(
                        0.6,
                        TextFormField(
                          onFieldSubmitted: (string) => navigate(),
                          controller: phoneController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Inserisci un telefono.";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                          cursorColor: Colors.deepPurple,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            icon: const Icon(Icons.phone),
                            labelText: "Telefono",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 350, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: SizedBox(
                      width: 300,
                      child: SlideYFadeInBottom(
                        1.2,
                        TextFormField(
                          onFieldSubmitted: (string) => navigate(),
                          controller: addressController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Inserisci un indirizzo.";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                          cursorColor: Colors.deepPurple,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            icon: const Icon(Icons.location_city_rounded),
                            labelText: "Indirizzo",
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 25),
                  Flexible(
                    child: SizedBox(
                      width: 150,
                      child: SlideYFadeInBottom(
                        1.4,
                        TextFormField(
                          onFieldSubmitted: (string) => navigate(),
                          controller: doornoController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Inserisci un numero civico.";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                          cursorColor: Colors.deepPurple,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            labelText: "Numero civico",
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 25),
                  Flexible(
                    child: SizedBox(
                      width: 100,
                      child: SlideYFadeInBottom(
                        1.6,
                        TextFormField(
                          onFieldSubmitted: (string) => navigate(),
                          controller: floorController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Inserisci il piano.";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                          cursorColor: Colors.deepPurple,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            labelText: "Piano",
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 25),
                  Flexible(
                    child: SizedBox(
                      width: 200,
                      child: SlideYFadeInBottom(
                        1.6,
                        TextFormField(
                          onFieldSubmitted: (string) => navigate(),
                          controller: areaController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Inserisci la località.";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                          cursorColor: Colors.deepPurple,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            labelText: "Località",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 350, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: SizedBox(
                      width: 120,
                      child: SlideYFadeInBottom(
                        2,
                        TextFormField(
                          onFieldSubmitted: (string) => navigate(),
                          controller: discountController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Inserisci uno sconto.";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                          cursorColor: Colors.deepPurple,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            icon: const Icon(Icons.euro),
                            //hintText: "Sconto",
                            labelText: "Sconto",
                            suffixText: "%",
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 25),
                  Flexible(
                    child: SizedBox(
                      width: 80,
                      child: SlideYFadeInBottom(
                        2.2,
                        TextFormField(
                          onFieldSubmitted: (string) => navigate(),
                          controller: creditController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Inserisci un piano.";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.words,
                          cursorColor: Colors.deepPurple,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            //hintText: "Credito",
                            labelText: "Credito",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 350, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: SizedBox(
                      width: 500,
                      child: SlideYFadeInBottom(
                        2,
                        TextFormField(
                          onFieldSubmitted: (string) => navigate(),
                          controller: notesController,
                          textCapitalization: TextCapitalization.words,
                          cursorColor: Colors.deepPurple,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            icon: const Icon(Icons.notes),
                            labelText: "Note",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            speedyButton(
                width: widget.fromCart
                    ? 180
                    : widget.fromCustomers
                        ? 180
                        : 110,
                text: widget.fromCart
                    ? "Ritorna al carrello >"
                    : widget.fromCustomers
                        ? "Ritorna ai clienti >"
                        : "Avanti >",
                color: Colors.white,
                pressed: navigate)
          ],
        ),
      ),
    );
  }
}
