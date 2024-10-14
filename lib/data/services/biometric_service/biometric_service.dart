abstract class BiometricService {
  Future<bool> hasBiometricSupport();
  Future<bool> authenticateWithBiometrics();
}
