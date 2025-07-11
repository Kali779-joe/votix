import 'package:flutter/material.dart';
import 'package:votix/component/buttons.dart';
import 'package:votix/component/votix_text.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: VotixAppBar(
      //   title: 'Dashboard',
      //   logo: Image.asset('assets/logo/votix.png', height: 28),
      //   height: 70,
      //   automaticallyImplyLeading: false,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              VotixText.title('Welcome to Votix!'),
              const SizedBox(height: 8),
              VotixText.body('Need to login'),
              const SizedBox(height: 32),
              VotixButton(
                text: 'login',
                leadingIcon: Icons.login,
                variant: VotixButtonVariant.primary,
                trailingIcon: Icons.arrow_forward,
                size: VotixButtonSize.large,
                onPressed: () {
                  Navigator.pushNamed(context, "/login");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
