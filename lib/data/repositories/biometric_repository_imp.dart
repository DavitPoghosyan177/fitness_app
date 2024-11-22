import 'package:fitness_app/data/services/biometric_service/biometric_service.dart';
import 'package:fitness_app/domain/repositories/biometric_repository.dart';

class BiometricRepositoryImp implements BiometricRepository {
  final BiometricService biometricService;

  BiometricRepositoryImp(this.biometricService);

  @override
  Future<bool> checkBiometricSupport() async {
    return await biometricService.hasBiometricSupport();
  }

  @override
  Future<bool> authenticateUser() async {
    return await biometricService.authenticateWithBiometrics();
  }
}
