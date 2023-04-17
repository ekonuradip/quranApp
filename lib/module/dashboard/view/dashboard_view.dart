import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quranapp/core.dart';
import 'package:quranapp/module/splash/tabs/hijb_tab.dart';
import 'package:quranapp/module/splash/tabs/surah_tab.dart';
import 'package:quranapp/module/splash/tabs/para_tab.dart';
import 'package:quranapp/module/splash/tabs/page_tab.dart';
import '../controller/dashboard_controller.dart';
import 'package:quranapp/globals.dart';
import 'package:google_fonts/google_fonts.dart';


class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  Widget build(context, DashboardController controller) {
    controller.view = this;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: background,
        leading: IconButton(
        onPressed: () {},
        icon:  Icon(
        Icons.menu_sharp,
        size: 24.0,
        color: text1,
        ),
        ),
        title:  Text("Quran App",style: GoogleFonts.poppins(
                    color: text1,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),),
        actions:  [
          IconButton(
          onPressed: () {},
          icon:  Icon(
          Icons.search,
          size: 24.0,
          color: text1,
          ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) =>[
                SliverToBoxAdapter(
                   child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                const SizedBox(
                height: 24.0,
                ),
                Text("Assalamu'alaikum",
                style: GoogleFonts.poppins(
                fontSize: 18.0,
                ),
                ),
                const SizedBox(
                height: 4.0,
                ),
                Text("Eko Nur Adi Prasetyo",
                style: GoogleFonts.poppins(
                fontSize: 24.0,
                fontWeight: FontWeight.bold
                ),
                ),
                const SizedBox(
                height: 24.0,
                ),
                Container(
                height: 131.0,
                decoration:  BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Color(0xffDF98FA),
                     primary,
                  ]
                ),
                borderRadius: BorderRadius.all(
                Radius.circular(
                16.0,
                ),
                ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 60,top: 20),
                      child: Column(
                        
                        children: [
                          
                          Container(
                            child: Row(
                              children: [
                                const Icon(
                                Icons.menu_book,
                                size: 24.0,
                                ),
                                const SizedBox(
                                width: 8.0,
                                ),
                                Text("Last Read",
                                style: GoogleFonts.poppins(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400
                                ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                          height: 20.0,
                          ),
                          Text("Al-Fatiah",
                          style: GoogleFonts.poppins(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                          ),
                          ),
                          const SizedBox(
                          height: 4.0,
                          ),
                          Text("Ayat 1",
                          style: GoogleFonts.poppins(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold
                          ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: SvgPicture.asset('assets/svgs/quran.svg')),
                  ],
                ),
                ),
                const SizedBox(
                height: 43.0,
                ),
              ],
            ),
                ),
                 SliverAppBar(
                  pinned: true,
                  elevation: 0,
                  backgroundColor: background,
                  automaticallyImplyLeading: false,
                  shape: Border(
                    bottom: BorderSide(
                      width: 3,
                      color: Color(0xFAAAAAAA).withOpacity(.4)
                    )
                  ),
                  bottom:  PreferredSize(
                    preferredSize: Size.fromHeight(0),
                    child: TabBar(
                      unselectedLabelColor: text1,
                      labelColor: Colors.white,
                      indicatorColor: text1,
                      indicatorWeight: 3,
                      tabs: [
                      _tabItem(label: "Surah"),
                      _tabItem(label: "Para"),
                      _tabItem(label: "Page"),
                      _tabItem(label: "Hijb"),
                    ]),
                  ),

                )
              ],
              body: TabBarView(children: [
                SurahTab(),
                ParaTab(),
                PageTab(),
                HijbTab()
               ],),
              ),
            
            
            
            
            
            
           ),
        ),
      
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
        _bottomBarItem(icon: "assets/svgs/quran-icon.svg",label: "quran"),
        _bottomBarItem(icon: "assets/svgs/lamp-icon.svg",label: "notification"),
        _bottomBarItem(icon: "assets/svgs/pray-icon.svg",label: "Pray Time"),
        _bottomBarItem(icon: "assets/svgs/hand-icon.svg",label: "Pray"),
        _bottomBarItem(icon: "assets/svgs/bookmark-icon.svg",label: "Bookmark"),
        
      ]),
    );
  }

  Tab _tabItem({required String label}) {
    return Tab(
      child: Text(label,style: GoogleFonts.poppins(color: text1, fontSize: 16, fontWeight: FontWeight.w600),),
    );
  }

  BottomNavigationBarItem _bottomBarItem(
    {required String icon, required String label}
  ) => BottomNavigationBarItem(
    icon: SvgPicture.asset(
      icon,
      color: background,
    ),
    activeIcon: SvgPicture.asset(
      icon,
      color: text1,
    ),
    label: label
    );

  @override
  State<DashboardView> createState() => DashboardController();
}