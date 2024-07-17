import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/utils/common_colors.dart';
import 'package:news_app/presentation/provider/news_provider.dart';
import 'package:news_app/presentation/screens/home/home_screen.dart';
import 'package:news_app/presentation/screens/signup/signup_screen.dart';
import 'package:news_app/presentation/widgets/textfield_container.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyColor,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 80),
            Text(
              'kAppName',
              style: TextStyle(
                color: kBlueColor,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 200),
            const SizedBox(height: 15),
            TextfieldContainer(
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: ' Email',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextfieldContainer(
              child: TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: ' Password',
                  border: InputBorder.none,
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    context.read<NewsProvider>().fetchNews();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()));
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      color: kBlueColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: kWhiteColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'New here?',
                    children: [
                      TextSpan(
                        text: ' Signup ',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            FocusScope.of(context).unfocus();
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) {
                              return const SignUpScreen();
                            }));
                          },
                        style: TextStyle(
                          color: kBlueColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
