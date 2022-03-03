// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_staff.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _ApiStaff implements ApiStaff {
  _ApiStaff(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://192.168.219.100:80/api/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiMessage> login(staffData) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(staffData.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiMessage>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/login',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiMessage.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiMessage> logout(currentUser) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(currentUser.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiMessage>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/logout',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiMessage.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiMessage> uploadPost(authApi, data) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authApi};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(data.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiMessage>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/post',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiMessage.fromJson(_result.data!);
    return value;
  }

  @override
  Stream<List<PostData>> getAllPost(authApi) async* {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authApi};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<PostData>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/posts',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => PostData.fromJson(i as Map<String, dynamic>))
        .toList();
    yield value;
  }

  @override
  Stream<List<PostData>> getSearchPost(authApi, searchData) async* {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'search': searchData};
    final _headers = <String, dynamic>{r'Authorization': authApi};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<PostData>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/posts',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => PostData.fromJson(i as Map<String, dynamic>))
        .toList();
    yield value;
  }

  @override
  Stream<List<PostData>> getSearchPostByCategory(authApi, categoryData) async* {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'category': categoryData};
    final _headers = <String, dynamic>{r'Authorization': authApi};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<PostData>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/posts',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => PostData.fromJson(i as Map<String, dynamic>))
        .toList();
    yield value;
  }

  @override
  Future<ApiMessage> editPost(authApi, data, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authApi};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(data.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiMessage>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/posts/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiMessage.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PostData> getPostById(authApi, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authApi};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PostData>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'post/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PostData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PostData> deletePost(authApi, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authApi};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PostData>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'posts/${id}/delete',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PostData.fromJson(_result.data!);
    return value;
  }

  @override
  Stream<List<SaleData>> getAllSalePost(authApi) async* {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authApi};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<SaleData>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/sales',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => SaleData.fromJson(i as Map<String, dynamic>))
        .toList();
    yield value;
  }

  @override
  Future<ApiMessage> uploadSalePost(authApi, data, image) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authApi};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(data.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiMessage>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'multipart/form-data')
            .compose(_dio.options, '/sale',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiMessage.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SaleData> deleteSalePost(authApi, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authApi};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SaleData>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'sales/${id}/delete',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SaleData.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
