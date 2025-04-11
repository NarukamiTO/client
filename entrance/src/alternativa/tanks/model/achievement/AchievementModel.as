package alternativa.tanks.model.achievement {
  import alternativa.tanks.service.achievement.IAchievementService;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.achievements.model.Achievement;
  import projects.tanks.client.achievements.model.panel.AchievementPanelModelBase;
  import projects.tanks.client.achievements.model.panel.IAchievementPanelModelBase;

  [ModelInfo]
  public class AchievementModel extends AchievementPanelModelBase implements IAchievementPanelModelBase, ObjectUnloadListener, ObjectLoadPostListener {
    [Inject]
    public static var achievementService:IAchievementService;

    public function AchievementModel() {
      super();
    }

    public function completeAchievement(param1:Achievement, param2:String, param3:int) : void {
      achievementService.completeAchievement(param1,param2,param3);
    }

    public function activateAchievement(param1:Achievement) : void {
      achievementService.activateAchievement(param1);
    }

    public function objectLoadedPost() : void {
      achievementService.setAchievements(getInitParam().activeAchievements);
    }

    public function objectUnloaded() : void {
      achievementService.hideAllBubbles(true);
    }
  }
}
