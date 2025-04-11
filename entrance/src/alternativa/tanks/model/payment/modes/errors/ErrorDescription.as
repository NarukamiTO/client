package alternativa.tanks.model.payment.modes.errors {
  [ModelInterface]
  public interface ErrorDescription {
    function showError(param1:int) : void;
    function showUnknownError() : void;
  }
}
