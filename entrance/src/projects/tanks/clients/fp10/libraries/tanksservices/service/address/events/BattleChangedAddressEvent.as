package projects.tanks.clients.fp10.libraries.tanksservices.service.address.events {
  import alternativa.types.Long;
  import flash.events.Event;

  public class BattleChangedAddressEvent extends Event {
    private var battleId:Long;

    public function BattleChangedAddressEvent(param1:Long) {
      super(TanksAddressEvent.BATTLE_CHANGED);
      this.battleId = param1;
    }

    public function getBattleId() : Long {
      return this.battleId;
    }
  }
}
