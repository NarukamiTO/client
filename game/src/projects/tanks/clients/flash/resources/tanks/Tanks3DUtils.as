package projects.tanks.clients.flash.resources.tanks {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Object3DContainer;
  import alternativa.engine3d.core.Sorting;
  import alternativa.engine3d.objects.BSP;
  import alternativa.engine3d.objects.Mesh;
  import flash.geom.Vector3D;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class Tanks3DUtils {
    public function Tanks3DUtils() {
      super();
    }

    public static function createTank3DPart(param1:Tanks3DSResource, param2:Boolean) : Tank3DPart {
      var local9:Object3D = null;
      var local10:Mesh = null;
      var local11:BSP = null;
      var local12:Object3D = null;
      var local13:int = 0;
      var local14:Object3D = null;
      var local15:Object3D = null;
      var local3:Tank3DPart = new Tank3DPart();
      var local4:Object3DContainer = new Object3DContainer();
      var local5:Vector.<Object3D> = param1.objects;
      var local6:Vector.<Object3D> = param1.parents;
      var local7:Object3D = local5[0];
      var local8:int = 0;
      while(local8 < local5.length) {
        local9 = local5[local8];
        if(local9 is Mesh && !Tank3D.EXCLUDED.test(local9.name)) {
          local10 = Mesh(local9);
          if(local10.sorting != Sorting.DYNAMIC_BSP) {
            local10.sorting = Sorting.DYNAMIC_BSP;
            local10.calculateFacesNormals(true);
            local10.optimizeForDynamicBSP();
          }
          local11 = new BSP();
          local11.createTree(Mesh(local10));
          local4.addChild(local11);
          local12 = local6[local8];
          if(local12 == null) {
            local11.x = local10.x - local7.x;
            local11.y = local10.y - local7.y;
            local11.z = local10.z - local7.z;
          } else {
            local13 = int(local5.indexOf(local12));
            local14 = local4.getChildAt(local13);
            local11.x = local10.x + local14.x;
            local11.y = local10.y + local14.y;
            local11.z = local10.z + local14.z;
          }
        }
        local8++;
      }
      local3.view = local4;
      local3.lightmap = param1.textures["lightmap.jpg"];
      local3.details = param1.textures["details.png"];
      if(param2) {
        local15 = local5[1];
        local3.turretMountPoint = new Vector3D(local15.x,local15.y,local15.z);
      }
      return local3;
    }
  }
}
