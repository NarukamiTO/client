package alternativa.engine3d.lights {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Debug;
  import alternativa.engine3d.core.Light3D;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Vertex;
  import flash.display.Sprite;

  use namespace alternativa3d;

  public class OmniLight extends Light3D {
    public var attenuationBegin:Number;
    public var attenuationEnd:Number;

    public function OmniLight(param1:uint, param2:Number, param3:Number) {
      super();
      this.color = param1;
      this.attenuationBegin = param2;
      this.attenuationEnd = param3;
      calculateBounds();
    }

    override public function clone() : Object3D {
      var local1:OmniLight = new OmniLight(color,this.attenuationBegin,this.attenuationEnd);
      local1.clonePropertiesFrom(this);
      return local1;
    }

    override alternativa3d function drawDebug(param1:Camera3D) : void {
      var local3:Sprite = null;
      var local4:Number = NaN;
      var local5:Number = NaN;
      var local6:Number = NaN;
      var local7:int = 0;
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local2:int = int(param1.alternativa3d::checkInDebug(this));
      if(local2 > 0) {
        local3 = param1.view.alternativa3d::canvas;
        if(Boolean(local2 & Debug.LIGHTS) && alternativa3d::ml > param1.nearClipping) {
          local4 = (color >> 16 & 0xFF) * intensity;
          local5 = (color >> 8 & 0xFF) * intensity;
          local6 = (color & 0xFF) * intensity;
          local7 = ((local4 > 255 ? 255 : local4) << 16) + ((local5 > 255 ? 255 : local5) << 8) + (local6 > 255 ? 255 : local6);
          local8 = alternativa3d::ma * param1.alternativa3d::viewSizeX / param1.alternativa3d::focalLength;
          local9 = alternativa3d::me * param1.alternativa3d::viewSizeY / param1.alternativa3d::focalLength;
          local10 = Math.sqrt(local8 * local8 + local9 * local9 + alternativa3d::mi * alternativa3d::mi);
          local8 = alternativa3d::mb * param1.alternativa3d::viewSizeX / param1.alternativa3d::focalLength;
          local9 = alternativa3d::mf * param1.alternativa3d::viewSizeY / param1.alternativa3d::focalLength;
          local10 += Math.sqrt(local8 * local8 + local9 * local9 + alternativa3d::mj * alternativa3d::mj);
          local8 = alternativa3d::mc * param1.alternativa3d::viewSizeX / param1.alternativa3d::focalLength;
          local9 = alternativa3d::mg * param1.alternativa3d::viewSizeY / param1.alternativa3d::focalLength;
          local10 += Math.sqrt(local8 * local8 + local9 * local9 + alternativa3d::mk * alternativa3d::mk);
          local10 /= 3;
          local11 = Math.round(alternativa3d::md * param1.alternativa3d::viewSizeX / alternativa3d::ml);
          local12 = Math.round(alternativa3d::mh * param1.alternativa3d::viewSizeY / alternativa3d::ml);
          local13 = 8;
          local3.graphics.lineStyle(1,local7);
          local3.graphics.moveTo(local11 - local13,local12);
          local3.graphics.lineTo(local11 + local13,local12);
          local3.graphics.moveTo(local11,local12 - local13);
          local3.graphics.lineTo(local11,local12 + local13);
          local3.graphics.moveTo(local11 - local13 * 0.7,local12 - local13 * 0.7);
          local3.graphics.lineTo(local11 + local13 * 0.7,local12 + local13 * 0.7);
          local3.graphics.moveTo(local11 - local13 * 0.7,local12 + local13 * 0.7);
          local3.graphics.lineTo(local11 + local13 * 0.7,local12 - local13 * 0.7);
          local3.graphics.drawCircle(local11,local12,this.attenuationBegin * local10 * param1.alternativa3d::focalLength / alternativa3d::ml);
          local3.graphics.lineStyle(1,local7,0.5);
          local3.graphics.drawCircle(local11,local12,this.attenuationEnd * local10 * param1.alternativa3d::focalLength / alternativa3d::ml);
        }
        if(Boolean(local2 & Debug.BOUNDS)) {
          Debug.alternativa3d::drawBounds(param1,this,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ,10092288);
        }
      }
    }

    override alternativa3d function updateBounds(param1:Object3D, param2:Object3D = null) : void {
      var local3:Vertex = null;
      if(param2 != null) {
        local3 = alternativa3d::boundVertexList;
        local3.x = -this.attenuationEnd;
        local3.y = -this.attenuationEnd;
        local3.z = -this.attenuationEnd;
        local3 = local3.alternativa3d::next;
        local3.x = this.attenuationEnd;
        local3.y = -this.attenuationEnd;
        local3.z = -this.attenuationEnd;
        local3 = local3.alternativa3d::next;
        local3.x = -this.attenuationEnd;
        local3.y = this.attenuationEnd;
        local3.z = -this.attenuationEnd;
        local3 = local3.alternativa3d::next;
        local3.x = this.attenuationEnd;
        local3.y = this.attenuationEnd;
        local3.z = -this.attenuationEnd;
        local3 = local3.alternativa3d::next;
        local3.x = -this.attenuationEnd;
        local3.y = -this.attenuationEnd;
        local3.z = this.attenuationEnd;
        local3 = local3.alternativa3d::next;
        local3.x = this.attenuationEnd;
        local3.y = -this.attenuationEnd;
        local3.z = this.attenuationEnd;
        local3 = local3.alternativa3d::next;
        local3.x = -this.attenuationEnd;
        local3.y = this.attenuationEnd;
        local3.z = this.attenuationEnd;
        local3 = local3.alternativa3d::next;
        local3.x = this.attenuationEnd;
        local3.y = this.attenuationEnd;
        local3.z = this.attenuationEnd;
        local3 = alternativa3d::boundVertexList;
        while(local3 != null) {
          local3.alternativa3d::cameraX = param2.alternativa3d::ma * local3.x + param2.alternativa3d::mb * local3.y + param2.alternativa3d::mc * local3.z + param2.alternativa3d::md;
          local3.alternativa3d::cameraY = param2.alternativa3d::me * local3.x + param2.alternativa3d::mf * local3.y + param2.alternativa3d::mg * local3.z + param2.alternativa3d::mh;
          local3.alternativa3d::cameraZ = param2.alternativa3d::mi * local3.x + param2.alternativa3d::mj * local3.y + param2.alternativa3d::mk * local3.z + param2.alternativa3d::ml;
          if(local3.alternativa3d::cameraX < param1.boundMinX) {
            param1.boundMinX = local3.alternativa3d::cameraX;
          }
          if(local3.alternativa3d::cameraX > param1.boundMaxX) {
            param1.boundMaxX = local3.alternativa3d::cameraX;
          }
          if(local3.alternativa3d::cameraY < param1.boundMinY) {
            param1.boundMinY = local3.alternativa3d::cameraY;
          }
          if(local3.alternativa3d::cameraY > param1.boundMaxY) {
            param1.boundMaxY = local3.alternativa3d::cameraY;
          }
          if(local3.alternativa3d::cameraZ < param1.boundMinZ) {
            param1.boundMinZ = local3.alternativa3d::cameraZ;
          }
          if(local3.alternativa3d::cameraZ > param1.boundMaxZ) {
            param1.boundMaxZ = local3.alternativa3d::cameraZ;
          }
          local3 = local3.alternativa3d::next;
        }
      } else {
        if(-this.attenuationEnd < param1.boundMinX) {
          param1.boundMinX = -this.attenuationEnd;
        }
        if(this.attenuationEnd > param1.boundMaxX) {
          param1.boundMaxX = this.attenuationEnd;
        }
        if(-this.attenuationEnd < param1.boundMinY) {
          param1.boundMinY = -this.attenuationEnd;
        }
        if(this.attenuationEnd > param1.boundMaxY) {
          param1.boundMaxY = this.attenuationEnd;
        }
        if(-this.attenuationEnd < param1.boundMinZ) {
          param1.boundMinZ = -this.attenuationEnd;
        }
        if(this.attenuationEnd > param1.boundMaxZ) {
          param1.boundMaxZ = this.attenuationEnd;
        }
      }
    }
  }
}
