package alternativa.tanks.model.payment.shop.kit {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.shop.kitpackage.KitPackageItemInfo;

  public class KitPackageAdapt implements KitPackage {
    private var object:IGameObject;
    private var impl:KitPackage;

    public function KitPackageAdapt(param1:IGameObject, param2:KitPackage) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getName() : String {
      var result:String = null;
      try {
        Model.object = this.object;
        result = this.impl.getName();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getItemInfos() : Vector.<KitPackageItemInfo> {
      var result:Vector.<KitPackageItemInfo> = null;
      try {
        Model.object = this.object;
        result = this.impl.getItemInfos();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
