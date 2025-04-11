package alternativa.tanks.model.payment.shop.specialkit {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.shop.specialkit.SpecialKitPackageCC;

  public class SpecialKitPackageEvents implements SpecialKitPackage {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function SpecialKitPackageEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getCrystalsAmount() : int {
      var result:int = 0;
      var i:int = 0;
      var m:SpecialKitPackage = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = SpecialKitPackage(this.impl[i]);
          result = int(m.getCrystalsAmount());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPremiumDurationInDays() : int {
      var result:int = 0;
      var i:int = 0;
      var m:SpecialKitPackage = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = SpecialKitPackage(this.impl[i]);
          result = int(m.getPremiumDurationInDays());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getEverySupplyAmount() : int {
      var result:int = 0;
      var i:int = 0;
      var m:SpecialKitPackage = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = SpecialKitPackage(this.impl[i]);
          result = int(m.getEverySupplyAmount());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getGoldAmount() : int {
      var result:int = 0;
      var i:int = 0;
      var m:SpecialKitPackage = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = SpecialKitPackage(this.impl[i]);
          result = int(m.getGoldAmount());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function hasAdditionalItem() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:SpecialKitPackage = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = SpecialKitPackage(this.impl[i]);
          result = Boolean(m.hasAdditionalItem());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getItemsCount() : int {
      var result:int = 0;
      var i:int = 0;
      var m:SpecialKitPackage = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = SpecialKitPackage(this.impl[i]);
          result = int(m.getItemsCount());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPackageData() : SpecialKitPackageCC {
      var result:SpecialKitPackageCC = null;
      var i:int = 0;
      var m:SpecialKitPackage = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = SpecialKitPackage(this.impl[i]);
          result = m.getPackageData();
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
