package alternativa.tanks.models.controlpoints {
  public interface IDominationModel {
    function onEnterPointCapturingZone(param1:int) : void;
    function onLeavePointCapturingZone(param1:int) : void;
    function onEnterMineRestrictionZone(param1:int) : void;
    function onLeaveMineRestrictionZone(param1:int) : void;
    function forceUpdatePoint(param1:int) : void;
  }
}
