package alternativa.tanks.model.item.kit {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.garage.models.item.kit.KitItem;

  public class GarageKitAdapt implements GarageKit {
    private var object:IGameObject;
    private var impl:GarageKit;

    public function GarageKitAdapt(param1:IGameObject, param2:GarageKit) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getImage() : ImageResource {
      var result:ImageResource = null;
      try {
        Model.object = this.object;
        result = this.impl.getImage();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPrice() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getPrice());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPriceWithoutDiscount() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getPriceWithoutDiscount());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPriceAlreadyBought() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getPriceAlreadyBought());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPriceYouSave() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getPriceYouSave());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getItems() : Vector.<KitItem> {
      var result:Vector.<KitItem> = null;
      try {
        Model.object = this.object;
        result = this.impl.getItems();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function canBuy() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.canBuy());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
