import 'package:coffeshopflutter1/lastscreen.dart';
import 'package:flutter/material.dart';
import 'package:coffeshopflutter1/models/coffee.dart';
import 'package:coffeshopflutter1/models/dessert.dart';
import 'color_manager.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final String userName;
  final double totalPrice;

  const OrderConfirmationScreen(
      {Key? key, required this.userName, required this.totalPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sipariş Onayı'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sipariş Onaylandı!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Toplam Fiyat: $totalPrice TL',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              'Siparişiniz $userName adına oluşturuldu.',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderScreen extends StatefulWidget {
  final List<Coffee> coffeeList;
  final List<Desserts> dessertList;

  const OrderScreen(
      {Key? key, required this.coffeeList, required this.dessertList})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late TextEditingController _userNameController;
  bool _isUserNameFilled = false;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _userNameController.addListener(() {
      setState(() {
        _isUserNameFilled = _userNameController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Coffee> orderedCoffees =
        widget.coffeeList.where((coffee) => coffee.quantity > 0).toList();
    List<Desserts> orderedDesserts =
        widget.dessertList.where((dessert) => dessert.quantity > 0).toList();

    double totalPrice = 0;
    for (Coffee coffee in orderedCoffees) {
      totalPrice += coffee.price! * coffee.quantity;
    }
    for (Desserts dessert in orderedDesserts) {
      totalPrice += dessert.price! * dessert.quantity;
    }

    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      appBar: AppBar(
        title: const Text('Confirm Your Order'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (orderedCoffees.isNotEmpty)
              Column(
                children: [
                  const Text(
                    'Coffees',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: orderedCoffees.length,
                    itemBuilder: (context, index) {
                      Coffee coffee = orderedCoffees[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        padding: const EdgeInsets.all(8.0),
                        color: ColorManager.cardBackgroundColor,
                        child: ListTile(
                          title: Text(
                            coffee.name!,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Quantity: ${coffee.quantity}',
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              Text(
                                'Price: \$${coffee.price}',
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              Text(
                                'Description: ${coffee.description}',
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            if (orderedDesserts.isNotEmpty)
              Column(
                children: [
                  const Text(
                    'Deserts',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: orderedDesserts.length,
                    itemBuilder: (context, index) {
                      Desserts desserts = orderedDesserts[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        padding: const EdgeInsets.all(8.0),
                        color: ColorManager.cardBackgroundColor,
                        child: ListTile(
                          title: Text(
                            desserts.name!,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Quantity: ${desserts.quantity}',
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              Text(
                                'Price: \$${desserts.price}',
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              Text(
                                'Description: ${desserts.description}',
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            Text(
              'Total Price: \$ $totalPrice',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _userNameController,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  labelText: 'Your order name',
                  labelStyle: TextStyle(
                    color: ColorManager.redColor,
                    fontSize: 18,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorManager.redColor),
                  ),
                ),
                textCapitalization: TextCapitalization.characters,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _isUserNameFilled
                    ? () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    LastScreen(
                              userName: _userNameController.text,
                              totalPrice: totalPrice,
                            ),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              var tween = Tween(begin: begin, end: end);
                              var offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
                  backgroundColor: ColorManager.buttonColor,
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
                child: const Text('CONFIRM'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
