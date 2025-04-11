package alternativa.tanks.models.battle.gui.gui.statistics.field.score.ctf.flagindicator {
  public interface IFlagIndicatorState {
    function getType() : int;
    function start() : void;
    function stop() : void;
    function update(param1:int, param2:int) : void;
  }
}
