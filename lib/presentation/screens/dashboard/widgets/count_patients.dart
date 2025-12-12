// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:idoc_admin_side/logic/blocs/dashboard/dashboard_bloc.dart';
// import 'package:idoc_admin_side/logic/blocs/dashboard/dashboard_state.dart';

// class PatientsCountWidget extends StatelessWidget {
//   const PatientsCountWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<DashboardBloc, DashboardState>(
//       builder: (context, state) {
//         int totalPatients = 0;
//         int malePatients = 0;
//         int femalePatients = 0;

//         if (state is DashboardLoaded) {
//           totalPatients = state.data.totalPatients;
//           malePatients = state.data.malePatients;
//           femalePatients = state.data.femalePatients;
//         }

//         if (state is DashboardLoading) {
//           return const SizedBox(
//             height: 200,
//             child: Center(child: CircularProgressIndicator()),
//           );
//         }

//         return LayoutBuilder(
//           builder: (context, constraints) {
//             double containerWidth = constraints.maxWidth * 0.4;
//             double imageWidth = constraints.maxWidth * 0.2;

//             return Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 111, 202, 120),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   height: 200,
//                   width: containerWidth,
//                   child: Column(
//                     children: [
//                       const SizedBox(height: 10),
//                       const Center(
//                         child: Text(
//                           "patient",
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                       Text(
//                         "TOTAL    : $totalPatients",
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 17,
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                       Text(
//                         "MALE     : $malePatients",
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 17,
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                       Text(
//                         "FEMALE : $femalePatients",
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 17,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(width: 20),
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   height: 200,
//                   width: imageWidth,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(20),
//                     child: Image.network(
//                       "https://st2.depositphotos.com/1005435/6561/i/950/depositphotos_65615121-stock-photo-happy-man-isolated-full-body.jpg",
//                       fit: BoxFit.cover,
//                       loadingBuilder: (context, child, loadingProgress) {
//                         if (loadingProgress == null) return child;
//                         return const Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       },
//                       errorBuilder: (context, error, stackTrace) {
//                         return const Icon(Icons.error);
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
// }
