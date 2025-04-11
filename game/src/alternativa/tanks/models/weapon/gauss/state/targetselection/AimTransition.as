package alternativa.tanks.models.weapon.gauss.state.targetselection {
  public class AimTransition {
    public var eventType:GaussAimEventType;
    public var state:IGaussAimState;
    public var newState:IGaussAimState;

    public function AimTransition(param1:GaussAimEventType, param2:IGaussAimState, param3:IGaussAimState) {
      super();
      this.eventType = param1;
      this.state = param2;
      this.newState = param3;
    }
  }
}
