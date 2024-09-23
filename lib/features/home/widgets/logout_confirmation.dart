import 'package:flutter/material.dart';

import '../../auth/controllers/auth_controller.dart';

class LogoutConfirmation extends StatelessWidget {
  const LogoutConfirmation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Logout',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Are you sure you want to logout?',
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                ),
              ),
              TextButton(
                onPressed: () {
                  AuthController.instance.signOut();

                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Logout',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
