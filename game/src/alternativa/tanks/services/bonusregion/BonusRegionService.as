package alternativa.tanks.services.bonusregion {
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Decal;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.BattleFinishEvent;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.bonus.region.BonusRegion;
  import alternativa.tanks.models.bonus.region.GoldBonusRegion;
  import alternativa.tanks.service.settings.ISettingsService;
  import alternativa.tanks.service.settings.SettingsServiceEvent;
  import alternativa.utils.TextureMaterialRegistry;
  import alternativa.utils.clearDictionary;
  import flash.display.BitmapData;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.resource.types.StubBitmapData;
  import projects.tanks.client.battlefield.models.bonus.battle.bonusregions.BonusRegionData;
  import projects.tanks.client.battlefield.models.bonus.battle.bonusregions.BonusRegionResource;
  import projects.tanks.client.battlefield.models.bonus.bonus.BonusesType;

  public class BonusRegionService implements IBonusRegionService {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var materialRegistry:TextureMaterialRegistry;

    [Inject]
    public static var settings:ISettingsService;

    private static var stubBitmapData:BitmapData;

    private static const REGION_SIZE:int = 500;
    private static const REGION_DECAL_ACSENSION:Number = 5;

    private var _battleEventSupport:BattleEventSupport;
    private var _textures:Dictionary;
    private var _bonusRegions:Dictionary;
    private var _forceShow:Boolean;
    private var _forceHide:Boolean;
    private var _tank:Tank;

    public function BonusRegionService(param1:BattleEventDispatcher) {
      super();
      this._battleEventSupport = new BattleEventSupport(param1);
      this._battleEventSupport.addEventHandler(BattleFinishEvent,this.onBattleFinished);
    }

    private static function createRegion(param1:Vector3, param2:Vector3, param3:TextureMaterial) : Mesh {
      var local4:Decal = new Decal();
      var local5:Number = REGION_SIZE / 2;
      var local6:Number = 0.5;
      var local7:Vertex = local4.addVertex(-local5,local5,local6,0,0);
      var local8:Vertex = local4.addVertex(-local5,-local5,local6,0,1);
      var local9:Vertex = local4.addVertex(local5,-local5,local6,1,1);
      var local10:Vertex = local4.addVertex(local5,local5,local6,1,0);
      local4.addQuadFace(local7,local8,local9,local10,param3);
      local4.calculateFacesNormals();
      local4.calculateVerticesNormals();
      local4.x = param1.x;
      local4.y = param1.y;
      local4.z = param1.z + REGION_DECAL_ACSENSION;
      local4.rotationX = param2.x;
      local4.rotationY = param2.y;
      local4.rotationZ = param2.z;
      return local4;
    }

    private static function getStubBitmapData() : BitmapData {
      if(stubBitmapData == null) {
        stubBitmapData = new StubBitmapData(65280);
      }
      return stubBitmapData;
    }

    private function onBattleFinished(param1:BattleFinishEvent) : void {
      this.hideAndRemoveGoldRegions();
    }

    private function hideAndRemoveGoldRegions() : void {
      var local1:BonusRegion = null;
      for each(local1 in this._bonusRegions) {
        if(local1 is GoldBonusRegion) {
          local1.hideAndRemoveFromGame();
          delete this._bonusRegions[local1.getPosition().toString()];
        }
      }
    }

    public function showAll() : void {
      var local1:BonusRegion = null;
      if(this._forceShow) {
        for each(local1 in this._bonusRegions) {
          local1.showForce();
        }
      }
    }

    private function hasTank() : Boolean {
      return this._tank != null;
    }

    public function prepare(param1:Vector.<BonusRegionResource>) : void {
      this._forceShow = settings.showDropZones;
      this._forceHide = !this._forceShow;
      settings.addEventListener(SettingsServiceEvent.SETTINGS_CHANGED,this.onSettingsAccept);
      this._battleEventSupport.activateHandlers();
      this._bonusRegions = new Dictionary();
      this.initMaterials(param1);
    }

    private function onSettingsAccept(param1:SettingsServiceEvent) : void {
      if(this._forceShow != settings.showDropZones) {
        this.toggleRegionsVisible();
      }
    }

    private function initMaterials(param1:Vector.<BonusRegionResource>) : void {
      var local4:BonusRegionResource = null;
      this._textures = new Dictionary();
      var local2:int = int(param1.length);
      var local3:int = 0;
      while(local3 < local2) {
        local4 = param1[local3];
        this._textures[local4.regionType] = local4.dropZoneResource.data;
        local3++;
      }
    }

    public function destroy() : void {
      settings.removeEventListener(SettingsServiceEvent.SETTINGS_CHANGED,this.onSettingsAccept);
      this._battleEventSupport.deactivateHandlers();
      this.destroyBonusRegions();
      this.destroyTextures();
      this._tank = null;
    }

    private function destroyBonusRegions() : void {
      var local1:BonusRegion = null;
      for each(local1 in this._bonusRegions) {
        local1.removeFromGame();
      }
      clearDictionary(this._bonusRegions);
      this._bonusRegions = null;
    }

    private function destroyTextures() : void {
      clearDictionary(this._textures);
      this._textures = null;
    }

    public function addOneRegion(param1:BonusRegionData) : void {
      var local2:Vector3 = null;
      var local3:Mesh = null;
      var local4:BonusRegion = null;
      if(!this.hasRegion(param1)) {
        local2 = BattleUtils.getVector3(param1.position);
        local3 = createRegion(local2,BattleUtils.getVector3(param1.rotation),this.getMaterial(param1.regionType));
        if(param1.regionType == BonusesType.GOLD) {
          local4 = new GoldBonusRegion(local3,local2);
        } else {
          local4 = new BonusRegion(local3,local2,this._forceShow);
        }
        local4.addToGame();
        this._bonusRegions[local2.toString()] = local4;
      }
    }

    public function addFewRegions(param1:Vector.<BonusRegionData>) : void {
      var local2:int = int(param1.length);
      var local3:int = 0;
      while(local3 < local2) {
        this.addOneRegion(param1[local3]);
        local3++;
      }
    }

    private function getMaterial(param1:BonusesType) : TextureMaterial {
      var local2:BitmapData = this._textures[param1];
      if(local2 == null) {
        local2 = getStubBitmapData();
      }
      var local3:TextureMaterial = materialRegistry.getMaterial(local2);
      local3.resolution = 2;
      return local3;
    }

    public function setTank(param1:Tank) : void {
      this._tank = param1;
    }

    public function changeTank(param1:Tank) : void {
      if(!this.hasTank() || this.hasTank() && this._tank.getUser() != param1.getUser()) {
        this._tank = param1;
      }
    }

    public function resetTank() : void {
      this._tank = null;
      if(this._forceShow) {
        this.showAll();
      }
    }

    public function enableForceShow() : void {
      var local1:BonusRegion = null;
      this._forceShow = true;
      this._forceHide = false;
      settings.showDropZones = true;
      for each(local1 in this._bonusRegions) {
        if(!(local1 is GoldBonusRegion)) {
          local1.showForce();
        }
      }
    }

    public function enableForceHide() : void {
      var local1:BonusRegion = null;
      this._forceHide = true;
      this._forceShow = false;
      settings.showDropZones = false;
      for each(local1 in this._bonusRegions) {
        if(!(local1 is GoldBonusRegion)) {
          local1.hideForce();
        }
      }
    }

    public function addAndShowRegion(param1:BonusRegionData) : void {
      var local2:Vector3 = null;
      var local3:BonusRegion = null;
      if(!this.hasRegion(param1)) {
        this.addOneRegion(param1);
        local2 = BattleUtils.getVector3(param1.position);
        local3 = this._bonusRegions[local2.toString()];
        local3.show();
      }
    }

    public function hideAndRemoveRegion(param1:BonusRegionData) : void {
      var local2:Vector3 = null;
      var local3:BonusRegion = null;
      if(this.hasRegion(param1)) {
        local2 = BattleUtils.getVector3(param1.position);
        local3 = this._bonusRegions[local2.toString()];
        local3.hideAndRemoveFromGame();
        delete this._bonusRegions[local2.toString()];
      }
    }

    public function hasRegion(param1:BonusRegionData) : Boolean {
      var local2:Vector3 = BattleUtils.getVector3(param1.position);
      return this._bonusRegions[local2.toString()] != undefined;
    }

    public function toggleRegionsVisible() : void {
      if(this._forceShow) {
        this.enableForceHide();
      } else if(this._forceHide) {
        this.enableForceShow();
      }
    }
  }
}
