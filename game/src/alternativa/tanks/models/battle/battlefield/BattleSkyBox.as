package alternativa.tanks.models.battle.battlefield {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.SkyBox;
  import projects.tanks.client.battlefield.models.map.SkyboxSides;

  public class BattleSkyBox extends SkyBox {
    private static const SKYBOX_SIZE:int = 200000;

    public function BattleSkyBox(param1:SkyboxSides) {
      var local2:TextureMaterial = new TextureMaterial(param1.left.data);
      var local3:TextureMaterial = new TextureMaterial(param1.right.data);
      var local4:TextureMaterial = new TextureMaterial(param1.front.data);
      var local5:TextureMaterial = new TextureMaterial(param1.back.data);
      var local6:TextureMaterial = new TextureMaterial(param1.top.data);
      var local7:TextureMaterial = new TextureMaterial(param1.bottom.data);
      super(SKYBOX_SIZE,local2,local3,local5,local4,local7,local6,0);
    }
  }
}
