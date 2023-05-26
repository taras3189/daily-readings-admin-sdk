
import 'package:daily_readings_admin_sdk/screens/product/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import '../../helpers/slide_right_route.dart';
import '../../models/products.dart';
import 'edit_product_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key, required this.products})
      : super(key: key);
  final Products products;
  static const String _title = 'Users';

  @override
  Widget build(BuildContext context) {
    return StatefulProductDetailsWidget(products: products);
  }
}

class StatefulProductDetailsWidget extends StatefulWidget {
  const StatefulProductDetailsWidget({Key? key, required this.products})
      : super(key: key);
  final Products products;

  @override
  // ignore: no_logic_in_create_state
  _ProductDetailsWidgetState createState() =>
      _ProductDetailsWidgetState(products: products);
}

class _ProductDetailsWidgetState extends State<StatefulProductDetailsWidget> {
  _ProductDetailsWidgetState({required this.products});

  final Products products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 26, 255, 1)),
        title: const Text(
          'Product Details',
          style: TextStyle(
            height: 1.171875,
            fontSize: 18.0,
            fontFamily: 'Roboto Condensed',
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 26, 255, 1),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 26, 255, 1)),
          onPressed: () => Navigator.pushReplacement(
              context,
              SlideRightRoute(
                  page: const ProductsScreen(
                errMsg: '',
              ))),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Card(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: const Color.fromARGB(255, 255, 255, 255),
                    border:
                        Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  width: 440,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Product Name:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(widget.products.prodName.toString(),
                                style: Theme.of(context).textTheme.titleMedium)
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Product Description:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(widget.products.prodDescription.toString(),
                                style: Theme.of(context).textTheme.titleMedium)
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Product Image:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Image.network(widget.products.prodImage.toString()),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Product Price:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(
                                NumberFormat.currency(
                                        locale: 'id', symbol: 'Rp')
                                    .format(widget.products.prodPrice),
                                style: Theme.of(context).textTheme.titleMedium)
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              child: SizedBox(
                                height: 60.0,
                                width: MediaQuery.of(context).size.width * 1.0,
                                child: ElevatedButton.icon(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    size: 24.0,
                                  ),
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      side: const BorderSide(
                                          color:
                                              Color.fromARGB(255, 128, 255, 0),
                                          width: 1.0),
                                    )),
                                    backgroundColor: MaterialStateProperty.all<
                                            Color>(
                                        const Color.fromARGB(255, 255, 200, 0)),
                                  ),
                                  onPressed: () async {
                                    Navigator.pushReplacement(
                                        context,
                                        SlideRightRoute(
                                            page: EditProductScreen(
                                          products: products,
                                        )));
                                  },
                                  label: const Text('EDIT',
                                      style: TextStyle(
                                        height: 1.171875,
                                        fontSize: 24.0,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      )),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              child: SizedBox(
                                height: 60.0,
                                width: MediaQuery.of(context).size.width * 1.0,
                                child: ElevatedButton.icon(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    size: 24.0,
                                  ),
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      side: const BorderSide(
                                          color:
                                              Color.fromARGB(255, 128, 255, 0),
                                          width: 1.0),
                                    )),
                                    backgroundColor: MaterialStateProperty.all<
                                            Color>(
                                        const Color.fromARGB(255, 255, 200, 0)),
                                  ),
                                  onPressed: () async {
                                    _confirmDialog();
                                  },
                                  label: const Text('DELETE',
                                      style: TextStyle(
                                        height: 1.171875,
                                        fontSize: 24.0,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ))),
        ),
      ),
    );
  }

  Future<void> _confirmDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning!'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want delete this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Yes'),
              onPressed: () async {
                EasyLoading.show();
                
              },
            ),
            ElevatedButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
