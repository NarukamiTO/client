package alternativa.tanks.models.battle.meteor {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.sfx.PositionAndRotationProvider;
  import flash.display.BlendMode;

  public class MeteorFlame implements GraphicEffect {
    private var material:TextureMaterial;
    private var container:Scene3DContainer;
    private var positionAndRotationProvider:PositionAndRotationProvider;
    private var flameTime:Number = 0;
    private var alive:Boolean = false;
    private var fadingOut:Boolean = false;
    private var fadeOutTime:Number = 0;

    internal const FLAME_SPRITE_SIZE:Number = 512;
    internal const FLAMES_COUNT:Number = 24;
    internal const FLAME_LOOP:Number = 0.8;
    internal const FADE_OUT_DURATION_COEFF:Number = 0.5;

    private var meteorPosition:Vector3;
    private var meteorDirection:Vector3;
    private var flames:Vector.<Sprite3D>;

    public function MeteorFlame(param1:TextureMaterial, param2:PositionAndRotationProvider) {
      var local4:Sprite3D = null;
      this.meteorPosition = new Vector3();
      this.meteorDirection = new Vector3();
      super();
      this.material = param1;
      this.positionAndRotationProvider = param2;
      this.flames = new Vector.<Sprite3D>();
      var local3:int = 0;
      while(local3 < this.FLAMES_COUNT) {
        local4 = new Sprite3D(this.FLAME_SPRITE_SIZE,this.FLAME_SPRITE_SIZE,param1);
        local4.blendMode = BlendMode.ADD;
        this.flames.push(local4);
        local3++;
      }
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      var local2:Sprite3D = null;
      this.container = param1;
      this.alive = true;
      this.fadingOut = false;
      this.flameTime = 0;
      for each(local2 in this.flames) {
        param1.addChild(local2);
      }
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      this.positionAndRotationProvider.readPositionAndRotation(this.meteorPosition,this.meteorDirection);
      this.update(param1 / 1000,this.meteorPosition,this.meteorDirection);
      return this.alive;
    }

    private function update(param1:Number, param2:Vector3, param3:Vector3) : void {
      var local5:Sprite3D = null;
      this.flameTime += param1;
      var local4:int = 0;
      while(local4 < this.flames.length) {
        local5 = this.flames[local4];
        this.updateFlame(local5,this.flameTime + local4 * this.FLAME_LOOP / this.FLAMES_COUNT,param2,param3);
        local4++;
      }
    }

    private function updateFlame(param1:Sprite3D, param2:Number, param3:Vector3, param4:Vector3) : void {
      var local16:Number = NaN;
      var local17:Number = NaN;
      var local18:Number = NaN;
      var local19:Number = NaN;
      var local20:Number = NaN;
      var local5:Number = 5 / 60;
      var local6:Number = this.FLAME_LOOP;
      var local7:Number = 0.5;
      var local8:Number = 0.8;
      var local9:Number = 0.2;
      var local10:Number = 20;
      var local11:Number = 300;
      var local12:Number = 3000;
      var local13:Number = 0.6;
      var local14:Number = 1;
      var local15:Number = 0;
      if(!this.fadingOut) {
        local20 = param2 % local6;
      } else {
        local20 = Math.min((param2 - this.fadeOutTime) / this.FADE_OUT_DURATION_COEFF,this.FLAME_LOOP / this.FADE_OUT_DURATION_COEFF);
      }
      if(local20 <= local5) {
        local16 = local20 / local5;
        local17 = local7 + (local8 - local7) * local16;
        local18 = local10 + (local11 - local10) * local16;
        local19 = local13 + (local14 - local13) * local16;
      } else {
        local16 = (local20 - local5) / (local6 - local5);
        local17 = local8 + (local9 - local8) * local16;
        local18 = local11 + (local12 - local11) * local16;
        local19 = local14 + (local15 - local14) * local16;
      }
      param1.scaleX = local17;
      param1.scaleY = local17;
      param1.scaleZ = local17;
      param1.x = param3.x - param4.x * local18;
      param1.y = param3.y - param4.y * local18;
      param1.z = param3.z - param4.z * local18;
      param1.alpha = local19;
    }

    public function destroy() : void {
      var local1:Sprite3D = null;
      if(this.container != null) {
        for each(local1 in this.flames) {
          this.container.removeChild(local1);
        }
        this.container = null;
      }
    }

    public function kill() : void {
      this.alive = false;
    }

    public function fadeOut() : void {
      this.fadingOut = true;
      this.fadeOutTime = this.flameTime;
    }
  }
}
