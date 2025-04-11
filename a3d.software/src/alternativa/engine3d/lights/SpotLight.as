package alternativa.engine3d.lights {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Canvas;
  import alternativa.engine3d.core.Debug;
  import alternativa.engine3d.core.Light3D;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Vertex;

  use namespace alternativa3d;

  public class SpotLight extends Light3D {
    public var attenuationBegin:Number;
    public var attenuationEnd:Number;
    public var hotspot:Number;
    public var falloff:Number;

    alternativa3d var localAttenuationBegin:Number;
    alternativa3d var localAttenuationEnd:Number;
    alternativa3d var localDirectionX:Number;
    alternativa3d var localDirectionY:Number;
    alternativa3d var localDirectionZ:Number;
    alternativa3d var localHotspot:Number;
    alternativa3d var localFalloff:Number;

    public function SpotLight(param1:uint, param2:Number, param3:Number, param4:Number, param5:Number) {
      super();
      this.color = param1;
      this.attenuationBegin = param2;
      this.attenuationEnd = param3;
      this.hotspot = param4;
      this.falloff = param5;
      calculateBounds();
    }

    public function lookAt(param1:Number, param2:Number, param3:Number) : void {
      var local4:Number = NaN;
      local4 = param1 - this.x;
      var local5:Number = param2 - this.y;
      var local6:Number = param3 - this.z;
      rotationX = Math.atan2(local6,Math.sqrt(local4 * local4 + local5 * local5)) - Math.PI / 2;
      rotationY = 0;
      rotationZ = -Math.atan2(local4,local5);
    }

    override public function clone() : Object3D {
      var local1:SpotLight = new SpotLight(color,this.attenuationBegin,this.attenuationEnd,this.hotspot,this.falloff);
      local1.clonePropertiesFrom(this);
      return local1;
    }

    override alternativa3d function drawDebug(param1:Camera3D, param2:Canvas) : void {
      var local4:Canvas = null;
      var local5:Number = NaN;
      var local6:Number = NaN;
      var local7:Number = NaN;
      var local8:int = 0;
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local16:Number = NaN;
      var local17:Number = NaN;
      var local18:Number = NaN;
      var local19:Number = NaN;
      var local20:Number = NaN;
      var local21:Number = NaN;
      var local22:Number = NaN;
      var local23:Number = NaN;
      var local24:Number = NaN;
      var local25:Number = NaN;
      var local26:Number = NaN;
      var local27:Number = NaN;
      var local28:Number = NaN;
      var local29:Number = NaN;
      var local30:Number = NaN;
      var local31:Number = NaN;
      var local32:Number = NaN;
      var local33:Number = NaN;
      var local34:Number = NaN;
      var local35:Number = NaN;
      var local36:Number = NaN;
      var local37:Number = NaN;
      var local38:Number = NaN;
      var local39:Number = NaN;
      var local40:Number = NaN;
      var local41:Number = NaN;
      var local42:Number = NaN;
      var local43:Number = NaN;
      var local44:Number = NaN;
      var local45:Number = NaN;
      var local46:Number = NaN;
      var local47:Number = NaN;
      var local48:Number = NaN;
      var local3:int = int(param1.alternativa3d::checkInDebug(this));
      if(local3 > 0) {
        local4 = param2.alternativa3d::getChildCanvas(true,false);
        if(Boolean(local3 & Debug.LIGHTS) && alternativa3d::ml > param1.nearClipping) {
          local5 = (color >> 16 & 0xFF) * intensity;
          local6 = (color >> 8 & 0xFF) * intensity;
          local7 = (color & 0xFF) * intensity;
          local8 = ((local5 > 255 ? 255 : local5) << 16) + ((local6 > 255 ? 255 : local6) << 8) + (local7 > 255 ? 255 : local7);
          local9 = 0;
          local10 = alternativa3d::md * param1.alternativa3d::viewSizeX / param1.alternativa3d::focalLength;
          local11 = alternativa3d::mh * param1.alternativa3d::viewSizeY / param1.alternativa3d::focalLength;
          local12 = Number(alternativa3d::ml);
          local13 = alternativa3d::mc * param1.alternativa3d::viewSizeX / param1.alternativa3d::focalLength;
          local14 = alternativa3d::mg * param1.alternativa3d::viewSizeY / param1.alternativa3d::focalLength;
          local15 = Number(alternativa3d::mk);
          local16 = Math.sqrt(local13 * local13 + local14 * local14 + local15 * local15);
          local9 += local16;
          local13 /= local16;
          local14 /= local16;
          local15 /= local16;
          local17 = alternativa3d::ma * param1.alternativa3d::viewSizeX / param1.alternativa3d::focalLength;
          local18 = alternativa3d::me * param1.alternativa3d::viewSizeY / param1.alternativa3d::focalLength;
          local19 = Number(alternativa3d::mi);
          local9 += Math.sqrt(local17 * local17 + local18 * local18 + local19 * local19);
          local20 = local19 * local14 - local18 * local15;
          local21 = local17 * local15 - local19 * local13;
          local22 = local18 * local13 - local17 * local14;
          local16 = Math.sqrt(local20 * local20 + local21 * local21 + local22 * local22);
          local20 /= local16;
          local21 /= local16;
          local22 /= local16;
          local17 = alternativa3d::mb * param1.alternativa3d::viewSizeX / param1.alternativa3d::focalLength;
          local18 = alternativa3d::mf * param1.alternativa3d::viewSizeY / param1.alternativa3d::focalLength;
          local19 = Number(alternativa3d::mj);
          local9 += Math.sqrt(local17 * local17 + local18 * local18 + local19 * local19);
          local9 /= 3;
          local17 = local22 * local14 - local21 * local15;
          local18 = local20 * local15 - local22 * local13;
          local19 = local21 * local13 - local20 * local14;
          local23 = Math.cos(this.hotspot / 2);
          local24 = Math.sin(this.hotspot / 2);
          local25 = local10 + (local13 * local23 + local17 * local24) * local9 * this.attenuationBegin;
          local26 = local11 + (local14 * local23 + local18 * local24) * local9 * this.attenuationBegin;
          local27 = local12 + (local15 * local23 + local19 * local24) * local9 * this.attenuationBegin;
          local28 = local10 + (local13 * local23 + (local17 + local20) * 0.9 * local24) * local9 * this.attenuationBegin;
          local29 = local11 + (local14 * local23 + (local18 + local21) * 0.9 * local24) * local9 * this.attenuationBegin;
          local30 = local12 + (local15 * local23 + (local19 + local22) * 0.9 * local24) * local9 * this.attenuationBegin;
          local31 = local10 + (local13 * local23 + local20 * local24) * local9 * this.attenuationBegin;
          local32 = local11 + (local14 * local23 + local21 * local24) * local9 * this.attenuationBegin;
          local33 = local12 + (local15 * local23 + local22 * local24) * local9 * this.attenuationBegin;
          local34 = local10 + (local13 * local23 - (local17 - local20) * 0.9 * local24) * local9 * this.attenuationBegin;
          local35 = local11 + (local14 * local23 - (local18 - local21) * 0.9 * local24) * local9 * this.attenuationBegin;
          local36 = local12 + (local15 * local23 - (local19 - local22) * 0.9 * local24) * local9 * this.attenuationBegin;
          local37 = local10 + (local13 * local23 - local17 * local24) * local9 * this.attenuationBegin;
          local38 = local11 + (local14 * local23 - local18 * local24) * local9 * this.attenuationBegin;
          local39 = local12 + (local15 * local23 - local19 * local24) * local9 * this.attenuationBegin;
          local40 = local10 + (local13 * local23 - (local17 + local20) * 0.9 * local24) * local9 * this.attenuationBegin;
          local41 = local11 + (local14 * local23 - (local18 + local21) * 0.9 * local24) * local9 * this.attenuationBegin;
          local42 = local12 + (local15 * local23 - (local19 + local22) * 0.9 * local24) * local9 * this.attenuationBegin;
          local43 = local10 + (local13 * local23 - local20 * local24) * local9 * this.attenuationBegin;
          local44 = local11 + (local14 * local23 - local21 * local24) * local9 * this.attenuationBegin;
          local45 = local12 + (local15 * local23 - local22 * local24) * local9 * this.attenuationBegin;
          local46 = local10 + (local13 * local23 + (local17 - local20) * 0.9 * local24) * local9 * this.attenuationBegin;
          local47 = local11 + (local14 * local23 + (local18 - local21) * 0.9 * local24) * local9 * this.attenuationBegin;
          local48 = local12 + (local15 * local23 + (local19 - local22) * 0.9 * local24) * local9 * this.attenuationBegin;
          if(local27 > param1.nearClipping && local30 > param1.nearClipping && local33 > param1.nearClipping && local36 > param1.nearClipping && local39 > param1.nearClipping && local42 > param1.nearClipping && local45 > param1.nearClipping && local48 > param1.nearClipping) {
            local4.alternativa3d::gfx.lineStyle(1,local8);
            local4.alternativa3d::gfx.moveTo(local25 * param1.alternativa3d::focalLength / local27,local26 * param1.alternativa3d::focalLength / local27);
            local4.alternativa3d::gfx.curveTo(local28 * param1.alternativa3d::focalLength / local30,local29 * param1.alternativa3d::focalLength / local30,local31 * param1.alternativa3d::focalLength / local33,local32 * param1.alternativa3d::focalLength / local33);
            local4.alternativa3d::gfx.curveTo(local34 * param1.alternativa3d::focalLength / local36,local35 * param1.alternativa3d::focalLength / local36,local37 * param1.alternativa3d::focalLength / local39,local38 * param1.alternativa3d::focalLength / local39);
            local4.alternativa3d::gfx.curveTo(local40 * param1.alternativa3d::focalLength / local42,local41 * param1.alternativa3d::focalLength / local42,local43 * param1.alternativa3d::focalLength / local45,local44 * param1.alternativa3d::focalLength / local45);
            local4.alternativa3d::gfx.curveTo(local46 * param1.alternativa3d::focalLength / local48,local47 * param1.alternativa3d::focalLength / local48,local25 * param1.alternativa3d::focalLength / local27,local26 * param1.alternativa3d::focalLength / local27);
            local4.alternativa3d::gfx.moveTo(local10 * param1.alternativa3d::focalLength / local12,local11 * param1.alternativa3d::focalLength / local12);
            local4.alternativa3d::gfx.lineTo(local25 * param1.alternativa3d::focalLength / local27,local26 * param1.alternativa3d::focalLength / local27);
            local4.alternativa3d::gfx.moveTo(local10 * param1.alternativa3d::focalLength / local12,local11 * param1.alternativa3d::focalLength / local12);
            local4.alternativa3d::gfx.lineTo(local31 * param1.alternativa3d::focalLength / local33,local32 * param1.alternativa3d::focalLength / local33);
            local4.alternativa3d::gfx.moveTo(local10 * param1.alternativa3d::focalLength / local12,local11 * param1.alternativa3d::focalLength / local12);
            local4.alternativa3d::gfx.lineTo(local37 * param1.alternativa3d::focalLength / local39,local38 * param1.alternativa3d::focalLength / local39);
            local4.alternativa3d::gfx.moveTo(local10 * param1.alternativa3d::focalLength / local12,local11 * param1.alternativa3d::focalLength / local12);
            local4.alternativa3d::gfx.lineTo(local43 * param1.alternativa3d::focalLength / local45,local44 * param1.alternativa3d::focalLength / local45);
          }
          local23 = Math.cos(this.falloff / 2);
          local24 = Math.sin(this.falloff / 2);
          local25 = local10 + (local13 * local23 + local17 * local24) * local9 * this.attenuationEnd;
          local26 = local11 + (local14 * local23 + local18 * local24) * local9 * this.attenuationEnd;
          local27 = local12 + (local15 * local23 + local19 * local24) * local9 * this.attenuationEnd;
          local28 = local10 + (local13 * local23 + (local17 + local20) * 0.9 * local24) * local9 * this.attenuationEnd;
          local29 = local11 + (local14 * local23 + (local18 + local21) * 0.9 * local24) * local9 * this.attenuationEnd;
          local30 = local12 + (local15 * local23 + (local19 + local22) * 0.9 * local24) * local9 * this.attenuationEnd;
          local31 = local10 + (local13 * local23 + local20 * local24) * local9 * this.attenuationEnd;
          local32 = local11 + (local14 * local23 + local21 * local24) * local9 * this.attenuationEnd;
          local33 = local12 + (local15 * local23 + local22 * local24) * local9 * this.attenuationEnd;
          local34 = local10 + (local13 * local23 - (local17 - local20) * 0.9 * local24) * local9 * this.attenuationEnd;
          local35 = local11 + (local14 * local23 - (local18 - local21) * 0.9 * local24) * local9 * this.attenuationEnd;
          local36 = local12 + (local15 * local23 - (local19 - local22) * 0.9 * local24) * local9 * this.attenuationEnd;
          local37 = local10 + (local13 * local23 - local17 * local24) * local9 * this.attenuationEnd;
          local38 = local11 + (local14 * local23 - local18 * local24) * local9 * this.attenuationEnd;
          local39 = local12 + (local15 * local23 - local19 * local24) * local9 * this.attenuationEnd;
          local40 = local10 + (local13 * local23 - (local17 + local20) * 0.9 * local24) * local9 * this.attenuationEnd;
          local41 = local11 + (local14 * local23 - (local18 + local21) * 0.9 * local24) * local9 * this.attenuationEnd;
          local42 = local12 + (local15 * local23 - (local19 + local22) * 0.9 * local24) * local9 * this.attenuationEnd;
          local43 = local10 + (local13 * local23 - local20 * local24) * local9 * this.attenuationEnd;
          local44 = local11 + (local14 * local23 - local21 * local24) * local9 * this.attenuationEnd;
          local45 = local12 + (local15 * local23 - local22 * local24) * local9 * this.attenuationEnd;
          local46 = local10 + (local13 * local23 + (local17 - local20) * 0.9 * local24) * local9 * this.attenuationEnd;
          local47 = local11 + (local14 * local23 + (local18 - local21) * 0.9 * local24) * local9 * this.attenuationEnd;
          local48 = local12 + (local15 * local23 + (local19 - local22) * 0.9 * local24) * local9 * this.attenuationEnd;
          if(local27 > param1.nearClipping && local30 > param1.nearClipping && local33 > param1.nearClipping && local36 > param1.nearClipping && local39 > param1.nearClipping && local42 > param1.nearClipping && local45 > param1.nearClipping && local48 > param1.nearClipping) {
            local4.alternativa3d::gfx.lineStyle(1,local8,0.5);
            local4.alternativa3d::gfx.moveTo(local25 * param1.alternativa3d::focalLength / local27,local26 * param1.alternativa3d::focalLength / local27);
            local4.alternativa3d::gfx.curveTo(local28 * param1.alternativa3d::focalLength / local30,local29 * param1.alternativa3d::focalLength / local30,local31 * param1.alternativa3d::focalLength / local33,local32 * param1.alternativa3d::focalLength / local33);
            local4.alternativa3d::gfx.curveTo(local34 * param1.alternativa3d::focalLength / local36,local35 * param1.alternativa3d::focalLength / local36,local37 * param1.alternativa3d::focalLength / local39,local38 * param1.alternativa3d::focalLength / local39);
            local4.alternativa3d::gfx.curveTo(local40 * param1.alternativa3d::focalLength / local42,local41 * param1.alternativa3d::focalLength / local42,local43 * param1.alternativa3d::focalLength / local45,local44 * param1.alternativa3d::focalLength / local45);
            local4.alternativa3d::gfx.curveTo(local46 * param1.alternativa3d::focalLength / local48,local47 * param1.alternativa3d::focalLength / local48,local25 * param1.alternativa3d::focalLength / local27,local26 * param1.alternativa3d::focalLength / local27);
            local4.alternativa3d::gfx.moveTo(local10 * param1.alternativa3d::focalLength / local12,local11 * param1.alternativa3d::focalLength / local12);
            local4.alternativa3d::gfx.lineTo(local25 * param1.alternativa3d::focalLength / local27,local26 * param1.alternativa3d::focalLength / local27);
            local4.alternativa3d::gfx.moveTo(local10 * param1.alternativa3d::focalLength / local12,local11 * param1.alternativa3d::focalLength / local12);
            local4.alternativa3d::gfx.lineTo(local31 * param1.alternativa3d::focalLength / local33,local32 * param1.alternativa3d::focalLength / local33);
            local4.alternativa3d::gfx.moveTo(local10 * param1.alternativa3d::focalLength / local12,local11 * param1.alternativa3d::focalLength / local12);
            local4.alternativa3d::gfx.lineTo(local37 * param1.alternativa3d::focalLength / local39,local38 * param1.alternativa3d::focalLength / local39);
            local4.alternativa3d::gfx.moveTo(local10 * param1.alternativa3d::focalLength / local12,local11 * param1.alternativa3d::focalLength / local12);
            local4.alternativa3d::gfx.lineTo(local43 * param1.alternativa3d::focalLength / local45,local44 * param1.alternativa3d::focalLength / local45);
          }
        }
        if(Boolean(local3 & Debug.BOUNDS)) {
          Debug.alternativa3d::drawBounds(param1,local4,this,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ,10092288);
        }
      }
    }

    override alternativa3d function updateBounds(param1:Object3D, param2:Object3D = null) : void {
      var local5:Vertex = null;
      var local3:Number = this.falloff < Math.PI ? Math.sin(this.falloff / 2) * this.attenuationEnd : this.attenuationEnd;
      var local4:Number = this.falloff < Math.PI ? 0 : Math.cos(this.falloff / 2) * this.attenuationEnd;
      if(param2 != null) {
        local5 = alternativa3d::boundVertexList;
        local5.x = -local3;
        local5.y = -local3;
        local5.z = local4;
        local5 = local5.alternativa3d::next;
        local5.x = local3;
        local5.y = -local3;
        local5.z = local4;
        local5 = local5.alternativa3d::next;
        local5.x = -local3;
        local5.y = local3;
        local5.z = local4;
        local5 = local5.alternativa3d::next;
        local5.x = local3;
        local5.y = local3;
        local5.z = local4;
        local5 = local5.alternativa3d::next;
        local5.x = -local3;
        local5.y = -local3;
        local5.z = this.attenuationEnd;
        local5 = local5.alternativa3d::next;
        local5.x = local3;
        local5.y = -local3;
        local5.z = this.attenuationEnd;
        local5 = local5.alternativa3d::next;
        local5.x = -local3;
        local5.y = local3;
        local5.z = this.attenuationEnd;
        local5 = local5.alternativa3d::next;
        local5.x = local3;
        local5.y = local3;
        local5.z = this.attenuationEnd;
        local5 = alternativa3d::boundVertexList;
        while(local5 != null) {
          local5.alternativa3d::cameraX = param2.alternativa3d::ma * local5.x + param2.alternativa3d::mb * local5.y + param2.alternativa3d::mc * local5.z + param2.alternativa3d::md;
          local5.alternativa3d::cameraY = param2.alternativa3d::me * local5.x + param2.alternativa3d::mf * local5.y + param2.alternativa3d::mg * local5.z + param2.alternativa3d::mh;
          local5.alternativa3d::cameraZ = param2.alternativa3d::mi * local5.x + param2.alternativa3d::mj * local5.y + param2.alternativa3d::mk * local5.z + param2.alternativa3d::ml;
          if(local5.alternativa3d::cameraX < param1.boundMinX) {
            param1.boundMinX = local5.alternativa3d::cameraX;
          }
          if(local5.alternativa3d::cameraX > param1.boundMaxX) {
            param1.boundMaxX = local5.alternativa3d::cameraX;
          }
          if(local5.alternativa3d::cameraY < param1.boundMinY) {
            param1.boundMinY = local5.alternativa3d::cameraY;
          }
          if(local5.alternativa3d::cameraY > param1.boundMaxY) {
            param1.boundMaxY = local5.alternativa3d::cameraY;
          }
          if(local5.alternativa3d::cameraZ < param1.boundMinZ) {
            param1.boundMinZ = local5.alternativa3d::cameraZ;
          }
          if(local5.alternativa3d::cameraZ > param1.boundMaxZ) {
            param1.boundMaxZ = local5.alternativa3d::cameraZ;
          }
          local5 = local5.alternativa3d::next;
        }
      } else {
        if(-local3 < param1.boundMinX) {
          param1.boundMinX = -local3;
        }
        if(local3 > param1.boundMaxX) {
          param1.boundMaxX = local3;
        }
        if(-local3 < param1.boundMinY) {
          param1.boundMinY = -local3;
        }
        if(local3 > param1.boundMaxY) {
          param1.boundMaxY = local3;
        }
        if(-local4 < param1.boundMinZ) {
          param1.boundMinZ = local4;
        }
        if(this.attenuationEnd > param1.boundMaxZ) {
          param1.boundMaxZ = this.attenuationEnd;
        }
      }
    }
  }
}
