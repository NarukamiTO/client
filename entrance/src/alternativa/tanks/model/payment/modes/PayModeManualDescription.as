package alternativa.tanks.model.payment.modes {
  [ModelInterface]
  public interface PayModeManualDescription {
    function hasCustomManualDescription() : Boolean;
    function getCustomManualDescription() : String;
  }
}
