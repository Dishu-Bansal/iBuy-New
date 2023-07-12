import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SideWidget extends StatelessWidget {
  const SideWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //color: Colors.red,
      width: MediaQuery.of(context).size.width * 0.6,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          SvgPicture.asset(
            "bg.svg",
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width * 0.6,
          ),
          Center(child: Image.asset("shop.png", width: 450)),
        ],
      ),
    );
  }
}
