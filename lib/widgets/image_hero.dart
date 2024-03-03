import 'package:flutter/material.dart';
import 'package:mengedegna_app/style/style.dart';

class ImageHero extends StatelessWidget {
  const ImageHero(
      {Key? key,
      required this.photo,
      required this.onTap,
      required this.width,
      this.plateNumber,
      this.driverName})
      : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double width;
  final String? plateNumber, driverName;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: width,
            child: Hero(
              tag: photo,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  child: Image.network(
                    photo,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          if (plateNumber != null || driverName != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TitleFont(
                    text: 'Licence Plate: $plateNumber',
                    size: 20,
                  ),
                  TitleFont(
                    text: 'Driver: $driverName',
                    size: 20,
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
