package alternativa.engine3d.lights {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Canvas;
  import alternativa.engine3d.core.Debug;
  import alternativa.engine3d.core.Light3D;
  import alternativa.engine3d.core.Object3D;

  use namespace alternativa3d;

  public class DirectionalLight extends Light3D {
    alternativa3d var localDirectionX:Number;
    alternativa3d var localDirectionY:Number;
    alternativa3d var localDirectionZ:Number;

    public function DirectionalLight(param1:uint) {
      super();
      this.color = param1;
      calculateBounds();
    }

    public function lookAt(param1:Number, param2:Number, param3:Number) : void {
      var local4:Number = param1 - this.x;
      var local5:Number = param2 - this.y;
      var local6:Number = param3 - this.z;
      rotationX = Math.atan2(local6,Math.sqrt(local4 * local4 + local5 * local5)) - Math.PI / 2;
      rotationY = 0;
      rotationZ = -Math.atan2(local4,local5);
    }

    override public function clone() : Object3D {
      var local1:DirectionalLight = new DirectionalLight(color);
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
      var local49:Number = NaN;
      var local50:Number = NaN;
      var local51:Number = NaN;
      var local52:Number = NaN;
      var local53:Number = NaN;
      var local54:Number = NaN;
      var local55:Number = NaN;
      var local56:Number = NaN;
      var local57:Number = NaN;
      var local58:Number = NaN;
      var local59:Number = NaN;
      var local60:Number = NaN;
      var local61:Number = NaN;
      var local62:Number = NaN;
      var local63:Number = NaN;
      var local64:Number = NaN;
      var local65:Number = NaN;
      var local3:int = int(param1.alternativa3d::checkInDebug(this));
      if(local3 > 0) {
        local4 = param2.alternativa3d::getChildCanvas(true,false);
        if(Boolean(local3 & Debug.LIGHTS) && alternativa3d::ml > param1.nearClipping) {
          local5 = (color >> 16 & 0xFF) * intensity;
          local6 = (color >> 8 & 0xFF) * intensity;
          local7 = (color & 0xFF) * intensity;
          local8 = ((local5 > 255 ? 255 : local5) << 16) + ((local6 > 255 ? 255 : local6) << 8) + (local7 > 255 ? 255 : local7);
          local9 = alternativa3d::md * param1.alternativa3d::viewSizeX / param1.alternativa3d::focalLength;
          local10 = alternativa3d::mh * param1.alternativa3d::viewSizeY / param1.alternativa3d::focalLength;
          local11 = Number(alternativa3d::ml);
          local12 = alternativa3d::mc * param1.alternativa3d::viewSizeX / param1.alternativa3d::focalLength;
          local13 = alternativa3d::mg * param1.alternativa3d::viewSizeY / param1.alternativa3d::focalLength;
          local14 = Number(alternativa3d::mk);
          local15 = Math.sqrt(local12 * local12 + local13 * local13 + local14 * local14);
          local12 /= local15;
          local13 /= local15;
          local14 /= local15;
          local16 = alternativa3d::ma * param1.alternativa3d::viewSizeX / param1.alternativa3d::focalLength;
          local17 = alternativa3d::me * param1.alternativa3d::viewSizeY / param1.alternativa3d::focalLength;
          local18 = Number(alternativa3d::mi);
          local19 = local18 * local13 - local17 * local14;
          local20 = local16 * local14 - local18 * local12;
          local21 = local17 * local12 - local16 * local13;
          local15 = Math.sqrt(local19 * local19 + local20 * local20 + local21 * local21);
          local19 /= local15;
          local20 /= local15;
          local21 /= local15;
          local16 = alternativa3d::mb * param1.alternativa3d::viewSizeX / param1.alternativa3d::focalLength;
          local17 = alternativa3d::mf * param1.alternativa3d::viewSizeY / param1.alternativa3d::focalLength;
          local18 = Number(alternativa3d::mj);
          local16 = local21 * local13 - local20 * local14;
          local17 = local19 * local14 - local21 * local12;
          local18 = local20 * local12 - local19 * local13;
          local22 = alternativa3d::ml / param1.alternativa3d::focalLength;
          local12 *= local22;
          local13 *= local22;
          local14 *= local22;
          local16 *= local22;
          local17 *= local22;
          local18 *= local22;
          local19 *= local22;
          local20 *= local22;
          local21 *= local22;
          local23 = 16;
          local24 = 24;
          local25 = 4;
          local26 = 8;
          local27 = local9 + local12 * local24;
          local28 = local10 + local13 * local24;
          local29 = local11 + local14 * local24;
          local30 = local9 + local16 * local25 + local19 * local25;
          local31 = local10 + local17 * local25 + local20 * local25;
          local32 = local11 + local18 * local25 + local21 * local25;
          local33 = local9 - local16 * local25 + local19 * local25;
          local34 = local10 - local17 * local25 + local20 * local25;
          local35 = local11 - local18 * local25 + local21 * local25;
          local36 = local9 - local16 * local25 - local19 * local25;
          local37 = local10 - local17 * local25 - local20 * local25;
          local38 = local11 - local18 * local25 - local21 * local25;
          local39 = local9 + local16 * local25 - local19 * local25;
          local40 = local10 + local17 * local25 - local20 * local25;
          local41 = local11 + local18 * local25 - local21 * local25;
          local42 = local9 + local12 * local23 + local16 * local25 + local19 * local25;
          local43 = local10 + local13 * local23 + local17 * local25 + local20 * local25;
          local44 = local11 + local14 * local23 + local18 * local25 + local21 * local25;
          local45 = local9 + local12 * local23 - local16 * local25 + local19 * local25;
          local46 = local10 + local13 * local23 - local17 * local25 + local20 * local25;
          local47 = local11 + local14 * local23 - local18 * local25 + local21 * local25;
          local48 = local9 + local12 * local23 - local16 * local25 - local19 * local25;
          local49 = local10 + local13 * local23 - local17 * local25 - local20 * local25;
          local50 = local11 + local14 * local23 - local18 * local25 - local21 * local25;
          local51 = local9 + local12 * local23 + local16 * local25 - local19 * local25;
          local52 = local10 + local13 * local23 + local17 * local25 - local20 * local25;
          local53 = local11 + local14 * local23 + local18 * local25 - local21 * local25;
          local54 = local9 + local12 * local23 + local16 * local26 + local19 * local26;
          local55 = local10 + local13 * local23 + local17 * local26 + local20 * local26;
          local56 = local11 + local14 * local23 + local18 * local26 + local21 * local26;
          local57 = local9 + local12 * local23 - local16 * local26 + local19 * local26;
          local58 = local10 + local13 * local23 - local17 * local26 + local20 * local26;
          local59 = local11 + local14 * local23 - local18 * local26 + local21 * local26;
          local60 = local9 + local12 * local23 - local16 * local26 - local19 * local26;
          local61 = local10 + local13 * local23 - local17 * local26 - local20 * local26;
          local62 = local11 + local14 * local23 - local18 * local26 - local21 * local26;
          local63 = local9 + local12 * local23 + local16 * local26 - local19 * local26;
          local64 = local10 + local13 * local23 + local17 * local26 - local20 * local26;
          local65 = local11 + local14 * local23 + local18 * local26 - local21 * local26;
          if(local29 > param1.nearClipping && local32 > param1.nearClipping && local35 > param1.nearClipping && local38 > param1.nearClipping && local41 > param1.nearClipping && local44 > param1.nearClipping && local47 > param1.nearClipping && local50 > param1.nearClipping && local53 > param1.nearClipping && local56 > param1.nearClipping && local59 > param1.nearClipping && local62 > param1.nearClipping && local65 > param1.nearClipping) {
            local4.alternativa3d::gfx.lineStyle(1,local8);
            local4.alternativa3d::gfx.moveTo(local30 * param1.alternativa3d::focalLength / local32,local31 * param1.alternativa3d::focalLength / local32);
            local4.alternativa3d::gfx.lineTo(local33 * param1.alternativa3d::focalLength / local35,local34 * param1.alternativa3d::focalLength / local35);
            local4.alternativa3d::gfx.lineTo(local36 * param1.alternativa3d::focalLength / local38,local37 * param1.alternativa3d::focalLength / local38);
            local4.alternativa3d::gfx.lineTo(local39 * param1.alternativa3d::focalLength / local41,local40 * param1.alternativa3d::focalLength / local41);
            local4.alternativa3d::gfx.lineTo(local30 * param1.alternativa3d::focalLength / local32,local31 * param1.alternativa3d::focalLength / local32);
            local4.alternativa3d::gfx.moveTo(local42 * param1.alternativa3d::focalLength / local44,local43 * param1.alternativa3d::focalLength / local44);
            local4.alternativa3d::gfx.lineTo(local45 * param1.alternativa3d::focalLength / local47,local46 * param1.alternativa3d::focalLength / local47);
            local4.alternativa3d::gfx.lineTo(local48 * param1.alternativa3d::focalLength / local50,local49 * param1.alternativa3d::focalLength / local50);
            local4.alternativa3d::gfx.lineTo(local51 * param1.alternativa3d::focalLength / local53,local52 * param1.alternativa3d::focalLength / local53);
            local4.alternativa3d::gfx.lineTo(local42 * param1.alternativa3d::focalLength / local44,local43 * param1.alternativa3d::focalLength / local44);
            local4.alternativa3d::gfx.moveTo(local54 * param1.alternativa3d::focalLength / local56,local55 * param1.alternativa3d::focalLength / local56);
            local4.alternativa3d::gfx.lineTo(local57 * param1.alternativa3d::focalLength / local59,local58 * param1.alternativa3d::focalLength / local59);
            local4.alternativa3d::gfx.lineTo(local60 * param1.alternativa3d::focalLength / local62,local61 * param1.alternativa3d::focalLength / local62);
            local4.alternativa3d::gfx.lineTo(local63 * param1.alternativa3d::focalLength / local65,local64 * param1.alternativa3d::focalLength / local65);
            local4.alternativa3d::gfx.lineTo(local54 * param1.alternativa3d::focalLength / local56,local55 * param1.alternativa3d::focalLength / local56);
            local4.alternativa3d::gfx.moveTo(local27 * param1.alternativa3d::focalLength / local29,local28 * param1.alternativa3d::focalLength / local29);
            local4.alternativa3d::gfx.lineTo(local54 * param1.alternativa3d::focalLength / local56,local55 * param1.alternativa3d::focalLength / local56);
            local4.alternativa3d::gfx.moveTo(local27 * param1.alternativa3d::focalLength / local29,local28 * param1.alternativa3d::focalLength / local29);
            local4.alternativa3d::gfx.lineTo(local57 * param1.alternativa3d::focalLength / local59,local58 * param1.alternativa3d::focalLength / local59);
            local4.alternativa3d::gfx.moveTo(local27 * param1.alternativa3d::focalLength / local29,local28 * param1.alternativa3d::focalLength / local29);
            local4.alternativa3d::gfx.lineTo(local60 * param1.alternativa3d::focalLength / local62,local61 * param1.alternativa3d::focalLength / local62);
            local4.alternativa3d::gfx.moveTo(local27 * param1.alternativa3d::focalLength / local29,local28 * param1.alternativa3d::focalLength / local29);
            local4.alternativa3d::gfx.lineTo(local63 * param1.alternativa3d::focalLength / local65,local64 * param1.alternativa3d::focalLength / local65);
            local4.alternativa3d::gfx.moveTo(local30 * param1.alternativa3d::focalLength / local32,local31 * param1.alternativa3d::focalLength / local32);
            local4.alternativa3d::gfx.lineTo(local42 * param1.alternativa3d::focalLength / local44,local43 * param1.alternativa3d::focalLength / local44);
            local4.alternativa3d::gfx.moveTo(local33 * param1.alternativa3d::focalLength / local35,local34 * param1.alternativa3d::focalLength / local35);
            local4.alternativa3d::gfx.lineTo(local45 * param1.alternativa3d::focalLength / local47,local46 * param1.alternativa3d::focalLength / local47);
            local4.alternativa3d::gfx.moveTo(local36 * param1.alternativa3d::focalLength / local38,local37 * param1.alternativa3d::focalLength / local38);
            local4.alternativa3d::gfx.lineTo(local48 * param1.alternativa3d::focalLength / local50,local49 * param1.alternativa3d::focalLength / local50);
            local4.alternativa3d::gfx.moveTo(local39 * param1.alternativa3d::focalLength / local41,local40 * param1.alternativa3d::focalLength / local41);
            local4.alternativa3d::gfx.lineTo(local51 * param1.alternativa3d::focalLength / local53,local52 * param1.alternativa3d::focalLength / local53);
          }
        }
        if(Boolean(local3 & Debug.BOUNDS)) {
          Debug.alternativa3d::drawBounds(param1,local4,this,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ,10092288);
        }
      }
    }
  }
}
