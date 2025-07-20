import 'package:client/cor/providers/current_song_notifier.dart';
import 'package:client/cor/theme/app_pallete.dart';
import 'package:client/cor/utils.dart';
import 'package:client/features/home/view/pages/library_page.dart';
import 'package:client/features/home/view/pages/songs_page.dart';
import 'package:client/features/home/view/widgets/music_slab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int selectedIndex = 0;
  final pages = [SongsPage(), LibraryPage()];
  @override
  Widget build(BuildContext context) {
    final currentSong = ref.watch(currentSongNotifierProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          decoration: currentSong == null
              ? null : BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      hexToColor(currentSong.hexCode),
                      Pallete.transparentColor
                    ],
                    stops: [0.0, 0.3],
                  ),
                ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Pallete.whiteColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Pallete.whiteColor.withOpacity(0.3),
                              width: 1),
                        ),
                        child: const Icon(
                          Icons.music_note_rounded,
                          color: Pallete.whiteColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Music Player',
                              style: TextStyle(
                                color: Pallete.whiteColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              selectedIndex == 0
                                  ? 'Discover New Music'
                                  : 'Your Personal Library',
                              style: const TextStyle(
                                  color: Pallete.whiteColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.2),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildActionButton(
                              icon: Icons.search_rounded, onPressed: () {}),
                          const SizedBox(
                            width: 8,
                          ),
                          _buildActionButton(
                              icon: Icons.person_rounded, onPressed: () {}),
                        ],
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
      body: Stack(children: [
        pages[selectedIndex],
        const Positioned(bottom: 0, child: MusicSlab())
      ]),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (val) {
            setState(() {
              selectedIndex = val;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(
                  selectedIndex == 0
                      ? 'assets/images/home_filled.png'
                      : 'assets/images/home_unfilled.png',
                  color: selectedIndex == 0
                      ? Pallete.whiteColor
                      : Pallete.inactiveBottomBarItemColor,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Image.asset('assets/images/library.png',
                    color: selectedIndex == 1
                        ? Pallete.whiteColor
                        : Pallete.inactiveBottomBarItemColor),
                label: 'library'),
          ]),
    );
  }
}

Widget _buildActionButton({
  required IconData icon,
  required VoidCallback onPressed,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Pallete.whiteColor.withOpacity(0.2),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: Pallete.whiteColor.withOpacity(0.3),
      ),
    ),
    child: Material(
      color: Pallete.transparentColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            color: Pallete.whiteColor,
            size: 20,
          ),
        ),
      ),
    ),
  );
}
