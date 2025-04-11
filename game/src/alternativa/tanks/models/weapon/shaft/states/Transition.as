package alternativa.tanks.models.weapon.shaft.states {
  import alternativa.tanks.models.weapon.shaft.ShaftEventType;

  public class Transition {
    public var eventType:ShaftEventType;
    public var state:IShaftState;
    public var newState:IShaftState;
    public var handler:ITransitionHandler;

    public function Transition(param1:ShaftEventType, param2:IShaftState, param3:IShaftState, param4:ITransitionHandler) {
      super();
      this.eventType = param1;
      this.state = param2;
      this.newState = param3;
      this.handler = param4;
    }
  }
}
