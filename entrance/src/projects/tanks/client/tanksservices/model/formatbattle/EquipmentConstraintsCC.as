package projects.tanks.client.tanksservices.model.formatbattle {
  public class EquipmentConstraintsCC {
    private var _equipmentConstraintsModeInfos:Vector.<EquipmentConstraintsModeInfo>;

    public function EquipmentConstraintsCC(param1:Vector.<EquipmentConstraintsModeInfo> = null) {
      super();
      this._equipmentConstraintsModeInfos = param1;
    }

    public function get equipmentConstraintsModeInfos() : Vector.<EquipmentConstraintsModeInfo> {
      return this._equipmentConstraintsModeInfos;
    }

    public function set equipmentConstraintsModeInfos(param1:Vector.<EquipmentConstraintsModeInfo>) : void {
      this._equipmentConstraintsModeInfos = param1;
    }

    public function toString() : String {
      var local1:String = "EquipmentConstraintsCC [";
      local1 += "equipmentConstraintsModeInfos = " + this.equipmentConstraintsModeInfos + " ";
      return local1 + "]";
    }
  }
}
