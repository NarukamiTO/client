package alternativa.tanks.model.quest.common.gui.window.buttons {
  import alternativa.osgi.service.locale.ILocaleService;
  import controls.base.ThreeLineBigButton;
  import controls.labels.MouseDisabledLabel;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class DailyQuestDisabledPrizeButton extends ThreeLineBigButton {
    [Inject]
    public static var localeService:ILocaleService;

    private var priceLabel:MouseDisabledLabel;

    public function DailyQuestDisabledPrizeButton() {
      super();
      this.priceLabel = new MouseDisabledLabel();
      this.priceLabel.size = 11;
      super.setText(localeService.getText(TanksLocale.TEXT_DAILY_QUEST_GET_PRIZE));
      super.showInOneRow(captionLabel);
    }
  }
}
