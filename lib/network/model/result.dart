//
// result.dart
// KYSuperApp
//
// Created by 曹雪松 on 2020/10/13.
// Copyright © 2020 KYDW. All rights reserved.
//
class Result<T> {
  T code;
  String message;

  Result({T code, String message}) {
    this.code = code;
    this.message = message;
  }

  static Result success(bool code) {
    return Result(code: code);
  }
}