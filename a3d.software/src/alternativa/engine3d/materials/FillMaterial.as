package alternativa.engine3d.materials {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Canvas;
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.core.Wrapper;

  use namespace alternativa3d;

  public class FillMaterial extends Material {
    public var color:int;
    public var alpha:Number;
    public var lineThickness:Number;
    public var lineColor:int;

    public function FillMaterial(param1:int = 8355711, param2:Number = 1, param3:Number = -1, param4:int = 16777215) {
      super();
      this.color = param1;
      this.alpha = param2;
      this.lineThickness = param3;
      this.lineColor = param4;
    }

    override public function clone() : Material {
      var local1:FillMaterial = new FillMaterial(this.color,this.alpha,this.lineThickness,this.lineColor);
      local1.clonePropertiesFrom(this);
      return local1;
    }

    override alternativa3d function draw(param1:Camera3D, param2:Canvas, param3:Face, param4:Number) : void {
      var local7:Face = null;
      var local9:Wrapper = null;
      var local10:Vertex = null;
      var local11:int = 0;
      var local5:Number = Number(param1.alternativa3d::viewSizeX);
      var local6:Number = Number(param1.alternativa3d::viewSizeY);
      if(this.lineThickness >= 0) {
        param2.alternativa3d::gfx.lineStyle(this.lineThickness,this.lineColor);
      }
      var local8:Face = param3;
      while(local8 != null) {
        local7 = local8.alternativa3d::processNext;
        local8.alternativa3d::processNext = null;
        local9 = local8.alternativa3d::wrapper;
        local10 = local9.alternativa3d::vertex;
        param2.alternativa3d::gfx.beginFill(this.color,this.alpha);
        param2.alternativa3d::gfx.moveTo(local10.alternativa3d::cameraX * local5 / local10.alternativa3d::cameraZ,local10.alternativa3d::cameraY * local6 / local10.alternativa3d::cameraZ);
        local11 = -1;
        local9 = local9.alternativa3d::next;
        while(local9 != null) {
          local10 = local9.alternativa3d::vertex;
          param2.alternativa3d::gfx.lineTo(local10.alternativa3d::cameraX * local5 / local10.alternativa3d::cameraZ,local10.alternativa3d::cameraY * local6 / local10.alternativa3d::cameraZ);
          local11++;
          local9 = local9.alternativa3d::next;
        }
        local10 = local8.alternativa3d::wrapper.alternativa3d::vertex;
        param2.alternativa3d::gfx.lineTo(local10.alternativa3d::cameraX * local5 / local10.alternativa3d::cameraZ,local10.alternativa3d::cameraY * local6 / local10.alternativa3d::cameraZ);
        param1.alternativa3d::numTriangles += local11;
        ++param1.alternativa3d::numPolygons;
        local8 = local7;
      }
      if(this.lineThickness >= 0) {
        param2.alternativa3d::gfx.lineStyle();
      }
      ++param1.alternativa3d::numDraws;
    }

    override alternativa3d function drawViewAligned(param1:Camera3D, param2:Canvas, param3:Face, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number) : void {
      var local13:Face = null;
      var local15:Wrapper = null;
      var local16:Vertex = null;
      var local17:int = 0;
      var local11:Number = Number(param1.alternativa3d::viewSizeX);
      var local12:Number = Number(param1.alternativa3d::viewSizeY);
      if(this.lineThickness >= 0) {
        param2.alternativa3d::gfx.lineStyle(this.lineThickness,this.lineColor);
      }
      var local14:Face = param3;
      while(local14 != null) {
        local13 = local14.alternativa3d::processNext;
        local14.alternativa3d::processNext = null;
        local15 = local14.alternativa3d::wrapper;
        local16 = local15.alternativa3d::vertex;
        param2.alternativa3d::gfx.beginFill(this.color,this.alpha);
        param2.alternativa3d::gfx.moveTo(local16.alternativa3d::cameraX * local11 / param4,local16.alternativa3d::cameraY * local12 / param4);
        local17 = -1;
        local15 = local15.alternativa3d::next;
        while(local15 != null) {
          local16 = local15.alternativa3d::vertex;
          param2.alternativa3d::gfx.lineTo(local16.alternativa3d::cameraX * local11 / param4,local16.alternativa3d::cameraY * local12 / param4);
          local17++;
          local15 = local15.alternativa3d::next;
        }
        local16 = local14.alternativa3d::wrapper.alternativa3d::vertex;
        param2.alternativa3d::gfx.lineTo(local16.alternativa3d::cameraX * local11 / param4,local16.alternativa3d::cameraY * local12 / param4);
        param1.alternativa3d::numTriangles += local17;
        ++param1.alternativa3d::numPolygons;
        local14 = local13;
      }
      if(this.lineThickness >= 0) {
        param2.alternativa3d::gfx.lineStyle();
      }
      ++param1.alternativa3d::numDraws;
    }
  }
}
