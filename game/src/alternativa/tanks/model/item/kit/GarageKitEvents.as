package alternativa.tanks.model.item.kit {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.garage.models.item.kit.KitItem;

  public class GarageKitEvents implements GarageKit {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function GarageKitEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getImage() : ImageResource {
      var result:ImageResource = null;
      var i:int = 0;
      var m:GarageKit = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = GarageKit(this.impl[i]);
          result = m.getImage();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPrice() : int {
      var result:int = 0;
      var i:int = 0;
      var m:GarageKit = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = GarageKit(this.impl[i]);
          result = int(m.getPrice());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPriceWithoutDiscount() : int {
      var result:int = 0;
      var i:int = 0;
      var m:GarageKit = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = GarageKit(this.impl[i]);
          result = int(m.getPriceWithoutDiscount());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPriceAlreadyBought() : int {
      var result:int = 0;
      var i:int = 0;
      var m:GarageKit = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = GarageKit(this.impl[i]);
          result = int(m.getPriceAlreadyBought());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPriceYouSave() : int {
      var result:int = 0;
      var i:int = 0;
      var m:GarageKit = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = GarageKit(this.impl[i]);
          result = int(m.getPriceYouSave());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getItems() : Vector.<KitItem> {
      var result:Vector.<KitItem> = null;
      var i:int = 0;
      var m:GarageKit = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = GarageKit(this.impl[i]);
          result = m.getItems();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function canBuy() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:GarageKit = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = GarageKit(this.impl[i]);
          result = Boolean(m.canBuy());
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
