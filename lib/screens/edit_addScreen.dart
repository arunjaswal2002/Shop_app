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
  final _imageUrlFocusNode = FocusNode();

  var _isLoading = false;

  var _isInit = true;
  var _isInitValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)?.settings.arguments;
      if (productId != null) {
        _editableProduct = Provider.of<Products>(context, listen: false)
            .findById(productId.toString());
        _isInitValues = {
          'title': _editableProduct.title,
          'description': _editableProduct.description,
          'price': _editableProduct.price.toString(),
          // 'imageUrl': _editableProduct.imageUrl,
          'imageUrl': '',
        };

        _imageUrlController.text = _editableProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_editableProduct.id != '') {
      // '' means empty
      Provider.of<Products>(context, listen: false)
          .editProduct(_editableProduct.id, _editableProduct);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      Provider.of<Products>(context, listen: false)
          .addProduct(_editableProduct)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Edit Product'), actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: _saveForm)
        ]),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _form,
                  child: ListView(children: <Widget>[
                    TextFormField(
                      initialValue: _isInitValues['title'],
                      decoration: InputDecoration(label: Text('Title')),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      onSaved: (value) {
                        _editableProduct = Product(
                            title: value as String,
                            id: _editableProduct.id,
                            isFavorite: _editableProduct.isFavorite,
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
                      initialValue: _isInitValues['price'],
                      decoration: InputDecoration(label: Text('Price')),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      onSaved: (value) {
                        _editableProduct = Product(
                            title: _editableProduct.title,
                            isFavorite: _editableProduct.isFavorite,
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
                      initialValue: _isInitValues['description'],
                      decoration: InputDecoration(label: Text('Description')),
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      onSaved: (value) {
                        _editableProduct = Product(
                            title: _editableProduct.title,
                            isFavorite: _editableProduct.isFavorite,
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
                          margin: const EdgeInsets.only(top: 18, right: 10),
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
                            // initialValue: _isInitValues['imageUrl'],
                            decoration: const InputDecoration(
                                labelText: 'Enter the Image URL'),
                            keyboardType: TextInputType.url,
                            focusNode: _imageUrlFocusNode,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            onSaved: (value) {
                              _editableProduct = Product(
                                  title: _editableProduct.title,
                                  id: _editableProduct.id,
                                  price: _editableProduct.price,
                                  imageUrl: value as String,
                                  isFavorite: _editableProduct.isFavorite,
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
