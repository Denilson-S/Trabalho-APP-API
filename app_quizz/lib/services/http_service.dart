import 'package:app_quizz/constants/app_defines.dart';
import 'package:app_quizz/storages/user_storage.dart';
import 'package:dio/dio.dart';

class HttpService {
  static final HttpService _instance = HttpService._internal();
  factory HttpService() => _instance;

  late final Dio _dio;
  final UserStorage _userStorage = UserStorage();

  HttpService._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: AppDefines.apiUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      // Middleware para injetar headers automáticos (Auth e Idioma)
      onRequest: (options, handler) async {
        // 1. Injeta Token de Autenticação
        final token = await _userStorage.getAccessToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        // 2. Injeta Idioma selcionado pelo usuário automaticamente
        final settings = await _userStorage.getSettings();
        // Converte o nome do idioma para o código esperado pela API (ex: 'Portuguese' -> 'pt-br')
        final langCode = _mapLanguageToCode(settings.language);
        options.headers['accept-language'] = langCode;

        return handler.next(options);
      },

      // Middleware para tratar erro de autenticação (RefreshToken automático)
      onError: (DioException e, handler) async {
        // Ignora rotas de login e registro, onde o 401 significa apenas "credenciais inválidas"
        final isAuthRoute = e.requestOptions.path.contains('/auth/login') || e.requestOptions.path.contains('/auth/register');

        if (e.response?.statusCode == 401 && !isAuthRoute) {
          final success = await _handleTokenRefresh();
          
          if (success) {
            // Se o refresh deu certo, repete a requisição com o novo token
            return handler.resolve(await _retry(e.requestOptions));
          }
        }
        return handler.next(e); // Repassa o erro de login para o AuthService tratar
      },
    ));
  }

  // Mapeia o nome do idioma salvo para o padrão ISO da API
  String _mapLanguageToCode(String language) {
    switch (language) {
      case 'Portuguese': return 'pt-br';
      case 'Spanish': return 'es-es';
      case 'English': 
      default: return 'en-us';
    }
  }

  // Tenta renovar o token
  Future<bool> _handleTokenRefresh() async {
    final refreshToken = await _userStorage.getRefreshToken();
    if (refreshToken == null) return false;

    try {
      final response = await Dio().post(
        '${AppDefines.apiUrl}/auth/refresh',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        final newAccessToken = response.data['accessToken'];
        final newRefreshToken = response.data['refreshToken'];
        
        await _userStorage.saveTokens(newAccessToken, newRefreshToken);
        return true;
      }
    } catch (e) {
      // Se falhar o refresh, desloga o usuário (ex: refresh token expirou)
      await _userStorage.deleteTokens();
      await _userStorage.deleteUserData();
    }
    return false;
  }

  // Repete a requisição que falhou
  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    
    return _dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  // Métodos HTTP atualizados para suportar headers manuais se necessário
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers}) async {
    return await _dio.get(path, queryParameters: queryParameters, options: Options(headers: headers));
  }

  Future<Response> post(String path, {dynamic data, Map<String, dynamic>? headers}) async {
    return await _dio.post(path, data: data, options: Options(headers: headers));
  }

  Future<Response> put(String path, {dynamic data, Map<String, dynamic>? headers}) async {
    return await _dio.put(path, data: data, options: Options(headers: headers));
  }

  Future<Response> delete(String path, {dynamic data, Map<String, dynamic>? headers}) async {
    return await _dio.delete(path, data: data, options: Options(headers: headers));
  }
}