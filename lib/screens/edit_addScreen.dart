import 'package:flutter/material.dart';
import '../providers/product.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class EditAddProductScreen extends StatefulWidget {
  const EditAddProductScreen({Key? key}) : super(key: key);
  static const routeName = '/editAddScreen';

  @override
  State<EditAddProductScreen> createState() => _EditAddProductScreenState();
}

class _EditAddProductScreenState extends State<EditAddProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editableProduct =
      Product(id: '', title: '', price: 0, description: '', imageUrl: '');

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    Provider.of<Products>(context, listen: false).addProduct(_editableProduct);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Edit Product'), actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: _saveForm)
        ]),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _form,
            child: ListView(children: <Widget>[
              TextFormField(
                decoration: InputDecoration(label: Text('Title')),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value) {
                  _editableProduct = Product(
                      title: value as String,
                      id: _editableProduct.id,
                      price: _editableProduct.price,
                      imageUrl: _editableProduct.imageUrl,
                      description: _editableProduct.description);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a valid title!';
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(label: Text('Price')),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value) {
                  _editableProduct = Product(
                      title: _editableProduct.title,
                      id: _editableProduct.id,
                      price: double.parse(value as String),
                      imageUrl: _editableProduct.imageUrl,
                      description: _editableProduct.description);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a Price!';
                  }

                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }

                  if (double.parse(value) <= 0) {
                    return 'Please enter a number greater than zero';
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(label: Text('Description')),
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                onSaved: (value) {
                  _editableProduct = Product(
                      title: _editableProduct.title,
                      id: _editableProduct.id,
                      price: _editableProduct.price,
                      imageUrl: _editableProduct.imageUrl,
                      description: value as String);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a valid Description!';
                  }

                  if (value.length < 10) {
                    return 'Too short!';
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: _imageUrlController.text.isEmpty
                        ? const Text(
                            'Enter the Url',
                            textAlign: TextAlign.center,
                          )
                        : FittedBox(
                            child: Image.network(_imageUrlController.text,
                                fit: BoxFit.cover)),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Enter the Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      onFieldSubmitted: (_) {
                        _saveForm();
                        setState(() {});
                      },
                      onSaved: (value) {
                        _editableProduct = Product(
                            title: _editableProduct.title,
                            id: _editableProduct.id,
                            price: _editableProduct.price,
                            imageUrl: value as String,
                            description: _editableProduct.description);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a Image Url!';
                        }
                        if (!value.startsWith('http') &&
                            !value.startsWith('https') &&
                            !value.endsWith('.jpg') &&
                            !value.endsWith('.png') &&
                            !value.endsWith('.jpeg')) {
                          return 'Please provide a valid Url';
                        }

                        return null;
                      },
                    ),
                  )
                ],
              )
            ]),
          ),
        ));
  }
}
