package alternativa.tanks.models.weapon.gauss.state.targetselection {
  public interface IGaussAimState {
    function enter(param1:int, param2:GaussAimEventType, param3:*) : void;
    function update(param1:int, param2:int) : void;
  }
}
