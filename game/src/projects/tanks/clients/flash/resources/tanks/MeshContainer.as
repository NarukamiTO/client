package projects.tanks.clients.flash.resources.tanks {
  import alternativa.engine3d.core.Object3DContainer;
  import alternativa.engine3d.objects.Mesh;

  public class MeshContainer extends Object3DContainer {
    private var meshes:Vector.<Mesh> = new Vector.<Mesh>();

    public function MeshContainer() {
      super();
    }

    public function getMeshes() : Vector.<Mesh> {
      return this.meshes;
    }

    public function setMeshes(param1:Vector.<Mesh>) : void {
      this.meshes.push(param1[0]);
      addChild(param1[0]);
      param1[0].x = 0;
      param1[0].y = 0;
      param1[0].z = 0;
      if(param1.length == 1) {
        return;
      }
      var local2:Object3DContainer = new Object3DContainer();
      addChild(local2);
      local2.x = param1[1].x;
      local2.y = param1[1].y;
      local2.z = param1[1].z;
      param1[1].x = 0;
      param1[1].y = 0;
      param1[1].z = 0;
      var local3:int = 1;
      while(local3 < param1.length) {
        local2.addChild(param1[local3]);
        this.meshes.push(param1[local3]);
        local3++;
      }
    }
  }
}
