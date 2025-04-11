package alternativa.tanks.model.payment.shop.category {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ShopCategoryEnum;

  public class ShopCategoryEvents implements ShopCategory {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ShopCategoryEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getOrderIndex() : int {
      var result:int = 0;
      var i:int = 0;
      var m:ShopCategory = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShopCategory(this.impl[i]);
          result = int(m.getOrderIndex());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function isWithJumpButton() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:ShopCategory = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShopCategory(this.impl[i]);
          result = Boolean(m.isWithJumpButton());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getType() : ShopCategoryEnum {
      var result:ShopCategoryEnum = null;
      var i:int = 0;
      var m:ShopCategory = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShopCategory(this.impl[i]);
          result = m.getType();
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
