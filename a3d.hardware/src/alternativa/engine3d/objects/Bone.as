package alternativa.engine3d.objects {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Debug;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Vertex;

  use namespace alternativa3d;

  public class Bone extends Joint {
    public var length:Number;

    alternativa3d var lx:Number;
    alternativa3d var ly:Number;
    alternativa3d var lz:Number;
    alternativa3d var ldot:Number;

    public function Bone(param1:Number, param2:Number) {
      super();
      this.length = param1;
      this.alternativa3d::distance = param2;
    }

    public function bindVerticesByDistance(param1:Skin) : void {
      var local2:Vertex = param1.alternativa3d::vertexList;
      while(local2 != null) {
        this.bindVertexByDistance(local2);
        local2 = local2.alternativa3d::next;
      }
    }

    public function bindVertexByDistance(param1:Vertex) : void {
      var local2:Number = param1.x - alternativa3d::md;
      var local3:Number = param1.y - alternativa3d::mh;
      var local4:Number = param1.z - alternativa3d::ml;
      var local5:Number = local2 * this.alternativa3d::lx + local3 * this.alternativa3d::ly + local4 * this.alternativa3d::lz;
      if(local5 > 0) {
        if(this.alternativa3d::ldot > local5) {
          local5 /= this.alternativa3d::ldot;
          local2 = param1.x - alternativa3d::md - local5 * this.alternativa3d::lx;
          local3 = param1.y - alternativa3d::mh - local5 * this.alternativa3d::ly;
          local4 = param1.z - alternativa3d::ml - local5 * this.alternativa3d::lz;
        } else {
          local2 -= this.alternativa3d::lx;
          local3 -= this.alternativa3d::ly;
          local4 -= this.alternativa3d::lz;
        }
      }
      bindVertex(param1,1 - Math.sqrt(local2 * local2 + local3 * local3 + local4 * local4) / alternativa3d::distance);
    }

    override alternativa3d function calculateBindingMatrix(param1:Object3D) : void {
      super.alternativa3d::calculateBindingMatrix(param1);
      this.alternativa3d::lx = alternativa3d::mc * this.length;
      this.alternativa3d::ly = alternativa3d::mg * this.length;
      this.alternativa3d::lz = alternativa3d::mk * this.length;
      this.alternativa3d::ldot = this.alternativa3d::lx * this.alternativa3d::lx + this.alternativa3d::ly * this.alternativa3d::ly + this.alternativa3d::lz * this.alternativa3d::lz;
    }

    override alternativa3d function drawDebug(param1:Camera3D) : void {
      var local2:Number = NaN;
      var local3:Number = NaN;
      var local4:Number = NaN;
      var local5:Number = NaN;
      var local6:Number = NaN;
      if(numChildren == 0) {
        local2 = alternativa3d::md * param1.alternativa3d::viewSizeX / alternativa3d::ml;
        local3 = alternativa3d::mh * param1.alternativa3d::viewSizeY / alternativa3d::ml;
        local4 = alternativa3d::mi * this.length + alternativa3d::ml;
        local5 = (alternativa3d::ma * this.length + alternativa3d::md) * param1.alternativa3d::viewSizeX / local4;
        local6 = (alternativa3d::me * this.length + alternativa3d::mh) * param1.alternativa3d::viewSizeY / local4;
        if(alternativa3d::ml > 0 && local4 > 0) {
          Debug.alternativa3d::drawBone(param1,local2,local3,local5,local6,10 * param1.alternativa3d::focalLength / alternativa3d::ml,39423);
        }
      } else {
        super.alternativa3d::drawDebug(param1);
      }
    }
  }
}
