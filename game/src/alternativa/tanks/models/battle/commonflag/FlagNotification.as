package alternativa.tanks.models.battle.commonflag {
  import alternativa.tanks.battle.objects.tank.Tank;
  import platform.client.fp10.core.type.IGameObject;

  [ModelInterface]
  public interface FlagNotification {
    function guiShowFlagDropped(param1:CommonFlag) : void;
    function guiShowFlagCarried(param1:CommonFlag) : void;
    function guiShowFlagAtBase(param1:CommonFlag) : void;
    function notifyFlagTaken(param1:CommonFlag, param2:Tank) : void;
    function notifyFlagReturned(param1:CommonFlag, param2:IGameObject) : void;
    function notifyFlagDropped(param1:CommonFlag) : void;
    function notifyFlagThrown(param1:CommonFlag) : void;
    function notifyFlagDelivered(param1:CommonFlag, param2:Tank) : void;
    function notifyFlagFacedOff(param1:CommonFlag) : void;
    function notifyReadyToFaceOff() : void;
  }
}
