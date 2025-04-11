package utils.graphics {
  import flash.display.BitmapData;
  import flash.display.Graphics;
  import flash.geom.Matrix;

  public class Pen {
    private var _gTarget:Graphics;
    private var _bLineStyleSet:Boolean;

    public function Pen(param1:Graphics) {
      super();
      this._gTarget = param1;
    }

    public function set target(param1:Graphics) : void {
      this._gTarget = param1;
    }

    public function get target() : Graphics {
      return this._gTarget;
    }

    public function lineStyle(param1:Number = 1, param2:Number = 0, param3:Number = 1, param4:Boolean = false, param5:String = "normal", param6:String = null, param7:String = null, param8:Number = 3) : void {
      this._gTarget.lineStyle(param1,param2,param3,param4,param5,param6,param7,param8);
      this._bLineStyleSet = true;
    }

    public function lineGradientStyle(param1:String, param2:Array, param3:Array, param4:Array, param5:Matrix = null, param6:String = "pad", param7:String = "rgb", param8:Number = 0) : void {
      if(!this._bLineStyleSet) {
        this.lineStyle();
      }
      this._gTarget.lineGradientStyle(param1,param2,param3,param4,param5,param6,param7,param8);
    }

    public function beginFill(param1:Number, param2:Number = 1) : void {
      this._gTarget.beginFill(param1,param2);
    }

    public function beginGradientFill(param1:String, param2:Array, param3:Array, param4:Array, param5:Matrix = null, param6:String = "pad", param7:String = "rgb", param8:Number = 0) : void {
      this._gTarget.beginGradientFill(param1,param2,param3,param4,param5,param6,param7,param8);
    }

    public function beginBitmapFill(param1:BitmapData, param2:Matrix = null, param3:Boolean = true, param4:Boolean = false) : void {
      this._gTarget.beginBitmapFill(param1,param2,param3,param4);
    }

    public function endFill() : void {
      this._gTarget.endFill();
    }

    public function clear() : void {
      this._gTarget.clear();
      this._bLineStyleSet = false;
    }

    public function moveTo(param1:Number, param2:Number) : void {
      this._gTarget.moveTo(param1,param2);
    }

    public function lineTo(param1:Number, param2:Number) : void {
      if(!this._bLineStyleSet) {
        this.lineStyle();
      }
      this._gTarget.lineTo(param1,param2);
    }

    public function curveTo(param1:Number, param2:Number, param3:Number, param4:Number) : void {
      if(!this._bLineStyleSet) {
        this.lineStyle();
      }
      this._gTarget.curveTo(param1,param2,param3,param4);
    }

    public function drawLine(param1:Number, param2:Number, param3:Number, param4:Number) : void {
      if(!this._bLineStyleSet) {
        this.lineStyle();
      }
      this._gTarget.moveTo(param1,param2);
      this._gTarget.lineTo(param3,param4);
    }

    public function drawCurve(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void {
      if(!this._bLineStyleSet) {
        this.lineStyle();
      }
      this._gTarget.moveTo(param1,param2);
      this._gTarget.curveTo(param3,param4,param5,param6);
    }

    public function drawRect(param1:Number, param2:Number, param3:Number, param4:Number) : void {
      if(!this._bLineStyleSet) {
        this.lineStyle();
      }
      this._gTarget.drawRect(param1,param2,param3,param4);
    }

    public function drawRoundRect(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : void {
      if(!this._bLineStyleSet) {
        this.lineStyle();
      }
      this._gTarget.drawRoundRect(param1,param2,param3,param4,param5);
    }

    public function drawRoundRectComplex(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : void {
      if(!this._bLineStyleSet) {
        this.lineStyle();
      }
      this._gTarget.drawRoundRectComplex(param1,param2,param3,param4,param5,param6,param7,param8);
    }

    public function drawCircle(param1:Number, param2:Number, param3:Number) : void {
      if(!this._bLineStyleSet) {
        this.lineStyle();
      }
      this._gTarget.drawCircle(param1,param2,param3);
    }

    public function drawSlice(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : void {
      this.drawArc(param4,param5,param2,param1,param3,true);
    }

    public function drawArc(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number = 0, param6:Boolean = false) : void {
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local13:Number = NaN;
      if(param4 > 360) {
        param4 = 360;
      }
      param4 = Math.PI / 180 * param4;
      var local7:Number = param4 / 8;
      var local8:Number = param3 / Math.cos(local7 / 2);
      param5 *= Math.PI / 180;
      var local9:Number = param5;
      var local14:Number = param1 + Math.cos(param5) * param3;
      var local15:Number = param2 + Math.sin(param5) * param3;
      if(param6) {
        this.moveTo(param1,param2);
        this.lineTo(local14,local15);
      } else {
        this.moveTo(local14,local15);
      }
      var local16:Number = 0;
      while(local16 < 8) {
        local9 += local7;
        local10 = param1 + Math.cos(local9 - local7 / 2) * local8;
        local11 = param2 + Math.sin(local9 - local7 / 2) * local8;
        local12 = param1 + Math.cos(local9) * param3;
        local13 = param2 + Math.sin(local9) * param3;
        this.curveTo(local10,local11,local12,local13);
        local16++;
      }
      if(param6) {
        this.lineTo(param1,param2);
      }
    }

    public function drawEllipse(param1:Number, param2:Number, param3:Number, param4:Number) : void {
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local5:Number = Math.PI / 4;
      var local6:Number = 0;
      var local7:Number = param3 / Math.cos(local5 / 2);
      var local8:Number = param4 / Math.cos(local5 / 2);
      this.moveTo(param1 + param3,param2);
      var local13:Number = 0;
      while(local13 < 8) {
        local6 += local5;
        local9 = param1 + Math.cos(local6 - local5 / 2) * local7;
        local10 = param2 + Math.sin(local6 - local5 / 2) * local8;
        local11 = param1 + Math.cos(local6) * param3;
        local12 = param2 + Math.sin(local6) * param4;
        this.curveTo(local9,local10,local11,local12);
        local13++;
      }
    }

    public function drawTriangle(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number = 0) : void {
      param6 = param6 * Math.PI / 180;
      param5 = param5 * Math.PI / 180;
      var local7:Number = Math.cos(param5 - param6) * param3;
      var local8:Number = Math.sin(param5 - param6) * param3;
      var local9:Number = Math.cos(-param6) * param4;
      var local10:Number = Math.sin(-param6) * param4;
      var local11:Number = 0;
      var local12:Number = 0;
      this.drawLine(-local11 + param1,-local12 + param2,local9 - local11 + param1,local10 - local12 + param2);
      this.lineTo(local7 - local11 + param1,local8 - local12 + param2);
      this.lineTo(-local11 + param1,-local12 + param2);
    }

    public function drawRegularPolygon(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number = 0) : void {
      param5 = param5 * Math.PI / 180;
      var local6:Number = 2 * Math.PI / param3;
      var local7:Number = param4 / 2 / Math.sin(local6 / 2);
      var local8:Number = Math.cos(param5) * local7 + param1;
      var local9:Number = Math.sin(param5) * local7 + param2;
      this.moveTo(local8,local9);
      var local10:Number = 1;
      while(local10 <= param3) {
        local8 = Math.cos(local6 * local10 + param5) * local7 + param1;
        local9 = Math.sin(local6 * local10 + param5) * local7 + param2;
        this.lineTo(local8,local9);
        local10++;
      }
    }

    public function drawStar(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number = 0) : void {
      if(param3 < 3) {
        return;
      }
      var local7:Number = Math.PI * 2 / param3;
      param6 = Math.PI * (param6 - 90) / 180;
      var local8:Number = param6;
      var local9:Number = param1 + Math.cos(local8 + local7 / 2) * param4;
      var local10:Number = param2 + Math.sin(local8 + local7 / 2) * param4;
      this.moveTo(local9,local10);
      local8 += local7;
      var local11:Number = 0;
      while(local11 < param3) {
        local9 = param1 + Math.cos(local8) * param5;
        local10 = param2 + Math.sin(local8) * param5;
        this.lineTo(local9,local10);
        local9 = param1 + Math.cos(local8 + local7 / 2) * param4;
        local10 = param2 + Math.sin(local8 + local7 / 2) * param4;
        this.lineTo(local9,local10);
        local8 += local7;
        local11++;
      }
    }
  }
}
