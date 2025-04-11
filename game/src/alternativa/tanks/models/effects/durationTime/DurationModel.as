package alternativa.tanks.models.effects.durationTime {
  import projects.tanks.client.battlefield.models.effects.duration.time.DurationModelBase;
  import projects.tanks.client.battlefield.models.effects.duration.time.IDurationModelBase;

  [ModelInfo]
  public class DurationModel extends DurationModelBase implements IDurationModelBase, IDuration {
    public function DurationModel() {
      super();
    }

    public function getDurationTimeInMs() : int {
      return getInitParam().durationTimeInMs;
    }

    public function isInfinite() : Boolean {
      return getInitParam().infinite;
    }
  }
}
