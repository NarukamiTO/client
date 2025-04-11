package alternativa.tanks.battle.objects.tank.tankskin.dynamic {
  public class CircleDynamicSkin extends CommonDynamicSkin {
    private var centerU:Number;
    private var centerV:Number;

    public function CircleDynamicSkin(param1:Number, param2:Number) {
      super();
      this.centerU = param1;
      this.centerV = param2;
    }

    override public function init() : void {
      super.init();
      this.rotate(0);
    }

    override public function rotate(param1:Number) : void {
      super.rotate(param1);
    }
  }
}
