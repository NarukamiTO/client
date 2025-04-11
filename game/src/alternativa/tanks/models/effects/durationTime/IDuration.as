package alternativa.tanks.models.effects.durationTime {
  [ModelInterface]
  public interface IDuration {
    function getDurationTimeInMs() : int;
    function isInfinite() : Boolean;
  }
}
