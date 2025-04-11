package alternativa.engine3d.lights {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Debug;
  import alternativa.engine3d.core.Light3D;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Vertex;
  import flash.display.Sprite;

  use namespace alternativa3d;

  public class TubeLight extends Light3D {
    public var length:Number;
    public var attenuationBegin:Number;
    public var attenuationEnd:Number;
    public var falloff:Number;

    public function TubeLight(param1:uint, param2:Number, param3:Number, param4:Number, param5:Number) {
      super();
      this.color = param1;
      this.length = param2;
      this.attenuationBegin = param3;
      this.attenuationEnd = param4;
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
      var local1:TubeLight = new TubeLight(color,this.length,this.attenuationBegin,this.attenuationEnd,this.falloff);
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
      var local2:int = int(param1.alternativa3d::checkInDebug(this));
      if(local2 > 0) {
        local3 = param1.view.alternativa3d::canvas;
        if(Boolean(local2 & Debug.LIGHTS) && alternativa3d::ml > param1.nearClipping) {
          local4 = (color >> 16 & 0xFF) * intensity;
          local5 = (color >> 8 & 0xFF) * intensity;
          local6 = (color & 0xFF) * intensity;
          local7 = ((local4 > 255 ? 255 : local4) << 16) + ((local5 > 255 ? 255 : local5) << 8) + (local6 > 255 ? 255 : local6);
          local8 = alternativa3d::md + alternativa3d::ma * this.attenuationBegin;
          local9 = alternativa3d::mh + alternativa3d::me * this.attenuationBegin;
          local10 = alternativa3d::ml + alternativa3d::mi * this.attenuationBegin;
          local11 = alternativa3d::md + (alternativa3d::ma * this.attenuationBegin + alternativa3d::mb * this.attenuationBegin) * 0.9;
          local12 = alternativa3d::mh + (alternativa3d::me * this.attenuationBegin + alternativa3d::mf * this.attenuationBegin) * 0.9;
          local13 = alternativa3d::ml + (alternativa3d::mi * this.attenuationBegin + alternativa3d::mj * this.attenuationBegin) * 0.9;
          local14 = alternativa3d::md + alternativa3d::mb * this.attenuationBegin;
          local15 = alternativa3d::mh + alternativa3d::mf * this.attenuationBegin;
          local16 = alternativa3d::ml + alternativa3d::mj * this.attenuationBegin;
          local17 = alternativa3d::md - (alternativa3d::ma * this.attenuationBegin - alternativa3d::mb * this.attenuationBegin) * 0.9;
          local18 = alternativa3d::mh - (alternativa3d::me * this.attenuationBegin - alternativa3d::mf * this.attenuationBegin) * 0.9;
          local19 = alternativa3d::ml - (alternativa3d::mi * this.attenuationBegin - alternativa3d::mj * this.attenuationBegin) * 0.9;
          local20 = alternativa3d::md - alternativa3d::ma * this.attenuationBegin;
          local21 = alternativa3d::mh - alternativa3d::me * this.attenuationBegin;
          local22 = alternativa3d::ml - alternativa3d::mi * this.attenuationBegin;
          local23 = alternativa3d::md - (alternativa3d::ma * this.attenuationBegin + alternativa3d::mb * this.attenuationBegin) * 0.9;
          local24 = alternativa3d::mh - (alternativa3d::me * this.attenuationBegin + alternativa3d::mf * this.attenuationBegin) * 0.9;
          local25 = alternativa3d::ml - (alternativa3d::mi * this.attenuationBegin + alternativa3d::mj * this.attenuationBegin) * 0.9;
          local26 = alternativa3d::md - alternativa3d::mb * this.attenuationBegin;
          local27 = alternativa3d::mh - alternativa3d::mf * this.attenuationBegin;
          local28 = alternativa3d::ml - alternativa3d::mj * this.attenuationBegin;
          local29 = alternativa3d::md + (alternativa3d::ma * this.attenuationBegin - alternativa3d::mb * this.attenuationBegin) * 0.9;
          local30 = alternativa3d::mh + (alternativa3d::me * this.attenuationBegin - alternativa3d::mf * this.attenuationBegin) * 0.9;
          local31 = alternativa3d::ml + (alternativa3d::mi * this.attenuationBegin - alternativa3d::mj * this.attenuationBegin) * 0.9;
          local32 = alternativa3d::md + alternativa3d::mc * this.length + alternativa3d::ma * this.attenuationBegin;
          local33 = alternativa3d::mh + alternativa3d::mg * this.length + alternativa3d::me * this.attenuationBegin;
          local34 = alternativa3d::ml + alternativa3d::mk * this.length + alternativa3d::mi * this.attenuationBegin;
          local35 = alternativa3d::md + alternativa3d::mc * this.length + (alternativa3d::ma * this.attenuationBegin + alternativa3d::mb * this.attenuationBegin) * 0.9;
          local36 = alternativa3d::mh + alternativa3d::mg * this.length + (alternativa3d::me * this.attenuationBegin + alternativa3d::mf * this.attenuationBegin) * 0.9;
          local37 = alternativa3d::ml + alternativa3d::mk * this.length + (alternativa3d::mi * this.attenuationBegin + alternativa3d::mj * this.attenuationBegin) * 0.9;
          local38 = alternativa3d::md + alternativa3d::mc * this.length + alternativa3d::mb * this.attenuationBegin;
          local39 = alternativa3d::mh + alternativa3d::mg * this.length + alternativa3d::mf * this.attenuationBegin;
          local40 = alternativa3d::ml + alternativa3d::mk * this.length + alternativa3d::mj * this.attenuationBegin;
          local41 = alternativa3d::md + alternativa3d::mc * this.length - (alternativa3d::ma * this.attenuationBegin - alternativa3d::mb * this.attenuationBegin) * 0.9;
          local42 = alternativa3d::mh + alternativa3d::mg * this.length - (alternativa3d::me * this.attenuationBegin - alternativa3d::mf * this.attenuationBegin) * 0.9;
          local43 = alternativa3d::ml + alternativa3d::mk * this.length - (alternativa3d::mi * this.attenuationBegin - alternativa3d::mj * this.attenuationBegin) * 0.9;
          local44 = alternativa3d::md + alternativa3d::mc * this.length - alternativa3d::ma * this.attenuationBegin;
          local45 = alternativa3d::mh + alternativa3d::mg * this.length - alternativa3d::me * this.attenuationBegin;
          local46 = alternativa3d::ml + alternativa3d::mk * this.length - alternativa3d::mi * this.attenuationBegin;
          local47 = alternativa3d::md + alternativa3d::mc * this.length - (alternativa3d::ma * this.attenuationBegin + alternativa3d::mb * this.attenuationBegin) * 0.9;
          local48 = alternativa3d::mh + alternativa3d::mg * this.length - (alternativa3d::me * this.attenuationBegin + alternativa3d::mf * this.attenuationBegin) * 0.9;
          local49 = alternativa3d::ml + alternativa3d::mk * this.length - (alternativa3d::mi * this.attenuationBegin + alternativa3d::mj * this.attenuationBegin) * 0.9;
          local50 = alternativa3d::md + alternativa3d::mc * this.length - alternativa3d::mb * this.attenuationBegin;
          local51 = alternativa3d::mh + alternativa3d::mg * this.length - alternativa3d::mf * this.attenuationBegin;
          local52 = alternativa3d::ml + alternativa3d::mk * this.length - alternativa3d::mj * this.attenuationBegin;
          local53 = alternativa3d::md + alternativa3d::mc * this.length + (alternativa3d::ma * this.attenuationBegin - alternativa3d::mb * this.attenuationBegin) * 0.9;
          local54 = alternativa3d::mh + alternativa3d::mg * this.length + (alternativa3d::me * this.attenuationBegin - alternativa3d::mf * this.attenuationBegin) * 0.9;
          local55 = alternativa3d::ml + alternativa3d::mk * this.length + (alternativa3d::mi * this.attenuationBegin - alternativa3d::mj * this.attenuationBegin) * 0.9;
          if(local10 > param1.nearClipping && local13 > param1.nearClipping && local16 > param1.nearClipping && local19 > param1.nearClipping && local22 > param1.nearClipping && local25 > param1.nearClipping && local28 > param1.nearClipping && local31 > param1.nearClipping && local34 > param1.nearClipping && local37 > param1.nearClipping && local40 > param1.nearClipping && local43 > param1.nearClipping && local46 > param1.nearClipping && local49 > param1.nearClipping && local52 > param1.nearClipping && local55 > param1.nearClipping) {
            local3.graphics.lineStyle(1,local7);
            local3.graphics.moveTo(local8 * param1.alternativa3d::viewSizeX / local10,local9 * param1.alternativa3d::viewSizeY / local10);
            local3.graphics.curveTo(local11 * param1.alternativa3d::viewSizeX / local13,local12 * param1.alternativa3d::viewSizeY / local13,local14 * param1.alternativa3d::viewSizeX / local16,local15 * param1.alternativa3d::viewSizeY / local16);
            local3.graphics.curveTo(local17 * param1.alternativa3d::viewSizeX / local19,local18 * param1.alternativa3d::viewSizeY / local19,local20 * param1.alternativa3d::viewSizeX / local22,local21 * param1.alternativa3d::viewSizeY / local22);
            local3.graphics.curveTo(local23 * param1.alternativa3d::viewSizeX / local25,local24 * param1.alternativa3d::viewSizeY / local25,local26 * param1.alternativa3d::viewSizeX / local28,local27 * param1.alternativa3d::viewSizeY / local28);
            local3.graphics.curveTo(local29 * param1.alternativa3d::viewSizeX / local31,local30 * param1.alternativa3d::viewSizeY / local31,local8 * param1.alternativa3d::viewSizeX / local10,local9 * param1.alternativa3d::viewSizeY / local10);
            local3.graphics.moveTo(local32 * param1.alternativa3d::viewSizeX / local34,local33 * param1.alternativa3d::viewSizeY / local34);
            local3.graphics.curveTo(local35 * param1.alternativa3d::viewSizeX / local37,local36 * param1.alternativa3d::viewSizeY / local37,local38 * param1.alternativa3d::viewSizeX / local40,local39 * param1.alternativa3d::viewSizeY / local40);
            local3.graphics.curveTo(local41 * param1.alternativa3d::viewSizeX / local43,local42 * param1.alternativa3d::viewSizeY / local43,local44 * param1.alternativa3d::viewSizeX / local46,local45 * param1.alternativa3d::viewSizeY / local46);
            local3.graphics.curveTo(local47 * param1.alternativa3d::viewSizeX / local49,local48 * param1.alternativa3d::viewSizeY / local49,local50 * param1.alternativa3d::viewSizeX / local52,local51 * param1.alternativa3d::viewSizeY / local52);
            local3.graphics.curveTo(local53 * param1.alternativa3d::viewSizeX / local55,local54 * param1.alternativa3d::viewSizeY / local55,local32 * param1.alternativa3d::viewSizeX / local34,local33 * param1.alternativa3d::viewSizeY / local34);
            local3.graphics.moveTo(local8 * param1.alternativa3d::viewSizeX / local10,local9 * param1.alternativa3d::viewSizeY / local10);
            local3.graphics.lineTo(local32 * param1.alternativa3d::viewSizeX / local34,local33 * param1.alternativa3d::viewSizeY / local34);
            local3.graphics.moveTo(local14 * param1.alternativa3d::viewSizeX / local16,local15 * param1.alternativa3d::viewSizeY / local16);
            local3.graphics.lineTo(local38 * param1.alternativa3d::viewSizeX / local40,local39 * param1.alternativa3d::viewSizeY / local40);
            local3.graphics.moveTo(local20 * param1.alternativa3d::viewSizeX / local22,local21 * param1.alternativa3d::viewSizeY / local22);
            local3.graphics.lineTo(local44 * param1.alternativa3d::viewSizeX / local46,local45 * param1.alternativa3d::viewSizeY / local46);
            local3.graphics.moveTo(local26 * param1.alternativa3d::viewSizeX / local28,local27 * param1.alternativa3d::viewSizeY / local28);
            local3.graphics.lineTo(local50 * param1.alternativa3d::viewSizeX / local52,local51 * param1.alternativa3d::viewSizeY / local52);
          }
          local8 = alternativa3d::md - alternativa3d::mc * this.falloff + alternativa3d::ma * this.attenuationEnd;
          local9 = alternativa3d::mh - alternativa3d::mg * this.falloff + alternativa3d::me * this.attenuationEnd;
          local10 = alternativa3d::ml - alternativa3d::mk * this.falloff + alternativa3d::mi * this.attenuationEnd;
          local11 = alternativa3d::md - alternativa3d::mc * this.falloff + (alternativa3d::ma * this.attenuationEnd + alternativa3d::mb * this.attenuationEnd) * 0.9;
          local12 = alternativa3d::mh - alternativa3d::mg * this.falloff + (alternativa3d::me * this.attenuationEnd + alternativa3d::mf * this.attenuationEnd) * 0.9;
          local13 = alternativa3d::ml - alternativa3d::mk * this.falloff + (alternativa3d::mi * this.attenuationEnd + alternativa3d::mj * this.attenuationEnd) * 0.9;
          local14 = alternativa3d::md - alternativa3d::mc * this.falloff + alternativa3d::mb * this.attenuationEnd;
          local15 = alternativa3d::mh - alternativa3d::mg * this.falloff + alternativa3d::mf * this.attenuationEnd;
          local16 = alternativa3d::ml - alternativa3d::mk * this.falloff + alternativa3d::mj * this.attenuationEnd;
          local17 = alternativa3d::md - alternativa3d::mc * this.falloff - (alternativa3d::ma * this.attenuationEnd - alternativa3d::mb * this.attenuationEnd) * 0.9;
          local18 = alternativa3d::mh - alternativa3d::mg * this.falloff - (alternativa3d::me * this.attenuationEnd - alternativa3d::mf * this.attenuationEnd) * 0.9;
          local19 = alternativa3d::ml - alternativa3d::mk * this.falloff - (alternativa3d::mi * this.attenuationEnd - alternativa3d::mj * this.attenuationEnd) * 0.9;
          local20 = alternativa3d::md - alternativa3d::mc * this.falloff - alternativa3d::ma * this.attenuationEnd;
          local21 = alternativa3d::mh - alternativa3d::mg * this.falloff - alternativa3d::me * this.attenuationEnd;
          local22 = alternativa3d::ml - alternativa3d::mk * this.falloff - alternativa3d::mi * this.attenuationEnd;
          local23 = alternativa3d::md - alternativa3d::mc * this.falloff - (alternativa3d::ma * this.attenuationEnd + alternativa3d::mb * this.attenuationEnd) * 0.9;
          local24 = alternativa3d::mh - alternativa3d::mg * this.falloff - (alternativa3d::me * this.attenuationEnd + alternativa3d::mf * this.attenuationEnd) * 0.9;
          local25 = alternativa3d::ml - alternativa3d::mk * this.falloff - (alternativa3d::mi * this.attenuationEnd + alternativa3d::mj * this.attenuationEnd) * 0.9;
          local26 = alternativa3d::md - alternativa3d::mc * this.falloff - alternativa3d::mb * this.attenuationEnd;
          local27 = alternativa3d::mh - alternativa3d::mg * this.falloff - alternativa3d::mf * this.attenuationEnd;
          local28 = alternativa3d::ml - alternativa3d::mk * this.falloff - alternativa3d::mj * this.attenuationEnd;
          local29 = alternativa3d::md - alternativa3d::mc * this.falloff + (alternativa3d::ma * this.attenuationEnd - alternativa3d::mb * this.attenuationEnd) * 0.9;
          local30 = alternativa3d::mh - alternativa3d::mg * this.falloff + (alternativa3d::me * this.attenuationEnd - alternativa3d::mf * this.attenuationEnd) * 0.9;
          local31 = alternativa3d::ml - alternativa3d::mk * this.falloff + (alternativa3d::mi * this.attenuationEnd - alternativa3d::mj * this.attenuationEnd) * 0.9;
          local32 = alternativa3d::md + alternativa3d::mc * (this.length + this.falloff) + alternativa3d::ma * this.attenuationEnd;
          local33 = alternativa3d::mh + alternativa3d::mg * (this.length + this.falloff) + alternativa3d::me * this.attenuationEnd;
          local34 = alternativa3d::ml + alternativa3d::mk * (this.length + this.falloff) + alternativa3d::mi * this.attenuationEnd;
          local35 = alternativa3d::md + alternativa3d::mc * (this.length + this.falloff) + (alternativa3d::ma * this.attenuationEnd + alternativa3d::mb * this.attenuationEnd) * 0.9;
          local36 = alternativa3d::mh + alternativa3d::mg * (this.length + this.falloff) + (alternativa3d::me * this.attenuationEnd + alternativa3d::mf * this.attenuationEnd) * 0.9;
          local37 = alternativa3d::ml + alternativa3d::mk * (this.length + this.falloff) + (alternativa3d::mi * this.attenuationEnd + alternativa3d::mj * this.attenuationEnd) * 0.9;
          local38 = alternativa3d::md + alternativa3d::mc * (this.length + this.falloff) + alternativa3d::mb * this.attenuationEnd;
          local39 = alternativa3d::mh + alternativa3d::mg * (this.length + this.falloff) + alternativa3d::mf * this.attenuationEnd;
          local40 = alternativa3d::ml + alternativa3d::mk * (this.length + this.falloff) + alternativa3d::mj * this.attenuationEnd;
          local41 = alternativa3d::md + alternativa3d::mc * (this.length + this.falloff) - (alternativa3d::ma * this.attenuationEnd - alternativa3d::mb * this.attenuationEnd) * 0.9;
          local42 = alternativa3d::mh + alternativa3d::mg * (this.length + this.falloff) - (alternativa3d::me * this.attenuationEnd - alternativa3d::mf * this.attenuationEnd) * 0.9;
          local43 = alternativa3d::ml + alternativa3d::mk * (this.length + this.falloff) - (alternativa3d::mi * this.attenuationEnd - alternativa3d::mj * this.attenuationEnd) * 0.9;
          local44 = alternativa3d::md + alternativa3d::mc * (this.length + this.falloff) - alternativa3d::ma * this.attenuationEnd;
          local45 = alternativa3d::mh + alternativa3d::mg * (this.length + this.falloff) - alternativa3d::me * this.attenuationEnd;
          local46 = alternativa3d::ml + alternativa3d::mk * (this.length + this.falloff) - alternativa3d::mi * this.attenuationEnd;
          local47 = alternativa3d::md + alternativa3d::mc * (this.length + this.falloff) - (alternativa3d::ma * this.attenuationEnd + alternativa3d::mb * this.attenuationEnd) * 0.9;
          local48 = alternativa3d::mh + alternativa3d::mg * (this.length + this.falloff) - (alternativa3d::me * this.attenuationEnd + alternativa3d::mf * this.attenuationEnd) * 0.9;
          local49 = alternativa3d::ml + alternativa3d::mk * (this.length + this.falloff) - (alternativa3d::mi * this.attenuationEnd + alternativa3d::mj * this.attenuationEnd) * 0.9;
          local50 = alternativa3d::md + alternativa3d::mc * (this.length + this.falloff) - alternativa3d::mb * this.attenuationEnd;
          local51 = alternativa3d::mh + alternativa3d::mg * (this.length + this.falloff) - alternativa3d::mf * this.attenuationEnd;
          local52 = alternativa3d::ml + alternativa3d::mk * (this.length + this.falloff) - alternativa3d::mj * this.attenuationEnd;
          local53 = alternativa3d::md + alternativa3d::mc * (this.length + this.falloff) + (alternativa3d::ma * this.attenuationEnd - alternativa3d::mb * this.attenuationEnd) * 0.9;
          local54 = alternativa3d::mh + alternativa3d::mg * (this.length + this.falloff) + (alternativa3d::me * this.attenuationEnd - alternativa3d::mf * this.attenuationEnd) * 0.9;
          local55 = alternativa3d::ml + alternativa3d::mk * (this.length + this.falloff) + (alternativa3d::mi * this.attenuationEnd - alternativa3d::mj * this.attenuationEnd) * 0.9;
          if(local10 > param1.nearClipping && local13 > param1.nearClipping && local16 > param1.nearClipping && local19 > param1.nearClipping && local22 > param1.nearClipping && local25 > param1.nearClipping && local28 > param1.nearClipping && local31 > param1.nearClipping && local34 > param1.nearClipping && local37 > param1.nearClipping && local40 > param1.nearClipping && local43 > param1.nearClipping && local46 > param1.nearClipping && local49 > param1.nearClipping && local52 > param1.nearClipping && local55 > param1.nearClipping) {
            local3.graphics.lineStyle(1,local7);
            local3.graphics.moveTo(local8 * param1.alternativa3d::viewSizeX / local10,local9 * param1.alternativa3d::viewSizeY / local10);
            local3.graphics.curveTo(local11 * param1.alternativa3d::viewSizeX / local13,local12 * param1.alternativa3d::viewSizeY / local13,local14 * param1.alternativa3d::viewSizeX / local16,local15 * param1.alternativa3d::viewSizeY / local16);
            local3.graphics.curveTo(local17 * param1.alternativa3d::viewSizeX / local19,local18 * param1.alternativa3d::viewSizeY / local19,local20 * param1.alternativa3d::viewSizeX / local22,local21 * param1.alternativa3d::viewSizeY / local22);
            local3.graphics.curveTo(local23 * param1.alternativa3d::viewSizeX / local25,local24 * param1.alternativa3d::viewSizeY / local25,local26 * param1.alternativa3d::viewSizeX / local28,local27 * param1.alternativa3d::viewSizeY / local28);
            local3.graphics.curveTo(local29 * param1.alternativa3d::viewSizeX / local31,local30 * param1.alternativa3d::viewSizeY / local31,local8 * param1.alternativa3d::viewSizeX / local10,local9 * param1.alternativa3d::viewSizeY / local10);
            local3.graphics.moveTo(local32 * param1.alternativa3d::viewSizeX / local34,local33 * param1.alternativa3d::viewSizeY / local34);
            local3.graphics.curveTo(local35 * param1.alternativa3d::viewSizeX / local37,local36 * param1.alternativa3d::viewSizeY / local37,local38 * param1.alternativa3d::viewSizeX / local40,local39 * param1.alternativa3d::viewSizeY / local40);
            local3.graphics.curveTo(local41 * param1.alternativa3d::viewSizeX / local43,local42 * param1.alternativa3d::viewSizeY / local43,local44 * param1.alternativa3d::viewSizeX / local46,local45 * param1.alternativa3d::viewSizeY / local46);
            local3.graphics.curveTo(local47 * param1.alternativa3d::viewSizeX / local49,local48 * param1.alternativa3d::viewSizeY / local49,local50 * param1.alternativa3d::viewSizeX / local52,local51 * param1.alternativa3d::viewSizeY / local52);
            local3.graphics.curveTo(local53 * param1.alternativa3d::viewSizeX / local55,local54 * param1.alternativa3d::viewSizeY / local55,local32 * param1.alternativa3d::viewSizeX / local34,local33 * param1.alternativa3d::viewSizeY / local34);
            local3.graphics.moveTo(local8 * param1.alternativa3d::viewSizeX / local10,local9 * param1.alternativa3d::viewSizeY / local10);
            local3.graphics.lineTo(local32 * param1.alternativa3d::viewSizeX / local34,local33 * param1.alternativa3d::viewSizeY / local34);
            local3.graphics.moveTo(local14 * param1.alternativa3d::viewSizeX / local16,local15 * param1.alternativa3d::viewSizeY / local16);
            local3.graphics.lineTo(local38 * param1.alternativa3d::viewSizeX / local40,local39 * param1.alternativa3d::viewSizeY / local40);
            local3.graphics.moveTo(local20 * param1.alternativa3d::viewSizeX / local22,local21 * param1.alternativa3d::viewSizeY / local22);
            local3.graphics.lineTo(local44 * param1.alternativa3d::viewSizeX / local46,local45 * param1.alternativa3d::viewSizeY / local46);
            local3.graphics.moveTo(local26 * param1.alternativa3d::viewSizeX / local28,local27 * param1.alternativa3d::viewSizeY / local28);
            local3.graphics.lineTo(local50 * param1.alternativa3d::viewSizeX / local52,local51 * param1.alternativa3d::viewSizeY / local52);
          }
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
        local3.z = -this.falloff;
        local3 = local3.alternativa3d::next;
        local3.x = this.attenuationEnd;
        local3.y = -this.attenuationEnd;
        local3.z = -this.falloff;
        local3 = local3.alternativa3d::next;
        local3.x = -this.attenuationEnd;
        local3.y = this.attenuationEnd;
        local3.z = -this.falloff;
        local3 = local3.alternativa3d::next;
        local3.x = this.attenuationEnd;
        local3.y = this.attenuationEnd;
        local3.z = -this.falloff;
        local3 = local3.alternativa3d::next;
        local3.x = -this.attenuationEnd;
        local3.y = -this.attenuationEnd;
        local3.z = this.length + this.falloff;
        local3 = local3.alternativa3d::next;
        local3.x = this.attenuationEnd;
        local3.y = -this.attenuationEnd;
        local3.z = this.length + this.falloff;
        local3 = local3.alternativa3d::next;
        local3.x = -this.attenuationEnd;
        local3.y = this.attenuationEnd;
        local3.z = this.length + this.falloff;
        local3 = local3.alternativa3d::next;
        local3.x = this.attenuationEnd;
        local3.y = this.attenuationEnd;
        local3.z = this.length + this.falloff;
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
        if(-this.falloff < param1.boundMinZ) {
          param1.boundMinZ = -this.falloff;
        }
        if(this.length + this.falloff > param1.boundMaxZ) {
          param1.boundMaxZ = this.length + this.falloff;
        }
      }
    }
  }
}
