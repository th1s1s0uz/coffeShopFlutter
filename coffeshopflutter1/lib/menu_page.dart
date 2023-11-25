import 'package:coffeshopflutter1/cards/coffeecards.dart';
import 'package:coffeshopflutter1/cards/dessert_cards.dart';
import 'package:coffeshopflutter1/color_manager.dart';
import 'package:coffeshopflutter1/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:coffeshopflutter1/models/coffee.dart';
import 'models/dessert.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final List<Coffee> coffeeList = [
    Coffee(
      id: 'espresso',
      name: 'Espresso',
      description: 'Intensely flavored coffee',
      imagePath: 'assets/images/espresso.svg',
      price: 2.0,
    ),
    Coffee(
      id: 'americano',
      name: 'Americano',
      description: 'Espresso with added hot water',
      imagePath: 'assets/images/americano.svg',
      price: 2.5,
    ),
    Coffee(
      id: 'frappe',
      name: 'Frappe',
      description: 'Iced coffee blended with milk',
      imagePath: 'assets/images/frappe.svg',
      price: 2.5,
    ),
    Coffee(
      id: 'latte',
      name: 'Latte',
      description: 'Espresso with steamed milk',
      imagePath: 'assets/images/latte.svg',
      price: 3.0,
    ),
    Coffee(
      id: 'macchiato',
      name: 'Macchiato',
      description: 'Espresso, fronty milk, bold flavor',
      imagePath: 'assets/images/machiato.svg',
      price: 3.0,
    ),
    Coffee(
      id: 'irishCoffee',
      name: 'Irish Coffee',
      description: 'Irish whiskey,sugar,cream, coffee',
      imagePath: 'assets/images/irish_coffee.svg',
      price: 7.0,
    ),
    Coffee(
      id: 'mocha',
      name: 'Mocha',
      description: 'Espresso, milk, chocolate',
      imagePath: 'assets/images/mocha.svg',
      price: 3.0,
    ),
    Coffee(
      id: 'tea',
      name: 'Tea',
      description: 'A cup of hot tea',
      imagePath: 'assets/images/tea.svg',
      price: 1.0,
    ),
    Coffee(
      id: 'cappucino',
      name: 'Cappucino',
      description: 'Espresso, milk, frothed milk,',
      imagePath: 'assets/images/cappucino.svg',
      price: 3.0,
    ),
    Coffee(
      id: 'turkishCoffee',
      name: 'Turkish Coffee',
      description: 'Classic Turkish Coffee',
      imagePath: 'assets/images/turkish_coffee.svg',
      price: 4.0,
    ),
  ];

  final List<Desserts> dessertList = [
    Desserts(
      id: 'Donot',
      name: 'Donot',
      description: 'Cinnamon-coated warm donuts',
      imagePath: 'assets/images/donot.svg',
      price: 3.0,
    ),
    Desserts(
      id: 'muffin',
      name: 'Muffin',
      description: 'Intensely chocolate-filled muffin',
      imagePath: 'assets/images/muffin.svg',
      price: 4.0,
    ),
    Desserts(
      id: 'cheeseCake',
      name: 'Cheesecake',
      description: 'Cream cheese and biscuit harmony',
      imagePath: 'assets/images/cake.svg',
      price: 5.0,
    ),
    Desserts(
      id: 'cookies',
      name: 'Cookies',
      description: 'Hazelnut and chocolate cookies',
      imagePath: 'assets/images/cookies.svg',
      price: 3.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      appBar: AppBar(
        title: const Text('Soul & Bloom'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 275,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (Coffee coffee in coffeeList)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CoffeeCard(
                      coffee: coffee,
                      onTap: (int quantity) {
                        setState(() {
                          coffee.quantity = quantity;
                        });
                      },
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(
            height: 275,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (Desserts dessert in dessertList)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DessertCard(
                      dessert: dessert,
                      onTap: (int quantity) {
                        setState(() {
                          dessert.quantity = quantity;
                        });
                      },
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6),
            child: ElevatedButton(
              onPressed: () {
                if (_anyItemOrdered()) {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          OrderScreen(
                        coffeeList: coffeeList,
                        dessertList: dessertList,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
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
                } else {
                  _showNoItemOrderedDialog();
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                backgroundColor: ColorManager.buttonColor,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              child: const Text('CHOOSE'),
            ),
          ),
        ],
      ),
    );
  }

  bool _anyItemOrdered() {
    return coffeeList.any((coffee) => coffee.quantity > 0) ||
        dessertList.any((dessert) => dessert.quantity > 0);
  }

  void _showNoItemOrderedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Opsss!'),
          content: const Text('Please select at least one product.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tamam'),
            ),
          ],
        );
      },
    );
  }
}
