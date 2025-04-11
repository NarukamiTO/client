package alternativa.tanks.view.matchmaking.quest {
  import alternativa.osgi.service.locale.ILocaleService;
  import controls.buttons.IconButton;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class QuestButton extends IconButton {
    [Inject]
    public static var localeService:ILocaleService;

    private static const missionIconClass:Class = QuestButton_missionIconClass;

    public function QuestButton() {
      super(localeService.getText(TanksLocale.TEXT_QUEST_BUTTON),missionIconClass);
    }
  }
}
