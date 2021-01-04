//
// null_safe_extension.dart
// KYSuperApp
//
// Created by 曹雪松 on 2020/9/24.
// Copyright © 2020 KYDW. All rights reserved.
//

extension MapSafetyExtension on Map {
  bool get isNullOrEmpty => (this == null || this.isEmpty);
  bool get isNotNullOrEmpty => (this != null && this.isNotEmpty);
}

extension IterableSafetyExtension on Iterable {
  bool get isNullOrEmpty => (this == null || this.isEmpty);
  bool get isNotNullOrEmpty => (this != null && this.isNotEmpty);
}

extension StringSafetyExtension on String {
  bool get isNullOrEmpty => (this == null || this.isEmpty);
  bool get isNotNullOrEmpty => (this != null && this.isNotEmpty);
}

