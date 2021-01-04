//
// response_interceptor.dart
// KYSuperApp
//
// Created by 曹雪松 on 2020/9/7.
// Copyright © 2020 KYDW. All rights reserved.
//
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:flutter_app/network/api.dart';
import 'package:flutter_app/network/model/base_model.dart';

import '../response_code.dart';

class ResponseInterceptor extends Interceptor {

  @override
  Future onResponse(Response response) async {

    if (response.request.baseUrl == Api.baseUrl) {
      // 请求成功
      final baseModel = BaseModel.fromJson(response.data);
      if (baseModel.code == ResponseStatusCode.success) {
        return super.onResponse(response);
      }

      return super.onResponse(response);
    }
    return super.onResponse(response);
  }

  // @override
  // Future onResponse(Response response) async {
  //
  //   if (response.request.baseUrl == Api.baseUrl) {
  //     // 请求成功
  //     final baseModel = BaseModel.fromJson(response.data);
  //     if (baseModel.code == ResponseStatusCode.success) {
  //       return super.onResponse(response);
  //     }
  //     // 请求成功，但是接口出错
  //     if (baseModel.message != null && baseModel.message.isNotEmpty) {
  //       if (baseModel.code == ResponseStatusCode.tokenExpired) {
  //         // 登录 token 失效
  //         // 重置本地 token, 跳转登录页面
  //         var account = await getIt<AccountRepository>().getAccount();
  //         await getIt<AccountRepository>().remove(account);
  //         navigatorState.currentState.pushNamedAndRemoveUntil(PageRouter.signInPage, (Route<dynamic> route) => false);
  //       }
  //       throw DioError(response: response, error: "${baseModel.message} (code: ${baseModel.code})");
  //     }
  //   }
  //   return super.onResponse(response);
  // }
}