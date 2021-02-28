import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/product/product.dart';
import '../../providers/products/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product-screen';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _formRef = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null,
    title: '',
    imageUrl: '',
    price: 0,
    description: '',
  );
  bool _isInit = true;
  bool _isProductLoading = false;

  var _initValues = {
    "title": '',
    "imageUrl": '',
    "price": '',
    "description": '',
  };

  @override
  void initState() {
    _imageFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<ProductsProvider>(context).findbyId(productId);
        _initValues = {
          "title": _editedProduct.title,
          "imageUrl": '',
          "price": _editedProduct.price.toString(),
          "description": _editedProduct.description,
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _descriptionFocusNode.dispose();
    _priceFocusNode.dispose();
    _imageFocusNode.dispose();
    _imageFocusNode.removeListener(_updateImageUrl);
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _onSaveForm() {
    final isFormValid = _formRef.currentState.validate();
    if (!isFormValid) {
      return;
    }
    _formRef.currentState.save();
    setState(() {
      _isProductLoading = true;
    });
    if (_editedProduct.id != null) {
      Provider.of<ProductsProvider>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
      setState(() {
        _isProductLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      Provider.of<ProductsProvider>(context, listen: false)
          .addProduct(_editedProduct)
          .catchError((error) {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: Text('Error occured!'),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Okay'))
                ],
                content: Text(
                  error.toString(),
                ));
          },
        );
      }).then((_) {
        setState(() {
          _isProductLoading = false;
        });
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit product'),
        actions: [
          IconButton(
            icon: Icon(Icons.save_alt_rounded),
            onPressed: () {
              _onSaveForm();
            },
          )
        ],
      ),
      body: _isProductLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(15),
              child: Form(
                key: _formRef,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Title'),
                      initialValue: _initValues['title'],
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      onSaved: (newValue) {
                        _editedProduct = Product(
                          title: newValue,
                          imageUrl: _editedProduct.imageUrl,
                          price: _editedProduct.price,
                          description: _editedProduct.description,
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a title';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Price'),
                      initialValue: _initValues['price'],
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      onSaved: (newValue) {
                        _editedProduct = Product(
                          title: _editedProduct.title,
                          imageUrl: _editedProduct.imageUrl,
                          price: double.parse(newValue),
                          description: _editedProduct.description,
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter valid number';
                        }
                        if (double.parse(value) < 0) {
                          return 'Please enter valid number that is greater than 0';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Description'),
                      initialValue: _initValues['description'],
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      onSaved: (newValue) {
                        _editedProduct = Product(
                          title: _editedProduct.title,
                          imageUrl: _editedProduct.imageUrl,
                          price: _editedProduct.price,
                          description: newValue,
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a description';
                        }
                        if (value.length < 10) {
                          return 'Please provide a longer description';
                        }
                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                            width: 2,
                            color: Colors.black,
                          )),
                          child: _imageUrlController.text.isEmpty
                              ? Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                      'Enter an image url to check a preview'))
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Image url'),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: _imageUrlController,
                              focusNode: _imageFocusNode,
                              onFieldSubmitted: (_) {
                                print(_);
                                _onSaveForm();
                              },
                              onSaved: (newValue) {
                                _editedProduct = Product(
                                  title: _editedProduct.title,
                                  imageUrl: newValue,
                                  price: _editedProduct.price,
                                  description: _editedProduct.description,
                                  id: _editedProduct.id,
                                  isFavorite: _editedProduct.isFavorite,
                                );
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please provide an image Url';
                                }
                                if (!value.startsWith('http') &&
                                    !value.startsWith('https')) {
                                  return 'Please provide a valid Url';
                                }
                                if (!value.endsWith('.png') &&
                                    !value.endsWith('.jpg') &&
                                    !value.endsWith('.jpeg')) {
                                  return 'Please enter a valid Url';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
