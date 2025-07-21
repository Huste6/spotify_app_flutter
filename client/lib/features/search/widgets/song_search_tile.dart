import 'package:client/cor/providers/current_song_notifier.dart';
import 'package:client/cor/theme/app_pallete.dart';
import 'package:client/cor/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/features/home/model/song_model.dart';
import 'package:client/features/home/viewmodel/home_viewmodel.dart';
import 'package:client/cor/providers/current_user_notifier.dart';

class SongSearchTile extends ConsumerStatefulWidget {
  final SongModel song;

  const SongSearchTile({
    super.key,
    required this.song,
  });

  @override
  ConsumerState<SongSearchTile> createState() => _SongSearchTileState();
}

class _SongSearchTileState extends ConsumerState<SongSearchTile> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
  }

  void _onTap() {
    // Handle song play logic here
    print('Playing song: ${widget.song.song_name}');
    ref
        .read(currentSongNotifierProvider.notifier)
        .updateSong(widget.song);
  }

  void _onFavoritePressed() async{
    await ref.read(homeViewModelProvider.notifier).favSong(songId: widget.song.id);
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = hexToColor(widget.song.hexCode);
    final userFavorites = ref
        .watch(currentUserNotifierProvider.select((data) => data!.favorites));

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: _onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _isPressed
              ? const Color(0xFF30363D)
              : const Color(0xFF21262D),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isPressed
                ? themeColor.withOpacity(0.3)
                : Colors.transparent,
            width: 1,
          ),
          boxShadow: _isPressed
              ? [
            BoxShadow(
              color: themeColor.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ]
              : null,
        ),
        child: Row(
          children: [
            // Song Thumbnail
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: themeColor.withOpacity(0.2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: widget.song.thumbnail_url.isNotEmpty
                    ? Image.network(
                  widget.song.thumbnail_url,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildPlaceholderThumbnail(themeColor);
                  },
                )
                    : _buildPlaceholderThumbnail(themeColor),
              ),
            ),

            const SizedBox(width: 12),

            // Song Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.song.song_name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.song.artist,
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Favorite Button
                IconButton(
                  onPressed: () async {
                    await ref
                        .read(homeViewModelProvider.notifier)
                        .favSong(songId: widget.song.id);
                  },
                  icon: Icon(
                    userFavorites
                        .where((fav) => fav.song_id == widget.song.id)
                        .toList()
                        .isNotEmpty
                        ? CupertinoIcons.heart_fill
                        : CupertinoIcons.heart,
                    color: Pallete.whiteColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderThumbnail(Color themeColor) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            themeColor.withOpacity(0.6),
            themeColor.withOpacity(0.3),
          ],
        ),
      ),
      child: const Icon(
        Icons.music_note,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}