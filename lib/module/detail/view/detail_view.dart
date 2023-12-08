import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quranapp/core.dart';
import 'package:quranapp/globals.dart';
import 'package:quranapp/module/dashboard/models/ayat.dart';
import '../controller/detail_controller.dart';

class DetailView extends StatefulWidget {
  final int noSurah;
  const DetailView({super.key, required this.noSurah});

  Future<Surah> _getDetailSurah() async {
    var data = await Dio().get("https://equran.id/api/surat/$noSurah");
    return Surah.fromJson(json.decode(data.toString()));
  }

  @override
  Widget build(context, DetailController controller) {
    controller.view = this;
    return FutureBuilder<Surah>(
      future: _getDetailSurah(),
      initialData: null,
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: background,
          );
        }
        Surah surah = snapshot.data!;
        return Scaffold(
            backgroundColor: background,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: background,
              automaticallyImplyLeading: false,
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: SvgPicture.asset('assets/svgs/back.svg')),
              title: Text(
                surah.namaLatin,
                style: GoogleFonts.poppins(
                  color: text1,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    size: 24.0,
                    color: text1,
                  ),
                ),
              ],
            ),
            body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverToBoxAdapter(
                        child: _details(surah: surah),
                      )
                    ],
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: ListView.separated(
                    itemBuilder: (context, index) => _ayatItem(
                        ayat: surah.ayat!
                            .elementAt(index + (noSurah == 1 ? 1 : 0))),
                    itemCount: surah.jumlahAyat + (noSurah == 1 ? -1 : 0),
                    separatorBuilder: (context, index) => Container(),
                  ),
                )));
      }),
    );
  }

  Widget _ayatItem({required Ayat ayat}) => Padding(
        padding: EdgeInsets.only(top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                  color: primary, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Container(
                    width: 27,
                    height: 27,
                    decoration: BoxDecoration(
                        color: text1,
                        borderRadius: BorderRadius.circular(27 / 2)),
                    child: Center(
                      child: Text(
                        '${ayat.nomor}',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ),
                  ),
                  Spacer(),
                  const Icon(
                    Icons.share_outlined,
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  const Icon(
                    Icons.play_arrow_outlined,
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  const Icon(
                    Icons.bookmark_outline,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Text(
              ayat.ar,
              style:
                  GoogleFonts.amiri(fontWeight: FontWeight.bold, fontSize: 18),
              textAlign: TextAlign.right,
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              ayat.idn,
              style: GoogleFonts.poppins(fontSize: 16),
            ),
          ],
        ),
      );

  Widget _details({required Surah surah}) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Stack(
          children: [
            Container(
              height: 257,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [
                        0,
                        .6,
                        1
                      ],
                      colors: [
                        Color(0xffdf98fa),
                        Color(0xffb070fd),
                        Color(0xff9055ff)
                      ])),
            ),
            Opacity(
              opacity: .2,
              child: Positioned(
                bottom: 0,
                right: 0,
                child: SvgPicture.asset('assets/svgs/quran.svg'),
                width: 324 - 55,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              child: Column(
                children: [
                  Text(
                    surah.namaLatin,
                    style: GoogleFonts.poppins(
                        fontSize: 26, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    surah.arti,
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Divider(
                    color: text1.withOpacity(.35),
                    thickness: 2,
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        surah.tempatTurun.name,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2)),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        "${surah.jumlahAyat} Ayat",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  SvgPicture.asset('assets/svgs/bismillah.svg')
                ],
              ),
            )
          ],
        ),
      );

  @override
  State<DetailView> createState() => DetailController();
}
