class URLEndPoints {
  static const String baseUrl =
      'http://ec2-13-233-146-59.ap-south-1.compute.amazonaws.com:8080/api/v1';
  // 'http://ec2-65-2-122-34.ap-south-1.compute.amazonaws.com:8080/api/v1';

  static const String sendOtp = baseUrl + '/sendOtp';

  static const String sendAccountDetails = baseUrl + '/user';

  static const String verifyOTP = baseUrl + '/verifyOtp';

  static const String createUser = baseUrl + '/user';

  static const String sendImages = baseUrl + '/user/images';

  static const String logIn = baseUrl + '/user/login';

  static const String getAllUser = baseUrl + '/users';

  static const String getUserById = baseUrl + '/user';

  static const String createLike = baseUrl + '/likes';

  static const String match = baseUrl + '/match';

  static const String contactUs = baseUrl + '/sendEmail';

  
}
