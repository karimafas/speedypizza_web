import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:speedypizza_web/components/CartListView.dart';
import 'package:speedypizza_web/components/SendButtonRow.dart';
import 'package:speedypizza_web/components/TotalAndItemsNumber.dart';
import 'package:speedypizza_web/provider/cart.dart';
import 'package:speedypizza_web/globals/globals.dart' as globals;

var outContext;

class CartView extends StatefulWidget {
  const CartView({
    Key key,
  }) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  TextEditingController _notesController = new TextEditingController();
  DateFormat _dateFormat = DateFormat("dd-MM-yyyy");

  @override
  void initState() {
    _notesController.text = Provider.of<Cart>(context, listen: false).notes;
  }

  @override
  Widget build(BuildContext context) {
    outContext = context;
    return Padding(
      padding: const EdgeInsets.only(top: 70, left: 100, right: 100),
      child: Consumer<Cart>(builder: (context, data, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(height: 20),
            Container(
              height: 4,
              color: Colors.deepPurple,
            ),
            Container(height: 20),
            CartListView(),
            Container(height: 30),
            TotalAndItemsNumber(data: data),
            Container(height: 20),
            NotesField(notesController: _notesController),
            Container(height: 50),
            SendButtonRow(notesController: _notesController, dateFormat: _dateFormat, data: data),
            Container(height: 100),
          ],
        );
      }),
    );
  }
}

class NotesField extends StatelessWidget {
  const NotesField({
    Key key,
    @required TextEditingController notesController,
  }) : _notesController = notesController, super(key: key);

  final TextEditingController _notesController;

  @override
  Widget build(BuildContext context) {
    _notesController.text = globals.notes;

    return TextFormField(
      controller: _notesController,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(labelText: "Note"),
    );
  }
}

class ShowEditViewButton extends StatelessWidget {
  const ShowEditViewButton({
    Key key,
    @required this.editPressed,
  }) : super(key: key);

  final Function editPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("images/dots.png"),
        ),
        onPressed: editPressed,
        heroTag: null,
        backgroundColor: Colors.deepPurple);
  }
}

class ModNotification extends StatelessWidget {
  const ModNotification({
    Key key,
    @required this.hasMod,
  }) : super(key: key);

  final bool hasMod;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 20,
        left: 20,
        child: AnimatedOpacity(
          opacity: hasMod ? 1 : 0,
          duration: Duration(milliseconds: 300),
          child: Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.redAccent),
          ),
        ));
  }
}
