// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:idoc_admin_side/logic/blocs/dashboard/dashboard_bloc.dart';
// import 'package:idoc_admin_side/logic/blocs/dashboard/dashboard_state.dart';

// class DoctorCountWidget extends StatelessWidget {
//   const DoctorCountWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<DashboardBloc, DashboardState>(
//       builder: (context, state) {
//         int totalDoctors = 0;
//         int maleDoctors = 0;
//         int femaleDoctors = 0;

//         if (state is DashboardLoaded) {
//           totalDoctors = state.data.totalDoctors;
//           maleDoctors = state.data.maleDoctors;
//           femaleDoctors = state.data.femaleDoctors;
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
//                           "Doctors",
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                       Text(
//                         "TOTAL    : $totalDoctors",
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 17,
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                       Text(
//                         "MALE     : $maleDoctors",
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 17,
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                       Text(
//                         "FEMALE : $femaleDoctors",
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
//                       "https://media.istockphoto.com/id/147948536/photo/female-doctor-standing-with-arms-crossed-isolated.jpg?s=612x612&w=0&k=20&c=4RZPVLQUuBkP7qDwfpSwlJ8yTQNBqFPI94oJvHSZgvE=",
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