package alternativa.tanks.models.weapon.healing {
  import alternativa.engine3d.core.Sorting;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;

  public class HealingGunStream extends Mesh {
    private var width:Number;
    private var deviation:Number;
    private var phase:Number;
    private var rnd:Number;
    private var count:int = 20;
    private var verts:Vector.<Vertex>;
    private var vertsLen:int = 0;
    private var segment:Number;
    private var offset:Number = 0;
    private var wave1Offset:Number = 0;
    private var wave2Offset:Number = 0;
    private var direction:int;

    public function HealingGunStream(param1:Number, param2:Number, param3:Number) {
      var local7:Vertex = null;
      var local8:Vertex = null;
      this.rnd = Math.random();
      this.verts = new Vector.<Vertex>();
      super();
      var local4:Vertex = addVertex(-1,0,0);
      var local5:Vertex = addVertex(1,0,0);
      this.verts[this.vertsLen] = local4;
      ++this.vertsLen;
      this.verts[this.vertsLen] = local5;
      ++this.vertsLen;
      var local6:int = 0;
      while(local6 < this.count) {
        local7 = addVertex(-1,-local6 - 1,0);
        local8 = addVertex(1,-local6 - 1,0);
        this.verts[this.vertsLen] = local7;
        ++this.vertsLen;
        this.verts[this.vertsLen] = local8;
        ++this.vertsLen;
        addQuadFace(local4,local7,local8,local5);
        local4 = local7;
        local5 = local8;
        local6++;
      }
      calculateFacesNormals();
      sorting = Sorting.DYNAMIC_BSP;
      this.width = param1;
      this.deviation = param2;
      this.phase = param3;
      this.shadowMapAlphaThreshold = 2;
      this.depthMapAlphaThreshold = 2;
      this.useShadowMap = false;
      this.useLight = false;
      this.direction = 1;
    }

    public function init() : void {
      var local3:Vertex = null;
      var local4:Vertex = null;
      var local5:Number = NaN;
      var local1:Number = this.width * 0.5;
      var local2:int = 0;
      while(local2 < this.vertsLen) {
        local3 = this.verts[local2];
        local2++;
        local4 = this.verts[local2];
        local5 = Math.cos((-local3.y / this.count * 2 - 1) * Math.PI / 2) * this.deviation;
        local3.x = -local1 + local5;
        local3.u = 0;
        local4.x = local1 + local5;
        local4.u = 1;
        local2++;
      }
      this.offset = 0;
    }

    public function setMaterial(param1:TextureMaterial, param2:int) : void {
      this.direction = param2;
      setMaterialToAllFaces(param1);
      if(param1 != null && param1.texture != null) {
        this.segment = this.width * param1.texture.height / param1.texture.width;
      } else {
        this.segment = this.width;
      }
      this.offset = 0;
      this.wave1Offset = 0;
      this.wave2Offset = 0;
    }

    public function update(param1:int, param2:Number = 512) : void {
      var local14:Vertex = null;
      var local15:Vertex = null;
      var local16:Number = NaN;
      var local17:Number = NaN;
      var local18:Number = NaN;
      var local3:Number = 600;
      var local4:Number = 350;
      var local5:Number = 0.13;
      var local6:Number = 450;
      var local7:Number = 400;
      this.wave1Offset += local6 * param1 / 1000;
      this.wave2Offset += local7 * param1 / 1000;
      var local8:Number = 1.1 * this.direction;
      this.offset += local8 * param1 / 1000;
      var local9:Number = param2 / this.count;
      var local10:Number = param2 / 2;
      var local11:Number = 150;
      var local12:Number = 1;
      var local13:int = 0;
      while(local13 < this.vertsLen) {
        local14 = this.verts[local13];
        local13++;
        local15 = this.verts[local13];
        local14.y = param2 - (local13 >> 1) * local9;
        local15.y = local14.y;
        local16 = local10 - local14.y;
        local14.v = local16 / this.segment + this.offset + this.rnd;
        local15.v = local14.v;
        if(local14.y < local10) {
          local12 = local14.y / local11;
        } else {
          local12 = (param2 - local14.y) / local11;
        }
        if(local12 > 1) {
          local12 = 1;
        }
        local17 = Math.sin((Math.PI * 2 + this.phase) * (local16 + this.wave1Offset) / local3);
        local18 = Math.sin((Math.PI * 2 + this.phase) * (local16 + this.wave2Offset) / local4);
        local14.u = (local17 + local18) * 0.5 * local5 * local12;
        local15.u = 1 + local14.u;
        local13++;
      }
    }
  }
}
