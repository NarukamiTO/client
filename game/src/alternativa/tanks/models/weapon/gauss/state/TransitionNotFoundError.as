package alternativa.tanks.models.weapon.gauss.state {
  import alternativa.tanks.models.weapon.gauss.GaussEventType;

  public class TransitionNotFoundError extends Error {
    public function TransitionNotFoundError(param1:IGaussState, param2:GaussEventType) {
      super("Transition not found (currentState: " + param1 + ", eventType: " + param2);
    }
  }
}
