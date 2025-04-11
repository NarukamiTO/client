package alternativa.tanks.service.achievement {
  import flash.geom.Point;
  import projects.tanks.client.achievements.model.Achievement;

  public interface IAchievementService {
    function setGarageBuyButtonTargetPoint(param1:Point) : void;
    function setBattleStartButtonTargetPoint(param1:Point) : void;
    function setPaymentResumeButtonTargetPoint(param1:Point) : void;
    function hideAllBubbles(param1:Boolean) : void;
    function showStartButtonHelper() : void;
    function hideStartButtonHelper() : void;
    function completeAchievement(param1:Achievement, param2:String, param3:int) : void;
    function activateAchievement(param1:Achievement) : void;
    function setAchievements(param1:Vector.<Achievement>) : void;
    function removeGarageButtonAchievement() : void;
  }
}
