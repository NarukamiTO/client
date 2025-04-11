package alternativa.tanks.models.weapon.splash {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class SplashAdapt implements Splash {
    private var object:IGameObject;
    private var impl:Splash;

    public function SplashAdapt(param1:IGameObject, param2:Splash) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function applySplashForce(param1:Vector3, param2:Number, param3:Body, param4:SplashParams = null) : Boolean {
      var result:Boolean = false;
      var hitPoint:Vector3 = param1;
      var impactCoeff:Number = param2;
      var excludedTarget:Body = param3;
      var splashParams:SplashParams = param4;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.applySplashForce(hitPoint,impactCoeff,excludedTarget,splashParams));
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
