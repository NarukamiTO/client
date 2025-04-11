package alternativa.tanks.model.item.countable {
  import platform.client.fp10.core.model.IObjectLoadListener;
  import projects.tanks.client.garage.models.item.countable.CountableItemModelBase;
  import projects.tanks.client.garage.models.item.countable.ICountableItemModelBase;

  [ModelInfo]
  public class CountableItemModel extends CountableItemModelBase implements ICountableItemModelBase, ICountableItem, IObjectLoadListener {
    public function CountableItemModel() {
      super();
    }

    public function getCount() : int {
      return int(getData(CountableItemModel));
    }

    public function setCount(param1:int) : void {
      putData(CountableItemModel,param1);
    }

    public function objectLoaded() : void {
      putData(CountableItemModel,getInitParam().count);
    }

    public function objectLoadedPost() : void {
    }

    public function objectUnloaded() : void {
    }

    public function objectUnloadedPost() : void {
    }
  }
}
