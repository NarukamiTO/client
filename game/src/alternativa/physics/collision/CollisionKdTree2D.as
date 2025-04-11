package alternativa.physics.collision {
  import alternativa.physics.collision.types.AABB;

  public class CollisionKdTree2D {
    private static const nodeBoundBoxThreshold:AABB = new AABB();
    private static const splitCoordsX:Vector.<Number> = new Vector.<Number>();
    private static const splitCoordsY:Vector.<Number> = new Vector.<Number>();
    private static const splitCoordsZ:Vector.<Number> = new Vector.<Number>();
    private static const _nodeBB:Vector.<Number> = new Vector.<Number>(6);
    private static const _bb:Vector.<Number> = new Vector.<Number>(6);

    public var threshold:Number = 0.1;
    public var minPrimitivesPerNode:int = 1;
    public var parentTree:CollisionKdTree;
    public var parentNode:CollisionKdNode;
    public var rootNode:CollisionKdNode;

    private var splitAxis:int;
    private var splitCost:Number;
    private var splitCoord:Number;

    public function CollisionKdTree2D(param1:CollisionKdTree, param2:CollisionKdNode) {
      super();
      this.parentTree = param1;
      this.parentNode = param2;
    }

    public function createTree() : void {
      this.rootNode = new CollisionKdNode();
      this.rootNode.boundBox = this.parentNode.boundBox.clone();
      this.rootNode.indices = new Vector.<int>();
      var local1:int = int(this.parentNode.splitIndices.length);
      var local2:int = 0;
      while(local2 < local1) {
        this.rootNode.indices[local2] = this.parentNode.splitIndices[local2];
        local2++;
      }
      this.splitNode(this.rootNode);
      splitCoordsX.length = splitCoordsY.length = splitCoordsZ.length = 0;
    }

    private function splitNode(param1:CollisionKdNode) : void {
      var local2:Vector.<int> = null;
      var local3:int = 0;
      var local4:int = 0;
      var local5:AABB = null;
      var local8:int = 0;
      var local9:int = 0;
      var local10:int = 0;
      var local16:AABB = null;
      var local17:Number = NaN;
      var local18:Number = NaN;
      if(param1.indices.length <= this.minPrimitivesPerNode) {
        return;
      }
      local2 = param1.indices;
      local5 = param1.boundBox;
      nodeBoundBoxThreshold.minX = local5.minX + this.threshold;
      nodeBoundBoxThreshold.minY = local5.minY + this.threshold;
      nodeBoundBoxThreshold.minZ = local5.minZ + this.threshold;
      nodeBoundBoxThreshold.maxX = local5.maxX - this.threshold;
      nodeBoundBoxThreshold.maxY = local5.maxY - this.threshold;
      nodeBoundBoxThreshold.maxZ = local5.maxZ - this.threshold;
      var local6:Number = this.threshold * 2;
      var local7:Vector.<AABB> = this.parentTree.staticBoundBoxes;
      var local11:int = int(local2.length);
      local3 = 0;
      while(local3 < local11) {
        local16 = local7[local2[local3]];
        if(this.parentNode.axis != 0) {
          if(local16.minX > nodeBoundBoxThreshold.minX) {
            var local19:* = local8++;
            splitCoordsX[local19] = local16.minX;
          }
          if(local16.maxX < nodeBoundBoxThreshold.maxX) {
            local19 = local8++;
            splitCoordsX[local19] = local16.maxX;
          }
        }
        if(this.parentNode.axis != 1) {
          if(local16.minY > nodeBoundBoxThreshold.minY) {
            local19 = local9++;
            splitCoordsY[local19] = local16.minY;
          }
          if(local16.maxY < nodeBoundBoxThreshold.maxY) {
            local19 = local9++;
            splitCoordsY[local19] = local16.maxY;
          }
        }
        if(this.parentNode.axis != 2) {
          if(local16.minZ > nodeBoundBoxThreshold.minZ) {
            local19 = local10++;
            splitCoordsZ[local19] = local16.minZ;
          }
          if(local16.maxZ < nodeBoundBoxThreshold.maxZ) {
            local19 = local10++;
            splitCoordsZ[local19] = local16.maxZ;
          }
        }
        local3++;
      }
      this.splitAxis = -1;
      this.splitCost = 1e+308;
      _nodeBB[0] = local5.minX;
      _nodeBB[1] = local5.minY;
      _nodeBB[2] = local5.minZ;
      _nodeBB[3] = local5.maxX;
      _nodeBB[4] = local5.maxY;
      _nodeBB[5] = local5.maxZ;
      if(this.parentNode.axis != 0) {
        this.checkNodeAxis(param1,0,local8,splitCoordsX,_nodeBB);
      }
      if(this.parentNode.axis != 1) {
        this.checkNodeAxis(param1,1,local9,splitCoordsY,_nodeBB);
      }
      if(this.parentNode.axis != 2) {
        this.checkNodeAxis(param1,2,local10,splitCoordsZ,_nodeBB);
      }
      if(this.splitAxis < 0) {
        return;
      }
      var local12:Boolean = this.splitAxis == 0;
      var local13:Boolean = this.splitAxis == 1;
      param1.axis = this.splitAxis;
      param1.coord = this.splitCoord;
      param1.negativeNode = new CollisionKdNode();
      param1.negativeNode.parent = param1;
      param1.negativeNode.boundBox = local5.clone();
      param1.positiveNode = new CollisionKdNode();
      param1.positiveNode.parent = param1;
      param1.positiveNode.boundBox = local5.clone();
      if(local12) {
        param1.negativeNode.boundBox.maxX = param1.positiveNode.boundBox.minX = this.splitCoord;
      } else if(local13) {
        param1.negativeNode.boundBox.maxY = param1.positiveNode.boundBox.minY = this.splitCoord;
      } else {
        param1.negativeNode.boundBox.maxZ = param1.positiveNode.boundBox.minZ = this.splitCoord;
      }
      var local14:Number = this.splitCoord - this.threshold;
      var local15:Number = this.splitCoord + this.threshold;
      local3 = 0;
      while(local3 < local11) {
        local16 = local7[local2[local3]];
        local17 = local12 ? local16.minX : (local13 ? local16.minY : local16.minZ);
        local18 = local12 ? local16.maxX : (local13 ? local16.maxY : local16.maxZ);
        if(local18 <= local15) {
          if(local17 < local14) {
            if(param1.negativeNode.indices == null) {
              param1.negativeNode.indices = new Vector.<int>();
            }
            param1.negativeNode.indices.push(local2[local3]);
            local2[local3] = -1;
          }
        } else if(local17 >= local14) {
          if(local18 > local15) {
            if(param1.positiveNode.indices == null) {
              param1.positiveNode.indices = new Vector.<int>();
            }
            param1.positiveNode.indices.push(local2[local3]);
            local2[local3] = -1;
          }
        }
        local3++;
      }
      local3 = 0;
      local4 = 0;
      while(local3 < local11) {
        if(local2[local3] >= 0) {
          local19 = local4++;
          local2[local19] = local2[local3];
        }
        local3++;
      }
      if(local4 > 0) {
        local2.length = local4;
      } else {
        param1.indices = null;
      }
      if(param1.negativeNode.indices != null) {
        this.splitNode(param1.negativeNode);
      }
      if(param1.positiveNode.indices != null) {
        this.splitNode(param1.positiveNode);
      }
    }

    private function checkNodeAxis(param1:CollisionKdNode, param2:int, param3:int, param4:Vector.<Number>, param5:Vector.<Number>) : void {
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local16:int = 0;
      var local17:int = 0;
      var local18:Boolean = false;
      var local19:int = 0;
      var local20:int = 0;
      var local21:Number = NaN;
      var local22:AABB = null;
      var local6:int = (param2 + 1) % 3;
      var local7:int = (param2 + 2) % 3;
      var local8:Number = (param5[local6 + 3] - param5[local6]) * (param5[local7 + 3] - param5[local7]);
      var local9:Vector.<AABB> = this.parentTree.staticBoundBoxes;
      var local10:int = 0;
      while(local10 < param3) {
        local11 = param4[local10];
        if(!isNaN(local11)) {
          local12 = local11 - this.threshold;
          local13 = local11 + this.threshold;
          local14 = local8 * (local11 - param5[param2]);
          local15 = local8 * (param5[int(param2 + 3)] - local11);
          local16 = 0;
          local17 = 0;
          local18 = false;
          local19 = int(param1.indices.length);
          local20 = 0;
          while(local20 < local19) {
            local22 = local9[param1.indices[local20]];
            _bb[0] = local22.minX;
            _bb[1] = local22.minY;
            _bb[2] = local22.minZ;
            _bb[3] = local22.maxX;
            _bb[4] = local22.maxY;
            _bb[5] = local22.maxZ;
            if(_bb[param2 + 3] <= local13) {
              if(_bb[param2] < local12) {
                local16++;
              }
            } else {
              if(_bb[param2] < local12) {
                local18 = true;
                break;
              }
              local17++;
            }
            local20++;
          }
          local21 = local14 * local16 + local15 * local17;
          if(!local18 && local21 < this.splitCost && local16 > 0 && local17 > 0) {
            this.splitAxis = param2;
            this.splitCost = local21;
            this.splitCoord = local11;
          }
          local20 = local10 + 1;
          while(local20 < param3) {
            if(param4[local20] >= local11 - this.threshold && param4[local20] <= local11 + this.threshold) {
              param4[local20] = NaN;
            }
            local20++;
          }
        }
        local10++;
      }
    }

    public function destroyTree() : void {
      this.parentTree = null;
      this.parentNode = null;
      if(Boolean(this.rootNode)) {
        this.rootNode.destroy();
        this.rootNode = null;
      }
    }
  }
}
