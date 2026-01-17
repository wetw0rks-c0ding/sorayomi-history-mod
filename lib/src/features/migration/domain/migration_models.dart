// Copyright (c) 2022 Contributors to the Suwayomi project
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../browse_center/domain/source/graphql/__generated__/fragment.graphql.dart';
import '../../manga_book/domain/manga/graphql/__generated__/fragment.graphql.dart';

part 'migration_models.freezed.dart';
part 'migration_models.g.dart';

@freezed
class MigrationSource with _$MigrationSource {
  const factory MigrationSource({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'lang') required String lang,
    @JsonKey(name: 'isConfigured') @Default(false) bool isConfigured,
    @JsonKey(name: 'mangaCount') @Default(0) int mangaCount,
    @JsonKey(name: 'displayName') String? displayName,
    @JsonKey(name: 'supportsLatest') bool? supportsLatest,
  }) = _MigrationSource;

  factory MigrationSource.fromJson(Map<String, dynamic> json) =>
      _$MigrationSourceFromJson(json);
}

@freezed
class MigrationOption with _$MigrationOption {
  const factory MigrationOption({
    @JsonKey(name: 'migrateChapters') @Default(true) bool migrateChapters,
    @JsonKey(name: 'migrateCategories') @Default(true) bool migrateCategories,
    @JsonKey(name: 'migrateDownloads') @Default(false) bool migrateDownloads,
    @JsonKey(name: 'migrateTracking') @Default(false) bool migrateTracking,
    @JsonKey(name: 'deleteSource') @Default(true) bool deleteSource,
  }) = _MigrationOption;

  factory MigrationOption.fromJson(Map<String, dynamic> json) =>
      _$MigrationOptionFromJson(json);
}

@freezed
class MigrationResult with _$MigrationResult {
  const factory MigrationResult({
    @JsonKey(name: 'success') required bool success,
    @JsonKey(name: 'error') String? error,
    @JsonKey(name: 'migratedChapters') @Default(0) int migratedChapters,
    @JsonKey(name: 'warnings') @Default(<String>[]) List<String> warnings,
    @JsonKey(name: 'newManga') Fragment$MangaDto? newManga,
    @JsonKey(name: 'migratedCategories') @Default(0) int migratedCategories,
    @JsonKey(name: 'migratedDownloads') @Default(0) int migratedDownloads,
  }) = _MigrationResult;

  factory MigrationResult.fromJson(Map<String, dynamic> json) =>
      _$MigrationResultFromJson(json);
}

enum MigrationStatus {
  idle,
  preparing,
  migrating,
  completed,
  error,
  cancelled,
}

enum MigrationStep {
  preparingMigration,
  migrateChapters,
  migrateCategories,
  migrationInProgress,
  migrationCompleted,
  migrationFailed,
  migrationCancelled,
}

@freezed
class MigrationProgress with _$MigrationProgress {
  const factory MigrationProgress({
    @JsonKey(name: 'currentStep') required MigrationStep currentStep,
    @JsonKey(name: 'percentage') @Default(0.0) double percentage,
    @JsonKey(name: 'status') @Default(MigrationStatus.idle) MigrationStatus status,
    @JsonKey(name: 'errorMessage') String? errorMessage,
    @JsonKey(name: 'processedItems') @Default(0) int processedItems,
    @JsonKey(name: 'totalItems') @Default(0) int totalItems,
  }) = _MigrationProgress;

  factory MigrationProgress.fromJson(Map<String, dynamic> json) =>
      _$MigrationProgressFromJson(json);
}

@freezed
class MangaSearchResult with _$MangaSearchResult {
  const factory MangaSearchResult({
    @JsonKey(name: 'manga') required Fragment$MangaDto manga,
    @JsonKey(name: 'similarity') @Default(0.0) double similarity,
    @JsonKey(name: 'matchReason') String? matchReason,
  }) = _MangaSearchResult;

  factory MangaSearchResult.fromJson(Map<String, dynamic> json) =>
      _$MangaSearchResultFromJson(json);
}

// Route Data Classes to replace Map<String, dynamic>
// These classes don't need JSON serialization since they're only used for navigation
@freezed
class MigrationRouteData with _$MigrationRouteData {
  const factory MigrationRouteData({
    required Fragment$MangaDto sourceManga,
  }) = _MigrationRouteData;
}

@freezed
class MigrationSearchRouteData with _$MigrationSearchRouteData {
  const factory MigrationSearchRouteData({
    required Fragment$MangaDto sourceManga,
    required Fragment$SourceDto targetSource,
  }) = _MigrationSearchRouteData;
}

@freezed
class MigrationPreviewRouteData with _$MigrationPreviewRouteData {
  const factory MigrationPreviewRouteData({
    required Fragment$MangaDto sourceManga,
    required Fragment$MangaDto targetManga,
    required Fragment$SourceDto targetSource,
  }) = _MigrationPreviewRouteData;
}

@freezed
class MigrationProgressRouteData with _$MigrationProgressRouteData {
  const factory MigrationProgressRouteData({
    required Fragment$MangaDto sourceManga,
    required Fragment$MangaDto targetManga,
    required Fragment$SourceDto targetSource,
    required MigrationOption options,
  }) = _MigrationProgressRouteData;
}
