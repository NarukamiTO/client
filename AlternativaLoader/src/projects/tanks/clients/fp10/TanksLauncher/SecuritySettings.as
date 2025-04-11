package projects.tanks.clients.fp10.TanksLauncher {
  import flash.system.Security;

  public class SecuritySettings {
    public function SecuritySettings() {
      super();
    }

    public static function apply() : void {
      Security.allowDomain("chat.kongregate.com");
      Security.allowDomain("internal.kongregate.com");
      Security.allowDomain("kongregate.com");
    }
  }
}
