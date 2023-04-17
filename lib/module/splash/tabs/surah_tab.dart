// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quranapp/core.dart';
import 'package:quranapp/globals.dart';
import 'package:quranapp/module/dashboard/models/surah.dart';

class SurahTab extends StatelessWidget {
  const SurahTab({Key? key}) : super(key: key);

  Future<List<Surah>> _getSurahList() async {
    String data = await rootBundle.loadString('assets/datas/list-surah.json');
    return surahFromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Surah>>(
      future: _getSurahList(),
      initialData: [],
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        return ListView.separated(
            itemBuilder: (context, index) =>
                _surahItem(context: context, surah: snapshot.data!.elementAt(index)),
            separatorBuilder: (context, index) => Container(),
            itemCount: snapshot.data!.length);
      }),
    );
  }

  Widget _surahItem({required Surah surah, required BuildContext context}) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: (){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DetailView(noSurah:  surah.nomor,)));
    },
  child: Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Stack(
            children: [
              SvgPicture.asset('assets/svgs/nomor.svg'),
              SizedBox(
                height: 36,
                width: 36,
                child: Center(
                  child: Text(
                    "${surah.nomor}",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            width: 16.0,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                surah.namaLatin,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Row(
                children: [
                  Text(
                    surah.tempatTurun.name,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500, fontSize: 12),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Container(
                    width: 4,
                    height: 4,
                    
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(2)),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    "${surah.jumlahAyat} Ayat",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500, fontSize: 12),
                  ),
                ],
              )
            ],
          )),
          Text(
            surah.nama,
            style: GoogleFonts.amiri(),
          )
        ],
      ),
      ));
}
