package alternativa.tanks.services.battlereadiness {
  public interface BattleReadinessService {
    function reset() : void;
    function unlockMap() : void;
    function unlockUser() : void;
    function isBattleReady() : Boolean;
    function isMapReady() : Boolean;
  }
}
