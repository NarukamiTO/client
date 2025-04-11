package alternativa.tanks.models.effects.effectlevel {
  import projects.tanks.client.battlefield.models.effects.effectlevel.EffectLevelModelBase;
  import projects.tanks.client.battlefield.models.effects.effectlevel.IEffectLevelModelBase;

  [ModelInfo]
  public class EffectLevelModel extends EffectLevelModelBase implements IEffectLevel, IEffectLevelModelBase {
    public function EffectLevelModel() {
      super();
    }

    public function getEffectLevel() : int {
      return getInitParam().effectLevel;
    }
  }
}
