package alternativa.tanks.service.device {
  public class DeviceOwningType {
    public static var BOUGHT:DeviceOwningType = new DeviceOwningType("bought");
    public static var RENT:DeviceOwningType = new DeviceOwningType("rent");
    public static var NOT_OWNED:DeviceOwningType = new DeviceOwningType("not_owned");

    private var name:String;

    public function DeviceOwningType(param1:String) {
      super();
      this.name = param1;
    }
  }
}
