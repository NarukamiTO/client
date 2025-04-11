package alternativa.tanks.model.antiaddiction {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IAntiAddictionAlertEvents implements IAntiAddictionAlert {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IAntiAddictionAlertEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function setIdNumberAndRealName(param1:String, param2:String) : void {
      var i:int = 0;
      var m:IAntiAddictionAlert = null;
      var realName:String = param1;
      var idNumber:String = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IAntiAddictionAlert(this.impl[i]);
          m.setIdNumberAndRealName(realName,idNumber);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
