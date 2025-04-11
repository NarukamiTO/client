package alternativa.tanks.model.donationalert {
  import alternativa.tanks.gui.ThanksForPurchaseWindow;
  import projects.tanks.client.panel.model.donationalert.types.GoodInfoData;

  [ModelInterface]
  public interface ThanksForDonationFormService {
    function getThanksForPurchaseForm(param1:Vector.<GoodInfoData>, param2:Boolean) : ThanksForPurchaseWindow;
  }
}
