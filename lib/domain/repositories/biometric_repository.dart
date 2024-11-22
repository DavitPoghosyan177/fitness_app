abstract class BiometricRepository {
  Future<bool> checkBiometricSupport();
  Future<bool> authenticateUser();
}
