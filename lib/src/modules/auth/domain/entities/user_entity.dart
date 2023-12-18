import 'package:smatrackz/core.dart';

class UserEntity extends Equatable {
  // TODO: add department id
  final String companyId;
  final String companyName;
  final String email;
  final String address;
  final String? website;
  final String? phoneNumber;
  final String? profilePicture;
  final String? bio;
  final num? latitude;
  final num? longitude;
  final String? workStart;
  final String? workEnd;
  final String? created;

  const UserEntity({
    required this.companyId,
    required this.companyName,
    required this.email,
    required this.address,
    this.website,
    this.phoneNumber,
    this.profilePicture,
    this.bio,
    required this.latitude,
    required this.longitude,
    this.workStart,
    this.workEnd,
    this.created,
  });

  const UserEntity.empty()
      : this(
          companyId: '',
          companyName: '',
          email: '',
          address: '',
          website: '',
          phoneNumber: '',
          profilePicture: '',
          bio: '',
          latitude: 0,
          longitude: 0,
          workStart: '',
          workEnd: '',
          created: '',
        );

  bool get isAdmin => email == 'admin@gmail.com';

  @override
  List<Object?> get props => [
        companyId,
        companyName,
        email,
        address,
        website,
        phoneNumber,
        profilePicture,
        bio,
        latitude,
        longitude,
        workStart,
        workEnd,
        created,
      ];

  @override
  String toString() {
    return '\n UserEntity{'
        '\n company_id: $companyId, '
        '\n company_name: $companyName, '
        '\n email: $email, '
        '\n address: $address, '
        '\n website: $website '
        '\n phone_number: $phoneNumber '
        '\n profile_picture: $profilePicture '
        '\n bio: $bio'
        '\n latitude: $latitude, '
        '\n longitude: $longitude '
        '\n work_start: $workStart, '
        '\n work_end: $workEnd'
        '\n created: $created, '
        '\n }';
  }
}
