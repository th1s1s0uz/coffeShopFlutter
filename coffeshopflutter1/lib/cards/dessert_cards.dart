import 'package:coffeshopflutter1/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:coffeshopflutter1/models/dessert.dart';

class DessertCard extends StatefulWidget {
  final Desserts dessert;
  final Function(int) onTap;

  const DessertCard({Key? key, required this.dessert, required this.onTap})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DessertCardState createState() => _DessertCardState();
}

class _DessertCardState extends State<DessertCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onTap(widget.dessert.quantity + 1);
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(18.0),
        ),
        child: Container(
          width: 250,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (widget.dessert.quantity > 0) {
                          widget.onTap(widget.dessert.quantity - 1);
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: ColorManager.leftTopButtonColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Text(
                        '−',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: ColorManager.buttonColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      '${widget.dessert.quantity}',
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SvgPicture.asset(
                widget.dessert.imagePath!,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 8),
              Text(
                widget.dessert.name!,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(widget.dessert.description!),
              const SizedBox(height: 8),
              Text(
                '\$${widget.dessert.price}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
