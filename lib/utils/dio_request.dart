import 'package:dio/dio.dart';

class DioRequest {
  static Dio? _dio;
  static final DioRequest _instance = DioRequest._internal();

  factory DioRequest() => _instance;

  DioRequest._internal() {
    _dio = Dio();
    // 配置dio实例
    _dio!.options.baseUrl = 'https://api.example.com'; // 替换为你的基础URL
    _dio!.options.connectTimeout = const Duration(seconds: 10); // 连接超时时间
    _dio!.options.receiveTimeout = const Duration(seconds: 10); // 超时时间

    // 添加拦截器
    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // 在请求前添加token等操作
          // options.headers['Authorization'] = 'Bearer your_token';
          print('请求: ${options.method} ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('响应: ${response.statusCode} ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print('错误: ${e.message}');
          return handler.next(e);
        },
      ),
    );
  }

  /// GET 请求
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response response = await _dio!.get(
        path,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// POST 请求
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response response = await _dio!.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// PUT 请求
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response response = await _dio!.put(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// DELETE 请求
  Future<Response> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response response = await _dio!.delete(
        path,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 下载文件
  Future<Response> download(String url, String savePath) async {
    try {
      final Response response = await _dio!.download(url, savePath);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 上传文件
  Future<Response> upload(String path, FormData formData) async {
    try {
      final Response response = await _dio!.post(path, data: formData);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 统一错误处理
  String _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return '连接超时';
      case DioExceptionType.sendTimeout:
        return '请求超时';
      case DioExceptionType.receiveTimeout:
        return '响应超时';
      case DioExceptionType.badResponse:
        if (error.response != null) {
          return '服务器错误: ${error.response!.statusMessage}';
        }
        return '服务器错误';
      case DioExceptionType.cancel:
        return '请求取消';
      case DioExceptionType.unknown:
        return '未知错误';
      default:
        return '网络错误';
    }
  }

  /// 设置认证token
  void setAuthorization(String token) {
    _dio!.options.headers['Authorization'] = 'Bearer $token';
  }

  /// 清除认证信息
  void clearAuthorization() {
    _dio!.options.headers.remove('Authorization');
  }
}
