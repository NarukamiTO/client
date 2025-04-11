package alternativa.tanks.model.payment.category {
  import alternativa.tanks.gui.payment.forms.PayModeForm;

  [ModelInterface]
  public interface PayModeView {
    function getView() : PayModeForm;
  }
}
