class AuthResponse {
  final String accessToken;
  final String refreshToken;

  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null || json['data'] == null) {
      return AuthResponse(accessToken: '', refreshToken: '');
    }
    final data = json['data'] as Map<String, dynamic>;

    return AuthResponse(
      accessToken: data['access_token'] as String,
      refreshToken: data['refresh_token'] as String,
    );
  }
}