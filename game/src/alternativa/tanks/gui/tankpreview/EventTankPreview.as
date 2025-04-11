package alternativa.tanks.gui.tankpreview {
  import alternativa.engine3d.containers.KDContainer;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.tanks.service.garage.GarageService;
  import flash.geom.Vector3D;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
  import projects.tanks.clients.flash.resources.tanks.Tank3D;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;

  public class EventTankPreview extends TankPreviewWindow {
    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var garageService:GarageService;

    public function EventTankPreview() {
      super();
    }

    private function createTank() : void {
      tank = new Tank3D();
      tank.x = -75;
      tank.y = -50;
      tank.z = 150;
    }

    override protected function addGarageObjectsToScene(param1:Tanks3DSResource) : void {
      var local5:Mesh = null;
      var local6:TextureMaterial = null;
      camera.x = 0;
      var local2:int = int(param1.objects.length);
      var local3:Vector.<Object3D> = new Vector.<Object3D>();
      var local4:int = 0;
      while(local4 < local2) {
        local5 = param1.objects[local4] as Mesh;
        if(local5 != null) {
          local5.setParent(null);
          local6 = TextureMaterial(local5.faceList.material);
          local6.texture = param1.getTextureForObject(local4);
          local5.setMaterialToAllFaces(local6);
          local5.sorting = 2;
          local3.push(local5);
        }
        local4++;
      }
      kdTree = new KDContainer();
      kdTree.x = 70;
      kdTree.y = 50;
      kdTree.z = -140;
      kdTree.createTree(local3);
      this.createTank();
      createDrone(new Vector3D(150,-150,100));
      kdTree.addChild(tank);
      tank.addChild(drone);
      hangarContainer.addChild(kdTree);
    }

    override protected function createScene() : void {
    }
  }
}
