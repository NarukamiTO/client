package alternativa.tanks.model.payment.shop.category {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ShopCategoryEnum;

  public class ShopCategoryAdapt implements ShopCategory {
    private var object:IGameObject;
    private var impl:ShopCategory;

    public function ShopCategoryAdapt(param1:IGameObject, param2:ShopCategory) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getOrderIndex() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getOrderIndex());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function isWithJumpButton() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.isWithJumpButton());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getType() : ShopCategoryEnum {
      var result:ShopCategoryEnum = null;
      try {
        Model.object = this.object;
        result = this.impl.getType();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
