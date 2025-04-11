package alternativa.tanks.model.payment.category {
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class PayModeViewAdapt implements PayModeView {
    private var object:IGameObject;
    private var impl:PayModeView;

    public function PayModeViewAdapt(param1:IGameObject, param2:PayModeView) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getView() : PayModeForm {
      var result:PayModeForm = null;
      try {
        Model.object = this.object;
        result = this.impl.getView();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
