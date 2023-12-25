import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:superkauf/generic/user/model/user_model.dart';

class UserDetailView extends StatelessWidget {
  final BoxConstraints constraints;
  final UserModel user;

  const UserDetailView(
      {super.key, required this.user, required this.constraints});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: constraints.maxWidth * 0.65,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 4.0),
            Material(
              elevation: 6,
              shape: const CircleBorder(),
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(user.profilePicture),
              ),
            ),
            const SizedBox(height: 16.0),
            SelectableText(
              user.username,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '${'user_info_registered_on_label'.tr()}: ${DateFormat('dd/MM/yyyy').format(user.createdAt)}',
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Karma: ${user.karma}',
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
