package projects.tanks.client.battlefield.models.battle.battlefield.mine {
  import alternativa.types.Long;

  public interface IBattleMinesModelBase {
    function activateMine(param1:Long) : void;
    function explodeMine(param1:Long, param2:Long, param3:Boolean) : void;
    function putMine(param1:Long, param2:Number, param3:Number, param4:Number, param5:Long) : void;
    function removeAllMines(param1:Long) : void;
    function removeMines(param1:Long, param2:Vector.<Long>) : void;
  }
}
