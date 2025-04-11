package alternativa.tanks.models.weapon.splash {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;

  [ModelInterface]
  public interface Splash {
    function applySplashForce(param1:Vector3, param2:Number, param3:Body, param4:SplashParams = null) : Boolean;
  }
}
