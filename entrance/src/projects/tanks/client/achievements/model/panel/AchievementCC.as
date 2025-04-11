package projects.tanks.client.achievements.model.panel {
  import projects.tanks.client.achievements.model.Achievement;

  public class AchievementCC {
    private var _activeAchievements:Vector.<Achievement>;

    public function AchievementCC(param1:Vector.<Achievement> = null) {
      super();
      this._activeAchievements = param1;
    }

    public function get activeAchievements() : Vector.<Achievement> {
      return this._activeAchievements;
    }

    public function set activeAchievements(param1:Vector.<Achievement>) : void {
      this._activeAchievements = param1;
    }

    public function toString() : String {
      var local1:String = "AchievementCC [";
      local1 += "activeAchievements = " + this.activeAchievements + " ";
      return local1 + "]";
    }
  }
}
