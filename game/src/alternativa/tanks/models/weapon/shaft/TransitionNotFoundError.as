package alternativa.tanks.models.weapon.shaft {
  import alternativa.tanks.models.weapon.shaft.states.IShaftState;

  public class TransitionNotFoundError extends Error {
    public function TransitionNotFoundError(param1:IShaftState, param2:ShaftEventType) {
      super("Transition not found (currentState: " + param1 + ", eventType: " + param2);
    }
  }
}
