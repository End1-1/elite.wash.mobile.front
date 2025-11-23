import 'dart:developer';

import 'package:armpet_wash_mobile/utilities.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum HttpState { loading, ok, error, unauthenticated, needsSetup }

class HttpData extends Equatable {
  final HttpState state;
  final dynamic data;

  const HttpData(this.state, {this.data = const <String, dynamic>{}});

  @override
  List<Object?> get props => [state,data];
}

class HttpCubit extends Cubit<HttpData> {
  Dio? dio;

  HttpCubit()
      : super(HttpData(HttpState.loading));

  Future<void> post(String route, {Map<String, dynamic>? postData}) async {
    final data = {...?postData};
    emit(HttpData(HttpState.loading));
    data.addAll({'host': sp.string('device_id'), 'f_branch': sp.getInt('f_branch')});
    final baseUrl = sp.getString('base_url') ?? '';
    if (baseUrl.isEmpty) {
      if (kDebugMode){
        print('BaseUrl is empty, need setup');
      }
      emit(HttpData(HttpState.needsSetup));
      return;
    }
    try {
      final token = sp.string('f_token');
      if (token.isEmpty) {
        if (kDebugMode) {
          print('Empty token. Need to login');
        }
        emit(HttpData(HttpState.unauthenticated));
        return;
      }
      if (kDebugMode) {
        print('Auth: $token');
        print('Route $baseUrl$route');
        log(data.toString());
      }
      dio = Dio();
      final response = await dio!.post('$baseUrl$route', data:data, options: Options(
        headers: {'Authorization': 'Bearer $token'},
        contentType: 'application/json',
      ));
      if (kDebugMode) {
        print('Status code ${response.statusCode}');
        debugPrint('Response data: ${response.data}');
      }
      if (response.statusCode == 200) {
        emit(HttpData(HttpState.ok, data: response.data));
      } else if (response.statusCode == 401) {
        emit(HttpData(HttpState.unauthenticated));
      } else if (response.statusCode == 500) {
        emit(HttpData(HttpState.error, data: response.data));
      }
    } on DioException catch (e) {
      var err = e.response?.data ?? e.toString();
      if (e.response == null) {
        err = String.fromCharCodes((e.error as FormatException).source as List<int>);
      }
      if (kDebugMode) {
        print(err);
      }
      emit(HttpData(HttpState.error, data: err));
    }
  }
}