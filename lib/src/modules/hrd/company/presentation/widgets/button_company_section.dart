// import 'package:smatrackz/core.dart';
//
// class ButtonCompanySection extends StatelessWidget {
//   const ButtonCompanySection({
//     super.key,
//     required this.nameController,
//     required this.emailController,
//     required this.addCompanyFormKey,
//     required this.company,
//     required this.size,
//   });
//
//   final TextEditingController nameController;
//   final TextEditingController emailController;
//   final GlobalKey<FormState> addCompanyFormKey;
//   final UserModel company;
//   final Size size;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         AddEmployeeButton(
//           nameController: nameController,
//           emailController: emailController,
//           addCompanyFormKey: addCompanyFormKey,
//           company: company,
//         ),
//         const SizedBox(height: 10.0),
//         RoundedContainer(
//           width: 160.0,
//           radius: 5.0,
//           containerColor: AppColors.whiteColor,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const Icon(
//                   Icons.calendar_month_outlined,
//                   color: AppColors.greyColor,
//                   size: 15.0,
//                 ),
//                 const SizedBox(width: 5.0),
//                 Text(
//                   'Holiday Calendar',
//                   style: CustomTextStyle.textMediumRegular.copyWith(
//                     color: AppColors.greyColor,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(height: 10.0),
//         RoundedContainer(
//           width: 160.0,
//           radius: 5.0,
//           containerColor: AppColors.whiteColor,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const Icon(
//                   Icons.area_chart,
//                   color: AppColors.greyColor,
//                   size: 15.0,
//                 ),
//                 const SizedBox(width: 5.0),
//                 Text(
//                   'Team Reports',
//                   style: CustomTextStyle.textMediumRegular.copyWith(
//                     color: AppColors.greyColor,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
