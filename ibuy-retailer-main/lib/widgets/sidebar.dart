// import 'package:flutter/material.dart';

// class Sidebar extends StatelessWidget {
//   final List sidebar;
//   final int selectedIndex;
//   const Sidebar({super.key, required this.sidebar, required this.selectedIndex});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 200,
//       color: Colors.black,
//       padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Center(
//             child: Image(
//               image: AssetImage("images/ANAblack.png"),
//               width: 100,
//             ),
//           ),
//           const SizedBox(
//             height: 15,
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: List.generate(sidebar.length, (index) {
//               return sideBarTile(index);
//             }),
//           )
//         ],
//       ),
//     );
//   }

//   Widget sideBarTile(int index) {
//     return GestureDetector(
//       onTap: () {
//         selectedIndex = index;
//       },
//       child: Container(
//         padding: EdgeInsets.all(10),
//         child: Text(
//           sidebar[index],
//           style: TextStyle(
//             color: selectedIndex == index ? Colors.white : Colors.grey,
//           ),
//         ),
//       ),
//     );
//   }
// }
