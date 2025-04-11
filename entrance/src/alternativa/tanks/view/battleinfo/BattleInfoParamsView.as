package alternativa.tanks.view.battleinfo {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.controllers.battleinfo.TimeStringUtils;
  import alternativa.tanks.view.battlelist.modefilter.BattleModeIcons;
  import alternativa.tanks.view.icons.BattleParamsBattleInfoIcons;
  import alternativa.tanks.view.timeleftindicator.BigWhiteTimeLeftIndicator;
  import alternativa.tanks.view.timeleftindicator.TimeLeftIndicator;
  import alternativa.types.Long;
  import assets.icons.InputCheckIcon;
  import base.DiscreteSprite;
  import controls.TankWindowInner;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import controls.base.TankInputBase;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.filters.GlowFilter;
  import flash.geom.Rectangle;
  import flash.system.System;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFieldType;
  import forms.ranks.SmallRankIcon;
  import forms.registration.CallsignIconStates;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.battleservice.BattleMode;
  import projects.tanks.client.battleservice.Range;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.battlelist.UserBattleSelectActionsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.BattleFormatUtil;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.BattleInfoUtils;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.removeChildrenFrom;
  import utils.preview.IImageResource;
  import utils.preview.ImageResourceLoadingWrapper;

  public class BattleInfoParamsView extends DiscreteSprite implements IImageResource {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var userBattleSelectActionsService:UserBattleSelectActionsService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    [Inject]
    public static var battleFormatUtil:BattleFormatUtil;

    private static const MAX_HEIGHT:int = 500;
    private static const ICON_VERTICAL_MARGIN:int = 6;
    private static const filter:Array = [new GlowFilter(0,1,6,6)];

    private static var waitIcon:InputCheckIcon = new InputCheckIcon();

    private var _width:int;
    private var _height:int;
    private var battleLimitsBar:Sprite = new Sprite();
    private var proOptionsBar:Sprite = new Sprite();
    private var autoBalanceIcon:Bitmap = new Bitmap(BattleParamsBattleInfoIcons.autoBalanceBitmapData);
    private var friendlyFireIcon:Bitmap = new Bitmap(BattleParamsBattleInfoIcons.friendlyFireBitmapData);
    private var scoreLimitIcon:Bitmap = new Bitmap();
    private var suppliesIcon:Bitmap = new Bitmap(BattleParamsBattleInfoIcons.suppliesBitmapData);
    private var bonusesIcon:Bitmap = new Bitmap(BattleParamsBattleInfoIcons.bonusesBitmapData);
    private var goldBoxesIcon:Bitmap = new Bitmap(BattleParamsBattleInfoIcons.goldBonusesBitmapData);
    private var upgradesIcon:Bitmap = new Bitmap(BattleParamsBattleInfoIcons.upgradesBitmapData);
    private var devicesIcon:Bitmap = new Bitmap(BattleParamsBattleInfoIcons.devicesBitmapData);
    private var proBattleIcon:Bitmap = new Bitmap(BattleParamsBattleInfoIcons.proBitmapData);
    private var formatBattleIcon:Bitmap = new Bitmap(BattleParamsBattleInfoIcons.formatBattleBitmapData);
    private var reArmorIcon:Bitmap = new Bitmap(BattleParamsBattleInfoIcons.rearmorBitmapData);
    private var dependentCooldownIcon:Bitmap = new Bitmap(BattleParamsBattleInfoIcons.dependentCooldownsBitmapData);
    private var ultimatesIcon:Bitmap = new Bitmap(BattleParamsBattleInfoIcons.ultimatesBitmapData);
    private var clanBattleIcon:Bitmap = new Bitmap(BattleParamsBattleInfoIcons.clanBattleBitmapData);
    private var matchmakingStampIcon:Bitmap = new Bitmap(BattleParamsBattleInfoIcons.matchmakingStampBitmapData);
    private var scoreLimitLabel:LabelBase = new LabelBase();
    private var timeLimitLabel:LabelBase = new LabelBase();
    private var timeLeftLabel:LabelBase = new LabelBase();
    private var timeLeftIndicator:TimeLeftIndicator = new BigWhiteTimeLeftIndicator();
    private var bg:TankWindowInner = new TankWindowInner(100,100,TankWindowInner.TRANSPARENT);
    private var nameLabel:LabelBase = new LabelBase();
    private var preview:Sprite = new Sprite();
    private var stamp:Sprite = new Sprite();
    private var rect:Rectangle = new Rectangle(0,0,400,300);
    private var urlString:TankInputBase;
    private var urlCopyButton:DefaultButtonBase;
    private var copyLinkText:String;
    private var rangBar:Sprite = new Sprite();
    private var rangIconsY:Number;
    private var spectatorButton:DefaultButtonBase = new DefaultButtonBase();
    private var infoParams:BattleInfoBaseParams;
    private var _previewLoadingId:Long;

    public function BattleInfoParamsView() {
      super();
      addChild(this.preview);
      addChild(this.bg);
      addChild(this.nameLabel);
      addChild(this.rangBar);
      addChild(this.battleLimitsBar);
      addChild(this.proOptionsBar);
      addChild(this.spectatorButton);
      addChild(this.proBattleIcon);
      addChild(this.formatBattleIcon);
      addChild(this.stamp);
      this.spectatorButton.label = "Spectator";
      this.spectatorButton.visible = false;
      this.spectatorButton.addEventListener(MouseEvent.CLICK,this.onSpectatorButtonClick);
      this.nameLabel.size = 18;
      this.nameLabel.height = 25;
      this.nameLabel.thickness = 0;
      this.nameLabel.autoSize = TextFieldAutoSize.NONE;
      this.nameLabel.filters = filter;
      this.battleLimitsBar.filters = filter;
      this.proOptionsBar.filters = filter;
      this.proBattleIcon.filters = filter;
      this.formatBattleIcon.filters = filter;
      this.proBattleIcon.visible = false;
      this.formatBattleIcon.visible = false;
      this.preview.scrollRect = this.rect;
      this.copyLinkText = localeService.getText(TanksLocale.TEXT_BATTLEINFO_PANEL_COPY_LINK_TEXT);
      this.stamp.addChild(this.matchmakingStampIcon);
    }

    private function onResize() : * {
      this.stamp.x = 10;
      this.stamp.y = this.bg.height - this.stamp.height;
      this.matchmakingStampIcon.visible = this.bg.height > 100;
    }

    public function setPreview(param1:BitmapData) : void {
      if(this.preview.numChildren > 0) {
        this.preview.removeChildAt(0);
      }
      if(param1 == null) {
        this.preview.addChild(waitIcon);
        waitIcon.gotoAndStop(CallsignIconStates.CALLSIGN_ICON_STATE_PROGRESS);
        waitIcon.x = int(375 - waitIcon.width / 2);
        waitIcon.y = int(250 - waitIcon.height / 2);
        this.preview.scrollRect = this.rect;
      } else {
        this.preview.addChild(new Bitmap(param1));
        this.preview.scrollRect = this.rect;
      }
      this.width = this._width;
      this.height = this._height;
    }

    public function update(param1:BattleInfoBaseParams) : void {
      this.infoParams = param1;
      this.updatePreview(param1.previewResource);
      this.updateRankRangeBar();
      this.updateBattleUrl();
      this.updateNameAndFormat();
      this.updateBattleLimits();
      this.updateOptions();
      this.width = this._width;
      this.height = this._height;
    }

    public function updatePreview(param1:ImageResource) : void {
      if(param1.isLazy && !param1.isLoaded) {
        this._previewLoadingId = param1.id;
        param1.loadLazyResource(new ImageResourceLoadingWrapper(this));
      }
      this.setPreview(param1.data);
    }

    public function setPreviewResource(param1:ImageResource) : void {
      if(this._previewLoadingId == param1.id) {
        this.setPreview(param1.data);
      }
    }

    private function updateOptions() : void {
      removeChildrenFrom(this.proOptionsBar);
      if(this.infoParams.createParams.proBattle) {
        this.addIcon(this.bonusesIcon,!this.infoParams.createParams.withoutBonuses);
        if(!this.infoParams.createParams.parkourMode) {
          this.addIcon(this.goldBoxesIcon,this.infoParams.createParams.goldBoxesEnabled);
        }
        this.addIcon(this.reArmorIcon,this.infoParams.createParams.reArmorEnabled);
        this.addIcon(this.upgradesIcon,!this.infoParams.createParams.withoutUpgrades);
        this.addIcon(this.devicesIcon,!this.infoParams.createParams.withoutDevices);
        this.addIcon(this.suppliesIcon,!this.infoParams.createParams.withoutSupplies);
        if(!this.infoParams.createParams.withoutSupplies) {
          this.addIcon(this.dependentCooldownIcon,this.infoParams.createParams.dependentCooldownEnabled);
        }
        if(this.infoParams.createParams.battleMode != BattleMode.DM) {
          this.addIcon(this.friendlyFireIcon,this.infoParams.createParams.friendlyFire);
          this.addIcon(this.autoBalanceIcon,this.infoParams.createParams.autoBalance);
        }
        this.addIcon(this.clanBattleIcon,this.infoParams.createParams.clanBattle);
        this.addIcon(this.ultimatesIcon,this.infoParams.createParams.ultimatesEnabled);
      }
    }

    private function updateBattleLimits() : void {
      removeChildrenFrom(this.battleLimitsBar);
      if(this.infoParams.createParams.limits.timeLimitInSec > 0) {
        this.timeLimitLabel.text = int(this.infoParams.createParams.limits.timeLimitInSec / 60).toString();
        this.timeLimitLabel.size = 14;
        this.battleLimitsBar.addChild(this.timeLimitLabel);
        this.battleLimitsBar.addChild(this.timeLeftIndicator);
        this.timeLeftIndicator.x = this.timeLimitLabel.textWidth + 11;
        this.timeLeftIndicator.y = 2;
        this.battleLimitsBar.addChild(this.timeLeftLabel);
        this.timeLeftLabel.x = this.timeLeftIndicator.x + this.timeLeftIndicator.width + 5;
        this.timeLeftLabel.autoSize = TextFieldAutoSize.NONE;
        this.timeLeftLabel.size = 14;
        this.timeLeftLabel.width = 50;
        this.timeLeftLabel.height = 20;
      }
      if(this.infoParams.createParams.limits.scoreLimit > 0) {
        this.scoreLimitIcon.x = this.battleLimitsBar.numChildren > 0 ? this.battleLimitsBar.width + ICON_VERTICAL_MARGIN : 0;
        this.scoreLimitIcon.y = -4;
        this.battleLimitsBar.addChild(this.scoreLimitIcon);
        switch(this.infoParams.createParams.battleMode) {
          case BattleMode.CP:
            this.scoreLimitIcon.bitmapData = BattleParamsBattleInfoIcons.cpBitmapData;
            break;
          case BattleMode.CTF:
            this.scoreLimitIcon.bitmapData = BattleParamsBattleInfoIcons.ctfBitmapData;
            break;
          case BattleMode.AS:
            this.scoreLimitIcon.bitmapData = BattleModeIcons.getIcon(BattleMode.AS);
            break;
          case BattleMode.RUGBY:
            this.scoreLimitIcon.bitmapData = BattleModeIcons.getIcon(BattleMode.RUGBY);
            break;
          default:
            this.scoreLimitIcon.bitmapData = BattleParamsBattleInfoIcons.dmBitmapData;
        }
        this.battleLimitsBar.addChild(this.scoreLimitLabel);
        this.scoreLimitLabel.size = 14;
        this.scoreLimitLabel.text = String(this.infoParams.createParams.limits.scoreLimit);
        this.scoreLimitLabel.x = this.scoreLimitIcon.x + 18;
      }
    }

    public function updateNameAndFormat() : void {
      var local1:String = battleFormatUtil.getShortFormatName(this.infoParams.createParams.equipmentConstraintsMode,this.infoParams.createParams.parkourMode);
      var local2:Boolean = local1.length > 0;
      if(Boolean(this.infoParams.customName)) {
        this.nameLabel.text = this.infoParams.customName;
      } else {
        this.nameLabel.text = this.infoParams.createParams.proBattle ? this.infoParams.mapName : BattleInfoUtils.buildBattleName(this.infoParams.mapName,this.infoParams.createParams.battleMode.name);
        if(local2) {
          this.nameLabel.text += " " + local1;
        }
      }
      this.proBattleIcon.x = this.nameLabel.x + this.nameLabel.textWidth + 8;
      this.proBattleIcon.y = this.nameLabel.y - 1;
      this.proBattleIcon.visible = this.infoParams.createParams.proBattle && !local2;
      this.formatBattleIcon.x = this.proBattleIcon.x;
      this.formatBattleIcon.y = this.proBattleIcon.y;
      this.formatBattleIcon.visible = this.infoParams.createParams.proBattle && local2;
      this.stamp.visible = this.infoParams.matchmakingMark;
    }

    private function updateBattleUrl() : void {
      if(this.infoParams.battleUrl.length > 0 && this.urlString == null) {
        this.urlString = new TankInputBase();
        this.urlCopyButton = new DefaultButtonBase();
        addChild(this.urlString);
        addChild(this.urlCopyButton);
      }
      if(this.infoParams.battleUrl.length > 0) {
        this.urlString.value = this.infoParams.battleUrl;
        this.urlString.textField.type = TextFieldType.DYNAMIC;
        this.urlCopyButton.width = this.copyLinkText.length * 7;
        this.urlCopyButton.label = this.copyLinkText;
        this.urlCopyButton.addEventListener(MouseEvent.CLICK,this.copyURL);
      }
    }

    private function updateRankRangeBar() : void {
      var local2:SmallRankIcon = null;
      var local6:int = 0;
      var local1:Range = this.infoParams.createParams.rankRange;
      var local3:int = 0;
      var local4:int = 0;
      removeChildrenFrom(this.rangBar);
      var local5:int = 16;
      if(local1.min != 0 && local1.max != 0) {
        local6 = local1.max;
        while(local6 >= local1.min) {
          local2 = new SmallRankIcon(local6);
          local2.x = local3 * 15;
          local2.y = local4 * local5;
          this.rangBar.addChild(local2);
          local3--;
          if(local3 < -15) {
            local4--;
            local3 = 0;
          }
          local6--;
        }
      }
      this.rangIconsY = local4 * local5;
    }

    private function addIcon(param1:Bitmap, param2:Boolean) : void {
      var local3:int = this.proOptionsBar.numChildren;
      var local4:int = Math.floor(this.width / (param1.width + ICON_VERTICAL_MARGIN));
      if(local3 > 0) {
        param1.x = this.proOptionsBar.width + ICON_VERTICAL_MARGIN;
      } else {
        param1.x = 0;
      }
      if(local3 > local4) {
        param1.y = param1.height + ICON_VERTICAL_MARGIN;
        param1.x = (param1.width + ICON_VERTICAL_MARGIN) * (local3 - (local4 - 1));
      }
      param1.alpha = param2 ? 1 : 0.5;
      this.proOptionsBar.addChild(param1);
    }

    private function copyURL(param1:MouseEvent) : void {
      userBattleSelectActionsService.copyBattleLink(this.infoParams.createParams.battleMode,this.infoParams.battleId);
      System.setClipboard(this.urlString.value);
    }

    override public function set width(param1:Number) : void {
      this._width = int(param1);
      this.bg.width = this._width;
      this.preview.x = 1;
      this.rect.x = int(375 - this._width / 2);
      this.rect.width = this._width - 2;
      this.preview.scrollRect = this.rect;
      this.rangBar.x = this._width - 23;
      this.nameLabel.x = 10;
      this.nameLabel.width = this._width - 20;
      this.battleLimitsBar.x = 12;
      this.proOptionsBar.x = 12;
      this.spectatorButton.x = this._width - this.spectatorButton.width - 9;
      if(this.urlString != null) {
        this.urlString.width = this._width - this.urlCopyButton.width - 3;
        this.urlCopyButton.x = this._width - this.urlCopyButton.width;
      }
      this.alignProOptionsIcons();
      this.onResize();
    }

    private function alignProOptionsIcons() : void {
      var local1:int = 0;
      var local2:int = 0;
      var local3:int = 0;
      var local4:int = 0;
      var local5:DisplayObject = null;
      if(this.proOptionsBar.numChildren > 0) {
        local1 = this.proOptionsBar.numChildren;
        local2 = this.width - 30;
        local3 = Math.floor(local2 / (this.proOptionsBar.getChildAt(0).width + ICON_VERTICAL_MARGIN));
        if(local1 <= local3) {
          return;
        }
        local4 = 0;
        while(local4 < local1) {
          local5 = this.proOptionsBar.getChildAt(local4);
          if(local4 > local3) {
            local5.y = local5.height + ICON_VERTICAL_MARGIN;
            local5.x = (local5.width + ICON_VERTICAL_MARGIN) * (local4 - (local3 + 1));
          } else {
            local5.y = 0;
            local5.x = (local5.width + ICON_VERTICAL_MARGIN) * local4;
          }
          local4++;
        }
      }
    }

    override public function set height(param1:Number) : void {
      this._height = Math.min(param1,MAX_HEIGHT);
      this.bg.height = this.urlString != null ? this._height - this.urlString.height - 3 : this._height;
      this.preview.y = 1;
      this.rect.y = int(250 - this._height / 2);
      this.rect.height = this.bg.height - 2;
      this.preview.scrollRect = this.rect;
      this.rangBar.y = this.bg.height - 23;
      this.nameLabel.y = 10;
      this.battleLimitsBar.y = 40;
      this.proOptionsBar.y = 70;
      this.spectatorButton.y = this.rangBar.y + this.rangIconsY - this.spectatorButton.height - 9;
      if(this.urlString != null) {
        this.urlString.y = this._height - this.urlCopyButton.height;
        this.urlCopyButton.y = this._height - this.urlCopyButton.height;
      }
      this.onResize();
    }

    override public function get width() : Number {
      return this._width;
    }

    override public function get height() : Number {
      return this._height;
    }

    private function onSpectatorButtonClick(param1:MouseEvent) : void {
      dispatchEvent(new BattleInfoViewEvent(BattleInfoViewEvent.ENTER_SPECTATOR));
    }

    public function updateSpectatorButton() : void {
      this.spectatorButton.visible = Boolean(userPropertiesService.hasSpectatorPermissions()) && !this.isSpectatorInSelectedBattle();
    }

    private function isSpectatorInSelectedBattle() : Boolean {
      return Boolean(battleInfoService.isSpectatorMode()) && battleInfoService.currentBattleId == this.infoParams.battleId;
    }

    public function destroy() : void {
      this.spectatorButton.removeEventListener(MouseEvent.CLICK,this.onSpectatorButtonClick);
    }

    public function setTimeAndPercentLeft(param1:int) : void {
      this.timeLeftLabel.text = TimeStringUtils.getTimeStr(param1);
      this.timeLeftIndicator.setPercentLeft(this.getPercentLeft(param1));
    }

    private function getPercentLeft(param1:int) : Number {
      if(param1 == 0) {
        return 1;
      }
      return param1 / this.infoParams.createParams.limits.timeLimitInSec;
    }

    public function setMatchmakingMark(param1:Boolean) : void {
      this.stamp.visible = param1;
    }
  }
}
