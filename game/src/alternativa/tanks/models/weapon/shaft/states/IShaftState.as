package alternativa.tanks.models.weapon.shaft.states {
  import alternativa.tanks.models.weapon.shaft.ShaftEventType;

  public interface IShaftState {
    function enter(param1:int) : void;
    function exit() : void;
    function update(param1:int, param2:int) : void;
    function processEvent(param1:ShaftEventType, param2:*) : void;
  }
}
