package alternativa.engine3d.core {
  import alternativa.engine3d.alternativa3d;

  use namespace alternativa3d;

  public class Light3D extends Object3D {
    public var color:uint;
    public var intensity:Number = 1;

    alternativa3d var localWeight:Number;
    alternativa3d var localRed:Number;
    alternativa3d var localGreen:Number;
    alternativa3d var localBlue:Number;
    alternativa3d var cma:Number;
    alternativa3d var cmb:Number;
    alternativa3d var cmc:Number;
    alternativa3d var cmd:Number;
    alternativa3d var cme:Number;
    alternativa3d var cmf:Number;
    alternativa3d var cmg:Number;
    alternativa3d var cmh:Number;
    alternativa3d var cmi:Number;
    alternativa3d var cmj:Number;
    alternativa3d var cmk:Number;
    alternativa3d var cml:Number;
    alternativa3d var oma:Number;
    alternativa3d var omb:Number;
    alternativa3d var omc:Number;
    alternativa3d var omd:Number;
    alternativa3d var ome:Number;
    alternativa3d var omf:Number;
    alternativa3d var omg:Number;
    alternativa3d var omh:Number;
    alternativa3d var omi:Number;
    alternativa3d var omj:Number;
    alternativa3d var omk:Number;
    alternativa3d var oml:Number;
    alternativa3d var nextLight:Light3D;

    public function Light3D() {
      super();
    }

    override public function clone() : Object3D {
      var local1:Light3D = new Light3D();
      local1.clonePropertiesFrom(this);
      return local1;
    }

    override protected function clonePropertiesFrom(param1:Object3D) : void {
      super.clonePropertiesFrom(param1);
      var local2:Light3D = param1 as Light3D;
      this.color = local2.color;
      this.intensity = local2.intensity;
    }

    alternativa3d function calculateCameraMatrix(param1:Camera3D) : void {
      alternativa3d::composeMatrix();
      var local2:Object3D = this;
      while(local2.alternativa3d::_parent != null) {
        local2 = local2.alternativa3d::_parent;
        local2.alternativa3d::composeMatrix();
        alternativa3d::appendMatrix(local2);
      }
      alternativa3d::appendMatrix(param1);
      this.alternativa3d::cma = alternativa3d::ma;
      this.alternativa3d::cmb = alternativa3d::mb;
      this.alternativa3d::cmc = alternativa3d::mc;
      this.alternativa3d::cmd = alternativa3d::md;
      this.alternativa3d::cme = alternativa3d::me;
      this.alternativa3d::cmf = alternativa3d::mf;
      this.alternativa3d::cmg = alternativa3d::mg;
      this.alternativa3d::cmh = alternativa3d::mh;
      this.alternativa3d::cmi = alternativa3d::mi;
      this.alternativa3d::cmj = alternativa3d::mj;
      this.alternativa3d::cmk = alternativa3d::mk;
      this.alternativa3d::cml = alternativa3d::ml;
    }

    alternativa3d function calculateObjectMatrix(param1:Object3D) : void {
      this.alternativa3d::oma = param1.alternativa3d::ima * this.alternativa3d::cma + param1.alternativa3d::imb * this.alternativa3d::cme + param1.alternativa3d::imc * this.alternativa3d::cmi;
      this.alternativa3d::omb = param1.alternativa3d::ima * this.alternativa3d::cmb + param1.alternativa3d::imb * this.alternativa3d::cmf + param1.alternativa3d::imc * this.alternativa3d::cmj;
      this.alternativa3d::omc = param1.alternativa3d::ima * this.alternativa3d::cmc + param1.alternativa3d::imb * this.alternativa3d::cmg + param1.alternativa3d::imc * this.alternativa3d::cmk;
      this.alternativa3d::omd = param1.alternativa3d::ima * this.alternativa3d::cmd + param1.alternativa3d::imb * this.alternativa3d::cmh + param1.alternativa3d::imc * this.alternativa3d::cml + param1.alternativa3d::imd;
      this.alternativa3d::ome = param1.alternativa3d::ime * this.alternativa3d::cma + param1.alternativa3d::imf * this.alternativa3d::cme + param1.alternativa3d::img * this.alternativa3d::cmi;
      this.alternativa3d::omf = param1.alternativa3d::ime * this.alternativa3d::cmb + param1.alternativa3d::imf * this.alternativa3d::cmf + param1.alternativa3d::img * this.alternativa3d::cmj;
      this.alternativa3d::omg = param1.alternativa3d::ime * this.alternativa3d::cmc + param1.alternativa3d::imf * this.alternativa3d::cmg + param1.alternativa3d::img * this.alternativa3d::cmk;
      this.alternativa3d::omh = param1.alternativa3d::ime * this.alternativa3d::cmd + param1.alternativa3d::imf * this.alternativa3d::cmh + param1.alternativa3d::img * this.alternativa3d::cml + param1.alternativa3d::imh;
      this.alternativa3d::omi = param1.alternativa3d::imi * this.alternativa3d::cma + param1.alternativa3d::imj * this.alternativa3d::cme + param1.alternativa3d::imk * this.alternativa3d::cmi;
      this.alternativa3d::omj = param1.alternativa3d::imi * this.alternativa3d::cmb + param1.alternativa3d::imj * this.alternativa3d::cmf + param1.alternativa3d::imk * this.alternativa3d::cmj;
      this.alternativa3d::omk = param1.alternativa3d::imi * this.alternativa3d::cmc + param1.alternativa3d::imj * this.alternativa3d::cmg + param1.alternativa3d::imk * this.alternativa3d::cmk;
      this.alternativa3d::oml = param1.alternativa3d::imi * this.alternativa3d::cmd + param1.alternativa3d::imj * this.alternativa3d::cmh + param1.alternativa3d::imk * this.alternativa3d::cml + param1.alternativa3d::iml;
    }

    override alternativa3d function setParent(param1:Object3DContainer) : void {
      var local2:Object3DContainer = null;
      var local3:Light3D = null;
      var local4:Light3D = null;
      if(param1 == null) {
        local2 = alternativa3d::_parent;
        while(local2.alternativa3d::_parent != null) {
          local2 = local2.alternativa3d::_parent;
        }
        local4 = local2.alternativa3d::lightList;
        while(local4 != null) {
          if(local4 == this) {
            if(local3 != null) {
              local3.alternativa3d::nextLight = this.alternativa3d::nextLight;
            } else {
              local2.alternativa3d::lightList = this.alternativa3d::nextLight;
            }
            this.alternativa3d::nextLight = null;
            break;
          }
          local3 = local4;
          local4 = local4.alternativa3d::nextLight;
        }
      } else {
        local2 = param1;
        while(local2.alternativa3d::_parent != null) {
          local2 = local2.alternativa3d::_parent;
        }
        this.alternativa3d::nextLight = local2.alternativa3d::lightList;
        local2.alternativa3d::lightList = this;
      }
      alternativa3d::_parent = param1;
    }

    alternativa3d function drawDebug(param1:Camera3D) : void {
    }

    override alternativa3d function updateBounds(param1:Object3D, param2:Object3D = null) : void {
      param1.boundMinX = -1e+22;
      param1.boundMinY = -1e+22;
      param1.boundMinZ = -1e+22;
      param1.boundMaxX = 1e+22;
      param1.boundMaxY = 1e+22;
      param1.boundMaxZ = 1e+22;
    }

    override alternativa3d function cullingInCamera(param1:Camera3D, param2:int) : int {
      return -1;
    }

    alternativa3d function checkFrustumCulling(param1:Camera3D) : Boolean {
      var local2:Vertex = alternativa3d::boundVertexList;
      local2.x = boundMinX;
      local2.y = boundMinY;
      local2.z = boundMinZ;
      local2 = local2.alternativa3d::next;
      local2.x = boundMaxX;
      local2.y = boundMinY;
      local2.z = boundMinZ;
      local2 = local2.alternativa3d::next;
      local2.x = boundMinX;
      local2.y = boundMaxY;
      local2.z = boundMinZ;
      local2 = local2.alternativa3d::next;
      local2.x = boundMaxX;
      local2.y = boundMaxY;
      local2.z = boundMinZ;
      local2 = local2.alternativa3d::next;
      local2.x = boundMinX;
      local2.y = boundMinY;
      local2.z = boundMaxZ;
      local2 = local2.alternativa3d::next;
      local2.x = boundMaxX;
      local2.y = boundMinY;
      local2.z = boundMaxZ;
      local2 = local2.alternativa3d::next;
      local2.x = boundMinX;
      local2.y = boundMaxY;
      local2.z = boundMaxZ;
      local2 = local2.alternativa3d::next;
      local2.x = boundMaxX;
      local2.y = boundMaxY;
      local2.z = boundMaxZ;
      local2 = alternativa3d::boundVertexList;
      while(local2 != null) {
        local2.alternativa3d::cameraX = alternativa3d::ma * local2.x + alternativa3d::mb * local2.y + alternativa3d::mc * local2.z + alternativa3d::md;
        local2.alternativa3d::cameraY = alternativa3d::me * local2.x + alternativa3d::mf * local2.y + alternativa3d::mg * local2.z + alternativa3d::mh;
        local2.alternativa3d::cameraZ = alternativa3d::mi * local2.x + alternativa3d::mj * local2.y + alternativa3d::mk * local2.z + alternativa3d::ml;
        local2 = local2.alternativa3d::next;
      }
      local2 = alternativa3d::boundVertexList;
      while(local2 != null) {
        if(local2.alternativa3d::cameraZ > param1.nearClipping) {
          break;
        }
        local2 = local2.alternativa3d::next;
      }
      if(local2 == null) {
        return false;
      }
      local2 = alternativa3d::boundVertexList;
      while(local2 != null) {
        if(local2.alternativa3d::cameraZ < param1.farClipping) {
          break;
        }
        local2 = local2.alternativa3d::next;
      }
      if(local2 == null) {
        return false;
      }
      local2 = alternativa3d::boundVertexList;
      while(local2 != null) {
        if(-local2.alternativa3d::cameraX < local2.alternativa3d::cameraZ) {
          break;
        }
        local2 = local2.alternativa3d::next;
      }
      if(local2 == null) {
        return false;
      }
      local2 = alternativa3d::boundVertexList;
      while(local2 != null) {
        if(local2.alternativa3d::cameraX < local2.alternativa3d::cameraZ) {
          break;
        }
        local2 = local2.alternativa3d::next;
      }
      if(local2 == null) {
        return false;
      }
      local2 = alternativa3d::boundVertexList;
      while(local2 != null) {
        if(-local2.alternativa3d::cameraY < local2.alternativa3d::cameraZ) {
          break;
        }
        local2 = local2.alternativa3d::next;
      }
      if(local2 == null) {
        return false;
      }
      local2 = alternativa3d::boundVertexList;
      while(local2 != null) {
        if(local2.alternativa3d::cameraY < local2.alternativa3d::cameraZ) {
          break;
        }
        local2 = local2.alternativa3d::next;
      }
      if(local2 == null) {
        return false;
      }
      return true;
    }

    alternativa3d function checkBoundsIntersection(param1:Object3D) : Boolean {
      var local2:Number = NaN;
      var local3:Number = NaN;
      var local4:Number = (boundMaxX - boundMinX) * 0.5;
      var local5:Number = (boundMaxY - boundMinY) * 0.5;
      var local6:Number = (boundMaxZ - boundMinZ) * 0.5;
      var local7:Number = this.alternativa3d::oma * local4;
      var local8:Number = this.alternativa3d::ome * local4;
      var local9:Number = this.alternativa3d::omi * local4;
      var local10:Number = this.alternativa3d::omb * local5;
      var local11:Number = this.alternativa3d::omf * local5;
      var local12:Number = this.alternativa3d::omj * local5;
      var local13:Number = this.alternativa3d::omc * local6;
      var local14:Number = this.alternativa3d::omg * local6;
      var local15:Number = this.alternativa3d::omk * local6;
      var local16:Number = (param1.boundMaxX - param1.boundMinX) * 0.5;
      var local17:Number = (param1.boundMaxY - param1.boundMinY) * 0.5;
      var local18:Number = (param1.boundMaxZ - param1.boundMinZ) * 0.5;
      var local19:Number = this.alternativa3d::oma * (boundMinX + local4) + this.alternativa3d::omb * (boundMinY + local5) + this.alternativa3d::omc * (boundMinZ + local6) + this.alternativa3d::omd - param1.boundMinX - local16;
      var local20:Number = this.alternativa3d::ome * (boundMinX + local4) + this.alternativa3d::omf * (boundMinY + local5) + this.alternativa3d::omg * (boundMinZ + local6) + this.alternativa3d::omh - param1.boundMinY - local17;
      var local21:Number = this.alternativa3d::omi * (boundMinX + local4) + this.alternativa3d::omj * (boundMinY + local5) + this.alternativa3d::omk * (boundMinZ + local6) + this.alternativa3d::oml - param1.boundMinZ - local18;
      local2 = 0;
      local3 = local7 >= 0 ? local7 : -local7;
      local2 += local3;
      local3 = local10 >= 0 ? local10 : -local10;
      local2 += local3;
      local3 = local13 >= 0 ? local13 : -local13;
      local2 += local3;
      local2 += local16;
      local3 = local19 >= 0 ? local19 : -local19;
      local2 -= local3;
      if(local2 <= 0) {
        return false;
      }
      local2 = 0;
      local3 = local8 >= 0 ? local8 : -local8;
      local2 += local3;
      local3 = local11 >= 0 ? local11 : -local11;
      local2 += local3;
      local3 = local14 >= 0 ? local14 : -local14;
      local2 += local3;
      local2 += local17;
      local3 = local20 >= 0 ? local20 : -local20;
      local2 -= local3;
      if(local2 <= 0) {
        return false;
      }
      local2 = 0;
      local3 = local9 >= 0 ? local9 : -local9;
      local2 += local3;
      local3 = local12 >= 0 ? local12 : -local12;
      local2 += local3;
      local3 = local15 >= 0 ? local15 : -local15;
      local2 += local3;
      local2 += local17;
      local3 = local21 >= 0 ? local21 : -local21;
      local2 -= local3;
      if(local2 <= 0) {
        return false;
      }
      local2 = 0;
      local3 = this.alternativa3d::oma * local7 + this.alternativa3d::ome * local8 + this.alternativa3d::omi * local9;
      local3 = local3 >= 0 ? local3 : -local3;
      local2 += local3;
      local3 = this.alternativa3d::oma * local10 + this.alternativa3d::ome * local11 + this.alternativa3d::omi * local12;
      local3 = local3 >= 0 ? local3 : -local3;
      local2 += local3;
      local3 = this.alternativa3d::oma * local13 + this.alternativa3d::ome * local14 + this.alternativa3d::omi * local15;
      local3 = local3 >= 0 ? local3 : -local3;
      local2 += local3;
      local3 = this.alternativa3d::oma >= 0 ? this.alternativa3d::oma * local16 : -this.alternativa3d::oma * local16;
      local2 += local3;
      local3 = this.alternativa3d::ome >= 0 ? this.alternativa3d::ome * local17 : -this.alternativa3d::ome * local17;
      local2 += local3;
      local3 = this.alternativa3d::omi >= 0 ? this.alternativa3d::omi * local18 : -this.alternativa3d::omi * local18;
      local2 += local3;
      local3 = this.alternativa3d::oma * local19 + this.alternativa3d::ome * local20 + this.alternativa3d::omi * local21;
      local3 = local3 >= 0 ? local3 : -local3;
      local2 -= local3;
      if(local2 <= 0) {
        return false;
      }
      local2 = 0;
      local3 = this.alternativa3d::omb * local7 + this.alternativa3d::omf * local8 + this.alternativa3d::omj * local9;
      local3 = local3 >= 0 ? local3 : -local3;
      local2 += local3;
      local3 = this.alternativa3d::omb * local10 + this.alternativa3d::omf * local11 + this.alternativa3d::omj * local12;
      local3 = local3 >= 0 ? local3 : -local3;
      local2 += local3;
      local3 = this.alternativa3d::omb * local13 + this.alternativa3d::omf * local14 + this.alternativa3d::omj * local15;
      local3 = local3 >= 0 ? local3 : -local3;
      local2 += local3;
      local3 = this.alternativa3d::omb >= 0 ? this.alternativa3d::omb * local16 : -this.alternativa3d::omb * local16;
      local2 += local3;
      local3 = this.alternativa3d::omf >= 0 ? this.alternativa3d::omf * local17 : -this.alternativa3d::omf * local17;
      local2 += local3;
      local3 = this.alternativa3d::omj >= 0 ? this.alternativa3d::omj * local18 : -this.alternativa3d::omj * local18;
      local2 += local3;
      local3 = this.alternativa3d::omb * local19 + this.alternativa3d::omf * local20 + this.alternativa3d::omj * local21;
      local3 = local3 >= 0 ? local3 : -local3;
      local2 -= local3;
      if(local2 <= 0) {
        return false;
      }
      local2 = 0;
      local3 = this.alternativa3d::omc * local7 + this.alternativa3d::omg * local8 + this.alternativa3d::omk * local9;
      local3 = local3 >= 0 ? local3 : -local3;
      local2 += local3;
      local3 = this.alternativa3d::omc * local10 + this.alternativa3d::omg * local11 + this.alternativa3d::omk * local12;
      local3 = local3 >= 0 ? local3 : -local3;
      local2 += local3;
      local3 = this.alternativa3d::omc * local13 + this.alternativa3d::omg * local14 + this.alternativa3d::omk * local15;
      local3 = local3 >= 0 ? local3 : -local3;
      local2 += local3;
      local3 = this.alternativa3d::omc >= 0 ? this.alternativa3d::omc * local16 : -this.alternativa3d::omc * local16;
      local2 += local3;
      local3 = this.alternativa3d::omg >= 0 ? this.alternativa3d::omg * local17 : -this.alternativa3d::omg * local17;
      local2 += local3;
      local3 = this.alternativa3d::omk >= 0 ? this.alternativa3d::omk * local18 : -this.alternativa3d::omk * local18;
      local2 += local3;
      local3 = this.alternativa3d::omc * local19 + this.alternativa3d::omg * local20 + this.alternativa3d::omk * local21;
      local3 = local3 >= 0 ? local3 : -local3;
      local2 -= local3;
      if(local2 <= 0) {
        return false;
      }
      return true;
    }
  }
}
