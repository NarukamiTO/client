package alternativa.engine3d.loaders.collada {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.animation.AnimationClip;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.objects.Joint;
  import alternativa.engine3d.objects.Skin;
  import alternativa.engine3d.objects.VertexBinding;
  import flash.utils.Dictionary;

  use namespace alternativa3d;
  use namespace collada;

  public class DaeController extends DaeElement {
    private var jointsBindMatrices:Vector.<Vector.<Number>>;
    private var vcounts:Array;
    private var indices:Array;
    private var jointsInput:DaeInput;
    private var weightsInput:DaeInput;
    private var inputsStride:int;

    public function DaeController(param1:XML, param2:DaeDocument) {
      super(param1,param2);
    }

    override protected function parseImplementation() : Boolean {
      var local1:XML = data.skin.vertex_weights[0];
      if(local1 == null) {
        return false;
      }
      var local2:XML = local1.vcount[0];
      if(local2 == null) {
        return false;
      }
      this.vcounts = parseIntsArray(local2);
      var local3:XML = local1.v[0];
      if(local3 == null) {
        return false;
      }
      this.indices = parseIntsArray(local3);
      this.parseInputs();
      this.parseJointsBindMatrices();
      return true;
    }

    private function parseInputs() : void {
      var local5:DaeInput = null;
      var local6:String = null;
      var local7:int = 0;
      var local1:XMLList = data.skin.vertex_weights.input;
      var local2:int = 0;
      var local3:int = 0;
      var local4:int = int(local1.length());
      for(; local3 < local4; local7 = local5.offset,local2 = local7 > local2 ? local7 : local2,local3++) {
        local5 = new DaeInput(local1[local3],document);
        local6 = local5.semantic;
        if(local6 == null) {
          continue;
        }
        switch(local6) {
          case "JOINT":
            if(this.jointsInput == null) {
              this.jointsInput = local5;
            }
            break;
          case "WEIGHT":
            if(this.weightsInput == null) {
              this.weightsInput = local5;
            }
            break;
        }
      }
      this.inputsStride = local2 + 1;
    }

    private function parseJointsBindMatrices() : void {
      var jointsXML:XML = null;
      var jointsSource:DaeSource = null;
      var stride:int = 0;
      var count:int = 0;
      var i:int = 0;
      var index:int = 0;
      var matrix:Vector.<Number> = null;
      var j:int = 0;
      jointsXML = data.skin.joints.input.(@semantic == "INV_BIND_MATRIX")[0];
      if(jointsXML != null) {
        jointsSource = document.findSource(jointsXML.@source[0]);
        if(jointsSource != null) {
          if(jointsSource.parse() && jointsSource.numbers != null && jointsSource.stride >= 16) {
            stride = jointsSource.stride;
            count = jointsSource.numbers.length / stride;
            this.jointsBindMatrices = new Vector.<Vector.<Number>>(count);
            i = 0;
            while(i < count) {
              index = stride * i;
              matrix = new Vector.<Number>(16);
              this.jointsBindMatrices[i] = matrix;
              j = 0;
              while(j < 16) {
                matrix[j] = jointsSource.numbers[int(index + j)];
                j++;
              }
              i++;
            }
          }
        } else {
          document.logger.logNotFoundError(jointsXML.@source[0]);
        }
      }
    }

    private function get geometry() : DaeGeometry {
      var local1:DaeGeometry = document.findGeometry(data.skin.@source[0]);
      if(local1 == null) {
        document.logger.logNotFoundError(data.@source[0]);
      }
      return local1;
    }

    public function parseSkin(param1:Object, param2:Vector.<DaeNode>, param3:Vector.<DaeNode>) : DaeObject {
      var local5:Skin = null;
      var local6:DaeGeometry = null;
      var local7:Vector.<Vertex> = null;
      var local8:Vector.<DaeObject> = null;
      var local4:XML = data.skin[0];
      if(local4 != null) {
        local5 = new Skin();
        local6 = this.geometry;
        if(local6 != null) {
          local6.parse();
          local7 = local6.fillInMesh(local5,param1);
          this.applyBindShapeMatrix(local5);
          local8 = this.addJointsToSkin(local5,param2,this.findNodes(param3));
          this.setJointsBindMatrices(local8);
          this.linkVerticesToJoints(local8,local7);
          local5.normalizeWeights();
          local6.cleanVertices(local5);
          local5.calculateFacesNormals(true);
          local5.calculateBounds();
          return new DaeObject(local5,this.mergeJointsClips(local5,local8));
        }
        local5.calculateFacesNormals(true);
        local5.calculateBounds();
        return new DaeObject(local5);
      }
      return null;
    }

    private function mergeJointsClips(param1:Skin, param2:Vector.<DaeObject>) : AnimationClip {
      var local7:DaeObject = null;
      var local8:AnimationClip = null;
      var local9:Object3D = null;
      var local10:int = 0;
      if(!this.hasJointsAnimation(param2)) {
        return null;
      }
      var local3:AnimationClip = new AnimationClip();
      var local4:Array = [param1];
      var local5:int = 0;
      var local6:int = int(param2.length);
      while(local5 < local6) {
        local7 = param2[local5];
        local8 = local7.animation;
        if(local8 != null) {
          local10 = 0;
          while(local10 < local8.numTracks) {
            local3.addTrack(local8.getTrackAt(local10));
            local10++;
          }
        } else {
          local3.addTrack(local7.jointNode.createStaticTransformTrack());
        }
        local9 = local7.object;
        local9.name = local7.jointNode.animName;
        local4.push(local9);
        local5++;
      }
      local3.alternativa3d::_objects = local4;
      return local3;
    }

    private function hasJointsAnimation(param1:Vector.<DaeObject>) : Boolean {
      var local4:DaeObject = null;
      var local2:int = 0;
      var local3:int = int(param1.length);
      while(local2 < local3) {
        local4 = param1[local2];
        if(local4.animation != null) {
          return true;
        }
        local2++;
      }
      return false;
    }

    private function setJointsBindMatrices(param1:Vector.<DaeObject>) : void {
      var local4:DaeObject = null;
      var local5:Vector.<Number> = null;
      var local6:Joint = null;
      var local2:int = 0;
      var local3:int = int(this.jointsBindMatrices.length);
      while(local2 < local3) {
        local4 = param1[local2];
        local5 = this.jointsBindMatrices[local2];
        local6 = local4.object as Joint;
        local6.alternativa3d::bma = local5[0];
        local6.alternativa3d::bmb = local5[1];
        local6.alternativa3d::bmc = local5[2];
        local6.alternativa3d::bmd = local5[3];
        local6.alternativa3d::bme = local5[4];
        local6.alternativa3d::bmf = local5[5];
        local6.alternativa3d::bmg = local5[6];
        local6.alternativa3d::bmh = local5[7];
        local6.alternativa3d::bmi = local5[8];
        local6.alternativa3d::bmj = local5[9];
        local6.alternativa3d::bmk = local5[10];
        local6.alternativa3d::bml = local5[11];
        local2++;
      }
    }

    private function linkVertexToJoint(param1:Joint, param2:Vertex, param3:Number) : void {
      var local4:VertexBinding = new VertexBinding();
      local4.alternativa3d::next = param1.alternativa3d::vertexBindingList;
      param1.alternativa3d::vertexBindingList = local4;
      local4.alternativa3d::vertex = param2;
      local4.alternativa3d::weight = param3;
      while(true) {
        param2 = param2.alternativa3d::value;
        if(param2 == null) {
          break;
        }
        local4 = new VertexBinding();
        local4.alternativa3d::next = param1.alternativa3d::vertexBindingList;
        param1.alternativa3d::vertexBindingList = local4;
        local4.alternativa3d::vertex = param2;
        local4.alternativa3d::weight = param3;
      }
    }

    private function linkVerticesToJoints(param1:Vector.<DaeObject>, param2:Vector.<Vertex>) : void {
      var local11:Vertex = null;
      var local12:int = 0;
      var local13:int = 0;
      var local14:int = 0;
      var local15:int = 0;
      var local16:int = 0;
      var local17:Number = NaN;
      var local3:int = this.jointsInput.offset;
      var local4:int = this.weightsInput.offset;
      var local5:DaeSource = this.weightsInput.prepareSource(1);
      var local6:Vector.<Number> = local5.numbers;
      var local7:int = local5.stride;
      var local8:int = 0;
      var local9:int = 0;
      var local10:int = int(param2.length);
      while(local9 < local10) {
        local11 = param2[local9];
        local12 = int(this.vcounts[local9]);
        local13 = 0;
        while(local13 < local12) {
          local14 = this.inputsStride * (local8 + local13);
          local15 = int(this.indices[int(local14 + local3)]);
          if(local15 >= 0) {
            local16 = int(this.indices[int(local14 + local4)]);
            local17 = local6[int(local7 * local16)];
            this.linkVertexToJoint(Joint(param1[local15].object),local11,local17);
          }
          local13++;
        }
        local8 += local12;
        local9++;
      }
    }

    private function addJointsToSkin(param1:Skin, param2:Vector.<DaeNode>, param3:Vector.<DaeNode>) : Vector.<DaeObject> {
      var local6:int = 0;
      var local9:DaeNode = null;
      var local10:DaeObject = null;
      var local4:Dictionary = new Dictionary();
      var local5:int = int(param3.length);
      local6 = 0;
      while(local6 < local5) {
        local4[param3[local6]] = local6;
        local6++;
      }
      var local7:Vector.<DaeObject> = new Vector.<DaeObject>(local5);
      var local8:int = int(param2.length);
      local6 = 0;
      while(local6 < local8) {
        local9 = param2[local6];
        local10 = this.addRootJointToSkin(param1,local9,local7,local4);
        this.addJointChildren(Joint(local10.object),local7,local9,local4);
        local6++;
      }
      return local7;
    }

    private function addRootJointToSkin(param1:Skin, param2:DaeNode, param3:Vector.<DaeObject>, param4:Dictionary) : DaeObject {
      var local5:Joint = new Joint();
      local5.name = param2.name;
      param1.addJoint(local5);
      var local6:DaeObject = param2.applyAnimation(param2.applyTransformations(local5));
      local6.jointNode = param2;
      if(param2 in param4) {
        param3[param4[param2]] = local6;
      } else {
        param3.push(local6);
      }
      return local6;
    }

    private function addJointChildren(param1:Joint, param2:Vector.<DaeObject>, param3:DaeNode, param4:Dictionary) : void {
      var local5:DaeObject = null;
      var local9:DaeNode = null;
      var local10:Joint = null;
      var local6:Vector.<DaeNode> = param3.nodes;
      var local7:int = 0;
      var local8:int = int(local6.length);
      while(local7 < local8) {
        local9 = local6[local7];
        if(local9 in param4) {
          local10 = new Joint();
          local10.name = local9.name;
          local5 = local9.applyAnimation(local9.applyTransformations(local10));
          local5.jointNode = local9;
          param2[param4[local9]] = local5;
          param1.addChild(local10);
          this.addJointChildren(local10,param2,local9,param4);
        } else if(this.hasJointInDescendants(local9,param4)) {
          local10 = new Joint();
          local10.name = local9.name;
          local5 = local9.applyAnimation(local9.applyTransformations(local10));
          local5.jointNode = local9;
          param2.push(local5);
          param1.addChild(local10);
          this.addJointChildren(local10,param2,local9,param4);
        }
        local7++;
      }
    }

    private function hasJointInDescendants(param1:DaeNode, param2:Dictionary) : Boolean {
      var local6:DaeNode = null;
      var local3:Vector.<DaeNode> = param1.nodes;
      var local4:int = 0;
      var local5:int = int(local3.length);
      while(local4 < local5) {
        local6 = local3[local4];
        if(local6 in param2 || this.hasJointInDescendants(local6,param2)) {
          return true;
        }
        local4++;
      }
      return false;
    }

    private function applyBindShapeMatrix(param1:Skin) : void {
      var local3:Array = null;
      var local4:Number = NaN;
      var local5:Number = NaN;
      var local6:Number = NaN;
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local16:Vertex = null;
      var local17:Number = NaN;
      var local18:Number = NaN;
      var local19:Number = NaN;
      var local2:XML = data.skin.bind_shape_matrix[0];
      if(local2 != null) {
        local3 = parseNumbersArray(local2);
        if(local3.length >= 16) {
          local4 = Number(local3[0]);
          local5 = Number(local3[1]);
          local6 = Number(local3[2]);
          local7 = Number(local3[3]);
          local8 = Number(local3[4]);
          local9 = Number(local3[5]);
          local10 = Number(local3[6]);
          local11 = Number(local3[7]);
          local12 = Number(local3[8]);
          local13 = Number(local3[9]);
          local14 = Number(local3[10]);
          local15 = Number(local3[11]);
          local16 = param1.alternativa3d::vertexList;
          while(local16 != null) {
            local17 = local16.x;
            local18 = local16.y;
            local19 = local16.z;
            local16.x = local4 * local17 + local5 * local18 + local6 * local19 + local7;
            local16.y = local8 * local17 + local9 * local18 + local10 * local19 + local11;
            local16.z = local12 * local17 + local13 * local18 + local14 * local19 + local15;
            local16 = local16.alternativa3d::next;
          }
        }
      }
    }

    private function isRootJointNode(param1:DaeNode, param2:Dictionary) : Boolean {
      var local3:DaeNode = param1.parent;
      while(local3 != null) {
        if(local3 in param2) {
          return false;
        }
        local3 = local3.parent;
      }
      return true;
    }

    public function findRootJointNodes(param1:Vector.<DaeNode>) : Vector.<DaeNode> {
      var local5:Dictionary = null;
      var local6:Vector.<DaeNode> = null;
      var local7:DaeNode = null;
      var local2:Vector.<DaeNode> = this.findNodes(param1);
      var local3:int = 0;
      var local4:int = int(local2.length);
      if(local4 > 0) {
        local5 = new Dictionary();
        local3 = 0;
        while(local3 < local4) {
          local5[local2[local3]] = local3;
          local3++;
        }
        local6 = new Vector.<DaeNode>();
        local3 = 0;
        while(local3 < local4) {
          local7 = local2[local3];
          if(this.isRootJointNode(local7,local5)) {
            local6.push(local7);
          }
          local3++;
        }
        return local6;
      }
      return null;
    }

    private function findNode(param1:String, param2:Vector.<DaeNode>) : DaeNode {
      var local5:DaeNode = null;
      var local3:int = int(param2.length);
      var local4:int = 0;
      while(local4 < local3) {
        local5 = param2[local4].getNodeBySid(param1);
        if(local5 != null) {
          return local5;
        }
        local4++;
      }
      return null;
    }

    private function findNodes(param1:Vector.<DaeNode>) : Vector.<DaeNode> {
      var jointsXML:XML = null;
      var jointsSource:DaeSource = null;
      var stride:int = 0;
      var count:int = 0;
      var nodes:Vector.<DaeNode> = null;
      var i:int = 0;
      var node:DaeNode = null;
      var skeletons:Vector.<DaeNode> = param1;
      jointsXML = data.skin.joints.input.(@semantic == "JOINT")[0];
      if(jointsXML != null) {
        jointsSource = document.findSource(jointsXML.@source[0]);
        if(jointsSource != null) {
          if(jointsSource.parse() && jointsSource.names != null) {
            stride = jointsSource.stride;
            count = jointsSource.names.length / stride;
            nodes = new Vector.<DaeNode>(count);
            i = 0;
            while(i < count) {
              node = this.findNode(jointsSource.names[int(stride * i)],skeletons);
              if(node == null) {
              }
              nodes[i] = node;
              i++;
            }
            return nodes;
          }
        } else {
          document.logger.logNotFoundError(jointsXML.@source[0]);
        }
      }
      return null;
    }
  }
}
