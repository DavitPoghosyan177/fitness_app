import 'package:local_auth/local_auth.dart';
import 'biometric_service.dart';

class BiometricServiceImp implements BiometricService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  @override
  Future<bool> hasBiometricSupport() async {
    try {
      return await _localAuth.canCheckBiometrics ||
          await _localAuth.isDeviceSupported();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> authenticateWithBiometrics() async {
    try {
      return await _localAuth.authenticate(
        localizedReason: 'Please authenticate to access',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      return false;
    }
  }
}
