package alternativa.tanks.model.payment.shop.paint {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class PaintPackageAdapt implements PaintPackage {
    private var object:IGameObject;
    private var impl:PaintPackage;

    public function PaintPackageAdapt(param1:IGameObject, param2:PaintPackage) {
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

    public function getDescription() : String {
      var result:String = null;
      try {
        Model.object = this.object;
        result = this.impl.getDescription();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
