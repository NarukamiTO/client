package projects.tanks.clients.flash.commons.models.challenge {
  public interface ChallengeInfoService {
    function isInTime() : Boolean;
    function getEndTime() : Number;
    function startEvent(param1:int) : void;
  }
}
