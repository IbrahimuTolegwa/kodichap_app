import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class imageCarousel extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String rooms;

  const imageCarousel({super.key, required this.imageUrl, required this.title, required this.rooms});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          imageUrl,
          fit: BoxFit.cover, // Cover the available space
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            // Display an error icon or text if the image fails to load
            return Center(
              child: Icon(
                Icons.error,
                color: Colors.red,
                size: 50,
              ),
            );
          },
        ),

        Positioned(
            bottom: 0,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  )
                ]
              ),
                child: Column(
                  children: [
                    Text(title),
                    SizedBox( height: 10,),
                    Text(rooms),
                  ],
                ),))
      ],
    );
  }
}
