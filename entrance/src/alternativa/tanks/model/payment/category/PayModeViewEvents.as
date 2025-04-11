package alternativa.tanks.model.payment.category {
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class PayModeViewEvents implements PayModeView {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function PayModeViewEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getView() : PayModeForm {
      var result:PayModeForm = null;
      var i:int = 0;
      var m:PayModeView = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PayModeView(this.impl[i]);
          result = m.getView();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
