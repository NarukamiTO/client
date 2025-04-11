package projects.tanks.clients.fp10.libraries.tanksservices.model.formatbattle {
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.tanksservices.model.formatbattle.EquipmentConstraintsNamingModelBase;
  import projects.tanks.client.tanksservices.model.formatbattle.IEquipmentConstraintsNamingModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.BattleFormatUtil;

  [ModelInfo]
  public class EquipmentConstraintsNamingModel extends EquipmentConstraintsNamingModelBase implements IEquipmentConstraintsNamingModelBase, ObjectLoadListener {
    [Inject]
    public static var battleFormatUtil:BattleFormatUtil;

    public function EquipmentConstraintsNamingModel() {
      super();
    }

    public function objectLoaded() : void {
      battleFormatUtil.init(getInitParam());
    }
  }
}
