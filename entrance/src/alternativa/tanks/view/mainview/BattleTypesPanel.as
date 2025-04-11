package alternativa.tanks.view.mainview {
  import alternativa.tanks.service.achievement.IAchievementService;
  import alternativa.tanks.view.mainview.button.MainViewButton;
  import alternativa.tanks.view.mainview.button.MatchmakingButton;
  import alternativa.tanks.view.mainview.button.ShowBattleSelectButton;
  import base.DiscreteSprite;
  import fl.containers.ScrollPane;
  import fl.controls.ScrollPolicy;
  import fl.events.ScrollEvent;
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import flash.geom.Point;
  import flash.utils.Dictionary;
  import flash.utils.setTimeout;
  import projects.tanks.client.battleselect.model.matchmaking.queue.MatchmakingMode;
  import projects.tanks.clients.flash.commons.models.challenge.ChallengeInfoService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import utils.ScrollStyleUtils;

  public class BattleTypesPanel extends DiscreteSprite {
    [Inject]
    public static var achievementService:IAchievementService;

    [Inject]
    public static var challengeInfoService:ChallengeInfoService;

    private static const cpBtnClass:Class = BattleTypesPanel_cpBtnClass;
    private static const ctfBtnClass:Class = BattleTypesPanel_ctfBtnClass;
    private static const dmBtnClass:Class = BattleTypesPanel_dmBtnClass;
    private static const tdmBtnClass:Class = BattleTypesPanel_tdmBtnClass;
    private static const quickBtnClass:Class = BattleTypesPanel_quickBtnClass;
    private static const assaultBtnClass:Class = BattleTypesPanel_assaultBtnClass;
    private static const rugbyBtnClass:Class = BattleTypesPanel_rugbyBtnClass;
    private static const jgrBtnClass:Class = BattleTypesPanel_jgrBtnClass;
    private static const cpButton:Bitmap = new Bitmap(new cpBtnClass().bitmapData);
    private static const ctfButton:Bitmap = new Bitmap(new ctfBtnClass().bitmapData);
    private static const dmButton:Bitmap = new Bitmap(new dmBtnClass().bitmapData);
    private static const tdmButton:Bitmap = new Bitmap(new tdmBtnClass().bitmapData);
    private static const quickButton:Bitmap = new Bitmap(new quickBtnClass().bitmapData);
    private static const assaultButton:Bitmap = new Bitmap(new assaultBtnClass().bitmapData);
    private static const rugbyButton:Bitmap = new Bitmap(new rugbyBtnClass().bitmapData);
    private static const juggernautButton:Bitmap = new Bitmap(new jgrBtnClass().bitmapData);

    private var scrollPane:ScrollPane = new ScrollPane();
    private var buttonsContainer:Sprite = new Sprite();
    private var modeButtons:Vector.<MainViewButton> = new Vector.<MainViewButton>();
    private var quickPlayButton:MatchmakingButton;
    private var dmModeButton:MatchmakingButton;
    private var holidayButton:MatchmakingButton;
    private var jgrModeButton:MatchmakingButton;
    private var battleSelectButton:ShowBattleSelectButton;
    private var panelWidth:int = 0;

    public function BattleTypesPanel(param1:Dictionary, param2:HolidayParams, param3:int) {
      super();
      ScrollStyleUtils.setGreenStyle(this.scrollPane);
      this.scrollPane.horizontalScrollPolicy = ScrollPolicy.OFF;
      this.scrollPane.verticalScrollPolicy = ScrollPolicy.AUTO;
      this.scrollPane.source = this.buttonsContainer;
      this.scrollPane.update();
      this.scrollPane.focusEnabled = false;
      this.scrollPane.addEventListener(ScrollEvent.SCROLL,this.onScroll);
      addChild(this.scrollPane);
      this.quickPlayButton = new MatchmakingButton(TanksLocale.TEXT_QUICK_PLAY_MODE_NAME,TanksLocale.TEXT_QUICK_PLAY_MODE_DESCRIPTION,quickButton,MatchmakingMode.TEAM_MODE,param1[MatchmakingMode.TEAM_MODE]);
      this.addButton(this.quickPlayButton);
      if(param2 != null) {
        this.holidayButton = new MatchmakingButton(param2.holidayTitle,param2.holidayDescription,new Bitmap(param2.holidayIcon.data),MatchmakingMode.HOLIDAY,1);
        this.addButton(this.holidayButton);
      }
      this.addButton(new MatchmakingButton(TanksLocale.TEXT_TDM_MODE_NAME,TanksLocale.TEXT_TDM_MODE_DESCRIPTION,tdmButton,MatchmakingMode.TDM_ONLY,param1[MatchmakingMode.TDM_ONLY]));
      if(param2 == null) {
        this.dmModeButton = new MatchmakingButton(TanksLocale.TEXT_DM_MODE_NAME,TanksLocale.TEXT_DM_MODE_DESCRIPTION,dmButton,MatchmakingMode.DM_ONLY,param1[MatchmakingMode.DM_ONLY]);
        this.addButton(this.dmModeButton);
      }
      this.addButton(new MatchmakingButton(TanksLocale.TEXT_CP_MODE_NAME,TanksLocale.TEXT_CP_MODE_DESCRIPTION,cpButton,MatchmakingMode.CP_ONLY,param1[MatchmakingMode.CP_ONLY]));
      this.addButton(new MatchmakingButton(TanksLocale.TEXT_CTF_MODE_NAME,TanksLocale.TEXT_CTF_MODE_DESCRIPTION,ctfButton,MatchmakingMode.CTF_ONLY,param1[MatchmakingMode.CTF_ONLY]));
      this.addButton(new MatchmakingButton(TanksLocale.TEXT_AS_MODE_NAME,TanksLocale.TEXT_AS_MODE_DESCRIPTION,assaultButton,MatchmakingMode.AS_ONLY,param1[MatchmakingMode.AS_ONLY]));
      this.addButton(new MatchmakingButton(TanksLocale.TEXT_RUGBY_MODE_NAME,TanksLocale.TEXT_RUGBY_MODE_DESCRIPTION,rugbyButton,MatchmakingMode.RUGBY_ONLY,param1[MatchmakingMode.RUGBY_ONLY]));
      this.jgrModeButton = new MatchmakingButton(TanksLocale.TEXT_JGR_MODE_NAME,TanksLocale.TEXT_JGR_MODE_DESCRIPTION,juggernautButton,MatchmakingMode.JGR_ONLY,param1[MatchmakingMode.JGR_ONLY]);
      this.addButton(this.jgrModeButton);
      this.battleSelectButton = new ShowBattleSelectButton(param3);
      this.buttonsContainer.addChild(this.battleSelectButton);
    }

    private function onScroll(param1:ScrollEvent) : void {
      setTimeout(this.moveBubble,5);
    }

    private function moveBubble() : void {
      var local1:Point = this.quickPlayButton.localToGlobal(new Point(this.quickPlayButton.width - 75,110));
      if(local1.y < 150) {
        local1 = new Point(-100,-100);
      }
      achievementService.setBattleStartButtonTargetPoint(local1);
    }

    private function addButton(param1:MainViewButton) : void {
      this.modeButtons.push(param1);
      this.buttonsContainer.addChild(param1);
    }

    public function resize(param1:int, param2:int) : void {
      this.panelWidth = param1;
      this.alignButtons();
      this.scrollPane.setSize(param1,param2);
      this.scrollPane.update();
      this.moveBubble();
    }

    private function alignButtons() : void {
      var local3:MainViewButton = null;
      var local1:int = -3;
      var local2:Vector.<MainViewButton> = new Vector.<MainViewButton>().concat(this.modeButtons);
      local2.push(this.battleSelectButton);
      for each(local3 in local2) {
        if(local3.visible) {
          local3.resize(this.panelWidth);
          local3.y = local1;
          local1 += local3.height - 3;
        }
      }
    }

    public function userEntersGroup(param1:Boolean) : void {
      if(!param1) {
        this.lockBattleButtons();
      }
      this.battleSelectButton.lockButton();
      this.setNotTeamButtonVisibility(false);
    }

    public function userLeavesGroup() : void {
      this.unlockBattleButtons();
      this.battleSelectButton.unlockIfPossible();
      this.setNotTeamButtonVisibility(true);
    }

    public function lockBattleButtons() : void {
      var local1:MainViewButton = null;
      for each(local1 in this.modeButtons) {
        local1.lockButton();
      }
    }

    public function unlockBattleButtons() : void {
      var local1:MainViewButton = null;
      for each(local1 in this.modeButtons) {
        local1.unlockIfPossible();
      }
    }

    private function setNotTeamButtonVisibility(param1:Boolean) : void {
      if(this.dmModeButton != null) {
        this.dmModeButton.visible = param1;
      }
      this.jgrModeButton.visible = param1;
      if(this.holidayButton != null) {
        this.holidayButton.visible = param1;
      }
      this.alignButtons();
    }

    public function setSpectatorsButtonVisible(param1:Boolean) : void {
      var local2:MainViewButton = null;
      for each(local2 in this.modeButtons) {
        local2.setSpectatorsButtonVisible(param1);
      }
    }
  }
}
