package alternativa.tanks.model.donationalert {
  import alternativa.tanks.gui.ThanksForPurchaseWindow;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.donationalert.types.GoodInfoData;

  public class ThanksForDonationFormServiceAdapt implements ThanksForDonationFormService {
    private var object:IGameObject;
    private var impl:ThanksForDonationFormService;

    public function ThanksForDonationFormServiceAdapt(param1:IGameObject, param2:ThanksForDonationFormService) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getThanksForPurchaseForm(param1:Vector.<GoodInfoData>, param2:Boolean) : ThanksForPurchaseWindow {
      var result:ThanksForPurchaseWindow = null;
      var items:Vector.<GoodInfoData> = param1;
      var requiredEmail:Boolean = param2;
      try {
        Model.object = this.object;
        result = this.impl.getThanksForPurchaseForm(items,requiredEmail);
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
