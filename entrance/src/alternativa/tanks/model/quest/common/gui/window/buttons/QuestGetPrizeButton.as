package alternativa.tanks.model.quest.common.gui.window.buttons {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.model.quest.common.gui.window.buttons.skin.GreenBigButtonSkin;
  import controls.base.ThreeLineBigButton;
  import controls.labels.MouseDisabledLabel;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class QuestGetPrizeButton extends ThreeLineBigButton {
    [Inject]
    public static var localeService:ILocaleService;

    private var priceLabel:MouseDisabledLabel;

    public function QuestGetPrizeButton() {
      super();
      this.priceLabel = new MouseDisabledLabel();
      this.priceLabel.size = 11;
      setSkin(GreenBigButtonSkin.GREEN_SKIN);
      super.setText(localeService.getText(TanksLocale.TEXT_DAILY_QUEST_GET_PRIZE));
      super.showInOneRow(captionLabel);
    }
  }
}
