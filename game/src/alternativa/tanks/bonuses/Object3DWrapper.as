package alternativa.tanks.bonuses {
  import alternativa.math.Vector3;

  public interface Object3DWrapper {
    function setPosition(param1:Vector3) : void;
    function setPositionComponents(param1:Number, param2:Number, param3:Number) : void;
    function setRotation(param1:Vector3) : void;
    function setRotationComponents(param1:Number, param2:Number, param3:Number) : void;
  }
}
