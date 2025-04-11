package alternativa.tanks.view.mainview.button {
  import alternativa.osgi.service.locale.ILocaleService;
  import base.DiscreteSprite;
  import controls.base.ThreeLineBigButton;
  import controls.labels.MouseDisabledLabel;
  import filters.Filters;
  import flash.display.Sprite;
  import forms.ranks.SmallRankIcon;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.UserPropertiesServiceEvent;

  public class LockedByRankButton extends ThreeLineBigButton {
    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    [Inject]
    public static var localeService:ILocaleService;

    private var rankRow:Sprite = new DiscreteSprite();
    private var rankLabel:MouseDisabledLabel = new MouseDisabledLabel();
    private var rankIcon:SmallRankIcon = new SmallRankIcon();
    private var unlockRank:int;

    public function LockedByRankButton(param1:int) {
      this.unlockRank = param1;
      super();
      if(this.shouldBeLockedByRank()) {
        disabledState.setSkin(new DisabledButtonSkin());
        this.rankLabel.sharpness = -100;
        this.rankLabel.thickness = 100;
        this.rankLabel.text = localeService.getText(TanksLocale.TEXT_GARAGE_BUY_BUTTON_RANK_LABEL);
        this.rankLabel.color = 16731648;
        this.rankLabel.filters = Filters.SHADOW_FILTERS;
        this.rankRow.addChild(this.rankLabel);
        this.rankIcon.y = 3;
        this.rankIcon.init(false,param1);
        this.rankIcon.x = this.rankLabel.x + this.rankLabel.width + 1;
        this.rankIcon.filters = Filters.SHADOW_FILTERS;
        this.rankRow.addChild(this.rankIcon);
        this.rankRow.width = this.rankLabel.width + this.rankIcon.width + 5;
        this.rankRow.x = 60 - this.rankRow.width / 2;
        addChild(this.rankRow);
        userPropertiesService.addEventListener(UserPropertiesServiceEvent.UPDATE_RANK,this.updateRank);
        this.lockByRank();
      } else {
        this.unlockByRank();
      }
    }

    public function unlockIfPossible() : void {
      if(!this.shouldBeLockedByRank()) {
        this.unlockByRank();
      }
    }

    private function lockByRank() : void {
      enabled = false;
      showInTwoRows(captionLabel,this.rankRow);
    }

    private function unlockByRank() : void {
      this.rankRow.visible = false;
      enabled = true;
      showInOneRow(captionLabel);
    }

    private function updateRank(param1:UserPropertiesServiceEvent) : void {
      if(!this.shouldBeLockedByRank()) {
        userPropertiesService.removeEventListener(UserPropertiesServiceEvent.UPDATE_RANK,this.updateRank);
        this.unlockByRank();
      }
    }

    private function shouldBeLockedByRank() : Boolean {
      return this.unlockRank > userPropertiesService.rank;
    }
  }
}
