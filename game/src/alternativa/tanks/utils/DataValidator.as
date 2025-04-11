package alternativa.tanks.utils {
  public interface DataValidator {
    function addValidator(param1:DataUnitValidator) : void;
    function removeValidator(param1:DataUnitValidator) : void;
    function removeAllValidators() : void;
    function tick() : void;
  }
}
