package alternativa.tanks.battle.objects.tank {
  public class ClientTankState {
    public static const DEAD:ClientTankState = new ClientTankState("DEAD");
    public static const SEMI_ACTIVE:ClientTankState = new ClientTankState("SEMI_ACTIVE");
    public static const ACTIVE:ClientTankState = new ClientTankState("ACTIVE");

    private var name:String;

    public function ClientTankState(param1:String) {
      super();
      this.name = param1;
    }

    public function toString() : String {
      return "ClientTankState." + this.name;
    }
  }
}
