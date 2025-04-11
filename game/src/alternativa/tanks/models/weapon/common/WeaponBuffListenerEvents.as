package alternativa.tanks.models.weapon.common {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class WeaponBuffListenerEvents implements WeaponBuffListener {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function WeaponBuffListenerEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function weaponBuffStateChanged(param1:IGameObject, param2:Boolean, param3:Number) : void {
      var i:int = 0;
      var m:WeaponBuffListener = null;
      var user:IGameObject = param1;
      var buffed:Boolean = param2;
      var recoilForce:Number = param3;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = WeaponBuffListener(this.impl[i]);
          m.weaponBuffStateChanged(user,buffed,recoilForce);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
