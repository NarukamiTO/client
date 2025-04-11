package alternativa.tanks.battle.hidablegraphicobjects {
  import alternativa.math.Vector3;

  public interface HidableGraphicObject {
    function readPosition(param1:Vector3) : void;
    function setAlphaMultiplier(param1:Number) : void;
  }
}
