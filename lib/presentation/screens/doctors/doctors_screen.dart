// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:idoc_admin_side/core/constants/color.dart';
// import 'package:idoc_admin_side/data/models/doctor_model.dart';
// import 'package:idoc_admin_side/logic/blocs/doctors/doctors_bloc.dart';
// import 'package:idoc_admin_side/logic/blocs/doctors/doctors_event.dart';
// import 'package:idoc_admin_side/logic/blocs/doctors/doctors_state.dart';

// class DoctorsScreen extends StatelessWidget {
//   const DoctorsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final isWeb = kIsWeb;
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isDesktop = isWeb && screenWidth >= 600;

//     return Scaffold(
//       backgroundColor: const Color(0xFFE8EAF6),
//       appBar: isDesktop
//           ? null
//           : AppBar(
//               backgroundColor: Colors.white,
//               elevation: 0,
//               title: const Text(
//                 'Approved Doctors',
//                 style: TextStyle(color: Colors.black87),
//               ),
//             ),
//       body: BlocProvider(
//         create: (context) => DoctorsBloc()..add(LoadApprovedDoctorsEvent()),
//         child: BlocBuilder<DoctorsBloc, DoctorsState>(
//           builder: (context, state) {
//             if (state is DoctorsLoadingState) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (state is DoctorsErrorState) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.error_outline, size: 64, color: Colors.red),
//                     const SizedBox(height: 16),
//                     Text(
//                       'Error: ${state.message}',
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                   ],
//                 ),
//               );
//             }

//             if (state is DoctorsLoadedState) {
//               if (state.doctors.isEmpty) {
//                 return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.people_outline,
//                           size: 64, color: Colors.grey),
//                       const SizedBox(height: 16),
//                       const Text(
//                         'No Approved Doctors',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         'Approved doctors will appear here',
//                         style: TextStyle(color: Colors.grey.shade600),
//                       ),
//                     ],
//                   ),
//                 );
//               }

//               return Padding(
//                 padding: EdgeInsets.all(isDesktop ? 24 : 16),
//                 child: isDesktop
//                     ? _buildWebLayout(context, state.doctors)
//                     : _buildMobileLayout(context, state.doctors),
//               );
//             }

//             return const SizedBox.shrink();
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildWebLayout(BuildContext context, List<DoctorModel> doctors) {
//     return Center(
//       child: ConstrainedBox(
//         constraints: const BoxConstraints(maxWidth: 1200),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Approved Doctors',
//                       style: TextStyle(
//                         fontSize: 32,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       '${doctors.length} doctor${doctors.length > 1 ? 's' : ''}',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey.shade600,
//                       ),
//                     ),
//                   ],
//                 ),
//                 // Search bar (can be implemented later)
//                 Container(
//                   width: 300,
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(color: Colors.grey.shade300),
//                   ),
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Search doctors...',
//                       border: InputBorder.none,
//                       icon: Icon(Icons.search, color: Colors.grey.shade600),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 24),
//             Expanded(
//               child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 16,
//                   mainAxisSpacing: 16,
//                   childAspectRatio: 0.85,
//                 ),
//                 itemCount: doctors.length,
//                 itemBuilder: (context, index) {
//                   return _buildDoctorCard(context, doctors[index], true);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMobileLayout(BuildContext context, List<DoctorModel> doctors) {
//     return ListView.builder(
//       itemCount: doctors.length,
//       itemBuilder: (context, index) {
//         return _buildDoctorCard(context, doctors[index], false);
//       },
//     );
//   }

//   Widget _buildDoctorCard(
//       BuildContext context, DoctorModel doctor, bool isWeb) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             CircleAvatar(
//               radius: isWeb ? 50 : 40,
//               backgroundColor: primaryColor.withValues(alpha: 0.1),
//               backgroundImage:
//                   doctor.profileImage != null ? NetworkImage(doctor.profileImage!) : null,
//               child: doctor.profileImage == null
//                   ? Icon(
//                       Icons.person,
//                       size: isWeb ? 50 : 40,
//                       color: primaryColor,
//                     )
//                   : null,
//             ),
//             const SizedBox(height: 12),
//             Text(
//               doctor.name,
//               style: TextStyle(
//                 fontSize: isWeb ? 18 : 16,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 4),
//             Text(
//               doctor.email,
//               style: TextStyle(
//                 fontSize: isWeb ? 12 : 11,
//                 color: Colors.grey.shade600,
//               ),
//               textAlign: TextAlign.center,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const SizedBox(height: 12),
//             if (doctor.specialization != null)
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 4),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.medical_services,
//                         size: 14, color: Colors.grey.shade600),
//                     const SizedBox(width: 4),
//                     Flexible(
//                       child: Text(
//                         doctor.specialization!,
//                         style: TextStyle(
//                           fontSize: isWeb ? 13 : 12,
//                           color: Colors.grey.shade700,
//                         ),
//                         textAlign: TextAlign.center,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             if (doctor.hospital != null)
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 4),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.local_hospital,
//                         size: 14, color: Colors.grey.shade600),
//                     const SizedBox(width: 4),
//                     Flexible(
//                       child: Text(
//                         doctor.hospital!,
//                         style: TextStyle(
//                           fontSize: isWeb ? 13 : 12,
//                           color: Colors.grey.shade700,
//                         ),
//                         textAlign: TextAlign.center,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             const Spacer(),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               decoration: BoxDecoration(
//                 color: Colors.green.withValues(alpha: 0.2),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: const Text(
//                 'Approved',
//                 style: TextStyle(
//                   color: Colors.green,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 12,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Doctors screen')));
  }
}
