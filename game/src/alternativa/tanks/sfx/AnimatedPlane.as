package alternativa.tanks.sfx {
  import alternativa.engine3d.core.Sorting;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.engine3d.UVFrame;

  public class AnimatedPlane extends Mesh {
    private var a:Vertex;
    private var b:Vertex;
    private var c:Vertex;
    private var d:Vertex;
    private var uvFrames:Vector.<UVFrame>;
    private var numFrames:int;
    private var framesPerTimeUnit:Number = 0;

    public function AnimatedPlane(param1:Number, param2:Number, param3:Number = 0, param4:Number = 0, param5:Number = 10) {
      super();
      this.createFaces(param1,param2,param3,param4,param5);
      sorting = Sorting.DYNAMIC_BSP;
      calculateBounds();
      calculateFacesNormals();
      this.writeVertices();
      this.softAttenuation = 130;
      this.shadowMapAlphaThreshold = 2;
      this.depthMapAlphaThreshold = 2;
    }

    private function createFaces(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : void {
      var local6:Number = param1 / 2;
      var local7:Number = param2 / 2;
      var local8:Vector.<Number> = Vector.<Number>([param3 - local6,param4 + local7,param5,param3 - local6,param4 - local7,param5,param3 + local6,param4 - local7,param5,param3 + local6,param4 + local7,param5]);
      var local9:Vector.<Number> = Vector.<Number>([0,0,0,1,1,1,1,0]);
      var local10:Vector.<int> = Vector.<int>([4,0,1,2,3,4,0,3,2,1]);
      addVerticesAndFaces(local8,local9,local10,true);
    }

    private function writeVertices() : void {
      var local1:Vector.<Vertex> = this.vertices;
      this.a = local1[0];
      this.b = local1[1];
      this.c = local1[2];
      this.d = local1[3];
    }

    public function init(param1:TextureAnimation, param2:Number) : void {
      setMaterialToAllFaces(param1.material);
      this.uvFrames = param1.frames;
      this.numFrames = this.uvFrames.length;
      this.framesPerTimeUnit = param2;
    }

    public function setTime(param1:Number) : void {
      var local2:int = param1 * this.framesPerTimeUnit;
      if(local2 >= this.numFrames) {
        local2 = this.numFrames - 1;
      }
      this.setFrame(this.uvFrames[local2]);
    }

    public function clear() : void {
      setMaterialToAllFaces(null);
      this.uvFrames = null;
      this.numFrames = 0;
    }

    public function getOneLoopTime() : Number {
      return this.numFrames / this.framesPerTimeUnit;
    }

    private function setFrame(param1:UVFrame) : void {
      this.a.u = param1.topLeftU;
      this.a.v = param1.topLeftV;
      this.b.u = param1.topLeftU;
      this.b.v = param1.bottomRightV;
      this.c.u = param1.bottomRightU;
      this.c.v = param1.bottomRightV;
      this.d.u = param1.bottomRightU;
      this.d.v = param1.topLeftV;
    }
  }
}
