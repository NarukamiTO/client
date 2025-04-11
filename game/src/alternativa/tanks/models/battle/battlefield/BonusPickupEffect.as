package alternativa.tanks.models.battle.battlefield {
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.sfx.GraphicEffect;

  public class BonusPickupEffect implements GraphicEffect {
    private static const COLOR_OFFSET:int = 100;
    private static const SPEED:Number = 400 / 1000;

    public var onScene:Boolean;

    private var tank:Tank;
    private var offset:Number = 0;
    private var speed:Number = 0;

    public function BonusPickupEffect(param1:Tank) {
      super();
      this.tank = param1;
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.onScene = true;
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      if(this.isDead()) {
        return false;
      }
      this.offset += this.speed * param1;
      if(this.offset > COLOR_OFFSET) {
        this.offset = COLOR_OFFSET;
        this.speed = -SPEED;
      } else if(this.offset < 0) {
        this.offset = 0;
      }
      return true;
    }

    private function isDead() : Boolean {
      return this.offset == 0 && this.speed < 0;
    }

    public function destroy() : void {
      this.onScene = false;
    }

    public function kill() : void {
      this.offset = 0;
      this.speed = -1;
    }

    public function init() : void {
      this.speed = SPEED;
    }
  }
}
