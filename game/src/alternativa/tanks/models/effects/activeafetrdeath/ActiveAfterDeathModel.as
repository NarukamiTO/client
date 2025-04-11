package alternativa.tanks.models.effects.activeafetrdeath {
  import projects.tanks.client.battlefield.models.effects.activeafterdeath.ActiveAfterDeathModelBase;
  import projects.tanks.client.battlefield.models.effects.activeafterdeath.IActiveAfterDeathModelBase;

  [ModelInfo]
  public class ActiveAfterDeathModel extends ActiveAfterDeathModelBase implements IActiveAfterDeathModelBase, IActiveAfterDeath {
    public function ActiveAfterDeathModel() {
      super();
    }

    public function isEnabled() : Boolean {
      return getInitParam().enabled;
    }
  }
}
