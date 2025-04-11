package alternativa.engine3d.objects {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Canvas;
  import alternativa.engine3d.core.Debug;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Vertex;
  import flash.geom.Matrix3D;
  import flash.geom.Vector3D;

  use namespace alternativa3d;

  public class Joint extends Object3D {
    alternativa3d var vertexBindingList:VertexBinding;
    alternativa3d var bma:Number;
    alternativa3d var bmb:Number;
    alternativa3d var bmc:Number;
    alternativa3d var bmd:Number;
    alternativa3d var bme:Number;
    alternativa3d var bmf:Number;
    alternativa3d var bmg:Number;
    alternativa3d var bmh:Number;
    alternativa3d var bmi:Number;
    alternativa3d var bmj:Number;
    alternativa3d var bmk:Number;
    alternativa3d var bml:Number;
    alternativa3d var _parentJoint:Joint;
    alternativa3d var _skin:Skin;
    alternativa3d var nextJoint:Joint;
    alternativa3d var childrenList:Joint;

    public function Joint() {
      super();
    }

    public function addChild(param1:Joint) : Joint {
      var local3:Joint = null;
      if(param1 == null) {
        throw new TypeError("Parameter child must be non-null.");
      }
      if(param1 == this) {
        throw new ArgumentError("A joint cannot be added as a child of itself.");
      }
      var local2:Joint = this.alternativa3d::_parentJoint;
      while(local2 != null) {
        if(local2 == param1) {
          throw new ArgumentError("A joint cannot be added as a child to one of it\'s children (or children\'s children, etc.).");
        }
        local2 = local2.alternativa3d::_parentJoint;
      }
      if(param1.alternativa3d::_parentJoint != null) {
        param1.alternativa3d::_parentJoint.removeChild(param1);
      } else if(param1.alternativa3d::_skin != null) {
        param1.alternativa3d::_skin.removeJoint(param1);
      }
      param1.alternativa3d::_parentJoint = this;
      param1.alternativa3d::setSkin(this.alternativa3d::_skin);
      if(this.alternativa3d::childrenList == null) {
        this.alternativa3d::childrenList = param1;
      } else {
        local3 = this.alternativa3d::childrenList;
        while(local3 != null) {
          if(local3.alternativa3d::nextJoint == null) {
            local3.alternativa3d::nextJoint = param1;
            break;
          }
          local3 = local3.alternativa3d::nextJoint;
        }
      }
      return param1;
    }

    alternativa3d function addChildFast(param1:Joint) : Joint {
      var local2:Joint = null;
      param1.alternativa3d::_parentJoint = this;
      param1.alternativa3d::setSkinFast(this.alternativa3d::_skin);
      if(this.alternativa3d::childrenList == null) {
        this.alternativa3d::childrenList = param1;
      } else {
        local2 = this.alternativa3d::childrenList;
        while(local2 != null) {
          if(local2.alternativa3d::nextJoint == null) {
            local2.alternativa3d::nextJoint = param1;
            break;
          }
          local2 = local2.alternativa3d::nextJoint;
        }
      }
      return param1;
    }

    public function removeChild(param1:Joint) : Joint {
      var local2:Joint = null;
      var local3:Joint = null;
      if(param1 == null) {
        throw new TypeError("Parameter child must be non-null.");
      }
      if(param1.alternativa3d::_parentJoint != this) {
        throw new ArgumentError("The supplied Joint must be a child of the caller.");
      }
      local3 = this.alternativa3d::childrenList;
      while(local3 != null) {
        if(local3 == param1) {
          if(local2 != null) {
            local2.alternativa3d::nextJoint = local3.alternativa3d::nextJoint;
          } else {
            this.alternativa3d::childrenList = local3.alternativa3d::nextJoint;
          }
          local3.alternativa3d::nextJoint = null;
          local3.alternativa3d::_parentJoint = null;
          local3.alternativa3d::setSkin(null);
          return param1;
        }
        local2 = local3;
        local3 = local3.alternativa3d::nextJoint;
      }
      return null;
    }

    public function getChildAt(param1:int) : Joint {
      if(param1 < 0) {
        throw new RangeError("The supplied index is out of bounds.");
      }
      var local2:Joint = this.alternativa3d::childrenList;
      var local3:int = 0;
      while(local3 < param1) {
        if(local2 == null) {
          throw new RangeError("The supplied index is out of bounds.");
        }
        local2 = local2.alternativa3d::nextJoint;
        local3++;
      }
      if(local2 == null) {
        throw new RangeError("The supplied index is out of bounds.");
      }
      return local2;
    }

    public function get numChildren() : int {
      var local1:int = 0;
      var local2:Joint = this.alternativa3d::childrenList;
      while(local2 != null) {
        local1++;
        local2 = local2.alternativa3d::nextJoint;
      }
      return local1;
    }

    public function get skin() : Skin {
      return this.alternativa3d::_skin;
    }

    public function get parentJoint() : Joint {
      return this.alternativa3d::_parentJoint;
    }

    public function bindVertex(param1:Vertex, param2:Number) : void {
      var local4:Vertex = null;
      var local5:VertexBinding = null;
      if(this.alternativa3d::_skin != null) {
        local4 = this.alternativa3d::_skin.alternativa3d::vertexList;
        while(local4 != null) {
          if(local4 == param1) {
            break;
          }
          local4 = local4.alternativa3d::next;
        }
        if(local4 == null) {
          throw new ArgumentError("Vertex not found");
        }
        var local3:VertexBinding = this.alternativa3d::vertexBindingList;
        while(local3 != null) {
          if(local3.alternativa3d::vertex == param1) {
            break;
          }
          local3 = local3.alternativa3d::next;
        }
        if(local3 != null) {
          local3.alternativa3d::weight = param2;
        } else {
          local5 = new VertexBinding();
          local5.alternativa3d::next = this.alternativa3d::vertexBindingList;
          this.alternativa3d::vertexBindingList = local5;
          local5.alternativa3d::vertex = param1;
          local5.alternativa3d::weight = param2;
        }
        return;
      }
      throw new ArgumentError("Vertex not found");
    }

    public function unbindVertex(param1:Vertex) : void {
      var local2:VertexBinding = null;
      var local3:VertexBinding = null;
      local3 = this.alternativa3d::vertexBindingList;
      while(local3 != null) {
        if(local3.alternativa3d::vertex == param1) {
          if(local2 != null) {
            local2.alternativa3d::next = local3.alternativa3d::next;
          } else {
            this.alternativa3d::vertexBindingList = local3.alternativa3d::next;
          }
          local3.alternativa3d::next = null;
          return;
        }
        local2 = local3;
        local3 = local3.alternativa3d::next;
      }
    }

    alternativa3d function calculateBindingMatrix(param1:Object3D) : void {
      alternativa3d::composeAndAppend(param1);
      var local2:Number = 1 / (-alternativa3d::mc * alternativa3d::mf * alternativa3d::mi + alternativa3d::mb * alternativa3d::mg * alternativa3d::mi + alternativa3d::mc * alternativa3d::me * alternativa3d::mj - alternativa3d::ma * alternativa3d::mg * alternativa3d::mj - alternativa3d::mb * alternativa3d::me * alternativa3d::mk + alternativa3d::ma * alternativa3d::mf * alternativa3d::mk);
      this.alternativa3d::bma = (-alternativa3d::mg * alternativa3d::mj + alternativa3d::mf * alternativa3d::mk) * local2;
      this.alternativa3d::bmb = (alternativa3d::mc * alternativa3d::mj - alternativa3d::mb * alternativa3d::mk) * local2;
      this.alternativa3d::bmc = (-alternativa3d::mc * alternativa3d::mf + alternativa3d::mb * alternativa3d::mg) * local2;
      this.alternativa3d::bmd = (alternativa3d::md * alternativa3d::mg * alternativa3d::mj - alternativa3d::mc * alternativa3d::mh * alternativa3d::mj - alternativa3d::md * alternativa3d::mf * alternativa3d::mk + alternativa3d::mb * alternativa3d::mh * alternativa3d::mk + alternativa3d::mc * alternativa3d::mf * alternativa3d::ml - alternativa3d::mb * alternativa3d::mg * alternativa3d::ml) * local2;
      this.alternativa3d::bme = (alternativa3d::mg * alternativa3d::mi - alternativa3d::me * alternativa3d::mk) * local2;
      this.alternativa3d::bmf = (-alternativa3d::mc * alternativa3d::mi + alternativa3d::ma * alternativa3d::mk) * local2;
      this.alternativa3d::bmg = (alternativa3d::mc * alternativa3d::me - alternativa3d::ma * alternativa3d::mg) * local2;
      this.alternativa3d::bmh = (alternativa3d::mc * alternativa3d::mh * alternativa3d::mi - alternativa3d::md * alternativa3d::mg * alternativa3d::mi + alternativa3d::md * alternativa3d::me * alternativa3d::mk - alternativa3d::ma * alternativa3d::mh * alternativa3d::mk - alternativa3d::mc * alternativa3d::me * alternativa3d::ml + alternativa3d::ma * alternativa3d::mg * alternativa3d::ml) * local2;
      this.alternativa3d::bmi = (-alternativa3d::mf * alternativa3d::mi + alternativa3d::me * alternativa3d::mj) * local2;
      this.alternativa3d::bmj = (alternativa3d::mb * alternativa3d::mi - alternativa3d::ma * alternativa3d::mj) * local2;
      this.alternativa3d::bmk = (-alternativa3d::mb * alternativa3d::me + alternativa3d::ma * alternativa3d::mf) * local2;
      this.alternativa3d::bml = (alternativa3d::md * alternativa3d::mf * alternativa3d::mi - alternativa3d::mb * alternativa3d::mh * alternativa3d::mi - alternativa3d::md * alternativa3d::me * alternativa3d::mj + alternativa3d::ma * alternativa3d::mh * alternativa3d::mj + alternativa3d::mb * alternativa3d::me * alternativa3d::ml - alternativa3d::ma * alternativa3d::mf * alternativa3d::ml) * local2;
      var local3:Joint = this.alternativa3d::childrenList;
      while(local3 != null) {
        local3.alternativa3d::calculateBindingMatrix(this);
        local3 = local3.alternativa3d::nextJoint;
      }
    }

    override public function get matrix() : Matrix3D {
      return super.matrix;
    }

    override public function set matrix(param1:Matrix3D) : void {
      var local2:Vector.<Vector3D> = param1.decompose();
      var local3:Vector3D = local2[0];
      var local4:Vector3D = local2[1];
      var local5:Vector3D = local2[2];
      x = local3.x;
      y = local3.y;
      z = local3.z;
      rotationX = local4.x;
      rotationY = local4.y;
      rotationZ = local4.z;
      scaleX = local5.x;
      scaleY = local5.y;
      scaleZ = local5.z;
    }

    override public function get concatenatedMatrix() : Matrix3D {
      var local2:Object3D = null;
      alternativa3d::tA.alternativa3d::composeMatrixFromSource(this);
      var local1:Joint = this;
      while(local1.alternativa3d::_parentJoint != null) {
        local1 = local1.alternativa3d::_parentJoint;
        alternativa3d::tB.alternativa3d::composeMatrixFromSource(local1);
        alternativa3d::tA.alternativa3d::appendMatrix(alternativa3d::tB);
      }
      if(this.alternativa3d::_skin != null) {
        alternativa3d::tB.alternativa3d::composeMatrixFromSource(this.alternativa3d::_skin);
        alternativa3d::tA.alternativa3d::appendMatrix(alternativa3d::tB);
        local2 = this.alternativa3d::_skin;
        while(local2.alternativa3d::_parent != null) {
          local2 = local2.alternativa3d::_parent;
          alternativa3d::tB.alternativa3d::composeMatrixFromSource(local2);
          alternativa3d::tA.alternativa3d::appendMatrix(alternativa3d::tB);
        }
      }
      return new Matrix3D(Vector.<Number>([alternativa3d::tA.alternativa3d::ma,alternativa3d::tA.alternativa3d::me,alternativa3d::tA.alternativa3d::mi,0,alternativa3d::tA.alternativa3d::mb,alternativa3d::tA.alternativa3d::mf,alternativa3d::tA.alternativa3d::mj,0,alternativa3d::tA.alternativa3d::mc,alternativa3d::tA.alternativa3d::mg,alternativa3d::tA.alternativa3d::mk,0,alternativa3d::tA.alternativa3d::md,alternativa3d::tA.alternativa3d::mh,alternativa3d::tA.alternativa3d::ml,1]));
    }

    override public function localToGlobal(param1:Vector3D) : Vector3D {
      var local4:Object3D = null;
      alternativa3d::tA.alternativa3d::composeMatrixFromSource(this);
      var local2:Joint = this;
      while(local2.alternativa3d::_parentJoint != null) {
        local2 = local2.alternativa3d::_parentJoint;
        alternativa3d::tB.alternativa3d::composeMatrixFromSource(local2);
        alternativa3d::tA.alternativa3d::appendMatrix(alternativa3d::tB);
      }
      if(this.alternativa3d::_skin != null) {
        alternativa3d::tB.alternativa3d::composeMatrixFromSource(this.alternativa3d::_skin);
        alternativa3d::tA.alternativa3d::appendMatrix(alternativa3d::tB);
        local4 = this.alternativa3d::_skin;
        while(local4.alternativa3d::_parent != null) {
          local4 = local4.alternativa3d::_parent;
          alternativa3d::tB.alternativa3d::composeMatrixFromSource(local4);
          alternativa3d::tA.alternativa3d::appendMatrix(alternativa3d::tB);
        }
      }
      var local3:Vector3D = new Vector3D();
      local3.x = alternativa3d::tA.alternativa3d::ma * param1.x + alternativa3d::tA.alternativa3d::mb * param1.y + alternativa3d::tA.alternativa3d::mc * param1.z + alternativa3d::tA.alternativa3d::md;
      local3.y = alternativa3d::tA.alternativa3d::me * param1.x + alternativa3d::tA.alternativa3d::mf * param1.y + alternativa3d::tA.alternativa3d::mg * param1.z + alternativa3d::tA.alternativa3d::mh;
      local3.z = alternativa3d::tA.alternativa3d::mi * param1.x + alternativa3d::tA.alternativa3d::mj * param1.y + alternativa3d::tA.alternativa3d::mk * param1.z + alternativa3d::tA.alternativa3d::ml;
      return local3;
    }

    override public function globalToLocal(param1:Vector3D) : Vector3D {
      var local4:Object3D = null;
      alternativa3d::tA.alternativa3d::composeMatrixFromSource(this);
      var local2:Joint = this;
      while(local2.alternativa3d::_parentJoint != null) {
        local2 = local2.alternativa3d::_parentJoint;
        alternativa3d::tB.alternativa3d::composeMatrixFromSource(local2);
        alternativa3d::tA.alternativa3d::appendMatrix(alternativa3d::tB);
      }
      if(this.alternativa3d::_skin != null) {
        alternativa3d::tB.alternativa3d::composeMatrixFromSource(this.alternativa3d::_skin);
        alternativa3d::tA.alternativa3d::appendMatrix(alternativa3d::tB);
        local4 = this.alternativa3d::_skin;
        while(local4.alternativa3d::_parent != null) {
          local4 = local4.alternativa3d::_parent;
          alternativa3d::tB.alternativa3d::composeMatrixFromSource(local4);
          alternativa3d::tA.alternativa3d::appendMatrix(alternativa3d::tB);
        }
      }
      alternativa3d::tA.alternativa3d::invertMatrix();
      var local3:Vector3D = new Vector3D();
      local3.x = alternativa3d::tA.alternativa3d::ma * param1.x + alternativa3d::tA.alternativa3d::mb * param1.y + alternativa3d::tA.alternativa3d::mc * param1.z + alternativa3d::tA.alternativa3d::md;
      local3.y = alternativa3d::tA.alternativa3d::me * param1.x + alternativa3d::tA.alternativa3d::mf * param1.y + alternativa3d::tA.alternativa3d::mg * param1.z + alternativa3d::tA.alternativa3d::mh;
      local3.z = alternativa3d::tA.alternativa3d::mi * param1.x + alternativa3d::tA.alternativa3d::mj * param1.y + alternativa3d::tA.alternativa3d::mk * param1.z + alternativa3d::tA.alternativa3d::ml;
      return local3;
    }

    public function get bindingMatrix() : Matrix3D {
      return new Matrix3D(Vector.<Number>([this.alternativa3d::bma,this.alternativa3d::bme,this.alternativa3d::bmi,0,this.alternativa3d::bmb,this.alternativa3d::bmf,this.alternativa3d::bmj,0,this.alternativa3d::bmc,this.alternativa3d::bmg,this.alternativa3d::bmk,0,this.alternativa3d::bmd,this.alternativa3d::bmh,this.alternativa3d::bml,1]));
    }

    public function set bindingMatrix(param1:Matrix3D) : void {
      var local2:Vector.<Number> = param1.rawData;
      this.alternativa3d::bma = local2[0];
      this.alternativa3d::bmb = local2[4];
      this.alternativa3d::bmc = local2[8];
      this.alternativa3d::bmd = local2[12];
      this.alternativa3d::bme = local2[1];
      this.alternativa3d::bmf = local2[5];
      this.alternativa3d::bmg = local2[9];
      this.alternativa3d::bmh = local2[13];
      this.alternativa3d::bmi = local2[2];
      this.alternativa3d::bmj = local2[6];
      this.alternativa3d::bmk = local2[10];
      this.alternativa3d::bml = local2[14];
    }

    alternativa3d function addWeights() : void {
      var local1:VertexBinding = this.alternativa3d::vertexBindingList;
      while(local1 != null) {
        local1.alternativa3d::vertex.alternativa3d::offset += local1.alternativa3d::weight;
        local1 = local1.alternativa3d::next;
      }
      var local2:Joint = this.alternativa3d::childrenList;
      while(local2 != null) {
        local2.alternativa3d::addWeights();
        local2 = local2.alternativa3d::nextJoint;
      }
    }

    alternativa3d function normalizeWeights() : void {
      var local1:VertexBinding = this.alternativa3d::vertexBindingList;
      while(local1 != null) {
        local1.alternativa3d::weight /= local1.alternativa3d::vertex.alternativa3d::offset;
        local1 = local1.alternativa3d::next;
      }
      var local2:Joint = this.alternativa3d::childrenList;
      while(local2 != null) {
        local2.alternativa3d::normalizeWeights();
        local2 = local2.alternativa3d::nextJoint;
      }
    }

    alternativa3d function drawDebug(param1:Camera3D, param2:Canvas) : void {
      var local5:Number = NaN;
      var local6:Number = NaN;
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local14:Number = NaN;
      alternativa3d::appendMatrix(this.alternativa3d::_skin);
      var local3:Number = alternativa3d::md * param1.alternativa3d::viewSizeX / alternativa3d::ml;
      var local4:Number = alternativa3d::mh * param1.alternativa3d::viewSizeY / alternativa3d::ml;
      var local9:Number = param1.alternativa3d::focalLength / param1.alternativa3d::viewSizeX;
      var local10:Number = param1.alternativa3d::focalLength / param1.alternativa3d::viewSizeY;
      var local11:Joint = this.alternativa3d::childrenList;
      while(local11 != null) {
        local5 = alternativa3d::mi * local11.x + alternativa3d::mj * local11.y + alternativa3d::mk * local11.z + alternativa3d::ml;
        local6 = (alternativa3d::ma * local11.x + alternativa3d::mb * local11.y + alternativa3d::mc * local11.z + alternativa3d::md) * param1.alternativa3d::viewSizeX / local5;
        local7 = (alternativa3d::me * local11.x + alternativa3d::mf * local11.y + alternativa3d::mg * local11.z + alternativa3d::mh) * param1.alternativa3d::viewSizeY / local5;
        local12 = (alternativa3d::ma * local11.x + alternativa3d::mb * local11.y + alternativa3d::mc * local11.z) / local9;
        local13 = (alternativa3d::me * local11.x + alternativa3d::mf * local11.y + alternativa3d::mg * local11.z) / local10;
        local14 = alternativa3d::mi * local11.x + alternativa3d::mj * local11.y + alternativa3d::mk * local11.z;
        local8 = Math.sqrt(local12 * local12 + local13 * local13 + local14 * local14);
        if(alternativa3d::ml > 0 && local5 > 0) {
          Debug.alternativa3d::drawBone(param2,local3,local4,local6,local7,local8 / 10 * param1.alternativa3d::focalLength / alternativa3d::ml,255);
        }
        local11.alternativa3d::drawDebug(param1,param2);
        local11 = local11.alternativa3d::nextJoint;
      }
    }

    alternativa3d function calculateVertices(param1:Boolean, param2:Boolean) : void {
      var local15:VertexBinding = null;
      var local16:Vertex = null;
      var local17:Number = NaN;
      var local18:Vertex = null;
      var local19:Joint = null;
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
      var local3:Number = alternativa3d::ma * this.alternativa3d::bma + alternativa3d::mb * this.alternativa3d::bme + alternativa3d::mc * this.alternativa3d::bmi;
      var local4:Number = alternativa3d::ma * this.alternativa3d::bmb + alternativa3d::mb * this.alternativa3d::bmf + alternativa3d::mc * this.alternativa3d::bmj;
      var local5:Number = alternativa3d::ma * this.alternativa3d::bmc + alternativa3d::mb * this.alternativa3d::bmg + alternativa3d::mc * this.alternativa3d::bmk;
      var local6:Number = alternativa3d::ma * this.alternativa3d::bmd + alternativa3d::mb * this.alternativa3d::bmh + alternativa3d::mc * this.alternativa3d::bml + alternativa3d::md;
      var local7:Number = alternativa3d::me * this.alternativa3d::bma + alternativa3d::mf * this.alternativa3d::bme + alternativa3d::mg * this.alternativa3d::bmi;
      var local8:Number = alternativa3d::me * this.alternativa3d::bmb + alternativa3d::mf * this.alternativa3d::bmf + alternativa3d::mg * this.alternativa3d::bmj;
      var local9:Number = alternativa3d::me * this.alternativa3d::bmc + alternativa3d::mf * this.alternativa3d::bmg + alternativa3d::mg * this.alternativa3d::bmk;
      var local10:Number = alternativa3d::me * this.alternativa3d::bmd + alternativa3d::mf * this.alternativa3d::bmh + alternativa3d::mg * this.alternativa3d::bml + alternativa3d::mh;
      var local11:Number = alternativa3d::mi * this.alternativa3d::bma + alternativa3d::mj * this.alternativa3d::bme + alternativa3d::mk * this.alternativa3d::bmi;
      var local12:Number = alternativa3d::mi * this.alternativa3d::bmb + alternativa3d::mj * this.alternativa3d::bmf + alternativa3d::mk * this.alternativa3d::bmj;
      var local13:Number = alternativa3d::mi * this.alternativa3d::bmc + alternativa3d::mj * this.alternativa3d::bmg + alternativa3d::mk * this.alternativa3d::bmk;
      var local14:Number = alternativa3d::mi * this.alternativa3d::bmd + alternativa3d::mj * this.alternativa3d::bmh + alternativa3d::mk * this.alternativa3d::bml + alternativa3d::ml;
      if(param1) {
        param2 ||= scaleX != 1 || scaleY != 1 || scaleZ != 1;
        if(param2) {
          local20 = 1 / (-local5 * local8 * local11 + local4 * local9 * local11 + local5 * local7 * local12 - local3 * local9 * local12 - local4 * local7 * local13 + local3 * local8 * local13);
          local21 = (-local9 * local12 + local8 * local13) * local20;
          local22 = (local5 * local12 - local4 * local13) * local20;
          local23 = (-local5 * local8 + local4 * local9) * local20;
          local24 = (local6 * local9 * local12 - local5 * local10 * local12 - local6 * local8 * local13 + local4 * local10 * local13 + local5 * local8 * local14 - local4 * local9 * local14) * local20;
          local25 = (local9 * local11 - local7 * local13) * local20;
          local26 = (-local5 * local11 + local3 * local13) * local20;
          local27 = (local5 * local7 - local3 * local9) * local20;
          local28 = (local5 * local10 * local11 - local6 * local9 * local11 + local6 * local7 * local13 - local3 * local10 * local13 - local5 * local7 * local14 + local3 * local9 * local14) * local20;
          local29 = (-local8 * local11 + local7 * local12) * local20;
          local30 = (local4 * local11 - local3 * local12) * local20;
          local31 = (-local4 * local7 + local3 * local8) * local20;
          local32 = (local6 * local8 * local11 - local4 * local10 * local11 - local6 * local7 * local12 + local3 * local10 * local12 + local4 * local7 * local14 - local3 * local8 * local14) * local20;
          local15 = this.alternativa3d::vertexBindingList;
          while(local15 != null) {
            local16 = local15.alternativa3d::vertex;
            local17 = Number(local15.alternativa3d::weight);
            local18 = local16.alternativa3d::value;
            local18.x += (local3 * local16.x + local4 * local16.y + local5 * local16.z + local6) * local17;
            local18.y += (local7 * local16.x + local8 * local16.y + local9 * local16.z + local10) * local17;
            local18.z += (local11 * local16.x + local12 * local16.y + local13 * local16.z + local14) * local17;
            local18.normalX += (local21 * local16.normalX + local25 * local16.normalY + local29 * local16.normalZ) * local17;
            local18.normalY += (local22 * local16.normalX + local26 * local16.normalY + local30 * local16.normalZ) * local17;
            local18.normalZ += (local23 * local16.normalX + local27 * local16.normalY + local31 * local16.normalZ) * local17;
            local15 = local15.alternativa3d::next;
          }
        } else {
          local15 = this.alternativa3d::vertexBindingList;
          while(local15 != null) {
            local16 = local15.alternativa3d::vertex;
            local17 = Number(local15.alternativa3d::weight);
            local18 = local16.alternativa3d::value;
            local18.x += (local3 * local16.x + local4 * local16.y + local5 * local16.z + local6) * local17;
            local18.y += (local7 * local16.x + local8 * local16.y + local9 * local16.z + local10) * local17;
            local18.z += (local11 * local16.x + local12 * local16.y + local13 * local16.z + local14) * local17;
            local18.normalX += (local3 * local16.normalX + local4 * local16.normalY + local5 * local16.normalZ) * local17;
            local18.normalY += (local7 * local16.normalX + local8 * local16.normalY + local9 * local16.normalZ) * local17;
            local18.normalZ += (local11 * local16.normalX + local12 * local16.normalY + local13 * local16.normalZ) * local17;
            local15 = local15.alternativa3d::next;
          }
        }
      } else {
        local15 = this.alternativa3d::vertexBindingList;
        while(local15 != null) {
          local16 = local15.alternativa3d::vertex;
          local17 = Number(local15.alternativa3d::weight);
          local18 = local16.alternativa3d::value;
          local18.x += (local3 * local16.x + local4 * local16.y + local5 * local16.z + local6) * local17;
          local18.y += (local7 * local16.x + local8 * local16.y + local9 * local16.z + local10) * local17;
          local18.z += (local11 * local16.x + local12 * local16.y + local13 * local16.z + local14) * local17;
          local15 = local15.alternativa3d::next;
        }
      }
      local19 = this.alternativa3d::childrenList;
      while(local19 != null) {
        local19.alternativa3d::composeAndAppend(this);
        local19.alternativa3d::calculateVertices(param1,param2);
        local19 = local19.alternativa3d::nextJoint;
      }
    }

    alternativa3d function setSkin(param1:Skin) : void {
      this.alternativa3d::vertexBindingList = null;
      this.alternativa3d::_skin = param1;
      var local2:Joint = this.alternativa3d::childrenList;
      while(local2 != null) {
        local2.alternativa3d::setSkin(param1);
        local2 = local2.alternativa3d::nextJoint;
      }
    }

    alternativa3d function setSkinFast(param1:Skin) : void {
      this.alternativa3d::_skin = param1;
      var local2:Joint = this.alternativa3d::childrenList;
      while(local2 != null) {
        local2.alternativa3d::setSkinFast(param1);
        local2 = local2.alternativa3d::nextJoint;
      }
    }
  }
}
