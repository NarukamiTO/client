package alternativa.engine3d.containers {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Object3DContainer;

  use namespace alternativa3d;

  public class DistanceSortContainer extends Object3DContainer {
    private static const sortingStack:Vector.<int> = new Vector.<int>();

    public var sortByZ:Boolean = false;

    public function DistanceSortContainer() {
      super();
    }

    override public function clone() : Object3D {
      var local1:DistanceSortContainer = new DistanceSortContainer();
      local1.clonePropertiesFrom(this);
      return local1;
    }

    override protected function clonePropertiesFrom(param1:Object3D) : void {
      super.clonePropertiesFrom(param1);
      var local2:DistanceSortContainer = param1 as DistanceSortContainer;
      this.sortByZ = local2.sortByZ;
    }

    override alternativa3d function drawVisibleChildren(param1:Camera3D) : void {
      var local2:int = 0;
      var local3:int = 0;
      var local4:Object3D = null;
      var local7:int = 0;
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local5:int = 0;
      var local6:int = alternativa3d::numVisibleChildren - 1;
      sortingStack[0] = local5;
      sortingStack[1] = local6;
      local7 = 2;
      if(this.sortByZ) {
        while(local7 > 0) {
          local6 = sortingStack[--local7];
          local5 = sortingStack[--local7];
          local3 = local6;
          local2 = local5;
          local4 = alternativa3d::visibleChildren[local6 + local5 >> 1];
          local9 = Number(local4.alternativa3d::ml);
          do {
            while(true) {
              local8 = Number((alternativa3d::visibleChildren[local2] as Object3D).alternativa3d::ml);
              if(local8 <= local9) {
                break;
              }
              local2++;
            }
            while(true) {
              local10 = Number((alternativa3d::visibleChildren[local3] as Object3D).alternativa3d::ml);
              if(local10 >= local9) {
                break;
              }
              local3--;
            }
            if(local2 <= local3) {
              local4 = alternativa3d::visibleChildren[local2];
              var local13:* = local2++;
              alternativa3d::visibleChildren[local13] = alternativa3d::visibleChildren[local3];
              var local14:* = local3--;
              alternativa3d::visibleChildren[local14] = local4;
            }
          }
          while(local2 <= local3);
          if(local5 < local3) {
            local13 = local7++;
            sortingStack[local13] = local5;
            local14 = local7++;
            sortingStack[local14] = local3;
          }
          if(local2 < local6) {
            local13 = local7++;
            sortingStack[local13] = local2;
            local14 = local7++;
            sortingStack[local14] = local6;
          }
        }
      } else {
        local2 = 0;
        while(local2 < alternativa3d::numVisibleChildren) {
          local4 = alternativa3d::visibleChildren[local2];
          local11 = local4.alternativa3d::md * param1.alternativa3d::viewSizeX / param1.alternativa3d::focalLength;
          local12 = local4.alternativa3d::mh * param1.alternativa3d::viewSizeY / param1.alternativa3d::focalLength;
          local4.alternativa3d::distance = local11 * local11 + local12 * local12 + local4.alternativa3d::ml * local4.alternativa3d::ml;
          local2++;
        }
        while(local7 > 0) {
          local6 = sortingStack[--local7];
          local5 = sortingStack[--local7];
          local3 = local6;
          local2 = local5;
          local4 = alternativa3d::visibleChildren[local6 + local5 >> 1];
          local9 = Number(local4.alternativa3d::distance);
          do {
            while(true) {
              local8 = Number((alternativa3d::visibleChildren[local2] as Object3D).alternativa3d::distance);
              if(local8 <= local9) {
                break;
              }
              local2++;
            }
            while(true) {
              local10 = Number((alternativa3d::visibleChildren[local3] as Object3D).alternativa3d::distance);
              if(local10 >= local9) {
                break;
              }
              local3--;
            }
            if(local2 <= local3) {
              local4 = alternativa3d::visibleChildren[local2];
              local13 = local2++;
              alternativa3d::visibleChildren[local13] = alternativa3d::visibleChildren[local3];
              local14 = local3--;
              alternativa3d::visibleChildren[local14] = local4;
            }
          }
          while(local2 <= local3);

          if(local5 < local3) {
            local13 = local7++;
            sortingStack[local13] = local5;
            local14 = local7++;
            sortingStack[local14] = local3;
          }
          if(local2 < local6) {
            local13 = local7++;
            sortingStack[local13] = local2;
            local14 = local7++;
            sortingStack[local14] = local6;
          }
        }
      }
      local2 = alternativa3d::numVisibleChildren - 1;
      while(local2 >= 0) {
        local4 = alternativa3d::visibleChildren[local2];
        local4.alternativa3d::concat(this);
        local4.alternativa3d::draw(param1);
        alternativa3d::visibleChildren[local2] = null;
        local2--;
      }
    }
  }
}
