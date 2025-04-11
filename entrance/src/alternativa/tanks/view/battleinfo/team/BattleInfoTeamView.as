package alternativa.tanks.view.battleinfo.team {
  import alternativa.tanks.view.battleinfo.AbstractBattleInfoView;
  import alternativa.tanks.view.battleinfo.BattleInfoUserList;
  import alternativa.tanks.view.battleinfo.BattleInfoViewEvent;
  import alternativa.tanks.view.battleinfo.LocaleBattleInfo;
  import alternativa.tanks.view.battleinfo.renderer.BattleInfoBlueUserListRenderer;
  import alternativa.tanks.view.battleinfo.renderer.BattleInfoRedUserListRenderer;
  import alternativa.tanks.view.battlelist.forms.BattleBigButton;
  import assets.icons.play_icons_BLUE;
  import assets.icons.play_icons_RED;
  import controls.TankWindowInner;
  import controls.base.LabelBase;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.filters.GlowFilter;
  import flash.text.TextFieldAutoSize;
  import forms.Styles;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import utils.ScrollStyleUtils;

  public class BattleInfoTeamView extends AbstractBattleInfoView {
    private var _listInnerRed:TankWindowInner;
    private var _listInnerBlue:TankWindowInner;

    public var redFightButton:BattleBigButton;
    public var blueFightButton:BattleBigButton;
    public var blueUserList:BattleInfoUserList;
    public var redUserList:BattleInfoUserList;

    private var _redScoreLabel:LabelBase;
    private var _blueScoreLabel:LabelBase;
    private var scorePanel:Sprite;

    public function BattleInfoTeamView() {
      super();
    }

    override protected function createUserList() : void {
      this._listInnerRed = new TankWindowInner(100,100,TankWindowInner.RED);
      this._listInnerRed.showBlink = true;
      addChild(this._listInnerRed);
      this._listInnerBlue = new TankWindowInner(100,100,TankWindowInner.BLUE);
      this._listInnerBlue.showBlink = true;
      addChild(this._listInnerBlue);
      this.blueUserList = new BattleInfoUserList();
      this.blueUserList.setStyle(Styles.CELL_RENDERER,BattleInfoBlueUserListRenderer);
      addChild(this.blueUserList);
      this.redUserList = new BattleInfoUserList();
      this.redUserList.setStyle(Styles.CELL_RENDERER,BattleInfoRedUserListRenderer);
      addChild(this.redUserList);
      ScrollStyleUtils.setRedStyle(this.redUserList);
      ScrollStyleUtils.setBlueStyle(this.blueUserList);
    }

    override protected function addControlsToPanel() : void {
      this.redFightButton = new BattleBigButton();
      this.redFightButton.label = LocaleBattleInfo.fightButtonLabel;
      this.redFightButton.icon = new play_icons_RED(0,0);
      addChild(this.redFightButton);
      this.blueFightButton = new BattleBigButton();
      this.blueFightButton.label = LocaleBattleInfo.fightButtonLabel;
      this.blueFightButton.icon = new play_icons_BLUE(0,0);
      addChild(this.blueFightButton);
      this.scorePanel = new Sprite();
      addChild(this.scorePanel);
      this._redScoreLabel = new LabelBase();
      this._redScoreLabel.size = 22;
      this._redScoreLabel.color = TankWindowInner.RED;
      this._redScoreLabel.x = -74;
      this._redScoreLabel.width = 70;
      this._redScoreLabel.autoSize = TextFieldAutoSize.RIGHT;
      this.scorePanel.addChild(this._redScoreLabel);
      this._blueScoreLabel = new LabelBase();
      this._blueScoreLabel.size = 22;
      this._blueScoreLabel.color = TankWindowInner.BLUE;
      this._blueScoreLabel.x = 5;
      this._blueScoreLabel.width = 70;
      this._blueScoreLabel.autoSize = TextFieldAutoSize.LEFT;
      this.scorePanel.addChild(this._blueScoreLabel);
      var local1:LabelBase = new LabelBase();
      local1.size = 22;
      local1.text = ":";
      local1.x = -4;
      local1.y = -2;
      this.scorePanel.addChild(local1);
      this.scorePanel.filters = [new GlowFilter(13434828,0.5)];
    }

    override protected function setEvents() : void {
      super.setEvents();
      this.redFightButton.addEventListener(MouseEvent.CLICK,this.onFightButtonRedClick);
      this.blueFightButton.addEventListener(MouseEvent.CLICK,this.onFightButtonBlueClick);
    }

    override protected function removeEvents() : void {
      super.removeEvents();
      this.redFightButton.removeEventListener(MouseEvent.CLICK,this.onFightButtonRedClick);
      this.blueFightButton.removeEventListener(MouseEvent.CLICK,this.onFightButtonBlueClick);
    }

    override public function destroy() : void {
      super.destroy();
      this._listInnerRed = null;
      this._listInnerBlue = null;
      this.redFightButton = null;
      this.blueFightButton = null;
      this.blueUserList = null;
      this.redUserList = null;
      this._redScoreLabel = null;
      this._blueScoreLabel = null;
      this.scorePanel = null;
    }

    override protected function resizeUserList(param1:Number, param2:Number) : void {
      this._listInnerRed.width = int(param1 - 25) / 2;
      this._listInnerRed.height = param2 - battleInfoParamsView.height - (proBattlePassAlert.visible ? 164 : 80);
      this._listInnerRed.x = 11;
      this._listInnerRed.y = battleInfoParamsView.height + 14;
      this._listInnerBlue.width = param1 - this._listInnerRed.width - 25;
      this._listInnerBlue.height = param2 - battleInfoParamsView.height - (proBattlePassAlert.visible ? 164 : 80);
      this._listInnerBlue.x = 14 + this._listInnerRed.width;
      this._listInnerBlue.y = battleInfoParamsView.height + 14;
      this.redUserList.x = this._listInnerRed.x + 4;
      this.redUserList.y = this._listInnerRed.y + 4;
      this.redUserList.setSize(this._listInnerRed.width - (this.redUserList.verticalScrollBar.visible ? 1 : 4),this._listInnerRed.height - 8);
      this.blueUserList.x = this._listInnerBlue.x + 4;
      this.blueUserList.y = this._listInnerBlue.y + 4;
      this.blueUserList.setSize(this._listInnerBlue.width - (this.blueUserList.verticalScrollBar.visible ? 1 : 4),this._listInnerBlue.height - 8);
    }

    override protected function resizeControlsPanel(param1:Number, param2:Number) : void {
      this.blueFightButton.width = this.redFightButton.width = Math.min(130,int((param1 - 110) / 2));
      this.redFightButton.x = 11;
      this.redFightButton.y = param2 - 61;
      this.blueFightButton.x = param1 - this.blueFightButton.width - 11;
      this.blueFightButton.y = param2 - 61;
      this.scorePanel.x = this._listInnerBlue.x - 3;
      this.scorePanel.y = param2 - 51;
    }

    override protected function invalidateDataProviders() : void {
      this.redUserList.dataProvider.invalidate();
      this.blueUserList.dataProvider.invalidate();
    }

    override protected function updateAchievementPosition() : void {
    }

    override public function showProBattlePassAlert() : void {
      super.showProBattlePassAlert();
      this.blueFightButton.visible = false;
      this.redFightButton.visible = false;
    }

    override public function hideNoSupplies() : void {
      super.hideNoSupplies();
      this.blueFightButton.visible = true;
      this.redFightButton.visible = true;
    }

    override public function updateScore(param1:BattleTeam, param2:int) : void {
      var local3:LabelBase = param1 == BattleTeam.RED ? this._redScoreLabel : this._blueScoreLabel;
      local3.text = String(param2);
    }

    private function onFightButtonRedClick(param1:MouseEvent) : void {
      dispatchEvent(new BattleInfoViewEvent(BattleInfoViewEvent.ENTER_BATTLE,BattleTeam.RED));
    }

    private function onFightButtonBlueClick(param1:MouseEvent) : void {
      dispatchEvent(new BattleInfoViewEvent(BattleInfoViewEvent.ENTER_BATTLE,BattleTeam.BLUE));
    }

    override public function updateInBattleState() : void {
      this.blueFightButton.visible = false;
      this.redFightButton.visible = false;
      super.updateInBattleState();
    }
  }
}
