package alternativa.tanks.model.payment.shop.kit {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.shop.kitpackage.KitPackageItemInfo;

  public class KitPackageEvents implements KitPackage {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function KitPackageEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getName() : String {
      var result:String = null;
      var i:int = 0;
      var m:KitPackage = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = KitPackage(this.impl[i]);
          result = m.getName();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getItemInfos() : Vector.<KitPackageItemInfo> {
      var result:Vector.<KitPackageItemInfo> = null;
      var i:int = 0;
      var m:KitPackage = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = KitPackage(this.impl[i]);
          result = m.getItemInfos();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
