package alternativa.tanks.battle.objects.tank.tankskin {
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.materials.Material;
  import alternativa.engine3d.materials.UVMatrixProvider;
  import alternativa.tanks.materials.TrackMaterial;
  import flash.geom.Matrix;
  import flash.utils.Dictionary;

  public class TrackSkin {
    private var uvsProvider:UVMatrixProvider;
    private var faces:Vector.<Face> = new Vector.<Face>();
    private var vertices:Vector.<Vertex>;
    private var ratio:Number;
    private var distance:Number = 0;

    public function TrackSkin() {
      super();
    }

    private static function getRatio(param1:Face) : Number {
      var local2:Vector.<Vertex> = param1.vertices;
      return getRatioForVertices(local2[0],local2[1]);
    }

    private static function getRatioForVertices(param1:Vertex, param2:Vertex) : Number {
      var local3:Number = param1.x - param2.x;
      var local4:Number = param1.y - param2.y;
      var local5:Number = param1.z - param2.z;
      var local6:Number = Math.sqrt(local3 * local3 + local4 * local4 + local5 * local5);
      var local7:Number = param1.u - param2.u;
      var local8:Number = param1.v - param2.v;
      var local9:Number = Math.sqrt(local7 * local7 + local8 * local8);
      return local9 / local6;
    }

    public function addFace(param1:Face) : void {
      this.faces.push(param1);
    }

    public function init() : void {
      var local3:Face = null;
      var local4:* = undefined;
      var local5:Vertex = null;
      var local1:Number = 0;
      var local2:Dictionary = new Dictionary();
      for each(local3 in this.faces) {
        for each(local5 in local3.vertices) {
          local2[local5] = true;
        }
        local1 += getRatio(local3);
      }
      this.ratio = local1 / this.faces.length;
      this.vertices = new Vector.<Vertex>();
      for(local4 in local2) {
        this.vertices.push(local4);
      }
    }

    public function move(param1:Number) : void {
      var local2:Matrix = null;
      this.distance += param1 * this.ratio;
      if(this.uvsProvider != null) {
        local2 = this.uvsProvider.getMatrix();
        local2.tx = this.distance;
      }
    }

    public function setMaterial(param1:Material) : void {
      var local2:Face = null;
      var local3:TrackMaterial = null;
      for each(local2 in this.faces) {
        local2.material = param1;
      }
      if(param1 is TrackMaterial) {
        local3 = param1 as TrackMaterial;
        this.uvsProvider = local3.uvMatrixProvider;
      }
    }
  }
}
