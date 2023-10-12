import 'package:flutter/material.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';

import 'media_tile.dart';

enum _MediaListType {
  sliver, // SliverList
  list, // ListView
}

typedef MediaListViewBuilder<Media extends PlayableMedia> = Widget Function(
    BuildContext context, Media mediaItem, int index);

typedef MediaListOnTap<Media> = void Function(int index, Media media);

class MediaListView<Media extends PlayableMedia> extends StatelessWidget {
  /// The list of media items to display.
  final List<Media> mediaItems;
  final _MediaListType _type;
  final MediaListViewBuilder<Media>? itemBuilder;
  final bool isPlaying;
  final bool Function(Media) isItemPlaying;
  final MediaListOnTap<Media>? onItemTap;
  final Color? itemSelectedColor;
  final PlayableMediaType? mediaType;

  /// Creates a [MediaListView] widget with a [ListView].
  const MediaListView(
    this.mediaItems, {
    super.key,
    required this.isPlaying,
    this.onItemTap,
    bool needSliver = false,
    required this.isItemPlaying,
    this.itemSelectedColor,
    this.mediaType,
  })  : _type = _MediaListType.list,
        itemBuilder = null;

  /// Creates a [MediaListView] widget with a [SliverList].
  const MediaListView.sliver(
    this.mediaItems, {
    super.key,
    required this.isPlaying,
    this.onItemTap,
    required this.isItemPlaying,
    this.itemSelectedColor,
    this.mediaType,
  })  : _type = _MediaListType.sliver,
        itemBuilder = null;

  /// Creates a [MediaListView] widget with a custom [itemBuilder].
  const MediaListView.builder({
    required this.mediaItems,
    required this.itemBuilder,
    required this.isPlaying,
    required this.isItemPlaying,
    this.itemSelectedColor,
    super.key,
    this.onItemTap,
    bool needSliver = false,
    this.mediaType,
  }) : _type = needSliver ? _MediaListType.sliver : _MediaListType.list;

  MediaListViewBuilder<Media> get _itemBuilder =>
      itemBuilder ??
      (context, media, index) => MediaTile<Media>(
            media,
            isPlaying: isPlaying,
            index: index,
            onTap: () {
              onItemTap?.call(index, media);
            },
            selected: isItemPlaying(media),
            selectedColor: itemSelectedColor,
            parentMediaType: mediaType ?? PlayableMediaType.song,
          );

  @override
  Widget build(BuildContext context) {
    final view = switch (_type) {
      _MediaListType.sliver => _MediaSliverListView.new,
      _MediaListType.list => _MediaListView.new,
    };
    return view<Media>(
      mediaItems,
      key: key,
      isPlaying: isPlaying,
      onItemTap: onItemTap,
      isItemPlaying: isItemPlaying,
      itemSelectedColor: itemSelectedColor,
      mediaType: mediaType,
    );
  }
}

class _MediaSliverListView<Media extends PlayableMedia>
    extends MediaListView<Media> {
  const _MediaSliverListView(
    super.mediaItems, {
    super.key,
    required super.isPlaying,
    super.onItemTap,
    required super.isItemPlaying,
    super.itemSelectedColor,
    required super.mediaType,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: mediaItems.length,
      itemBuilder: (context, index) {
        final media = mediaItems[index];
        return _itemBuilder(context, media, index);
      },
    );
  }
}

class _MediaListView<Media extends PlayableMedia> extends MediaListView<Media> {
  const _MediaListView(
    super.mediaItems, {
    super.key,
    required super.isPlaying,
    super.onItemTap,
    required super.isItemPlaying,
    super.itemSelectedColor,
    required super.mediaType,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: mediaItems.length,
      itemBuilder: (context, index) {
        final media = mediaItems[index];
        return _itemBuilder(context, media, index);
      },
    );
  }
}
