package alternativa.engine3d.objects {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Debug;
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.RayIntersectionData;
  import alternativa.engine3d.core.VG;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.core.Wrapper;
  import alternativa.engine3d.materials.Material;
  import flash.geom.Vector3D;
  import flash.utils.Dictionary;

  use namespace alternativa3d;

  public class Skin extends Mesh {
    alternativa3d var jointList:Joint;
    alternativa3d var localList:Face;

    public function Skin() {
      super();
      shadowMapAlphaThreshold = 100;
    }

    public function addJoint(param1:Joint) : Joint {
      var local2:Joint = null;
      if(param1 == null) {
        throw new TypeError("Parameter joint must be non-null.");
      }
      if(param1.alternativa3d::_parentJoint != null) {
        param1.alternativa3d::_parentJoint.removeChild(param1);
      } else if(param1.alternativa3d::_skin != null) {
        param1.alternativa3d::_skin.removeJoint(param1);
      }
      param1.alternativa3d::_parentJoint = null;
      param1.alternativa3d::setSkin(this);
      if(this.alternativa3d::jointList == null) {
        this.alternativa3d::jointList = param1;
      } else {
        local2 = this.alternativa3d::jointList;
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

    public function removeJoint(param1:Joint) : Joint {
      var local2:Joint = null;
      var local3:Joint = null;
      if(param1 == null) {
        throw new TypeError("Parameter joint must be non-null.");
      }
      if(param1.alternativa3d::_parentJoint != null || param1.alternativa3d::_skin != this) {
        throw new ArgumentError("The supplied Joint must be contained in the caller.");
      }
      local3 = this.alternativa3d::jointList;
      while(local3 != null) {
        if(local3 == param1) {
          if(local2 != null) {
            local2.alternativa3d::nextJoint = local3.alternativa3d::nextJoint;
          } else {
            this.alternativa3d::jointList = local3.alternativa3d::nextJoint;
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

    public function getJointAt(param1:int) : Joint {
      if(param1 < 0) {
        throw new RangeError("The supplied index is out of bounds.");
      }
      var local2:Joint = this.alternativa3d::jointList;
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

    public function get numJoints() : int {
      var local1:int = 0;
      var local2:Joint = this.alternativa3d::jointList;
      while(local2 != null) {
        local1++;
        local2 = local2.alternativa3d::nextJoint;
      }
      return local1;
    }

    public function getJointByName(param1:String) : Joint {
      var local4:Joint = null;
      var local6:int = 0;
      var local7:Vector.<Joint> = null;
      var local8:Joint = null;
      if(param1 == null) {
        throw new TypeError("Parameter name must be non-null.");
      }
      var local2:Vector.<Joint> = new Vector.<Joint>();
      var local3:Vector.<Joint> = new Vector.<Joint>();
      local4 = this.alternativa3d::jointList;
      while(local4 != null) {
        if(local4.name == param1) {
          return local4;
        }
        local2.push(local4);
        local4 = local4.alternativa3d::nextJoint;
      }
      var local5:int = this.numJoints;
      while(local5 > 0) {
        local6 = 0;
        while(local6 < local5) {
          local4 = local2[local6];
          local8 = local4.alternativa3d::childrenList;
          while(local8 != null) {
            if(local8.name == param1) {
              return local8;
            }
            if(local8.alternativa3d::childrenList != null) {
              local3.push(local8);
            }
            local8 = local8.alternativa3d::nextJoint;
          }
          local6++;
        }
        local7 = local2;
        local2 = local3;
        local3 = local7;
        local3.length = 0;
        local5 = int(local2.length);
      }
      return null;
    }

    override public function addVertex(param1:Number, param2:Number, param3:Number, param4:Number = 0, param5:Number = 0, param6:Object = null) : Vertex {
      this.alternativa3d::clearLocal();
      return super.addVertex(param1,param2,param3,param4,param5,param6);
    }

    override public function removeVertex(param1:Vertex) : Vertex {
      this.alternativa3d::clearLocal();
      var local2:Vertex = super.removeVertex(param1);
      var local3:Joint = this.alternativa3d::jointList;
      while(local3 != null) {
        this.unbindVertex(local3,local2);
        local3 = local3.alternativa3d::nextJoint;
      }
      return local2;
    }

    override public function removeVertexById(param1:Object) : Vertex {
      this.alternativa3d::clearLocal();
      var local2:Vertex = super.removeVertexById(param1);
      var local3:Joint = this.alternativa3d::jointList;
      while(local3 != null) {
        this.unbindVertex(local3,local2);
        local3 = local3.alternativa3d::nextJoint;
      }
      return local2;
    }

    private function unbindVertex(param1:Joint, param2:Vertex) : void {
      param1.unbindVertex(param2);
      var local3:Joint = param1.alternativa3d::childrenList;
      while(local3 != null) {
        this.unbindVertex(local3,param2);
        local3 = local3.alternativa3d::nextJoint;
      }
    }

    override public function addFace(param1:Vector.<Vertex>, param2:Material = null, param3:Object = null) : Face {
      this.alternativa3d::clearLocal();
      return super.addFace(param1,param2,param3);
    }

    override public function addFaceByIds(param1:Array, param2:Material = null, param3:Object = null) : Face {
      this.alternativa3d::clearLocal();
      return super.addFaceByIds(param1,param2,param3);
    }

    override public function addTriFace(param1:Vertex, param2:Vertex, param3:Vertex, param4:Material = null, param5:Object = null) : Face {
      this.alternativa3d::clearLocal();
      return super.addTriFace(param1,param2,param3,param4,param5);
    }

    override public function addQuadFace(param1:Vertex, param2:Vertex, param3:Vertex, param4:Vertex, param5:Material = null, param6:Object = null) : Face {
      this.alternativa3d::clearLocal();
      return super.addQuadFace(param1,param2,param3,param4,param5,param6);
    }

    override public function removeFace(param1:Face) : Face {
      this.alternativa3d::clearLocal();
      return super.removeFace(param1);
    }

    override public function removeFaceById(param1:Object) : Face {
      this.alternativa3d::clearLocal();
      return super.removeFaceById(param1);
    }

    override public function addVerticesAndFaces(param1:Vector.<Number>, param2:Vector.<Number>, param3:Vector.<int>, param4:Boolean = false, param5:Material = null) : void {
      this.alternativa3d::clearLocal();
      super.addVerticesAndFaces(param1,param2,param3,param4,param5);
    }

    override public function weldVertices(param1:Number = 0, param2:Number = 0) : void {
      var local3:Vertex = null;
      var local5:* = undefined;
      var local6:Joint = null;
      this.alternativa3d::clearLocal();
      var local4:Dictionary = new Dictionary();
      local3 = alternativa3d::vertexList;
      while(local3 != null) {
        local4[local3] = true;
        local3 = local3.alternativa3d::next;
      }
      super.weldVertices(param1,param2);
      local3 = alternativa3d::vertexList;
      while(local3 != null) {
        delete local4[local3];
        local3 = local3.alternativa3d::next;
      }
      for(local5 in local4) {
        local3 = local5;
        local6 = this.alternativa3d::jointList;
        while(local6 != null) {
          this.unbindVertex(local6,local3);
          local6 = local6.alternativa3d::nextJoint;
        }
      }
    }

    override public function weldFaces(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Boolean = false) : void {
      this.alternativa3d::clearLocal();
      super.weldFaces(param1,param2,param3,param4);
    }

    override public function optimizeForDynamicBSP(param1:int = 1) : void {
      this.alternativa3d::clearLocal();
      super.optimizeForDynamicBSP(param1);
    }

    public function calculateBindingMatrices() : void {
      alternativa3d::ma = 1;
      alternativa3d::mb = 0;
      alternativa3d::mc = 0;
      alternativa3d::md = 0;
      alternativa3d::me = 0;
      alternativa3d::mf = 1;
      alternativa3d::mg = 0;
      alternativa3d::mh = 0;
      alternativa3d::mi = 0;
      alternativa3d::mj = 0;
      alternativa3d::mk = 1;
      alternativa3d::ml = 0;
      var local1:Joint = this.alternativa3d::jointList;
      while(local1 != null) {
        local1.alternativa3d::calculateBindingMatrix(this);
        local1 = local1.alternativa3d::nextJoint;
      }
    }

    public function normalizeWeights() : void {
      var local2:Joint = null;
      var local1:Vertex = alternativa3d::vertexList;
      while(local1 != null) {
        local1.alternativa3d::offset = 0;
        local1 = local1.alternativa3d::next;
      }
      local2 = this.alternativa3d::jointList;
      while(local2 != null) {
        local2.alternativa3d::addWeights();
        local2 = local2.alternativa3d::nextJoint;
      }
      local2 = this.alternativa3d::jointList;
      while(local2 != null) {
        local2.alternativa3d::normalizeWeights();
        local2 = local2.alternativa3d::nextJoint;
      }
    }

    override public function intersectRay(param1:Vector3D, param2:Vector3D, param3:Dictionary = null, param4:Camera3D = null) : RayIntersectionData {
      var local7:Face = null;
      var local8:Face = null;
      if(param3 != null && Boolean(param3[this])) {
        return null;
      }
      if(!alternativa3d::boundIntersectRay(param1,param2,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ)) {
        return null;
      }
      this.alternativa3d::updateLocal();
      var local5:Face = alternativa3d::faceList;
      alternativa3d::faceList = this.alternativa3d::localList;
      calculateFacesNormals(true);
      var local6:RayIntersectionData = super.intersectRay(param1,param2,param3,param4);
      alternativa3d::faceList = local5;
      if(local6 != null) {
        local7 = alternativa3d::faceList;
        local8 = this.alternativa3d::localList;
        while(local7 != null) {
          if(local8 == local6.face) {
            local6.face = local7;
            break;
          }
          local7 = local7.alternativa3d::next;
          local8 = local8.alternativa3d::next;
        }
      }
      return local6;
    }

    override alternativa3d function checkIntersection(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Dictionary) : Boolean {
      this.alternativa3d::updateLocal();
      var local9:Face = alternativa3d::faceList;
      alternativa3d::faceList = this.alternativa3d::localList;
      calculateFacesNormals(true);
      var local10:Boolean = super.alternativa3d::checkIntersection(param1,param2,param3,param4,param5,param6,param7,param8);
      alternativa3d::faceList = local9;
      return local10;
    }

    override alternativa3d function collectPlanes(param1:Vector3D, param2:Vector3D, param3:Vector3D, param4:Vector3D, param5:Vector3D, param6:Vector.<Face>, param7:Dictionary = null) : void {
      if(param7 != null && Boolean(param7[this])) {
        return;
      }
      var local8:Vector3D = alternativa3d::calculateSphere(param1,param2,param3,param4,param5);
      if(!alternativa3d::boundIntersectSphere(local8,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ)) {
        return;
      }
      var local9:Face = alternativa3d::faceList;
      alternativa3d::faceList = this.alternativa3d::localList;
      calculateFacesNormals(true);
      super.alternativa3d::collectPlanes(param1,param2,param3,param4,param5,param6,param7);
      alternativa3d::faceList = local9;
    }

    public function attach(param1:Skin) : void {
      var local3:Vertex = null;
      var local4:Face = null;
      var local5:Joint = null;
      this.alternativa3d::clearLocal();
      param1.alternativa3d::clearLocal();
      if(alternativa3d::vertexList == null) {
        alternativa3d::vertexList = param1.alternativa3d::vertexList;
      } else {
        local3 = alternativa3d::vertexList;
        while(local3.alternativa3d::next != null) {
          local3 = local3.alternativa3d::next;
        }
        local3.alternativa3d::next = param1.alternativa3d::vertexList;
      }
      param1.alternativa3d::vertexList = null;
      if(alternativa3d::faceList == null) {
        alternativa3d::faceList = param1.alternativa3d::faceList;
      } else {
        local4 = alternativa3d::faceList;
        while(local4.alternativa3d::next != null) {
          local4 = local4.alternativa3d::next;
        }
        local4.alternativa3d::next = param1.alternativa3d::faceList;
      }
      param1.alternativa3d::faceList = null;
      var local2:Joint = param1.alternativa3d::jointList;
      while(local2 != null) {
        if(local2.name == null || local2.name == "") {
          this.addJointFast(local2);
        } else {
          local5 = this.getJointByName(local2.name);
          if(local5 != null) {
            this.mergeJoints(local2,local5);
          } else {
            this.addJointFast(local2);
          }
        }
        local2 = local2.alternativa3d::nextJoint;
      }
      param1.alternativa3d::jointList = null;
    }

    private function addJointFast(param1:Joint) : Joint {
      var local2:Joint = null;
      param1.alternativa3d::_parentJoint = null;
      param1.alternativa3d::setSkinFast(this);
      if(this.alternativa3d::jointList == null) {
        this.alternativa3d::jointList = param1;
      } else {
        local2 = this.alternativa3d::jointList;
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

    private function mergeJoints(param1:Joint, param2:Joint) : void {
      var local5:Joint = null;
      var local3:VertexBinding = param1.alternativa3d::vertexBindingList;
      if(local3 != null) {
        while(local3.alternativa3d::next != null) {
          local3 = local3.alternativa3d::next;
        }
        local3.alternativa3d::next = param2.alternativa3d::vertexBindingList;
        param2.alternativa3d::vertexBindingList = param1.alternativa3d::vertexBindingList;
      }
      param1.alternativa3d::vertexBindingList = null;
      var local4:Joint = param1.alternativa3d::childrenList;
      while(local4 != null) {
        if(local4.name == null || local4.name.length == 0) {
          param2.alternativa3d::addChildFast(local4);
        } else {
          local5 = this.findJointChildByName(local4.name,param2);
          if(local5 != null) {
            this.mergeJoints(local4,local5);
          } else {
            param2.alternativa3d::addChildFast(local4);
          }
        }
        local4 = local4.alternativa3d::nextJoint;
      }
      param1.alternativa3d::childrenList = null;
    }

    private function findJointChildByName(param1:String, param2:Joint) : Joint {
      var local3:Joint = param2.alternativa3d::childrenList;
      while(local3 != null) {
        if(local3.name == param1) {
          return local3;
        }
        local3 = local3.alternativa3d::nextJoint;
      }
      return null;
    }

    override public function clone() : Object3D {
      this.alternativa3d::clearLocal();
      var local1:Skin = new Skin();
      local1.clonePropertiesFrom(this);
      return local1;
    }

    override protected function clonePropertiesFrom(param1:Object3D) : void {
      var local3:Vertex = null;
      var local4:Vertex = null;
      var local6:Joint = null;
      var local7:Joint = null;
      super.clonePropertiesFrom(param1);
      var local2:Skin = param1 as Skin;
      local3 = local2.alternativa3d::vertexList;
      local4 = alternativa3d::vertexList;
      while(local3 != null) {
        local3.alternativa3d::value = local4;
        local3 = local3.alternativa3d::next;
        local4 = local4.alternativa3d::next;
      }
      var local5:Joint = local2.alternativa3d::jointList;
      while(local5 != null) {
        local7 = this.cloneJoint(local5);
        if(this.alternativa3d::jointList != null) {
          local6.alternativa3d::nextJoint = local7;
        } else {
          this.alternativa3d::jointList = local7;
        }
        local6 = local7;
        local7.alternativa3d::_parentJoint = null;
        local7.alternativa3d::setSkinFast(this);
        local5 = local5.alternativa3d::nextJoint;
      }
      local3 = local2.alternativa3d::vertexList;
      while(local3 != null) {
        local3.alternativa3d::value = null;
        local3 = local3.alternativa3d::next;
      }
    }

    override alternativa3d function draw(param1:Camera3D) : void {
      var local4:Vertex = null;
      var local5:Joint = null;
      if(alternativa3d::faceList == null) {
        return;
      }
      if(clipping == 0) {
        if(Boolean(alternativa3d::culling & 1)) {
          return;
        }
        alternativa3d::culling = 0;
      }
      var local2:int = param1.debug ? int(param1.alternativa3d::checkInDebug(this)) : 0;
      if(Boolean(local2 & Debug.BOUNDS)) {
        Debug.alternativa3d::drawBounds(param1,this,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ);
      }
      if(alternativa3d::transformId > 500000000) {
        alternativa3d::transformId = 0;
        local4 = alternativa3d::vertexList;
        while(local4 != null) {
          local4.alternativa3d::transformId = 0;
          local4 = local4.alternativa3d::next;
        }
      }
      ++alternativa3d::transformId;
      alternativa3d::calculateInverseMatrix();
      var local3:Face = this.alternativa3d::prepareFaces(param1,this.alternativa3d::localList);
      if(local3 == null) {
        return;
      }
      if(alternativa3d::culling > 0) {
        if(clipping == 1) {
          local3 = param1.alternativa3d::cull(local3,alternativa3d::culling);
        } else {
          local3 = param1.alternativa3d::clip(local3,alternativa3d::culling);
        }
        if(local3 == null) {
          return;
        }
      }
      if(local3.alternativa3d::processNext != null) {
        if(sorting == 1) {
          local3 = param1.alternativa3d::sortByAverageZ(local3);
        } else if(sorting == 2) {
          local3 = param1.alternativa3d::sortByDynamicBSP(local3,threshold);
        }
      }
      if(Boolean(local2 & Debug.BONES)) {
        local5 = this.alternativa3d::jointList;
        while(local5 != null) {
          local5.alternativa3d::drawDebug(param1);
          local5 = local5.alternativa3d::nextJoint;
        }
      }
      if(Boolean(local2 & Debug.EDGES)) {
        Debug.alternativa3d::drawEdges(param1,local3,16777215);
      }
      alternativa3d::drawFaces(param1,local3);
    }

    override alternativa3d function getVG(param1:Camera3D) : VG {
      var local4:Joint = null;
      var local5:Vertex = null;
      var local6:Face = null;
      var local7:Face = null;
      var local8:Face = null;
      if(alternativa3d::faceList == null) {
        return null;
      }
      if(clipping == 0) {
        if(Boolean(alternativa3d::culling & 1)) {
          return null;
        }
        alternativa3d::culling = 0;
      }
      var local2:int = param1.debug ? int(param1.alternativa3d::checkInDebug(this)) : 0;
      if(Boolean(local2 & Debug.BONES)) {
        local4 = this.alternativa3d::jointList;
        while(local4 != null) {
          local4.alternativa3d::drawDebug(param1);
          local4 = local4.alternativa3d::nextJoint;
        }
      }
      if(alternativa3d::transformId > 500000000) {
        alternativa3d::transformId = 0;
        local5 = alternativa3d::vertexList;
        while(local5 != null) {
          local5.alternativa3d::transformId = 0;
          local5 = local5.alternativa3d::next;
        }
      }
      ++alternativa3d::transformId;
      alternativa3d::calculateInverseMatrix();
      var local3:Face = this.alternativa3d::prepareFaces(param1,this.alternativa3d::localList);
      if(local3 == null) {
        return null;
      }
      if(alternativa3d::culling > 0) {
        if(clipping == 1) {
          local3 = param1.alternativa3d::cull(local3,alternativa3d::culling);
        } else {
          local3 = param1.alternativa3d::clip(local3,alternativa3d::culling);
        }
        if(local3 == null) {
          return null;
        }
      }
      if(alternativa3d::concatenatedAlpha >= 1 && alternativa3d::concatenatedBlendMode == "normal") {
        local8 = null;
        local6 = local3;
        local3 = null;
        while(local6 != null) {
          local7 = local6.alternativa3d::processNext;
          if(local6.material != null && !local6.material.alternativa3d::transparent) {
            local6.alternativa3d::processNext = local8;
            local8 = local6;
          } else {
            local6.alternativa3d::processNext = local3;
            local3 = local6;
          }
          local6 = local7;
        }
        local6 = local8;
        while(local6 != null) {
          local7 = local6.alternativa3d::processNext;
          if(local7 == null || local7.material != local8.material) {
            local6.alternativa3d::processNext = null;
            param1.alternativa3d::addTransparentOpaque(local8,this);
            local8 = local7;
          }
          local6 = local7;
        }
        if(local3 == null) {
          return null;
        }
      }
      return VG.alternativa3d::create(this,local3,sorting,local2,false);
    }

    override alternativa3d function prepareFaces(param1:Camera3D, param2:Face) : Face {
      var local4:Wrapper = null;
      var local5:Vertex = null;
      var local6:Vertex = null;
      var local7:Vertex = null;
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local16:Number = NaN;
      this.alternativa3d::updateLocal();
      var local3:Face = param2;
      while(local3 != null) {
        local4 = local3.alternativa3d::wrapper;
        local5 = local4.alternativa3d::vertex;
        local4 = local4.alternativa3d::next;
        local6 = local4.alternativa3d::vertex;
        local4 = local4.alternativa3d::next;
        local7 = local4.alternativa3d::vertex;
        local8 = local6.x - local5.x;
        local9 = local6.y - local5.y;
        local10 = local6.z - local5.z;
        local11 = local7.x - local5.x;
        local12 = local7.y - local5.y;
        local13 = local7.z - local5.z;
        local14 = local13 * local9 - local12 * local10;
        local15 = local11 * local10 - local13 * local8;
        local16 = local12 * local8 - local11 * local9;
        local3.alternativa3d::normalX = local14;
        local3.alternativa3d::normalY = local15;
        local3.alternativa3d::normalZ = local16;
        local3.alternativa3d::offset = local5.x * local14 + local5.y * local15 + local5.z * local16;
        local3 = local3.alternativa3d::next;
      }
      return super.alternativa3d::prepareFaces(param1,param2);
    }

    override alternativa3d function prepareResources() : void {
    }

    override alternativa3d function deleteResources() : void {
    }

    alternativa3d function updateLocal() : void {
      var local1:Vertex = null;
      var local2:Face = null;
      var local3:Face = null;
      var local6:Face = null;
      var local7:Wrapper = null;
      var local8:Wrapper = null;
      var local9:Wrapper = null;
      var local10:Material = null;
      var local11:Vertex = null;
      if(this.alternativa3d::localList == null) {
        local1 = alternativa3d::vertexList;
        while(local1 != null) {
          local1.alternativa3d::value = new Vertex();
          local1 = local1.alternativa3d::next;
        }
        local2 = alternativa3d::faceList;
        while(local2 != null) {
          local3 = new Face();
          local7 = null;
          local8 = local2.alternativa3d::wrapper;
          while(local8 != null) {
            local9 = new Wrapper();
            local9.alternativa3d::vertex = local8.alternativa3d::vertex.alternativa3d::value;
            if(local7 != null) {
              local7.alternativa3d::next = local9;
            } else {
              local3.alternativa3d::wrapper = local9;
            }
            local7 = local9;
            local8 = local8.alternativa3d::next;
          }
          if(local6 != null) {
            local6.alternativa3d::next = local3;
          } else {
            this.alternativa3d::localList = local3;
          }
          local6 = local3;
          local2 = local2.alternativa3d::next;
        }
      }
      var local4:Boolean = false;
      local2 = alternativa3d::faceList;
      local3 = this.alternativa3d::localList;
      while(local2 != null) {
        local10 = local2.material;
        local4 ||= local10 != null && Boolean(local10.alternativa3d::useVerticesNormals);
        local3.material = local2.material;
        local2 = local2.alternativa3d::next;
        local3 = local3.alternativa3d::next;
      }
      local1 = alternativa3d::vertexList;
      while(local1 != null) {
        local11 = local1.alternativa3d::value;
        local11.x = 0;
        local11.y = 0;
        local11.z = 0;
        local11.u = local1.u;
        local11.v = local1.v;
        local11.normalX = 0;
        local11.normalY = 0;
        local11.normalZ = 0;
        local11.alternativa3d::drawId = 0;
        local1 = local1.alternativa3d::next;
      }
      var local5:Joint = this.alternativa3d::jointList;
      while(local5 != null) {
        local5.alternativa3d::composeMatrix();
        local5.alternativa3d::calculateVertices(local4,false);
        local5 = local5.alternativa3d::nextJoint;
      }
    }

    alternativa3d function clearLocal() : void {
      var local1:Vertex = alternativa3d::vertexList;
      while(local1 != null) {
        local1.alternativa3d::value = null;
        local1 = local1.alternativa3d::next;
      }
      this.alternativa3d::localList = null;
    }

    override alternativa3d function updateBounds(param1:Object3D, param2:Object3D = null) : void {
      this.alternativa3d::updateLocal();
      var local3:Face = alternativa3d::faceList;
      alternativa3d::faceList = this.alternativa3d::localList;
      super.alternativa3d::updateBounds(param1,param2);
      alternativa3d::faceList = local3;
    }

    override alternativa3d function split(param1:Vector3D, param2:Vector3D, param3:Vector3D, param4:Number) : Vector.<Object3D> {
      return new Vector.<Object3D>(2);
    }

    private function cloneJoint(param1:Joint) : Joint {
      var local3:VertexBinding = null;
      var local6:Joint = null;
      var local7:VertexBinding = null;
      var local8:Joint = null;
      var local2:Joint = new Joint();
      local2.name = param1.name;
      local2.x = param1.x;
      local2.y = param1.y;
      local2.z = param1.z;
      local2.rotationX = param1.rotationX;
      local2.rotationY = param1.rotationY;
      local2.rotationZ = param1.rotationZ;
      local2.scaleX = param1.scaleX;
      local2.scaleY = param1.scaleY;
      local2.scaleZ = param1.scaleZ;
      local2.alternativa3d::bma = param1.alternativa3d::bma;
      local2.alternativa3d::bmb = param1.alternativa3d::bmb;
      local2.alternativa3d::bmc = param1.alternativa3d::bmc;
      local2.alternativa3d::bmd = param1.alternativa3d::bmd;
      local2.alternativa3d::bme = param1.alternativa3d::bme;
      local2.alternativa3d::bmf = param1.alternativa3d::bmf;
      local2.alternativa3d::bmg = param1.alternativa3d::bmg;
      local2.alternativa3d::bmh = param1.alternativa3d::bmh;
      local2.alternativa3d::bmi = param1.alternativa3d::bmi;
      local2.alternativa3d::bmj = param1.alternativa3d::bmj;
      local2.alternativa3d::bmk = param1.alternativa3d::bmk;
      local2.alternativa3d::bml = param1.alternativa3d::bml;
      if(param1 is Bone) {
        Bone(local2).length = Bone(param1).length;
        Bone(local2).alternativa3d::distance = Bone(param1).alternativa3d::distance;
        Bone(local2).alternativa3d::lx = Bone(param1).alternativa3d::lx;
        Bone(local2).alternativa3d::ly = Bone(param1).alternativa3d::ly;
        Bone(local2).alternativa3d::lz = Bone(param1).alternativa3d::lz;
        Bone(local2).alternativa3d::ldot = Bone(param1).alternativa3d::ldot;
      }
      var local4:VertexBinding = param1.alternativa3d::vertexBindingList;
      while(local4 != null) {
        local7 = new VertexBinding();
        local7.alternativa3d::vertex = local4.alternativa3d::vertex.alternativa3d::value;
        local7.alternativa3d::weight = local4.alternativa3d::weight;
        if(local3 != null) {
          local3.alternativa3d::next = local7;
        } else {
          local2.alternativa3d::vertexBindingList = local7;
        }
        local3 = local7;
        local4 = local4.alternativa3d::next;
      }
      var local5:Joint = param1.alternativa3d::childrenList;
      while(local5 != null) {
        local8 = this.cloneJoint(local5);
        if(local2.alternativa3d::childrenList != null) {
          local6.alternativa3d::nextJoint = local8;
        } else {
          local2.alternativa3d::childrenList = local8;
        }
        local6 = local8;
        local8.alternativa3d::_parentJoint = local2;
        local5 = local5.alternativa3d::nextJoint;
      }
      return local2;
    }
  }
}
