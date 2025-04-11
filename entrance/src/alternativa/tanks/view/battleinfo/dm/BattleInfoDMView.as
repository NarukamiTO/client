package alternativa.tanks.view.battleinfo.dm {
  import alternativa.tanks.view.battleinfo.AbstractBattleInfoView;
  import alternativa.tanks.view.battleinfo.BattleInfoUserList;
  import alternativa.tanks.view.battleinfo.BattleInfoViewEvent;
  import alternativa.tanks.view.battleinfo.LocaleBattleInfo;
  import alternativa.tanks.view.battlelist.forms.BattleBigButton;
  import assets.icons.play_icons_ALL;
  import controls.TankWindowInner;
  import flash.events.MouseEvent;
  import flash.geom.Point;

  public class BattleInfoDMView extends AbstractBattleInfoView {
    private var _listInner:TankWindowInner;

    public var fightButton:BattleBigButton;
    public var userList:BattleInfoUserList;

    public function BattleInfoDMView() {
      super();
    }

    override protected function createUserList() : void {
      this._listInner = new TankWindowInner(100,100,TankWindowInner.GREEN);
      this._listInner.showBlink = true;
      addChild(this._listInner);
      this.userList = new BattleInfoUserList();
      addChild(this.userList);
    }

    override protected function addControlsToPanel() : void {
      this.fightButton = new BattleBigButton();
      this.fightButton.label = LocaleBattleInfo.fightButtonLabel;
      this.fightButton.icon = new play_icons_ALL(0,0);
      addChild(this.fightButton);
    }

    override protected function setEvents() : void {
      super.setEvents();
      this.fightButton.addEventListener(MouseEvent.CLICK,this.onFightButtonClick);
    }

    override protected function removeEvents() : void {
      super.removeEvents();
      this.fightButton.removeEventListener(MouseEvent.CLICK,this.onFightButtonClick);
    }

    override public function showProBattlePassAlert() : void {
      super.showProBattlePassAlert();
      this.fightButton.visible = false;
    }

    override public function hideNoSupplies() : void {
      super.hideNoSupplies();
      this.fightButton.visible = true;
    }

    override public function destroy() : void {
      super.destroy();
      this._listInner = null;
      this.fightButton = null;
      this.userList = null;
    }

    override protected function resizeUserList(param1:Number, param2:Number) : void {
      this._listInner.width = param1 - 22;
      this._listInner.height = param2 - battleInfoParamsView.height - (proBattlePassAlert.visible ? 164 : 80);
      this._listInner.x = 11;
      this._listInner.y = battleInfoParamsView.height + 14;
      this.userList.setSize(this._listInner.width - (this.userList.verticalScrollBar.visible ? 1 : 4),this._listInner.height - 8);
      this.userList.x = this._listInner.x + 4;
      this.userList.y = this._listInner.y + 4;
    }

    override protected function resizeControlsPanel(param1:Number, param2:Number) : void {
      this.fightButton.width = 130;
      this.fightButton.x = param1 - this.fightButton.width - 11;
      this.fightButton.y = param2 - 61;
    }

    override protected function updateAchievementPosition() : void {
      if(this.fightButton.visible && this.fightButton.enabled) {
        achievementService.setBattleStartButtonTargetPoint(new Point(this.x + this.fightButton.x,this.y + this.fightButton.y));
      } else {
        achievementService.setBattleStartButtonTargetPoint(new Point());
      }
    }

    private function onFightButtonClick(param1:MouseEvent) : void {
      dispatchEvent(new BattleInfoViewEvent(BattleInfoViewEvent.ENTER_BATTLE));
    }

    override public function updateInBattleState() : void {
      this.fightButton.visible = false;
      super.updateInBattleState();
    }

    override protected function invalidateDataProviders() : void {
      this.userList.dataProvider.invalidate();
    }
  }
}
