package alternativa.tanks.view.battlecreate {
  import alternativa.osgi.service.locale.ILocaleService;
  import controls.TypeBattleButton;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import projects.tanks.client.battleservice.BattleMode;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class ChooseTypeBattleView extends Sprite {
    [Inject]
    public static var localeService:ILocaleService;

    private static const MIN_FULL_NAME_WIDTH:int = 400;

    private var _battleTypesButton:Array;
    private var _selectedButton:TypeBattleButton;
    private var createBattleFormView:CreateBattleFormView;
    private var _buttonLabelsName:Vector.<String>;
    private var _buttonLabelsShortName:Vector.<String>;
    private var _componentWidth:Number = 0;
    private var _componentHeight:Number = 0;

    public function ChooseTypeBattleView(param1:CreateBattleFormView) {
      super();
      this.createBattleFormView = param1;
      this.initLabelNames();
    }

    private function initLabelNames() : void {
      this._buttonLabelsName = new Vector.<String>();
      this._buttonLabelsName.push(CreateBattleFormLabels.deathMatchButtonLabel);
      this._buttonLabelsName.push(CreateBattleFormLabels.teamDeathMatchButtonLabel);
      this._buttonLabelsName.push(CreateBattleFormLabels.captureTheFlagButtonLabel);
      this._buttonLabelsName.push(CreateBattleFormLabels.dominationButtonLabel);
      this._buttonLabelsName.push(localeService.getText(TanksLocale.TEXT_BATTLE_CREATE_PANEL_BUTTON_ASSAULT));
      this._buttonLabelsName.push(localeService.getText(TanksLocale.TEXT_BATTLE_CREATE_PANEL_BUTTON_RUGBY));
      this._buttonLabelsName.push("SUR");
      this._buttonLabelsName.push(localeService.getText(TanksLocale.TEXT_JGR_MODE_NAME));
      this._buttonLabelsShortName = new Vector.<String>();
      this._buttonLabelsShortName.push(CreateBattleFormLabels.deathMatchButtonShortLabel);
      this._buttonLabelsShortName.push(CreateBattleFormLabels.teamDeathMatchButtonShortLabel);
      this._buttonLabelsShortName.push(CreateBattleFormLabels.captureTheFlagButtonShortLabel);
      this._buttonLabelsShortName.push(CreateBattleFormLabels.dominationButtonShortLabel);
      this._buttonLabelsShortName.push(localeService.getText(TanksLocale.TEXT_AS_SHORT_NAME));
      this._buttonLabelsShortName.push(localeService.getText(TanksLocale.TEXT_RUGBY_SHORT_NAME));
      this._buttonLabelsShortName.push("SUR");
      this._buttonLabelsShortName.push(localeService.getText(TanksLocale.TEXT_JGR_SHORT_NAME));
    }

    public function setAvailableTypesBattle(param1:Vector.<BattleMode>) : void {
      var local3:TypeBattleButton = null;
      var local4:Object = null;
      this.destroy();
      this._battleTypesButton = new Array();
      var local2:int = 0;
      while(local2 < param1.length) {
        local3 = new TypeBattleButton();
        local3.data = param1[local2];
        local3.label = this._buttonLabelsName[param1[local2].value];
        addChild(local3);
        local4 = new Object();
        local4.id = param1[local2].value;
        local4.button = local3;
        this._battleTypesButton[local2] = local4;
        local2++;
      }
      this._battleTypesButton.sortOn(["id"],[Array.NUMERIC]);
      this.setEvents();
      this.resize(this._componentWidth,this._componentHeight);
    }

    public function setEvents() : void {
      var local2:TypeBattleButton = null;
      var local1:int = 0;
      while(local1 < this._battleTypesButton.length) {
        local2 = TypeBattleButton(this._battleTypesButton[local1].button);
        local2.addEventListener(MouseEvent.CLICK,this.onClickButton);
        local1++;
      }
    }

    public function removeEvents() : void {
      var local2:TypeBattleButton = null;
      var local1:int = 0;
      while(local1 < this._battleTypesButton.length) {
        local2 = TypeBattleButton(this._battleTypesButton[local1].button);
        local2.removeEventListener(MouseEvent.CLICK,this.onClickButton);
        local1++;
      }
    }

    public function destroy() : void {
      var local1:int = 0;
      if(this._battleTypesButton != null) {
        this.removeEvents();
        local1 = 0;
        while(local1 < this._battleTypesButton.length) {
          removeChild(this._battleTypesButton[local1].button);
          this._battleTypesButton[local1] = null;
          local1++;
        }
      }
      this._battleTypesButton = null;
    }

    public function resize(param1:Number, param2:Number) : void {
      var local3:int = 0;
      var local4:int = 0;
      var local5:int = 0;
      var local6:TypeBattleButton = null;
      var local7:TypeBattleButton = null;
      this._componentWidth = param1;
      this._componentHeight = param2;
      if(this._battleTypesButton != null) {
        local3 = int(this._battleTypesButton.length);
        local4 = int((param1 - (local3 - 1) * 4 + 1) / local3);
        local5 = 0;
        while(local5 < this._battleTypesButton.length) {
          local6 = TypeBattleButton(this._battleTypesButton[local5].button);
          local6.width = local4;
          if(local5 != 0) {
            local7 = TypeBattleButton(this._battleTypesButton[local5 - 1].button);
            local6.x = local7.x + local7.width + 4;
          }
          local5++;
        }
        this.setLabels();
      }
    }

    private function setLabels() : void {
      var local3:int = 0;
      var local1:Boolean = this._componentWidth > MIN_FULL_NAME_WIDTH;
      var local2:int = 0;
      while(local2 < this._battleTypesButton.length) {
        local3 = int(this._battleTypesButton[local2].id);
        TypeBattleButton(this._battleTypesButton[local2]["button"]).label = local1 ? this._buttonLabelsName[local3] : this._buttonLabelsShortName[local3];
        local2++;
      }
    }

    public function getComponentHeight() : Number {
      return this._battleTypesButton != null ? Number(this._battleTypesButton[0].button.height) : 10;
    }

    private function onClickButton(param1:MouseEvent) : void {
      var local2:BattleMode = BattleMode((param1.currentTarget as TypeBattleButton).data);
      this.createBattleFormView.setBattleMode(local2);
    }

    public function setTypeBattle(param1:BattleMode) : void {
      var local3:TypeBattleButton = null;
      if(this._selectedButton != null) {
        this._selectedButton.enabled = true;
      }
      var local2:int = 0;
      while(local2 < this._battleTypesButton.length) {
        local3 = TypeBattleButton(this._battleTypesButton[local2].button);
        if(param1 == BattleMode(local3.data)) {
          this._selectedButton = local3;
          this._selectedButton.enabled = false;
        }
        local2++;
      }
    }
  }
}
