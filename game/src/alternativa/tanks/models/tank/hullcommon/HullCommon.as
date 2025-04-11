package alternativa.tanks.models.tank.hullcommon {
  import flash.display.BitmapData;
  import flash.media.Sound;
  import platform.client.fp10.core.resource.types.TextureResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.armor.common.HullCommonCC;

  [ModelInterface]
  public interface HullCommon {
    function getCC() : HullCommonCC;
    function getDeadColoring() : TextureResource;
    function getMass() : Number;
    function setTankObject(param1:IGameObject) : void;
    function getTankObject() : IGameObject;
    function getStunEffectTexture() : BitmapData;
    function getStunSound() : Sound;
    function getUltimateIconIndex() : int;
  }
}
