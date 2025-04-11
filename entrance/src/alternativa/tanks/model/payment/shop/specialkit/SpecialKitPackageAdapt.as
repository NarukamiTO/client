package alternativa.tanks.model.payment.shop.specialkit {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.shop.specialkit.SpecialKitPackageCC;

  public class SpecialKitPackageAdapt implements SpecialKitPackage {
    private var object:IGameObject;
    private var impl:SpecialKitPackage;

    public function SpecialKitPackageAdapt(param1:IGameObject, param2:SpecialKitPackage) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getCrystalsAmount() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getCrystalsAmount());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPremiumDurationInDays() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getPremiumDurationInDays());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getEverySupplyAmount() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getEverySupplyAmount());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getGoldAmount() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getGoldAmount());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function hasAdditionalItem() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.hasAdditionalItem());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getItemsCount() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getItemsCount());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPackageData() : SpecialKitPackageCC {
      var result:SpecialKitPackageCC = null;
      try {
        Model.object = this.object;
        result = this.impl.getPackageData();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
