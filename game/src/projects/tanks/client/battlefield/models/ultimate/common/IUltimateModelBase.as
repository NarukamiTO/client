package projects.tanks.client.battlefield.models.ultimate.common {
  public interface IUltimateModelBase {
    function resetCharge() : void;
    function showUltimateCharged() : void;
    function ultimateRejected() : void;
    function ultimateUsed() : void;
    function updateCharge(param1:int) : void;
    function updateChargeAndRate(param1:int, param2:Number) : void;
  }
}
