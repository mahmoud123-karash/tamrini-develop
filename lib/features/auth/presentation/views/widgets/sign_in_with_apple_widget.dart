import 'package:flutter/material.dart';
import 'package:tamrini/core/shared/assets.dart';

class SignInWithAppleIconWidget extends StatelessWidget {
  const SignInWithAppleIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        child: Container(
          decoration: const ShapeDecoration(
            shape: CircleBorder(),
            color: Colors.white,
          ),
          width: 50,
          height: 40,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 40,
                height: 30,
                child: Image.asset(
                  Assets.imagesAppleLogopng,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
