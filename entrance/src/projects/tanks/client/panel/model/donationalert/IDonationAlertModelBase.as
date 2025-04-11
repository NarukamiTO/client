package projects.tanks.client.panel.model.donationalert {
  import projects.tanks.client.panel.model.donationalert.types.DonationData;

  public interface IDonationAlertModelBase {
    function showDonationAlert(param1:DonationData) : void;
    function showDonationAlertWithEmailBlock(param1:DonationData) : void;
    function showEmailIsBusy(param1:String) : void;
    function showEmailIsForbidden(param1:String) : void;
    function showEmailIsFree(param1:String) : void;
  }
}
