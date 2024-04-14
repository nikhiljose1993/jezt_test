import 'package:flutter/material.dart';

class MovieSkelton extends StatelessWidget {
  const MovieSkelton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: Colors.white.withOpacity(.4),
      ),
      padding: const EdgeInsets.all(4),
      child: Column(
        children: [
          Expanded(
            child: Container(
              margin:
                  const EdgeInsets.only(bottom: 11, top: 6, left: 6, right: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
              ),
            ),
          ),
          Container(
            height: 16,
            width: 160,
            margin: const EdgeInsets.only(bottom: 11),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
            ),
          ),
          Container(
            height: 16,
            width: 60,
            margin: const EdgeInsets.only(bottom: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
