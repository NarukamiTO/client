package alternativa.tanks.models.battle.gui.userlabel {
  import alternativa.tanks.battle.objects.tank.ClientTankState;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.display.resistance.ResistanceShieldIcon;
  import alternativa.tanks.models.battle.battlefield.BattleUserInfoService;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.resistance.TankResistances;
  import alternativa.tanks.services.tankregistry.TankUsersRegistry;
  import alternativa.types.Long;
  import controls.base.LabelBase;
  import controls.chat.MessageColor;
  import filters.Filters;
  import flash.display.Bitmap;
  import flash.events.MouseEvent;
  import flash.text.AntiAliasType;
  import forms.userlabel.ChatUserLabel;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;

  public class BattleChatUserLabel extends ChatUserLabel {
    [Inject]
    public static var battleInfoService:IBattleInfoService;

    [Inject]
    public static var tankUsersRegistry:TankUsersRegistry;

    [Inject]
    public static var userInfoService:BattleUserInfoService;

    private var resitanceLabel:LabelBase;

    public function BattleChatUserLabel(param1:Long, param2:Boolean = true) {
      var local4:IGameObject = null;
      var local5:Tank = null;
      this.resitanceLabel = new LabelBase();
      _uid = userInfoService.getUserName(param1);
      _rank = userInfoService.getUserRank(param1);
      _chatModeratorLevel = userInfoService.getChatModeratorLevel(param1);
      _writeInPublicChat = false;
      _writePrivateInChat = false;
      _blockUserEnable = param2;
      var local3:Boolean = false;
      if(battleInfoService.isSpectatorMode()) {
        local4 = tankUsersRegistry.getUser(param1);
        if(local4 != null) {
          local5 = ITankModel(local4.adapt(ITankModel)).getTank();
          if(local5 != null) {
            local3 = local5.state == ClientTankState.ACTIVE;
          }
        }
      }
      this._focusOnUserEnabled = local3;
      super(param1);
      if(!_self) {
        addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
        addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
    }

    [Obfuscation(rename="false")]
    override protected function getShadowFilters() : Array {
      return Filters.SHADOW_FILTERS;
    }

    [Obfuscation(rename="false")]
    protected function getShadowFiltersOnOver() : Array {
      return Filters.SHADOW_ON_OVER_FILTERS;
    }

    private function onMouseOut(param1:MouseEvent) : void {
      shadowContainer.filters = this.getShadowFilters();
      this.resitanceLabel.filters = this.getShadowFilters();
    }

    private function onMouseOver(param1:MouseEvent) : void {
      shadowContainer.filters = this.getShadowFiltersOnOver();
      this.resitanceLabel.filters = this.getShadowFiltersOnOver();
    }

    [Obfuscation(rename="false")]
    override protected function onMouseClick(param1:MouseEvent) : void {
      showClanProfile = true;
      super.onMouseClick(param1);
    }

    [Obfuscation(rename="false")]
    override protected function updateProperties() : void {
      var local2:TankResistances = null;
      var local3:int = 0;
      var local4:Bitmap = null;
      setUid(_uid);
      setRank(_rank);
      setFriendState(_friendInfoUpdater.state);
      var local1:IGameObject = tankUsersRegistry.getUser(super.userId);
      if(local1 != null) {
        local2 = TankResistances(local1.adapt(TankResistances));
        local3 = int(local2.getResistance(false));
        if(local3 > 0) {
          local4 = ResistanceShieldIcon.getBitmapFor(local1);
          local4.y += 4;
          local4.x = _uidLabel.x + _uidLabel.textWidth + 7;
          shadowContainer.addChild(local4);
          this.resitanceLabel.text = local3 == 100 ? "??" : local3.toString();
          addChild(this.resitanceLabel);
          this.resitanceLabel.x = local4.x + 3;
          this.resitanceLabel.color = MessageColor.YELLOW;
          this.resitanceLabel.filters = this.getShadowFilters();
        }
      }
    }

    [Obfuscation(rename="false")]
    override protected function createUidLabel() : void {
      super.createUidLabel();
      _uidLabel.antiAliasType = AntiAliasType.ADVANCED;
      _uidLabel.thickness = 150;
      _uidLabel.sharpness = 200;
    }
  }
}
