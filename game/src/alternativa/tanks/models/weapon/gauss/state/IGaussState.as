package alternativa.tanks.models.weapon.gauss.state {
  import alternativa.tanks.models.weapon.gauss.GaussEventType;

  public interface IGaussState {
    function enter(param1:int, param2:GaussEventType, param3:*) : void;
    function update(param1:int, param2:int) : void;
  }
}
