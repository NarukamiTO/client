package alternativa.tanks.models.battle.jgr {
  import alternativa.math.Vector3;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.TankLoadedEvent;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.battle.ctf.MessageColor;
  import alternativa.tanks.models.battle.gui.BattlefieldGUI;
  import alternativa.tanks.models.battle.gui.markers.PointIndicatorStateProvider;
  import alternativa.tanks.models.battle.gui.statistics.ShortUserInfo;
  import alternativa.tanks.models.statistics.IClientUserInfo;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.services.tankregistry.TankUsersRegistry;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.types.Long;
  import flash.display.Bitmap;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.resource.types.TextureResource;
  import platform.client.fp10.core.type.IGameObject;
  import platform.client.fp10.core.type.ISpace;
  import projects.tanks.client.battlefield.models.battle.jgr.IJuggernautModelBase;
  import projects.tanks.client.battlefield.models.battle.jgr.JuggernautCC;
  import projects.tanks.client.battlefield.models.battle.jgr.JuggernautModelBase;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;

  [ModelInfo]
  public class JuggernautModel extends JuggernautModelBase implements IJuggernautModelBase, Juggernaut, ObjectLoadListener, ObjectUnloadListener, ObjectLoadPostListener, PointIndicatorStateProvider {
    [Inject]
    public static var usersRegistry:TankUsersRegistry;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    private static const MARKER_Z_OFFSET:Number = 350;

    private var guiModel:BattlefieldGUI = null;
    private var currentBossId:Long = null;
    private var battleSpace:ISpace = null;
    private var bossSpawnedSound:Sound3D;
    private var bossDiedSound:Sound3D;
    private var localTank:Tank = null;
    private var battleEventSupport:BattleEventSupport;

    public function JuggernautModel() {
      super();
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(TankLoadedEvent,this.onTankLoaded);
    }

    private static function getUserUid(param1:Long) : String {
      var local2:ShortUserInfo = null;
      if(param1 != null) {
        local2 = IClientUserInfo(object.adapt(IClientUserInfo)).getShortUserInfo(param1);
        if(local2 != null) {
          return local2.uid;
        }
      }
      return null;
    }

    public function objectLoaded() : void {
      this.battleEventSupport.activateHandlers();
    }

    public function bossChanged(param1:Long) : void {
      var local4:String = null;
      this.currentBossId = param1;
      var local2:Boolean = !battleInfoService.isSpectatorMode() && this.localTank != null && this.localTank.user != null && this.currentBossId != null && this.localTank.user.id == this.currentBossId;
      var local3:String = getUserUid(this.currentBossId);
      if(local3 != null) {
        local4 = localeService.getText(TanksLocale.TEXT_JGR_NEW_BOSS,local3);
        this.guiModel.showBattleMessage(local2 ? MessageColor.POSITIVE : MessageColor.YELLOW,local4);
      }
      this.bossSpawnedSound.play(0,0);
    }

    public function bossKilled() : void {
      var local3:String = null;
      var local1:uint = !battleInfoService.isSpectatorMode() && this.localTank.user.id == this.currentBossId ? MessageColor.NEGATIVE : MessageColor.POSITIVE;
      var local2:String = getUserUid(this.currentBossId);
      if(local2 != null) {
        local3 = localeService.getText(TanksLocale.TEXT_JGR_BOSS_KILLED,local2);
        this.guiModel.showBattleMessage(local1,local3);
      }
      this.bossDiedSound.play(0,0);
    }

    public function bossId() : Long {
      return this.currentBossId;
    }

    private function onTankLoaded(param1:TankLoadedEvent) : void {
      if(param1.isLocal) {
        this.localTank = param1.tank;
      }
    }

    public function objectUnloaded() : void {
      this.battleEventSupport.deactivateHandlers();
      this.localTank = null;
      this.battleSpace = null;
    }

    public function objectLoadedPost() : void {
      this.guiModel = BattlefieldGUI(object.adapt(BattlefieldGUI));
      var local1:JuggernautCC = getInitParam();
      this.bossSpawnedSound = Sound3D.create(local1.bossSpawnedSound.sound);
      this.bossDiedSound = Sound3D.create(local1.bossKilledSound.sound);
      var local2:TextureResource = local1.bossHudMarker;
      var local3:JuggernautHudIndicator = new JuggernautHudIndicator(new Bitmap(local2.data),this);
      battleService.getBattleScene3D().addRenderer(local3);
      this.currentBossId = local1.currentBoss == null ? null : local1.currentBoss.id;
      this.battleSpace = object.space;
    }

    public function getIndicatorPosition() : Vector3 {
      var local1:IGameObject = null;
      if(this.currentBossId != null) {
        local1 = this.battleSpace.getObject(this.currentBossId);
        if(local1 != null) {
          return ITankModel(local1.adapt(ITankModel)).getTank().getBody().state.position;
        }
      }
      return Vector3.ZERO;
    }

    public function isIndicatorActive(param1:Vector3 = null) : Boolean {
      return this.currentBossId != null && this.localTank != null && this.localTank.user != null && this.currentBossId != this.localTank.user.id;
    }

    public function zOffset() : Number {
      return MARKER_Z_OFFSET;
    }
  }
}
