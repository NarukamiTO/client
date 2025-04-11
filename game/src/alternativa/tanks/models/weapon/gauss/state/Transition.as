package alternativa.tanks.models.weapon.gauss.state {
  import alternativa.tanks.models.weapon.gauss.GaussEventType;

  public class Transition {
    public var eventType:GaussEventType;
    public var state:IGaussState;
    public var newState:IGaussState;

    public function Transition(param1:GaussEventType, param2:IGaussState, param3:IGaussState) {
      super();
      this.eventType = param1;
      this.state = param2;
      this.newState = param3;
    }
  }
}
