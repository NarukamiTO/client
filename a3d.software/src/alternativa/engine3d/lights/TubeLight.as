package alternativa.engine3d.lights {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Canvas;
  import alternativa.engine3d.core.Debug;
  import alternativa.engine3d.core.Light3D;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Vertex;

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
      var local3:int = int(param1.alternativa3d::checkInDebug(this));
      if(local3 > 0) {
        local4 = param2.alternativa3d::getChildCanvas(true,false);
        if(Boolean(local3 & Debug.LIGHTS) && alternativa3d::ml > param1.nearClipping) {
          local5 = (color >> 16 & 0xFF) * intensity;
          local6 = (color >> 8 & 0xFF) * intensity;
          local7 = (color & 0xFF) * intensity;
          local8 = ((local5 > 255 ? 255 : local5) << 16) + ((local6 > 255 ? 255 : local6) << 8) + (local7 > 255 ? 255 : local7);
          local9 = alternativa3d::md + alternativa3d::ma * this.attenuationBegin;
          local10 = alternativa3d::mh + alternativa3d::me * this.attenuationBegin;
          local11 = alternativa3d::ml + alternativa3d::mi * this.attenuationBegin;
          local12 = alternativa3d::md + (alternativa3d::ma * this.attenuationBegin + alternativa3d::mb * this.attenuationBegin) * 0.9;
          local13 = alternativa3d::mh + (alternativa3d::me * this.attenuationBegin + alternativa3d::mf * this.attenuationBegin) * 0.9;
          local14 = alternativa3d::ml + (alternativa3d::mi * this.attenuationBegin + alternativa3d::mj * this.attenuationBegin) * 0.9;
          local15 = alternativa3d::md + alternativa3d::mb * this.attenuationBegin;
          local16 = alternativa3d::mh + alternativa3d::mf * this.attenuationBegin;
          local17 = alternativa3d::ml + alternativa3d::mj * this.attenuationBegin;
          local18 = alternativa3d::md - (alternativa3d::ma * this.attenuationBegin - alternativa3d::mb * this.attenuationBegin) * 0.9;
          local19 = alternativa3d::mh - (alternativa3d::me * this.attenuationBegin - alternativa3d::mf * this.attenuationBegin) * 0.9;
          local20 = alternativa3d::ml - (alternativa3d::mi * this.attenuationBegin - alternativa3d::mj * this.attenuationBegin) * 0.9;
          local21 = alternativa3d::md - alternativa3d::ma * this.attenuationBegin;
          local22 = alternativa3d::mh - alternativa3d::me * this.attenuationBegin;
          local23 = alternativa3d::ml - alternativa3d::mi * this.attenuationBegin;
          local24 = alternativa3d::md - (alternativa3d::ma * this.attenuationBegin + alternativa3d::mb * this.attenuationBegin) * 0.9;
          local25 = alternativa3d::mh - (alternativa3d::me * this.attenuationBegin + alternativa3d::mf * this.attenuationBegin) * 0.9;
          local26 = alternativa3d::ml - (alternativa3d::mi * this.attenuationBegin + alternativa3d::mj * this.attenuationBegin) * 0.9;
          local27 = alternativa3d::md - alternativa3d::mb * this.attenuationBegin;
          local28 = alternativa3d::mh - alternativa3d::mf * this.attenuationBegin;
          local29 = alternativa3d::ml - alternativa3d::mj * this.attenuationBegin;
          local30 = alternativa3d::md + (alternativa3d::ma * this.attenuationBegin - alternativa3d::mb * this.attenuationBegin) * 0.9;
          local31 = alternativa3d::mh + (alternativa3d::me * this.attenuationBegin - alternativa3d::mf * this.attenuationBegin) * 0.9;
          local32 = alternativa3d::ml + (alternativa3d::mi * this.attenuationBegin - alternativa3d::mj * this.attenuationBegin) * 0.9;
          local33 = alternativa3d::md + alternativa3d::mc * this.length + alternativa3d::ma * this.attenuationBegin;
          local34 = alternativa3d::mh + alternativa3d::mg * this.length + alternativa3d::me * this.attenuationBegin;
          local35 = alternativa3d::ml + alternativa3d::mk * this.length + alternativa3d::mi * this.attenuationBegin;
          local36 = alternativa3d::md + alternativa3d::mc * this.length + (alternativa3d::ma * this.attenuationBegin + alternativa3d::mb * this.attenuationBegin) * 0.9;
          local37 = alternativa3d::mh + alternativa3d::mg * this.length + (alternativa3d::me * this.attenuationBegin + alternativa3d::mf * this.attenuationBegin) * 0.9;
          local38 = alternativa3d::ml + alternativa3d::mk * this.length + (alternativa3d::mi * this.attenuationBegin + alternativa3d::mj * this.attenuationBegin) * 0.9;
          local39 = alternativa3d::md + alternativa3d::mc * this.length + alternativa3d::mb * this.attenuationBegin;
          local40 = alternativa3d::mh + alternativa3d::mg * this.length + alternativa3d::mf * this.attenuationBegin;
          local41 = alternativa3d::ml + alternativa3d::mk * this.length + alternativa3d::mj * this.attenuationBegin;
          local42 = alternativa3d::md + alternativa3d::mc * this.length - (alternativa3d::ma * this.attenuationBegin - alternativa3d::mb * this.attenuationBegin) * 0.9;
          local43 = alternativa3d::mh + alternativa3d::mg * this.length - (alternativa3d::me * this.attenuationBegin - alternativa3d::mf * this.attenuationBegin) * 0.9;
          local44 = alternativa3d::ml + alternativa3d::mk * this.length - (alternativa3d::mi * this.attenuationBegin - alternativa3d::mj * this.attenuationBegin) * 0.9;
          local45 = alternativa3d::md + alternativa3d::mc * this.length - alternativa3d::ma * this.attenuationBegin;
          local46 = alternativa3d::mh + alternativa3d::mg * this.length - alternativa3d::me * this.attenuationBegin;
          local47 = alternativa3d::ml + alternativa3d::mk * this.length - alternativa3d::mi * this.attenuationBegin;
          local48 = alternativa3d::md + alternativa3d::mc * this.length - (alternativa3d::ma * this.attenuationBegin + alternativa3d::mb * this.attenuationBegin) * 0.9;
          local49 = alternativa3d::mh + alternativa3d::mg * this.length - (alternativa3d::me * this.attenuationBegin + alternativa3d::mf * this.attenuationBegin) * 0.9;
          local50 = alternativa3d::ml + alternativa3d::mk * this.length - (alternativa3d::mi * this.attenuationBegin + alternativa3d::mj * this.attenuationBegin) * 0.9;
          local51 = alternativa3d::md + alternativa3d::mc * this.length - alternativa3d::mb * this.attenuationBegin;
          local52 = alternativa3d::mh + alternativa3d::mg * this.length - alternativa3d::mf * this.attenuationBegin;
          local53 = alternativa3d::ml + alternativa3d::mk * this.length - alternativa3d::mj * this.attenuationBegin;
          local54 = alternativa3d::md + alternativa3d::mc * this.length + (alternativa3d::ma * this.attenuationBegin - alternativa3d::mb * this.attenuationBegin) * 0.9;
          local55 = alternativa3d::mh + alternativa3d::mg * this.length + (alternativa3d::me * this.attenuationBegin - alternativa3d::mf * this.attenuationBegin) * 0.9;
          local56 = alternativa3d::ml + alternativa3d::mk * this.length + (alternativa3d::mi * this.attenuationBegin - alternativa3d::mj * this.attenuationBegin) * 0.9;
          if(local11 > param1.nearClipping && local14 > param1.nearClipping && local17 > param1.nearClipping && local20 > param1.nearClipping && local23 > param1.nearClipping && local26 > param1.nearClipping && local29 > param1.nearClipping && local32 > param1.nearClipping && local35 > param1.nearClipping && local38 > param1.nearClipping && local41 > param1.nearClipping && local44 > param1.nearClipping && local47 > param1.nearClipping && local50 > param1.nearClipping && local53 > param1.nearClipping && local56 > param1.nearClipping) {
            local4.alternativa3d::gfx.lineStyle(1,local8);
            local4.alternativa3d::gfx.moveTo(local9 * param1.alternativa3d::viewSizeX / local11,local10 * param1.alternativa3d::viewSizeY / local11);
            local4.alternativa3d::gfx.curveTo(local12 * param1.alternativa3d::viewSizeX / local14,local13 * param1.alternativa3d::viewSizeY / local14,local15 * param1.alternativa3d::viewSizeX / local17,local16 * param1.alternativa3d::viewSizeY / local17);
            local4.alternativa3d::gfx.curveTo(local18 * param1.alternativa3d::viewSizeX / local20,local19 * param1.alternativa3d::viewSizeY / local20,local21 * param1.alternativa3d::viewSizeX / local23,local22 * param1.alternativa3d::viewSizeY / local23);
            local4.alternativa3d::gfx.curveTo(local24 * param1.alternativa3d::viewSizeX / local26,local25 * param1.alternativa3d::viewSizeY / local26,local27 * param1.alternativa3d::viewSizeX / local29,local28 * param1.alternativa3d::viewSizeY / local29);
            local4.alternativa3d::gfx.curveTo(local30 * param1.alternativa3d::viewSizeX / local32,local31 * param1.alternativa3d::viewSizeY / local32,local9 * param1.alternativa3d::viewSizeX / local11,local10 * param1.alternativa3d::viewSizeY / local11);
            local4.alternativa3d::gfx.moveTo(local33 * param1.alternativa3d::viewSizeX / local35,local34 * param1.alternativa3d::viewSizeY / local35);
            local4.alternativa3d::gfx.curveTo(local36 * param1.alternativa3d::viewSizeX / local38,local37 * param1.alternativa3d::viewSizeY / local38,local39 * param1.alternativa3d::viewSizeX / local41,local40 * param1.alternativa3d::viewSizeY / local41);
            local4.alternativa3d::gfx.curveTo(local42 * param1.alternativa3d::viewSizeX / local44,local43 * param1.alternativa3d::viewSizeY / local44,local45 * param1.alternativa3d::viewSizeX / local47,local46 * param1.alternativa3d::viewSizeY / local47);
            local4.alternativa3d::gfx.curveTo(local48 * param1.alternativa3d::viewSizeX / local50,local49 * param1.alternativa3d::viewSizeY / local50,local51 * param1.alternativa3d::viewSizeX / local53,local52 * param1.alternativa3d::viewSizeY / local53);
            local4.alternativa3d::gfx.curveTo(local54 * param1.alternativa3d::viewSizeX / local56,local55 * param1.alternativa3d::viewSizeY / local56,local33 * param1.alternativa3d::viewSizeX / local35,local34 * param1.alternativa3d::viewSizeY / local35);
            local4.alternativa3d::gfx.moveTo(local9 * param1.alternativa3d::viewSizeX / local11,local10 * param1.alternativa3d::viewSizeY / local11);
            local4.alternativa3d::gfx.lineTo(local33 * param1.alternativa3d::viewSizeX / local35,local34 * param1.alternativa3d::viewSizeY / local35);
            local4.alternativa3d::gfx.moveTo(local15 * param1.alternativa3d::viewSizeX / local17,local16 * param1.alternativa3d::viewSizeY / local17);
            local4.alternativa3d::gfx.lineTo(local39 * param1.alternativa3d::viewSizeX / local41,local40 * param1.alternativa3d::viewSizeY / local41);
            local4.alternativa3d::gfx.moveTo(local21 * param1.alternativa3d::viewSizeX / local23,local22 * param1.alternativa3d::viewSizeY / local23);
            local4.alternativa3d::gfx.lineTo(local45 * param1.alternativa3d::viewSizeX / local47,local46 * param1.alternativa3d::viewSizeY / local47);
            local4.alternativa3d::gfx.moveTo(local27 * param1.alternativa3d::viewSizeX / local29,local28 * param1.alternativa3d::viewSizeY / local29);
            local4.alternativa3d::gfx.lineTo(local51 * param1.alternativa3d::viewSizeX / local53,local52 * param1.alternativa3d::viewSizeY / local53);
          }
          local9 = alternativa3d::md - alternativa3d::mc * this.falloff + alternativa3d::ma * this.attenuationEnd;
          local10 = alternativa3d::mh - alternativa3d::mg * this.falloff + alternativa3d::me * this.attenuationEnd;
          local11 = alternativa3d::ml - alternativa3d::mk * this.falloff + alternativa3d::mi * this.attenuationEnd;
          local12 = alternativa3d::md - alternativa3d::mc * this.falloff + (alternativa3d::ma * this.attenuationEnd + alternativa3d::mb * this.attenuationEnd) * 0.9;
          local13 = alternativa3d::mh - alternativa3d::mg * this.falloff + (alternativa3d::me * this.attenuationEnd + alternativa3d::mf * this.attenuationEnd) * 0.9;
          local14 = alternativa3d::ml - alternativa3d::mk * this.falloff + (alternativa3d::mi * this.attenuationEnd + alternativa3d::mj * this.attenuationEnd) * 0.9;
          local15 = alternativa3d::md - alternativa3d::mc * this.falloff + alternativa3d::mb * this.attenuationEnd;
          local16 = alternativa3d::mh - alternativa3d::mg * this.falloff + alternativa3d::mf * this.attenuationEnd;
          local17 = alternativa3d::ml - alternativa3d::mk * this.falloff + alternativa3d::mj * this.attenuationEnd;
          local18 = alternativa3d::md - alternativa3d::mc * this.falloff - (alternativa3d::ma * this.attenuationEnd - alternativa3d::mb * this.attenuationEnd) * 0.9;
          local19 = alternativa3d::mh - alternativa3d::mg * this.falloff - (alternativa3d::me * this.attenuationEnd - alternativa3d::mf * this.attenuationEnd) * 0.9;
          local20 = alternativa3d::ml - alternativa3d::mk * this.falloff - (alternativa3d::mi * this.attenuationEnd - alternativa3d::mj * this.attenuationEnd) * 0.9;
          local21 = alternativa3d::md - alternativa3d::mc * this.falloff - alternativa3d::ma * this.attenuationEnd;
          local22 = alternativa3d::mh - alternativa3d::mg * this.falloff - alternativa3d::me * this.attenuationEnd;
          local23 = alternativa3d::ml - alternativa3d::mk * this.falloff - alternativa3d::mi * this.attenuationEnd;
          local24 = alternativa3d::md - alternativa3d::mc * this.falloff - (alternativa3d::ma * this.attenuationEnd + alternativa3d::mb * this.attenuationEnd) * 0.9;
          local25 = alternativa3d::mh - alternativa3d::mg * this.falloff - (alternativa3d::me * this.attenuationEnd + alternativa3d::mf * this.attenuationEnd) * 0.9;
          local26 = alternativa3d::ml - alternativa3d::mk * this.falloff - (alternativa3d::mi * this.attenuationEnd + alternativa3d::mj * this.attenuationEnd) * 0.9;
          local27 = alternativa3d::md - alternativa3d::mc * this.falloff - alternativa3d::mb * this.attenuationEnd;
          local28 = alternativa3d::mh - alternativa3d::mg * this.falloff - alternativa3d::mf * this.attenuationEnd;
          local29 = alternativa3d::ml - alternativa3d::mk * this.falloff - alternativa3d::mj * this.attenuationEnd;
          local30 = alternativa3d::md - alternativa3d::mc * this.falloff + (alternativa3d::ma * this.attenuationEnd - alternativa3d::mb * this.attenuationEnd) * 0.9;
          local31 = alternativa3d::mh - alternativa3d::mg * this.falloff + (alternativa3d::me * this.attenuationEnd - alternativa3d::mf * this.attenuationEnd) * 0.9;
          local32 = alternativa3d::ml - alternativa3d::mk * this.falloff + (alternativa3d::mi * this.attenuationEnd - alternativa3d::mj * this.attenuationEnd) * 0.9;
          local33 = alternativa3d::md + alternativa3d::mc * (this.length + this.falloff) + alternativa3d::ma * this.attenuationEnd;
          local34 = alternativa3d::mh + alternativa3d::mg * (this.length + this.falloff) + alternativa3d::me * this.attenuationEnd;
          local35 = alternativa3d::ml + alternativa3d::mk * (this.length + this.falloff) + alternativa3d::mi * this.attenuationEnd;
          local36 = alternativa3d::md + alternativa3d::mc * (this.length + this.falloff) + (alternativa3d::ma * this.attenuationEnd + alternativa3d::mb * this.attenuationEnd) * 0.9;
          local37 = alternativa3d::mh + alternativa3d::mg * (this.length + this.falloff) + (alternativa3d::me * this.attenuationEnd + alternativa3d::mf * this.attenuationEnd) * 0.9;
          local38 = alternativa3d::ml + alternativa3d::mk * (this.length + this.falloff) + (alternativa3d::mi * this.attenuationEnd + alternativa3d::mj * this.attenuationEnd) * 0.9;
          local39 = alternativa3d::md + alternativa3d::mc * (this.length + this.falloff) + alternativa3d::mb * this.attenuationEnd;
          local40 = alternativa3d::mh + alternativa3d::mg * (this.length + this.falloff) + alternativa3d::mf * this.attenuationEnd;
          local41 = alternativa3d::ml + alternativa3d::mk * (this.length + this.falloff) + alternativa3d::mj * this.attenuationEnd;
          local42 = alternativa3d::md + alternativa3d::mc * (this.length + this.falloff) - (alternativa3d::ma * this.attenuationEnd - alternativa3d::mb * this.attenuationEnd) * 0.9;
          local43 = alternativa3d::mh + alternativa3d::mg * (this.length + this.falloff) - (alternativa3d::me * this.attenuationEnd - alternativa3d::mf * this.attenuationEnd) * 0.9;
          local44 = alternativa3d::ml + alternativa3d::mk * (this.length + this.falloff) - (alternativa3d::mi * this.attenuationEnd - alternativa3d::mj * this.attenuationEnd) * 0.9;
          local45 = alternativa3d::md + alternativa3d::mc * (this.length + this.falloff) - alternativa3d::ma * this.attenuationEnd;
          local46 = alternativa3d::mh + alternativa3d::mg * (this.length + this.falloff) - alternativa3d::me * this.attenuationEnd;
          local47 = alternativa3d::ml + alternativa3d::mk * (this.length + this.falloff) - alternativa3d::mi * this.attenuationEnd;
          local48 = alternativa3d::md + alternativa3d::mc * (this.length + this.falloff) - (alternativa3d::ma * this.attenuationEnd + alternativa3d::mb * this.attenuationEnd) * 0.9;
          local49 = alternativa3d::mh + alternativa3d::mg * (this.length + this.falloff) - (alternativa3d::me * this.attenuationEnd + alternativa3d::mf * this.attenuationEnd) * 0.9;
          local50 = alternativa3d::ml + alternativa3d::mk * (this.length + this.falloff) - (alternativa3d::mi * this.attenuationEnd + alternativa3d::mj * this.attenuationEnd) * 0.9;
          local51 = alternativa3d::md + alternativa3d::mc * (this.length + this.falloff) - alternativa3d::mb * this.attenuationEnd;
          local52 = alternativa3d::mh + alternativa3d::mg * (this.length + this.falloff) - alternativa3d::mf * this.attenuationEnd;
          local53 = alternativa3d::ml + alternativa3d::mk * (this.length + this.falloff) - alternativa3d::mj * this.attenuationEnd;
          local54 = alternativa3d::md + alternativa3d::mc * (this.length + this.falloff) + (alternativa3d::ma * this.attenuationEnd - alternativa3d::mb * this.attenuationEnd) * 0.9;
          local55 = alternativa3d::mh + alternativa3d::mg * (this.length + this.falloff) + (alternativa3d::me * this.attenuationEnd - alternativa3d::mf * this.attenuationEnd) * 0.9;
          local56 = alternativa3d::ml + alternativa3d::mk * (this.length + this.falloff) + (alternativa3d::mi * this.attenuationEnd - alternativa3d::mj * this.attenuationEnd) * 0.9;
          if(local11 > param1.nearClipping && local14 > param1.nearClipping && local17 > param1.nearClipping && local20 > param1.nearClipping && local23 > param1.nearClipping && local26 > param1.nearClipping && local29 > param1.nearClipping && local32 > param1.nearClipping && local35 > param1.nearClipping && local38 > param1.nearClipping && local41 > param1.nearClipping && local44 > param1.nearClipping && local47 > param1.nearClipping && local50 > param1.nearClipping && local53 > param1.nearClipping && local56 > param1.nearClipping) {
            local4.alternativa3d::gfx.lineStyle(1,local8);
            local4.alternativa3d::gfx.moveTo(local9 * param1.alternativa3d::viewSizeX / local11,local10 * param1.alternativa3d::viewSizeY / local11);
            local4.alternativa3d::gfx.curveTo(local12 * param1.alternativa3d::viewSizeX / local14,local13 * param1.alternativa3d::viewSizeY / local14,local15 * param1.alternativa3d::viewSizeX / local17,local16 * param1.alternativa3d::viewSizeY / local17);
            local4.alternativa3d::gfx.curveTo(local18 * param1.alternativa3d::viewSizeX / local20,local19 * param1.alternativa3d::viewSizeY / local20,local21 * param1.alternativa3d::viewSizeX / local23,local22 * param1.alternativa3d::viewSizeY / local23);
            local4.alternativa3d::gfx.curveTo(local24 * param1.alternativa3d::viewSizeX / local26,local25 * param1.alternativa3d::viewSizeY / local26,local27 * param1.alternativa3d::viewSizeX / local29,local28 * param1.alternativa3d::viewSizeY / local29);
            local4.alternativa3d::gfx.curveTo(local30 * param1.alternativa3d::viewSizeX / local32,local31 * param1.alternativa3d::viewSizeY / local32,local9 * param1.alternativa3d::viewSizeX / local11,local10 * param1.alternativa3d::viewSizeY / local11);
            local4.alternativa3d::gfx.moveTo(local33 * param1.alternativa3d::viewSizeX / local35,local34 * param1.alternativa3d::viewSizeY / local35);
            local4.alternativa3d::gfx.curveTo(local36 * param1.alternativa3d::viewSizeX / local38,local37 * param1.alternativa3d::viewSizeY / local38,local39 * param1.alternativa3d::viewSizeX / local41,local40 * param1.alternativa3d::viewSizeY / local41);
            local4.alternativa3d::gfx.curveTo(local42 * param1.alternativa3d::viewSizeX / local44,local43 * param1.alternativa3d::viewSizeY / local44,local45 * param1.alternativa3d::viewSizeX / local47,local46 * param1.alternativa3d::viewSizeY / local47);
            local4.alternativa3d::gfx.curveTo(local48 * param1.alternativa3d::viewSizeX / local50,local49 * param1.alternativa3d::viewSizeY / local50,local51 * param1.alternativa3d::viewSizeX / local53,local52 * param1.alternativa3d::viewSizeY / local53);
            local4.alternativa3d::gfx.curveTo(local54 * param1.alternativa3d::viewSizeX / local56,local55 * param1.alternativa3d::viewSizeY / local56,local33 * param1.alternativa3d::viewSizeX / local35,local34 * param1.alternativa3d::viewSizeY / local35);
            local4.alternativa3d::gfx.moveTo(local9 * param1.alternativa3d::viewSizeX / local11,local10 * param1.alternativa3d::viewSizeY / local11);
            local4.alternativa3d::gfx.lineTo(local33 * param1.alternativa3d::viewSizeX / local35,local34 * param1.alternativa3d::viewSizeY / local35);
            local4.alternativa3d::gfx.moveTo(local15 * param1.alternativa3d::viewSizeX / local17,local16 * param1.alternativa3d::viewSizeY / local17);
            local4.alternativa3d::gfx.lineTo(local39 * param1.alternativa3d::viewSizeX / local41,local40 * param1.alternativa3d::viewSizeY / local41);
            local4.alternativa3d::gfx.moveTo(local21 * param1.alternativa3d::viewSizeX / local23,local22 * param1.alternativa3d::viewSizeY / local23);
            local4.alternativa3d::gfx.lineTo(local45 * param1.alternativa3d::viewSizeX / local47,local46 * param1.alternativa3d::viewSizeY / local47);
            local4.alternativa3d::gfx.moveTo(local27 * param1.alternativa3d::viewSizeX / local29,local28 * param1.alternativa3d::viewSizeY / local29);
            local4.alternativa3d::gfx.lineTo(local51 * param1.alternativa3d::viewSizeX / local53,local52 * param1.alternativa3d::viewSizeY / local53);
          }
        }
        if(Boolean(local3 & Debug.BOUNDS)) {
          Debug.alternativa3d::drawBounds(param1,local4,this,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ,10092288);
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
