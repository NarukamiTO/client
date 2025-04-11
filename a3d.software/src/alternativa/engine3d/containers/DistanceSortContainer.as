package alternativa.engine3d.containers {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Canvas;
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

    override alternativa3d function drawVisibleChildren(param1:Camera3D, param2:Canvas) : void {
      var local3:int = 0;
      var local4:int = 0;
      var local5:Object3D = null;
      var local8:int = 0;
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local6:int = 0;
      var local7:int = alternativa3d::numVisibleChildren - 1;
      sortingStack[0] = local6;
      sortingStack[1] = local7;
      local8 = 2;
      if(this.sortByZ) {
        while(local8 > 0) {
          local7 = sortingStack[--local8];
          local6 = sortingStack[--local8];
          local4 = local7;
          local3 = local6;
          local5 = alternativa3d::visibleChildren[local7 + local6 >> 1];
          local10 = Number(local5.alternativa3d::ml);
          do {
            while(true) {
              local9 = Number((alternativa3d::visibleChildren[local3] as Object3D).alternativa3d::ml);
              if(local9 <= local10) {
                break;
              }
              local3++;
            }
            while(true) {
              local11 = Number((alternativa3d::visibleChildren[local4] as Object3D).alternativa3d::ml);
              if(local11 >= local10) {
                break;
              }
              local4--;
            }
            if(local3 <= local4) {
              local5 = alternativa3d::visibleChildren[local3];
              var local14:* = local3++;
              alternativa3d::visibleChildren[local14] = alternativa3d::visibleChildren[local4];
              var local15:* = local4--;
              alternativa3d::visibleChildren[local15] = local5;
            }
          }
          while(local3 <= local4);
          if(local6 < local4) {
            local14 = local8++;
            sortingStack[local14] = local6;
            local15 = local8++;
            sortingStack[local15] = local4;
          }
          if(local3 < local7) {
            local14 = local8++;
            sortingStack[local14] = local3;
            local15 = local8++;
            sortingStack[local15] = local7;
          }
        }
      } else {
        local3 = 0;
        while(local3 < alternativa3d::numVisibleChildren) {
          local5 = alternativa3d::visibleChildren[local3];
          local12 = local5.alternativa3d::md * param1.alternativa3d::viewSizeX / param1.alternativa3d::focalLength;
          local13 = local5.alternativa3d::mh * param1.alternativa3d::viewSizeY / param1.alternativa3d::focalLength;
          local5.alternativa3d::distance = local12 * local12 + local13 * local13 + local5.alternativa3d::ml * local5.alternativa3d::ml;
          local3++;
        }
        while(local8 > 0) {
          local7 = sortingStack[--local8];
          local6 = sortingStack[--local8];
          local4 = local7;
          local3 = local6;
          local5 = alternativa3d::visibleChildren[local7 + local6 >> 1];
          local10 = Number(local5.alternativa3d::distance);
          do {
            while(true) {
              local9 = Number((alternativa3d::visibleChildren[local3] as Object3D).alternativa3d::distance);
              if(local9 <= local10) {
                break;
              }
              local3++;
            }
            while(true) {
              local11 = Number((alternativa3d::visibleChildren[local4] as Object3D).alternativa3d::distance);
              if(local11 >= local10) {
                break;
              }
              local4--;
            }
            if(local3 <= local4) {
              local5 = alternativa3d::visibleChildren[local3];
              local14 = local3++;
              alternativa3d::visibleChildren[local14] = alternativa3d::visibleChildren[local4];
              local15 = local4--;
              alternativa3d::visibleChildren[local15] = local5;
            }
          }
          while(local3 <= local4);

          if(local6 < local4) {
            local14 = local8++;
            sortingStack[local14] = local6;
            local15 = local8++;
            sortingStack[local15] = local4;
          }
          if(local3 < local7) {
            local14 = local8++;
            sortingStack[local14] = local3;
            local15 = local8++;
            sortingStack[local15] = local7;
          }
        }
      }
      local3 = alternativa3d::numVisibleChildren - 1;
      while(local3 >= 0) {
        local5 = alternativa3d::visibleChildren[local3];
        local5.alternativa3d::draw(param1,param2);
        alternativa3d::visibleChildren[local3] = null;
        local3--;
      }
    }
  }
}
