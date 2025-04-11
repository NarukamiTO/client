package alternativa.tanks.bonuses {
  public class BattleBonusState {
    public var pivotZ:Number = 0;
    public var angleX:Number = 0;
    public var angleZ:Number = 0;

    public function BattleBonusState() {
      super();
    }

    public function interpolate(param1:BattleBonusState, param2:BattleBonusState, param3:Number) : void {
      this.pivotZ = param1.pivotZ + param3 * (param2.pivotZ - param1.pivotZ);
      this.angleX = param1.angleX + param3 * (param2.angleX - param1.angleX);
      this.angleZ = param1.angleZ + param3 * (param2.angleZ - param1.angleZ);
    }

    public function copy(param1:BattleBonusState) : void {
      this.pivotZ = param1.pivotZ;
      this.angleX = param1.angleX;
      this.angleZ = param1.angleZ;
    }
  }
}
