
import 'package:daily_readings_admin_sdk/screens/product/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../helpers/slide_right_route.dart';
class AddProductScreen extends StatelessWidget {
  const AddProductScreen({Key? key}) : super(key: key);
  static const String _title = 'Add Product';

  @override
  Widget build(BuildContext context) {
    return const StatefulAddProductWidget();
  }
}

class StatefulAddProductWidget extends StatefulWidget {
  const StatefulAddProductWidget({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _AddProductWidgetState createState() => _AddProductWidgetState();
}

class _AddProductWidgetState extends State<StatefulAddProductWidget> {
  // final ApiService api = ApiService();
  final _addProductFormKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _productDescriptionController = TextEditingController();
  final _productImageController = TextEditingController();
  final _productPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 26, 255, 1)),
        title: const Text(
          'Add Product',
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
              context, SlideRightRoute(page: const ProductsScreen(errMsg: ''))),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(15, 80, 15, 20),
                child: Text(
                  'Please fill your product name, description, image, and price',
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.171875,
                    fontSize: 18.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: TextFormField(
                  controller: _productNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your product name';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    errorStyle:
                        TextStyle(color: Color.fromARGB(255, 26, 255, 1)),
                    fillColor: Color.fromARGB(255, 0, 0, 0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 128, 255, 0), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 128, 255, 0), width: 1),
                    ),
                    labelText: 'Product Name',
                    hintText: 'Product Name',
                    prefixIcon: Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      child: Icon(
                        Icons.text_format,
                        color: Color.fromARGB(255, 128, 255, 0),
                        size: 24,
                      ),
                    ),
                    labelStyle: TextStyle(
                        height: 1.171875,
                        fontSize: 24.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 128, 255, 0)),
                    hintStyle: TextStyle(
                        height: 1.171875,
                        fontSize: 24.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 128, 255, 0)),
                    filled: true,
                  ),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 128, 255, 0), fontSize: 24.0),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: TextFormField(
                  controller: _productDescriptionController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your product description';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    errorStyle:
                        TextStyle(color: Color.fromARGB(255, 26, 255, 1)),
                    fillColor: Color.fromARGB(255, 0, 0, 0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 128, 255, 0), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 235, 235, 235), width: 1),
                    ),
                    labelText: 'Product Description',
                    hintText: 'Product Description',
                    prefixIcon: Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      child: Icon(
                        Icons.text_fields,
                        color: Color.fromARGB(255, 128, 255, 0),
                        size: 24,
                      ),
                    ),
                    labelStyle: TextStyle(
                        height: 1.171875,
                        fontSize: 24.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 128, 255, 0)),
                    hintStyle: TextStyle(
                        height: 1.171875,
                        fontSize: 24.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 128, 255, 0)),
                    filled: true,
                  ),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 128, 255, 0), fontSize: 24.0),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: TextFormField(
                  controller: _productImageController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your product image URL';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  autocorrect: true,
                  keyboardType: TextInputType.url,
                  decoration: const InputDecoration(
                    errorStyle:
                        TextStyle(color: Color.fromARGB(255, 26, 255, 1)),
                    fillColor: Color.fromARGB(255, 0, 0, 0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 128, 255, 0), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 235, 235, 235), width: 1),
                    ),
                    labelText: 'Product Image URL',
                    hintText: 'Product Image URL',
                    prefixIcon: Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      child: Icon(
                        Icons.image,
                        color: Color.fromARGB(255, 128, 255, 0),
                        size: 24,
                      ),
                    ),
                    labelStyle: TextStyle(
                        height: 1.171875,
                        fontSize: 24.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 128, 255, 0)),
                    hintStyle: TextStyle(
                        height: 1.171875,
                        fontSize: 24.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 128, 255, 0)),
                    filled: true,
                  ),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 128, 255, 0), fontSize: 24.0),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: TextFormField(
                  controller: _productPriceController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your product price';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  autocorrect: true,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    errorStyle:
                        TextStyle(color: Color.fromARGB(255, 26, 255, 1)),
                    fillColor: Color.fromARGB(255, 0, 0, 0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 128, 255, 0), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 235, 235, 235), width: 1),
                    ),
                    labelText: 'Product Price',
                    hintText: 'Product Price',
                    prefixIcon: Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      child: Icon(
                        Icons.monetization_on,
                        color: Color.fromARGB(255, 128, 255, 0),
                        size: 24,
                      ),
                    ),
                    labelStyle: TextStyle(
                        height: 1.171875,
                        fontSize: 24.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 128, 255, 0)),
                    hintStyle: TextStyle(
                        height: 1.171875,
                        fontSize: 24.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 128, 255, 0)),
                    filled: true,
                  ),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 128, 255, 0), fontSize: 24.0),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: SizedBox(
                  height: 60.0,
                  width: MediaQuery.of(context).size.width * 1.0,
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.save,
                      color: Color.fromARGB(255, 0, 0, 0),
                      size: 24.0,
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: const BorderSide(
                            color: Color.fromARGB(255, 128, 255, 0),
                            width: 1.0),
                      )),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 255, 200, 0)),
                    ),
                    onPressed: () async {
                      if (_addProductFormKey.currentState!.validate()) {
                        _addProductFormKey.currentState!.save();
                        EasyLoading.show();
                        // var res = await api.addProduct(
                        //     _productNameController.text,
                        //     _productDescriptionController.text,
                        //     _productImageController.text,
                        //     _productPriceController.text);

                        // switch (res.statusCode) {
                        //   case 201:
                        //     EasyLoading.dismiss();
                        //     Navigator.pushReplacement(
                        //         context,
                        //         SlideRightRoute(
                        //             page: const ProductsScreen(
                        //           errMsg: 'Product Added Successfully',
                        //         )));
                        //     break;
                        //   case 400:
                        //     EasyLoading.dismiss();
                        //     var data = jsonDecode(res.body);
                        //     if (data["msg"]) {
                        //       ScaffoldMessenger.of(context)
                        //           .showSnackBar(SnackBar(
                        //         content: Text(data["msg"].toString()),
                        //       ));
                        //     }
                        //     ScaffoldMessenger.of(context)
                        //         .showSnackBar(const SnackBar(
                        //       content: Text("Failed to Add Product"),
                        //     ));
                        //     break;
                        //   case 403:
                        //     EasyLoading.dismiss();
                        //     ScaffoldMessenger.of(context)
                        //         .showSnackBar(const SnackBar(
                        //       content: Text("Permission Denied"),
                        //     ));
                        //     break;
                        //   default:
                        //     EasyLoading.dismiss();
                        //     ScaffoldMessenger.of(context)
                        //         .showSnackBar(const SnackBar(
                        //       content: Text("Failed to Add Product"),
                        //     ));
                        //     break;
                        // }
                      }
                    },
                    label: const Text('SAVE',
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
      ),
    );
  }
}