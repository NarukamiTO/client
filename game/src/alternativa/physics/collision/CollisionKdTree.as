package alternativa.physics.collision {
  import alternativa.physics.collision.types.AABB;

  public class CollisionKdTree {
    private static const nodeBoundBoxThreshold:AABB = new AABB();
    private static const splitCoordsX:Vector.<Number> = new Vector.<Number>();
    private static const splitCoordsY:Vector.<Number> = new Vector.<Number>();
    private static const splitCoordsZ:Vector.<Number> = new Vector.<Number>();
    private static const _nodeBB:Vector.<Number> = new Vector.<Number>(6);
    private static const _bb:Vector.<Number> = new Vector.<Number>(6);

    public var threshold:Number = 0.1;
    public var minPrimitivesPerNode:int = 1;
    public var rootNode:CollisionKdNode;
    public var staticChildren:Vector.<CollisionShape>;
    public var numStaticChildren:int;
    public var staticBoundBoxes:Vector.<AABB> = new Vector.<AABB>();

    private var splitAxis:int;
    private var splitCoord:Number;
    private var splitCost:Number;

    public function CollisionKdTree() {
      super();
    }

    public function createTree(param1:Vector.<CollisionShape>, param2:AABB = null) : void {
      var local5:CollisionShape = null;
      var local6:AABB = null;
      this.staticChildren = param1.concat();
      this.numStaticChildren = this.staticChildren.length;
      this.rootNode = new CollisionKdNode();
      this.rootNode.indices = new Vector.<int>();
      var local3:AABB = this.rootNode.boundBox = param2 != null ? param2 : new AABB();
      var local4:int = 0;
      while(local4 < this.numStaticChildren) {
        local5 = this.staticChildren[local4];
        local6 = this.staticBoundBoxes[local4] = local5.calculateAABB();
        local3.addBoundBox(local6);
        this.rootNode.indices[local4] = local4;
        local4++;
      }
      this.staticBoundBoxes.length = this.numStaticChildren;
      this.splitNode(this.rootNode);
      splitCoordsX.length = splitCoordsY.length = splitCoordsZ.length = 0;
    }

    private function splitNode(param1:CollisionKdNode) : void {
      var local4:AABB = null;
      var local6:int = 0;
      var local7:int = 0;
      var local15:AABB = null;
      var local16:Number = NaN;
      var local17:Number = NaN;
      var local2:Vector.<int> = param1.indices;
      var local3:int = int(local2.length);
      if(local3 <= this.minPrimitivesPerNode) {
        return;
      }
      local4 = param1.boundBox;
      nodeBoundBoxThreshold.minX = local4.minX + this.threshold;
      nodeBoundBoxThreshold.minY = local4.minY + this.threshold;
      nodeBoundBoxThreshold.minZ = local4.minZ + this.threshold;
      nodeBoundBoxThreshold.maxX = local4.maxX - this.threshold;
      nodeBoundBoxThreshold.maxY = local4.maxY - this.threshold;
      nodeBoundBoxThreshold.maxZ = local4.maxZ - this.threshold;
      var local5:Number = this.threshold * 2;
      var local8:int = 0;
      var local9:int = 0;
      var local10:int = 0;
      local6 = 0;
      while(local6 < local3) {
        local15 = this.staticBoundBoxes[local2[local6]];
        if(local15.maxX - local15.minX <= local5) {
          if(local15.minX <= nodeBoundBoxThreshold.minX) {
            var local18:* = local8++;
            splitCoordsX[local18] = local4.minX;
          } else if(local15.maxX >= nodeBoundBoxThreshold.maxX) {
            local18 = local8++;
            splitCoordsX[local18] = local4.maxX;
          } else {
            local18 = local8++;
            splitCoordsX[local18] = (local15.minX + local15.maxX) * 0.5;
          }
        } else {
          if(local15.minX > nodeBoundBoxThreshold.minX) {
            local18 = local8++;
            splitCoordsX[local18] = local15.minX;
          }
          if(local15.maxX < nodeBoundBoxThreshold.maxX) {
            local18 = local8++;
            splitCoordsX[local18] = local15.maxX;
          }
        }
        if(local15.maxY - local15.minY <= local5) {
          if(local15.minY <= nodeBoundBoxThreshold.minY) {
            local18 = local9++;
            splitCoordsY[local18] = local4.minY;
          } else if(local15.maxY >= nodeBoundBoxThreshold.maxY) {
            local18 = local9++;
            splitCoordsY[local18] = local4.maxY;
          } else {
            local18 = local9++;
            splitCoordsY[local18] = (local15.minY + local15.maxY) * 0.5;
          }
        } else {
          if(local15.minY > nodeBoundBoxThreshold.minY) {
            local18 = local9++;
            splitCoordsY[local18] = local15.minY;
          }
          if(local15.maxY < nodeBoundBoxThreshold.maxY) {
            local18 = local9++;
            splitCoordsY[local18] = local15.maxY;
          }
        }
        if(local15.maxZ - local15.minZ <= local5) {
          if(local15.minZ <= nodeBoundBoxThreshold.minZ) {
            local18 = local10++;
            splitCoordsZ[local18] = local4.minZ;
          } else if(local15.maxZ >= nodeBoundBoxThreshold.maxZ) {
            local18 = local10++;
            splitCoordsZ[local18] = local4.maxZ;
          } else {
            local18 = local10++;
            splitCoordsZ[local18] = (local15.minZ + local15.maxZ) * 0.5;
          }
        } else {
          if(local15.minZ > nodeBoundBoxThreshold.minZ) {
            local18 = local10++;
            splitCoordsZ[local18] = local15.minZ;
          }
          if(local15.maxZ < nodeBoundBoxThreshold.maxZ) {
            local18 = local10++;
            splitCoordsZ[local18] = local15.maxZ;
          }
        }
        local6++;
      }
      this.splitAxis = -1;
      this.splitCost = 1e+308;
      _nodeBB[0] = local4.minX;
      _nodeBB[1] = local4.minY;
      _nodeBB[2] = local4.minZ;
      _nodeBB[3] = local4.maxX;
      _nodeBB[4] = local4.maxY;
      _nodeBB[5] = local4.maxZ;
      this.checkNodeAxis(param1,0,local8,splitCoordsX,_nodeBB);
      this.checkNodeAxis(param1,1,local9,splitCoordsY,_nodeBB);
      this.checkNodeAxis(param1,2,local10,splitCoordsZ,_nodeBB);
      if(this.splitAxis < 0) {
        return;
      }
      var local11:Boolean = this.splitAxis == 0;
      var local12:Boolean = this.splitAxis == 1;
      param1.axis = this.splitAxis;
      param1.coord = this.splitCoord;
      param1.negativeNode = new CollisionKdNode();
      param1.negativeNode.parent = param1;
      param1.negativeNode.boundBox = local4.clone();
      param1.positiveNode = new CollisionKdNode();
      param1.positiveNode.parent = param1;
      param1.positiveNode.boundBox = local4.clone();
      if(local11) {
        param1.negativeNode.boundBox.maxX = param1.positiveNode.boundBox.minX = this.splitCoord;
      } else if(local12) {
        param1.negativeNode.boundBox.maxY = param1.positiveNode.boundBox.minY = this.splitCoord;
      } else {
        param1.negativeNode.boundBox.maxZ = param1.positiveNode.boundBox.minZ = this.splitCoord;
      }
      var local13:Number = this.splitCoord - this.threshold;
      var local14:Number = this.splitCoord + this.threshold;
      local6 = 0;
      while(local6 < local3) {
        local15 = this.staticBoundBoxes[local2[local6]];
        local16 = local11 ? local15.minX : (local12 ? local15.minY : local15.minZ);
        local17 = local11 ? local15.maxX : (local12 ? local15.maxY : local15.maxZ);
        if(local17 <= local14) {
          if(local16 < local13) {
            if(param1.negativeNode.indices == null) {
              param1.negativeNode.indices = new Vector.<int>();
            }
            param1.negativeNode.indices.push(local2[local6]);
            local2[local6] = -1;
          } else {
            if(param1.splitIndices == null) {
              param1.splitIndices = new Vector.<int>();
            }
            param1.splitIndices.push(local2[local6]);
            local2[local6] = -1;
          }
        } else if(local16 >= local13) {
          if(param1.positiveNode.indices == null) {
            param1.positiveNode.indices = new Vector.<int>();
          }
          param1.positiveNode.indices.push(local2[local6]);
          local2[local6] = -1;
        }
        local6++;
      }
      local6 = 0;
      local7 = 0;
      while(local6 < local3) {
        if(local2[local6] >= 0) {
          local18 = local7++;
          local2[local18] = local2[local6];
        }
        local6++;
      }
      if(local7 > 0) {
        local2.length = local7;
      } else {
        param1.indices = null;
      }
      if(param1.splitIndices != null) {
        param1.splitTree = new CollisionKdTree2D(this,param1);
        param1.splitTree.createTree();
      }
      if(param1.negativeNode.indices != null) {
        this.splitNode(param1.negativeNode);
      }
      if(param1.positiveNode.indices != null) {
        this.splitNode(param1.positiveNode);
      }
    }

    private function checkNodeAxis(param1:CollisionKdNode, param2:int, param3:int, param4:Vector.<Number>, param5:Vector.<Number>) : void {
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:int = 0;
      var local16:int = 0;
      var local17:Boolean = false;
      var local18:int = 0;
      var local19:int = 0;
      var local20:Number = NaN;
      var local21:AABB = null;
      var local6:int = (param2 + 1) % 3;
      var local7:int = (param2 + 2) % 3;
      var local8:Number = (param5[local6 + 3] - param5[local6]) * (param5[local7 + 3] - param5[local7]);
      var local9:int = 0;
      while(local9 < param3) {
        local10 = param4[local9];
        if(!isNaN(local10)) {
          local11 = local10 - this.threshold;
          local12 = local10 + this.threshold;
          local13 = local8 * (local10 - param5[param2]);
          local14 = local8 * (param5[int(param2 + 3)] - local10);
          local15 = 0;
          local16 = 0;
          local17 = false;
          local18 = int(param1.indices.length);
          local19 = 0;
          while(local19 < local18) {
            local21 = this.staticBoundBoxes[param1.indices[local19]];
            _bb[0] = local21.minX;
            _bb[1] = local21.minY;
            _bb[2] = local21.minZ;
            _bb[3] = local21.maxX;
            _bb[4] = local21.maxY;
            _bb[5] = local21.maxZ;
            if(_bb[param2 + 3] <= local12) {
              if(_bb[param2] < local11) {
                local15++;
              }
            } else {
              if(_bb[param2] < local11) {
                local17 = true;
                break;
              }
              local16++;
            }
            local19++;
          }
          local20 = local13 * local15 + local14 * local16;
          if(!local17 && local20 < this.splitCost && local15 > 0 && local16 > 0) {
            this.splitAxis = param2;
            this.splitCost = local20;
            this.splitCoord = local10;
          }
          local19 = local9 + 1;
          while(local19 < param3) {
            if(param4[local19] >= local10 - this.threshold && param4[local19] <= local10 + this.threshold) {
              param4[local19] = NaN;
            }
            local19++;
          }
        }
        local9++;
      }
    }

    public function traceTree() : void {
      this.traceNode("",this.rootNode);
    }

    private function traceNode(param1:String, param2:CollisionKdNode) : void {
      if(param2 == null) {
        return;
      }
      this.traceNode(param1 + "-",param2.negativeNode);
      this.traceNode(param1 + "+",param2.positiveNode);
    }

    public function destroyTree() : void {
      if(Boolean(this.rootNode)) {
        this.rootNode.destroy();
        this.rootNode = null;
      }
      if(Boolean(this.staticChildren)) {
        this.staticChildren.length = 0;
        this.staticChildren = null;
      }
      this.staticBoundBoxes.length = 0;
    }
  }
}
