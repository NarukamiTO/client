package projects.tanks.client.entrance.model.entrance.blockvalidator {
  public interface IBlockValidatorModelBase {
    function youAreBlocked(param1:String) : void;
    function youWereKicked(param1:String, param2:int, param3:int, param4:int) : void;
  }
}
