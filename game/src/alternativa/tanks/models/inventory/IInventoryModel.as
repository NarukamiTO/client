package alternativa.tanks.models.inventory {
  [ModelInterface]
  public interface IInventoryModel {
    function lockItem(param1:int, param2:int, param3:Boolean) : void;
    function lockItems(param1:int, param2:Boolean) : void;
    function lockItemsByMask(param1:Vector.<int>, param2:int, param3:Boolean) : void;
  }
}
