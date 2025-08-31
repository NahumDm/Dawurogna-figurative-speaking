// // Helper widget to build styled cards for details
// import 'package:dawurogna_figurative_speaking/Core/Constants/constants.dart';
// import 'package:flutter/material.dart';

// class ProverbsDetailCard extends StatelessWidget {
//   final String content;

//   const ProverbsDetailCard({Key? key, required this.content}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 220.0,
//       child: Stack(
//         alignment: Alignment.center, // Center the text by default
//         children: [
//           // 1. Background Image (Bottom layer)
//           Container(
//             height: 220.0,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/images/dawuro_gihibli.png'),
//                 fit: BoxFit.cover,
//               ),
//               gradient: LinearGradient(
//                 colors: [Colors.black.withOpacity(0.6), Colors.transparent],
//                 begin: Alignment.bottomCenter,
//                 end: Alignment.topCenter,
//               ),
//             ),
//           ),

//           // 2. Text Content (Top layer)
//           Center(
//             child: Column(
//               children: [
//                 Text(
//                   content,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: Constants.mdFont,
//                     height: 1.5,
//                     color: Colors.white, // Changed to white for better contrast
//                     fontWeight: FontWeight.bold,
//                     shadows: [
//                       // Add a subtle shadow for even more readability
//                       Shadow(
//                         blurRadius: 4.0,
//                         color: Colors.black.withOpacity(0.5),
//                         offset: Offset(2.0, 2.0),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
