package projects.tanks.clients.fp10.libraries.tanksservices.service.servername {
  import projects.tanks.clients.fp10.libraries.tanksservices.service.address.TanksAddressService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.reconnect.ReconnectService;

  public class ServerNumberToLocaleServerServiceImpl implements ServerNumberToLocaleServerService {
    [Inject]
    public static var reconnectService:ReconnectService;

    [Inject]
    public static var addressService:TanksAddressService;

    public function ServerNumberToLocaleServerServiceImpl() {
      super();
    }

    public function isLocalServer() : Boolean {
      return addressService.getServerNumber() == reconnectService.getCurrentServerNumber();
    }
  }
}
