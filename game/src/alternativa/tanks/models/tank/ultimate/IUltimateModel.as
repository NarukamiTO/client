package alternativa.tanks.models.tank.ultimate {
  [ModelInterface]
  public interface IUltimateModel {
    function resetCharge() : void;
    function initIndicator() : void;
    function isUltimateEnabled() : Boolean;
    function effectDeactivated() : void;
    function effectActivatedOrMerged(param1:int) : void;
  }
}
