package alternativa.tanks.sfx {
  import alternativa.engine3d.core.Light3D;
  import alternativa.engine3d.lights.OmniLight;
  import alternativa.engine3d.lights.SpotLight;
  import alternativa.engine3d.lights.TubeLight;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightEffectItem;

  public final class LightAnimation {
    private var frames:int;
    private var time:Vector.<uint>;
    private var intensity:Vector.<Number>;
    private var color:Vector.<uint>;
    private var attenuationBegin:Vector.<Number>;
    private var attenuationEnd:Vector.<Number>;

    public function LightAnimation(param1:Vector.<LightEffectItem>) {
      var local3:LightEffectItem = null;
      super();
      this.frames = param1.length;
      this.intensity = new Vector.<Number>(this.frames,true);
      this.color = new Vector.<uint>(this.frames,true);
      this.attenuationBegin = new Vector.<Number>(this.frames,true);
      this.attenuationEnd = new Vector.<Number>(this.frames,true);
      this.time = new Vector.<uint>(this.frames,true);
      var local2:int = 0;
      while(local2 < this.frames) {
        local3 = param1[local2];
        this.intensity[local2] = Number(local3.intensity);
        this.color[local2] = uint(local3.color);
        this.attenuationBegin[local2] = Number(local3.attenuationBegin);
        this.attenuationEnd[local2] = Number(local3.attenuationEnd);
        this.time[local2] = uint(local3.time);
        local2++;
      }
    }

    private static function lerpNumber(param1:Number, param2:Number, param3:Number) : Number {
      return param1 + (param2 - param1) * param3;
    }

    private static function lerpColor(param1:uint, param2:uint, param3:Number) : uint {
      var local4:Number = (param1 >> 16 & 0xFF) / 255;
      var local5:Number = (param1 >> 8 & 0xFF) / 255;
      var local6:Number = (param1 & 0xFF) / 255;
      var local7:Number = (param2 >> 16 & 0xFF) / 255;
      var local8:Number = (param2 >> 8 & 0xFF) / 255;
      var local9:Number = (param2 & 0xFF) / 255;
      var local10:int = lerpNumber(local4,local7,param3) * 255;
      var local11:int = lerpNumber(local5,local8,param3) * 255;
      var local12:int = lerpNumber(local6,local9,param3) * 255;
      return local10 << 16 | local11 << 8 | local12;
    }

    private function getFrameByTime(param1:Number) : Number {
      var local3:int = 0;
      var local4:Number = NaN;
      var local5:Number = NaN;
      var local6:Number = NaN;
      var local2:Number = 0;
      if(param1 < this.time[this.frames - 1]) {
        local3 = 0;
        while(local3 < this.frames - 1) {
          local4 = this.time[local3];
          local5 = this.time[local3 + 1];
          if(param1 >= local4 && param1 < local5) {
            local6 = (param1 - local4) / (local5 - local4);
            local2 = local3 + local6;
            break;
          }
          local3++;
        }
      } else {
        local2 = this.frames - 1;
      }
      return local2;
    }

    public function getFramesCount() : int {
      return this.frames;
    }

    private function limitFrame(param1:int) : int {
      return param1 < this.frames ? param1 : this.frames - 1;
    }

    private function updateSpotLight(param1:Number, param2:SpotLight) : void {
      var local3:int = this.limitFrame(Math.floor(param1));
      var local4:int = this.limitFrame(Math.ceil(param1));
      var local5:Number = param1 - local3;
      var local6:Number = this.intensity[local3];
      var local7:Number = this.intensity[local4];
      var local8:uint = this.color[local3];
      var local9:uint = this.color[local4];
      var local10:Number = this.attenuationBegin[local3];
      var local11:Number = this.attenuationBegin[local4];
      var local12:Number = this.attenuationEnd[local3];
      var local13:Number = this.attenuationEnd[local4];
      param2.intensity = lerpNumber(local6,local7,local5);
      param2.color = lerpColor(local8,local9,local5);
      param2.attenuationBegin = lerpNumber(local10,local11,local5);
      param2.attenuationEnd = lerpNumber(local12,local13,local5);
    }

    private function updateOmniLight(param1:Number, param2:OmniLight) : void {
      var local3:int = this.limitFrame(Math.floor(param1));
      var local4:int = this.limitFrame(Math.ceil(param1));
      var local5:Number = param1 - local3;
      var local6:Number = this.intensity[local3];
      var local7:Number = this.intensity[local4];
      var local8:uint = this.color[local3];
      var local9:uint = this.color[local4];
      var local10:Number = this.attenuationBegin[local3];
      var local11:Number = this.attenuationBegin[local4];
      var local12:Number = this.attenuationEnd[local3];
      var local13:Number = this.attenuationEnd[local4];
      param2.intensity = lerpNumber(local6,local7,local5);
      param2.color = lerpColor(local8,local9,local5);
      param2.attenuationBegin = lerpNumber(local10,local11,local5);
      param2.attenuationEnd = lerpNumber(local12,local13,local5);
    }

    private function updateTubeLight(param1:Number, param2:TubeLight) : void {
      var local3:int = this.limitFrame(Math.floor(param1));
      var local4:int = this.limitFrame(Math.ceil(param1));
      var local5:Number = param1 - local3;
      var local6:Number = this.intensity[local3];
      var local7:Number = this.intensity[local4];
      var local8:uint = this.color[local3];
      var local9:uint = this.color[local4];
      var local10:Number = this.attenuationBegin[local3];
      var local11:Number = this.attenuationBegin[local4];
      var local12:Number = this.attenuationEnd[local3];
      var local13:Number = this.attenuationEnd[local4];
      param2.intensity = lerpNumber(local6,local7,local5);
      param2.color = lerpColor(local8,local9,local5);
      param2.attenuationBegin = lerpNumber(local10,local11,local5);
      param2.attenuationEnd = lerpNumber(local12,local13,local5);
    }

    public function updateByTime(param1:Light3D, param2:int, param3:int = -1) : void {
      var local4:Number = 1;
      if(param3 > 0 && this.frames > 0) {
        local4 = this.time[this.frames - 1] / param3;
      }
      var local5:Number = this.getFrameByTime(param2 * local4);
      this.updateByFrame(param1,local5);
    }

    private function updateByFrame(param1:Light3D, param2:Number) : void {
      if(param1 is OmniLight) {
        this.updateOmniLight(param2,OmniLight(param1));
      } else if(param1 is SpotLight) {
        this.updateSpotLight(param2,SpotLight(param1));
      } else if(param1 is TubeLight) {
        this.updateTubeLight(param2,TubeLight(param1));
      }
      param1.calculateBounds();
    }

    public function getLiveTime() : int {
      return this.time[this.frames - 1];
    }
  }
}
