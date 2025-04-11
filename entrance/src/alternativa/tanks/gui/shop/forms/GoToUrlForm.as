package alternativa.tanks.gui.shop.forms {
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import alternativa.tanks.model.payment.modes.asyncurl.AsyncUrlPayMode;
  import platform.client.fp10.core.type.IGameObject;

  public class GoToUrlForm extends PayModeForm {
    public function GoToUrlForm(param1:IGameObject) {
      super(param1);
    }

    override public function activate() : void {
      AsyncUrlPayMode(payMode.adapt(AsyncUrlPayMode)).requestAsyncUrl();
      logProceedAction();
    }

    override public function shouldBeOmitted() : Boolean {
      return true;
    }
  }
}
