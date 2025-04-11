package alternativa.engine3d.lights {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Debug;
  import alternativa.engine3d.core.Light3D;
  import alternativa.engine3d.core.Object3D;
  import flash.display.Sprite;

  use namespace alternativa3d;

  public class DirectionalLight extends Light3D {
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
      var local2:int = int(param1.alternativa3d::checkInDebug(this));
      if(local2 > 0) {
        local3 = param1.view.alternativa3d::canvas;
        if(Boolean(local2 & Debug.LIGHTS) && alternativa3d::ml > param1.nearClipping) {
          local4 = (color >> 16 & 0xFF) * intensity;
          local5 = (color >> 8 & 0xFF) * intensity;
          local6 = (color & 0xFF) * intensity;
          local7 = ((local4 > 255 ? 255 : local4) << 16) + ((local5 > 255 ? 255 : local5) << 8) + (local6 > 255 ? 255 : local6);
          local8 = alternativa3d::md * param1.alternativa3d::viewSizeX / param1.alternativa3d::focalLength;
          local9 = alternativa3d::mh * param1.alternativa3d::viewSizeY / param1.alternativa3d::focalLength;
          local10 = Number(alternativa3d::ml);
          local11 = alternativa3d::mc * param1.alternativa3d::viewSizeX / param1.alternativa3d::focalLength;
          local12 = alternativa3d::mg * param1.alternativa3d::viewSizeY / param1.alternativa3d::focalLength;
          local13 = Number(alternativa3d::mk);
          local14 = Math.sqrt(local11 * local11 + local12 * local12 + local13 * local13);
          local11 /= local14;
          local12 /= local14;
          local13 /= local14;
          local15 = alternativa3d::ma * param1.alternativa3d::viewSizeX / param1.alternativa3d::focalLength;
          local16 = alternativa3d::me * param1.alternativa3d::viewSizeY / param1.alternativa3d::focalLength;
          local17 = Number(alternativa3d::mi);
          local18 = local17 * local12 - local16 * local13;
          local19 = local15 * local13 - local17 * local11;
          local20 = local16 * local11 - local15 * local12;
          local14 = Math.sqrt(local18 * local18 + local19 * local19 + local20 * local20);
          local18 /= local14;
          local19 /= local14;
          local20 /= local14;
          local15 = alternativa3d::mb * param1.alternativa3d::viewSizeX / param1.alternativa3d::focalLength;
          local16 = alternativa3d::mf * param1.alternativa3d::viewSizeY / param1.alternativa3d::focalLength;
          local17 = Number(alternativa3d::mj);
          local15 = local20 * local12 - local19 * local13;
          local16 = local18 * local13 - local20 * local11;
          local17 = local19 * local11 - local18 * local12;
          local21 = alternativa3d::ml / param1.alternativa3d::focalLength;
          local11 *= local21;
          local12 *= local21;
          local13 *= local21;
          local15 *= local21;
          local16 *= local21;
          local17 *= local21;
          local18 *= local21;
          local19 *= local21;
          local20 *= local21;
          local22 = 16;
          local23 = 24;
          local24 = 4;
          local25 = 8;
          local26 = local8 + local11 * local23;
          local27 = local9 + local12 * local23;
          local28 = local10 + local13 * local23;
          local29 = local8 + local15 * local24 + local18 * local24;
          local30 = local9 + local16 * local24 + local19 * local24;
          local31 = local10 + local17 * local24 + local20 * local24;
          local32 = local8 - local15 * local24 + local18 * local24;
          local33 = local9 - local16 * local24 + local19 * local24;
          local34 = local10 - local17 * local24 + local20 * local24;
          local35 = local8 - local15 * local24 - local18 * local24;
          local36 = local9 - local16 * local24 - local19 * local24;
          local37 = local10 - local17 * local24 - local20 * local24;
          local38 = local8 + local15 * local24 - local18 * local24;
          local39 = local9 + local16 * local24 - local19 * local24;
          local40 = local10 + local17 * local24 - local20 * local24;
          local41 = local8 + local11 * local22 + local15 * local24 + local18 * local24;
          local42 = local9 + local12 * local22 + local16 * local24 + local19 * local24;
          local43 = local10 + local13 * local22 + local17 * local24 + local20 * local24;
          local44 = local8 + local11 * local22 - local15 * local24 + local18 * local24;
          local45 = local9 + local12 * local22 - local16 * local24 + local19 * local24;
          local46 = local10 + local13 * local22 - local17 * local24 + local20 * local24;
          local47 = local8 + local11 * local22 - local15 * local24 - local18 * local24;
          local48 = local9 + local12 * local22 - local16 * local24 - local19 * local24;
          local49 = local10 + local13 * local22 - local17 * local24 - local20 * local24;
          local50 = local8 + local11 * local22 + local15 * local24 - local18 * local24;
          local51 = local9 + local12 * local22 + local16 * local24 - local19 * local24;
          local52 = local10 + local13 * local22 + local17 * local24 - local20 * local24;
          local53 = local8 + local11 * local22 + local15 * local25 + local18 * local25;
          local54 = local9 + local12 * local22 + local16 * local25 + local19 * local25;
          local55 = local10 + local13 * local22 + local17 * local25 + local20 * local25;
          local56 = local8 + local11 * local22 - local15 * local25 + local18 * local25;
          local57 = local9 + local12 * local22 - local16 * local25 + local19 * local25;
          local58 = local10 + local13 * local22 - local17 * local25 + local20 * local25;
          local59 = local8 + local11 * local22 - local15 * local25 - local18 * local25;
          local60 = local9 + local12 * local22 - local16 * local25 - local19 * local25;
          local61 = local10 + local13 * local22 - local17 * local25 - local20 * local25;
          local62 = local8 + local11 * local22 + local15 * local25 - local18 * local25;
          local63 = local9 + local12 * local22 + local16 * local25 - local19 * local25;
          local64 = local10 + local13 * local22 + local17 * local25 - local20 * local25;
          if(local28 > param1.nearClipping && local31 > param1.nearClipping && local34 > param1.nearClipping && local37 > param1.nearClipping && local40 > param1.nearClipping && local43 > param1.nearClipping && local46 > param1.nearClipping && local49 > param1.nearClipping && local52 > param1.nearClipping && local55 > param1.nearClipping && local58 > param1.nearClipping && local61 > param1.nearClipping && local64 > param1.nearClipping) {
            local3.graphics.lineStyle(1,local7);
            local3.graphics.moveTo(local29 * param1.alternativa3d::focalLength / local31,local30 * param1.alternativa3d::focalLength / local31);
            local3.graphics.lineTo(local32 * param1.alternativa3d::focalLength / local34,local33 * param1.alternativa3d::focalLength / local34);
            local3.graphics.lineTo(local35 * param1.alternativa3d::focalLength / local37,local36 * param1.alternativa3d::focalLength / local37);
            local3.graphics.lineTo(local38 * param1.alternativa3d::focalLength / local40,local39 * param1.alternativa3d::focalLength / local40);
            local3.graphics.lineTo(local29 * param1.alternativa3d::focalLength / local31,local30 * param1.alternativa3d::focalLength / local31);
            local3.graphics.moveTo(local41 * param1.alternativa3d::focalLength / local43,local42 * param1.alternativa3d::focalLength / local43);
            local3.graphics.lineTo(local44 * param1.alternativa3d::focalLength / local46,local45 * param1.alternativa3d::focalLength / local46);
            local3.graphics.lineTo(local47 * param1.alternativa3d::focalLength / local49,local48 * param1.alternativa3d::focalLength / local49);
            local3.graphics.lineTo(local50 * param1.alternativa3d::focalLength / local52,local51 * param1.alternativa3d::focalLength / local52);
            local3.graphics.lineTo(local41 * param1.alternativa3d::focalLength / local43,local42 * param1.alternativa3d::focalLength / local43);
            local3.graphics.moveTo(local53 * param1.alternativa3d::focalLength / local55,local54 * param1.alternativa3d::focalLength / local55);
            local3.graphics.lineTo(local56 * param1.alternativa3d::focalLength / local58,local57 * param1.alternativa3d::focalLength / local58);
            local3.graphics.lineTo(local59 * param1.alternativa3d::focalLength / local61,local60 * param1.alternativa3d::focalLength / local61);
            local3.graphics.lineTo(local62 * param1.alternativa3d::focalLength / local64,local63 * param1.alternativa3d::focalLength / local64);
            local3.graphics.lineTo(local53 * param1.alternativa3d::focalLength / local55,local54 * param1.alternativa3d::focalLength / local55);
            local3.graphics.moveTo(local26 * param1.alternativa3d::focalLength / local28,local27 * param1.alternativa3d::focalLength / local28);
            local3.graphics.lineTo(local53 * param1.alternativa3d::focalLength / local55,local54 * param1.alternativa3d::focalLength / local55);
            local3.graphics.moveTo(local26 * param1.alternativa3d::focalLength / local28,local27 * param1.alternativa3d::focalLength / local28);
            local3.graphics.lineTo(local56 * param1.alternativa3d::focalLength / local58,local57 * param1.alternativa3d::focalLength / local58);
            local3.graphics.moveTo(local26 * param1.alternativa3d::focalLength / local28,local27 * param1.alternativa3d::focalLength / local28);
            local3.graphics.lineTo(local59 * param1.alternativa3d::focalLength / local61,local60 * param1.alternativa3d::focalLength / local61);
            local3.graphics.moveTo(local26 * param1.alternativa3d::focalLength / local28,local27 * param1.alternativa3d::focalLength / local28);
            local3.graphics.lineTo(local62 * param1.alternativa3d::focalLength / local64,local63 * param1.alternativa3d::focalLength / local64);
            local3.graphics.moveTo(local29 * param1.alternativa3d::focalLength / local31,local30 * param1.alternativa3d::focalLength / local31);
            local3.graphics.lineTo(local41 * param1.alternativa3d::focalLength / local43,local42 * param1.alternativa3d::focalLength / local43);
            local3.graphics.moveTo(local32 * param1.alternativa3d::focalLength / local34,local33 * param1.alternativa3d::focalLength / local34);
            local3.graphics.lineTo(local44 * param1.alternativa3d::focalLength / local46,local45 * param1.alternativa3d::focalLength / local46);
            local3.graphics.moveTo(local35 * param1.alternativa3d::focalLength / local37,local36 * param1.alternativa3d::focalLength / local37);
            local3.graphics.lineTo(local47 * param1.alternativa3d::focalLength / local49,local48 * param1.alternativa3d::focalLength / local49);
            local3.graphics.moveTo(local38 * param1.alternativa3d::focalLength / local40,local39 * param1.alternativa3d::focalLength / local40);
            local3.graphics.lineTo(local50 * param1.alternativa3d::focalLength / local52,local51 * param1.alternativa3d::focalLength / local52);
          }
        }
        if(Boolean(local2 & Debug.BOUNDS)) {
          Debug.alternativa3d::drawBounds(param1,this,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ,10092288);
        }
      }
    }
  }
}
