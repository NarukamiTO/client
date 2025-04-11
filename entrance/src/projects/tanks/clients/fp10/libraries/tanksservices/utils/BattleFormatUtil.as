package projects.tanks.clients.fp10.libraries.tanksservices.utils {
  import alternativa.osgi.service.locale.ILocaleService;
  import flash.utils.Dictionary;
  import projects.tanks.client.tanksservices.model.formatbattle.EquipmentConstraintsCC;
  import projects.tanks.client.tanksservices.model.formatbattle.EquipmentConstraintsModeInfo;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class BattleFormatUtil {
    [Inject]
    public static var localeService:ILocaleService;

    private var equipmentConstraintsModeNames:Dictionary;
    private var equipmentConstraintsModes:Vector.<EquipmentConstraintsModeInfo>;

    public function BattleFormatUtil() {
      super();
    }

    public function init(param1:EquipmentConstraintsCC) : void {
      var modeInfo:EquipmentConstraintsModeInfo = null;
      var equipmentConstraintsCC:EquipmentConstraintsCC = param1;
      if(this.equipmentConstraintsModeNames != null) {
        return;
      }
      this.equipmentConstraintsModes = equipmentConstraintsCC.equipmentConstraintsModeInfos.concat().sort(function(param1:EquipmentConstraintsModeInfo, param2:EquipmentConstraintsModeInfo):int {
        return param1.index - param2.index;
      });
      this.equipmentConstraintsModeNames = new Dictionary();
      for each(modeInfo in this.equipmentConstraintsModes) {
        this.equipmentConstraintsModeNames[modeInfo.mode] = modeInfo.name;
      }
    }

    public function isFormatBattle(param1:String, param2:Boolean) : Boolean {
      return param2 || param1 != null;
    }

    public function getShortFormatName(param1:String, param2:Boolean) : String {
      if(param2) {
        return this.getParkourFormatName();
      }
      return param1 != null ? this.equipmentConstraintsModeNames[param1] : "";
    }

    public function getParkourFormatName() : String {
      return localeService.getText(TanksLocale.TEXT_FORMAT_NAME_PARKOUR);
    }

    public function getEquipmentConstraintsModes() : Vector.<EquipmentConstraintsModeInfo> {
      return this.equipmentConstraintsModes;
    }

    public function getClanFormatName() : String {
      return "Клановый";
    }
  }
}
