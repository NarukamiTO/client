package alternativa.tanks.battle.events.death {
  import alternativa.types.Long;
  import projects.tanks.client.battlefield.types.DamageType;

  public class TankKilledEvent {
    public var killerId:Long;
    public var victimId:Long;
    public var damageType:DamageType;

    public function TankKilledEvent(param1:Long, param2:Long, param3:DamageType) {
      super();
      this.killerId = param1;
      this.victimId = param2;
      this.damageType = param3;
    }
  }
}
