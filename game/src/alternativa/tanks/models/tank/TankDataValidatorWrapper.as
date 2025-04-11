package alternativa.tanks.models.tank {
  import alternativa.tanks.utils.DataUnitValidator;
  import alternativa.tanks.utils.DataValidator;
  import platform.client.fp10.core.type.AutoClosable;

  public class TankDataValidatorWrapper implements AutoClosable {
    [Inject]
    public static var dataValidator:DataValidator;

    private var dataUnitValidator:DataUnitValidator;

    public function TankDataValidatorWrapper(param1:DataUnitValidator) {
      super();
      this.dataUnitValidator = param1;
      dataValidator.addValidator(param1);
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      dataValidator.removeValidator(this.dataUnitValidator);
      this.dataUnitValidator = null;
    }
  }
}
