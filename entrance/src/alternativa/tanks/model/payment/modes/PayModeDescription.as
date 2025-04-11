package alternativa.tanks.model.payment.modes {
  [ModelInterface]
  public interface PayModeDescription {
    function getDescription() : String;
    function rewriteCategoryDescription() : Boolean;
  }
}
