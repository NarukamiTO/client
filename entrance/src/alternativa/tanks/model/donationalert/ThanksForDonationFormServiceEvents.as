package alternativa.tanks.model.donationalert {
  import alternativa.tanks.gui.ThanksForPurchaseWindow;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.donationalert.types.GoodInfoData;

  public class ThanksForDonationFormServiceEvents implements ThanksForDonationFormService {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ThanksForDonationFormServiceEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getThanksForPurchaseForm(param1:Vector.<GoodInfoData>, param2:Boolean) : ThanksForPurchaseWindow {
      var result:ThanksForPurchaseWindow = null;
      var i:int = 0;
      var m:ThanksForDonationFormService = null;
      var items:Vector.<GoodInfoData> = param1;
      var requiredEmail:Boolean = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ThanksForDonationFormService(this.impl[i]);
          result = m.getThanksForPurchaseForm(items,requiredEmail);
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
