package alternativa.tanks.models.battle.facilities {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.materials.PaintMaterial;
  import flash.display.BitmapData;
  import flash.geom.Vector3D;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.battle.battlefield.facilities.facillity.CommonFacilityCC;
  import projects.tanks.client.battlefield.models.battle.battlefield.facilities.facillity.CommonFacilityModelBase;
  import projects.tanks.client.battlefield.models.battle.battlefield.facilities.facillity.ICommonFacilityModelBase;
  import projects.tanks.client.battlefield.types.Vector3d;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.clients.flash.commons.models.coloring.IColoring;

  [ModelInfo]
  public class CommonFacilityModel extends CommonFacilityModelBase implements ICommonFacilityModelBase, ObjectLoadListener, ObjectUnloadListener, ICommonFacility {
    [Inject]
    public static var battleService:BattleService;

    private static const LIGHTMAP_TEXTURE_NAME:String = "lightmap.jpg";

    public function CommonFacilityModel() {
      super();
    }

    public function objectLoaded() : void {
      var local1:CommonFacilityCC = getInitParam();
      var local2:Object3D = this.createVisual(local1);
      BattleUtils.setObjectPosition3d(local2,local1.position);
      BattleUtils.setObjectRotation3d(local2,local1.rotation);
      putData(CommonFacilityData,new CommonFacilityData(local2));
      battleService.getBattleScene3D().addObject(local2);
      this.battleFacilities().register(object);
    }

    private function createVisual(param1:CommonFacilityCC) : Object3D {
      var local3:Mesh = null;
      var local2:Mesh = param1.facilityObject.objects[0] as Mesh;
      local3 = local2.clone() as Mesh;
      var local4:BitmapData = param1.facilityObject.textures[LIGHTMAP_TEXTURE_NAME];
      var local5:IColoring = IColoring(object.adapt(IColoring));
      var local6:PaintMaterial = FacilityMaterialFactory.createMaterial(local4,param1.facilityTexture.data,local5);
      local3.setMaterialToAllFaces(local6);
      local3.useShadowMap = param1.useShadows;
      local3.useLight = param1.useLight;
      return local3;
    }

    private function battleFacilities() : BattleFacilities {
      return BattleFacilities(object.space.rootObject.adapt(BattleFacilities));
    }

    public function markAsDispelled() : void {
      this.getFacilityData().isDispelled = true;
    }

    private function getFacilityData() : CommonFacilityData {
      return CommonFacilityData(getData(CommonFacilityData));
    }

    public function objectUnloaded() : void {
      this.battleFacilities().unregister(object);
      var local1:CommonFacilityData = this.getFacilityData();
      battleService.getBattleScene3D().removeObject(local1.object3d);
      if(local1.isDispelled) {
        this.facilityDispellEffects().createDispellEffects(this.getPosition());
      }
    }

    private function facilityDispellEffects() : FacilityDispellEffect {
      return FacilityDispellEffect(object.event(FacilityDispellEffect));
    }

    public function getPosition() : Vector3 {
      var local1:Object3D = this.getFacilityData().object3d;
      return new Vector3(local1.x,local1.y,local1.z);
    }

    public function getCenter() : Vector3 {
      return this.toVector3(this.getFacilityData().object3d.localToGlobal(this.toVector3D(getInitParam().localCenter)));
    }

    public function getTeam() : BattleTeam {
      return getInitParam().facilityTeam;
    }

    public function getOwner() : IGameObject {
      return object.space.getObject(getInitParam().ownerId);
    }

    private function toVector3D(param1:Vector3d) : Vector3D {
      return new Vector3D(param1.x,param1.y,param1.z);
    }

    private function toVector3(param1:Vector3D) : Vector3 {
      return new Vector3(param1.x,param1.y,param1.z);
    }
  }
}
