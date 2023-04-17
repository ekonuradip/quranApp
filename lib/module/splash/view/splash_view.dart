import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quranapp/core.dart';
import 'package:quranapp/globals.dart';
import '../controller/splash_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  Widget build(context, SplashController controller) {
    controller.view = this;

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Quran App",
                  style: GoogleFonts.poppins(
                    color: text1,
                    fontWeight: FontWeight.bold,
                    fontSize: 28.0,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Learn Quran every day \n and recite once everyday",
                  style: GoogleFonts.poppins(
                    color: primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 48.0,
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 450,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: text1,
                          borderRadius: BorderRadius.circular(30)),
                      child: SvgPicture.asset('assets/svgs/splash.svg'),
                    ),
                    Positioned(
                      left: 0,
                      bottom: -23,
                      right: 0,
                      child: Center(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DashboardView(),
                            ));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 16),
                            decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              "Get Started",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<SplashView> createState() => SplashController();
}
