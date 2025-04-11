package alternativa.tanks.model.antiaddiction {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IAntiAddictionAlertAdapt implements IAntiAddictionAlert {
    private var object:IGameObject;
    private var impl:IAntiAddictionAlert;

    public function IAntiAddictionAlertAdapt(param1:IGameObject, param2:IAntiAddictionAlert) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function setIdNumberAndRealName(param1:String, param2:String) : void {
      var realName:String = param1;
      var idNumber:String = param2;
      try {
        Model.object = this.object;
        this.impl.setIdNumberAndRealName(realName,idNumber);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
