package projects.tanks.client.achievements.model.panel {
  import projects.tanks.client.achievements.model.Achievement;

  public interface IAchievementPanelModelBase {
    function activateAchievement(param1:Achievement) : void;
    function completeAchievement(param1:Achievement, param2:String, param3:int) : void;
  }
}
